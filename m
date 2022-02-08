Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90B4ADDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382706AbiBHQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382045AbiBHQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:08:47 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49837C061576;
        Tue,  8 Feb 2022 08:08:45 -0800 (PST)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpDa5-1o6m2d0V9L-00qgdf; Tue, 08 Feb 2022 17:08:44 +0100
Received: by mail-wr1-f48.google.com with SMTP id q7so3481316wrc.13;
        Tue, 08 Feb 2022 08:08:44 -0800 (PST)
X-Gm-Message-State: AOAM531Kmt5kvut4rye3Ax+rrj6i+cqG0u7F0+4RvsDHAFsbdmfA0siM
        AwoUjFxfvL/qMJ4ZqSfZSMui1zv+BCFbpcycxTg=
X-Google-Smtp-Source: ABdhPJzbA1zhEbjBXruIegFSKr/HlmX/M9YfBzun4TpdLrkSYokD3NF400y+3a1CS0q9b/Y6jtkGtIJW7ls/Wf3lrm8=
X-Received: by 2002:a5d:568f:: with SMTP id f15mr974996wrv.407.1644336523635;
 Tue, 08 Feb 2022 08:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20220113080017.30155-1-kavyasree.kotagiri@microchip.com> <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com>
In-Reply-To: <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Feb 2022 17:08:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
Message-ID: <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9uqDdXQWcYkDHc7ZX1oQfuAHe7gAvXka4B2tLwL+Kragmwlm3/r
 NPW9GMxB8NDKxfjMQhMT8hNbaUI8T1MkBqM/ZabCp3cW27L8iVmYnh3mPNdcYF2TJuUpiyY
 AVZR67ad14GMtcLKfyVY1wP9xZXfZeSej8YRm3EU/fZVj0HObaHRB9eOXzvU7JM/y+/nMl5
 G6cGHB3WvP8n9sRCrMZFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y4eHeEHtqwY=:CwJ6+ncq7lv4SbOuasjRFk
 idtgZ2jMaeP49duqkgdjtyPvGH4L07HaXhDLkAkT1sFZog87JKlYr0hELlBqptZFpC6Cm/or2
 6P+Gl1eni3YSpxJ6e7Cu6UMtm5wTzgYAaHY3JyWM6912SBetUZy+gq39uxf5vkxWpKgUYXEJ9
 x/VQK6DUC6K/jd92dbd4IoL26+hYnPpDFOiXAlym34DsTVvPgvZ5awMOVEX4I/r40eprnCY+K
 rLoNG9eV0dO+/VHIC9XEK+AxpHwmuUQlpcUA0jSdj1xxkpqvZjvTagThJRv4zc4UxD8tuPa8J
 ZQi4k8snjDzcZ9Idm7d+2QEwjjjQE3j4myjdZGBnu9ETTmA0Ql+vynAz7c8d3emPGKK0sygBj
 wZWnzfuCXQKf/SzjDEezBaZua0Y8kl4cBVfAn9Fgf3CMKwcNyEXIdQ7efRUAVjkrY0SVX3rZ/
 Kx3ZOVaJsvoIMaKBNUHoRAamnGsXPl1OpUPo0W8ZSXdhEXmU6I+J/niVFPlkwtmupO4Gbyq2Y
 98jvKYlgDOzEkAJHpJ69QA/lYG9BK45eLCtPABMofTJRxrUmPwhs7s1hYnkuMhOSRV5vh0sUd
 3TKw+78RBk9r7UQzUyYCGCN6jnMC6sPgkGTqC7f9KplEixLy09PM6ixj49mM0p6fW35QXXy8e
 T4ESyZ2ltLiBOhtwnY0MXQNeo7gesZ73tews/N8eeboLuAfp7hHkNvsdyC6q5MH0KOj8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:33 AM Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
>
> On 13/01/2022 at 09:00, Kavyasree Kotagiri wrote:
> > This patch adds basic DT for Microchip lan966x SoC and associated board
> > pcb8291(2-port EVB). Adds peripherals required to allow booting: IRQs,
> > clocks, timers, memory, flexcoms, GPIOs. Also adds other peripherals like
> > crypto(AES,SHA), DMA and watchdog.
> >
> > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>
> Looks good to me:
> Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I'm not quite sure what to do with this, as this was sent to:soc@kernel.org,
which is normally for patches that are already reviewed and should just
get applied.

I can apply this, but I would normally expect board files to get picked up
in the at91 tree first. I'll drop this version from patchwork for now, as I
also have a couple of comments:

> > +
> > +/ {
> > +     model = "Microchip LAN966x family SoC";
> > +     compatible = "microchip,lan966x";

By convention, the 'compatible' strings should not contain 'x'
as a wildcard character. Just pick one of the models to be
compatible with. The .dtsi file doesn't really need a top-level
compatible or model property though, as they need to be
overridden by teh board anyway.

> > +
> > +     memory@60000000 {
> > +             device_type = "memory";
> > +             reg = <0x60000000 0x40000000>;  /* 1GB */
> > +     };

Probably also no memory node. This tends to be filled by the
boot loader, or it is part of the board when when the boot loader
is too old for that.

If the memory is part of the chip package, having it in the .dtsi
file is probably ok, but I would add a comment for that.

> > + */
> > +/dts-v1/;
> > +#include "lan966x.dtsi"
> > +
> > +/ {
> > +     model = "Microchip EVB - LAN9662";
> > +     compatible = "microchip,lan9662-pcb8291", "microchip,lan9662", "microchip,lan966";
> > +};

Here I would expect /chosen and /aliases nodes.

> > +&gpio {
> > +     fc_shrd7_pins: fc_shrd7-pins {
> > +             pins = "GPIO_49";
> > +             function = "fc_shrd7";
> > +     };

These properties don't look like most pinctrl nodes, has the binding
been reviewed?
I don't see it in Documentation/devicetree/bindings/pinctrl/

          Arnd
