import { Widget, Battery } from "../../../imports.js";
import {
    getBatteryPercentage,
    getBatteryTooltip,
    getBatteryIcon,
} from "../../../utils/battery.js";
const { Button, Box, Label, Revealer } = Widget;

const BatIcon = () =>
    Label({ className: "batIcon" })
        // NOTE: label needs to be used instead of icon here
        .bind("label", Battery, "available", getBatteryIcon)
        .bind("tooltip-text", Battery, "percent", getBatteryTooltip);

const BatStatus = () =>
    Revealer({
        transition: "slide_down",
        transition_duration: 200,
        child: Label().bind("label", Battery, "percent", getBatteryPercentage),
    });

export const BatteryWidget = () =>
    Button({
        onPrimaryClick: (self) => {
            self.child.children[1].revealChild =
                !self.child.children[1].revealChild;
        },
        child: Box({
            className: "battery",
            cursor: "pointer",
            vertical: true,
            children: [BatIcon(), BatStatus()],
            visible: Battery.bind("available"),
        }),
    });

/*
    Box({
        className: "battery",
        cursor: "pointer",
        vertical: true,
        children: [BatIcon(), BatStatus()],
        visible: Battery.bind("available"),
    });
*/

/*
Button({
        className: name + "Button",
        onPrimaryClick: onPrimary,
        child: Box({
            className: name,
            vertical: true,
            children: [
                CircularProgress({
                    className: name + "Progress",
                    // binds: [["value", process]],
                    rounded: true,
                    inverted: false,
                    startAt: 0.27,
                }).bind("value", process),
                ...extraChildren,
            ],
        }),
    });
*/
