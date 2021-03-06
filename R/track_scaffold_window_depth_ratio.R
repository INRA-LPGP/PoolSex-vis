#' @title Scaffold ratio depth window track
#'
#' @description Draws a scaffold plot track for the ratio of depth window data.
#' This function is intended for use in the \code{\link{draw_scaffold_plot}} function.
#'
#' @param data depth window data frame.
#'
#' @param scaffold.name Name of the plotted scaffold (for the x axis)
#'
#' @param region A vector specifying the boundaries of the region to be plotted, e.g. c(125000, 250000).
#'
#' @param type Type of depth to use, either "absolute" or "relative" (default: "absolute").
#'
#' @param min.depth Minimum depth to compute depth ratio (default: 0).
#'
#' @param major.lines.y If TRUE, major grid lines will be plotted for the y axis (default: TRUE).
#'
#' @param major.lines.x If TRUE, major grid lines will be plotted for the y axis (default: TRUE).
#'
#' @param ylim Limits of the y axis (default: c(min(FST), 1)).
#'
#' @param males.color Color of the plotted area for males (default: "dodgerblue3").
#'
#' @param females.color Color of the plotted area for females (default: "firebrick2").
#'
#' @param bottom.track If TRUE, this track will be considered bottom track of the plot and the x axis will be drawn (default: FALSE).
#'
#' @param ratio.lines If TRUE, lines will be drawn for ratios of 2, 3/2, 2/3, and 1/2 (default: FALSE).


track_scaffold_window_depth_ratio <- function(data, scaffold.name, region, type = "absolute", min.depth = 0,
                                              major.lines.y = TRUE, major.lines.x = FALSE, ylim = NULL,
                                              males.color = "dodgerblue3", females.color = "firebrick2",
                                              bottom.track = FALSE, ratio.lines = FALSE) {

    # Create major grid lines for y axis if specified
    if (major.lines.y) {
        major_lines_y <- ggplot2::element_line(color = "grey90", linetype = 1)
    } else {
        major_lines_y <- ggplot2::element_blank()
    }

    # Create major grid lines for x axis if specified
    if (major.lines.x) {
        major_lines_x <- ggplot2::element_line(color = "grey90", linetype = 1)
    } else {
        major_lines_x <- ggplot2::element_blank()
    }

    # Create data based on type of depth
    if (type == "absolute") {
        data$Males <- data$Males_depth_abs
        data$Females <- data$Females_depth_abs
    } else if (type == "relative") {
        data$Males <- data$Males_depth_rel
        data$Females <- data$Females_depth_rel
    } else {
        stop(paste0(" - Error: depth type \"", type, "\" does not exist."))
    }

    # Separate male and female biased ratio for color
    # Formula for SNP ratio.
    data$Ratio <- log((1 + data$Males) / (1 + data$Females), 2)
    data$Ratio[which(data$Males_depth_abs < min.depth | data$Females_depth_abs < min.depth)] <- 0  # No Ratio computed when depth is too low
    data$Ratio_m <- data$Ratio
    data$Ratio_m[which(data$Ratio_m < 0)] <- 0
    data$Ratio_f <- data$Ratio
    data$Ratio_f[which(data$Ratio_f > 0)] <- 0

    # Y axis limits
    ymax <- 1.1 * max(abs(data$Ratio))
    ylim <- c(-ymax, ymax)

    # Add x axis if bottom track
    if (!bottom.track) {
        axis_title_x <- ggplot2::element_blank()
    } else {
        axis_title_x <- ggplot2::element_text()
    }

    # Draw the plot
    g <- ggplot2::ggplot() +
        cowplot::theme_cowplot() +
        ggplot2::geom_ribbon(data = data, ggplot2::aes(x = Original_position, ymin = 0, ymax = Ratio_m),
                             fill = males.color, color = males.color, size = 0.4, alpha = 0.75) +
        ggplot2::geom_ribbon(data = data, ggplot2::aes(x = Original_position, ymin = 0, ymax = Ratio_f),
                             fill = females.color, color = females.color, size = 0.4, alpha = 0.75) +
        ggplot2::scale_y_continuous(name = expression(paste("log"[2], "(M:F) depth window")), expand = c(0.01, 0.01), limits = ylim,
                                    breaks = seq(-ymax, ymax, 2 * ymax / 6), labels = round(seq(-ymax, ymax, 2 * ymax / 6), 2)) +
        generate_x_scale(region, scaffold.name) +
        ggplot2::theme(axis.text.y = ggplot2::element_text(margin = ggplot2::margin(l = 5)),
                       panel.grid.major.y = major_lines_y,
                       panel.grid.major.x = major_lines_x,
                       axis.title.x = axis_title_x)

    if (ratio.lines == TRUE) {
        g <- g +
            ggplot2::geom_hline(yintercept = log(2, 2), color = "black", linetype = 3) +
            ggplot2::geom_hline(yintercept = log(3/2, 2), color = "black", linetype = 3) +
            ggplot2::geom_hline(yintercept = log(2/3, 2), color = "black", linetype = 3) +
            ggplot2::geom_hline(yintercept = log(1/2, 2), color = "black", linetype = 3)
    }

    return(g)
}
