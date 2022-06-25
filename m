Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E355A7AF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiFYHQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiFYHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:16:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295031DCA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:16:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i7so8052595ybe.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMEaIAOApI/h+XtfbSMsgFJNmVDOdy9tj5I/1m2LWHI=;
        b=Cf4fDw1G7GOQF/r5uzLROGEMDJRd2oaA/xDN9O+6UxGLwxU7tBfNUaaD1bXC0ivrel
         q0s5aowxFF0DUZcuZ7ROb+hlqnleNv8wA3sPth+3W+FJPlPXrYa1cmFTVhx/2RRIqkCZ
         FgahSBuTV/Fhcstn3AHYXuj2uCuD6xBEn3gSEsISVRDglVWlDhArFoN8KTH4ShgxAvuz
         Tko1pLVTIBc/BGRNhJJ2QvaCzo5nHyFA8ww+bC/HTRt4XkrGgCwLYRhbE9bTpv4chkmM
         0TTH/5x1UFolxKhcabzUQCrEflE+707njt7SSuTitL/GSc5ACM7y97tOKm4JIun4USN/
         9L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMEaIAOApI/h+XtfbSMsgFJNmVDOdy9tj5I/1m2LWHI=;
        b=cwMpP4xnhgOgA9C1XtHxNSW6NeH4rCmhVkmz0Fhi8bgfDHVmgvYyIvgPGkmBASNF0A
         66whVOzEDkbPqIVJ8bh/FOT8eHkZJdWCeRM6dRtEmJqTRY99vLa+F4dWnQAh1Osmg6ph
         mlSqvrrimA8qE519/MBpdRxBKvKhDeR04C0YgqgHXwczTQH04SLLjWNbfP84uAn3qqnQ
         KaBP3ZvkuZ5QPTJhOC3MPK04+zeXZJ9z1nO994id6L4tkZk1GyUaYuL0BwljjakScjgb
         CMnWD+QSNIF0o8dkQIu3ss4iAbAcqGzScuuCMlE6lgjZWlRhhNAlpu8rE5L4QuM2CgMD
         L3lg==
X-Gm-Message-State: AJIora/0xow6L6me4rcFoRVKFGAPadwQTjoqfaNnq50u9/YVRNPqEoeH
        w/eWAHJ3MAkV6x+udd3nLLrkj6k6A7PUHjB4tauskQ==
X-Google-Smtp-Source: AGRyM1uXWaSX13oeaRbQH7z8ctYGsH32j7YKFBI2J6A2E8YYutj+Wqm1iTQQ+ZQNMExEJTZUMdfCZC8gfPE4S37rru0=
X-Received: by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr2965356ybb.447.1656141387301; Sat, 25
 Jun 2022 00:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
In-Reply-To: <20220622072435.GT1615@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 25 Jun 2022 00:15:51 -0700
Message-ID: <CAGETcx_R0zr1PMgNO8HAqcWpaQNOBGzpYdnrMa2MD=HP6mzDqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:24 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> +Cc Saravana Kannan <saravanak@google.com>, the author of 71066545b48e4
>
> On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Commit 71066545b48e4("driver core: Set fw_devlink.strict=1 by default")
> > default set fw_devlink to true. This has a side effect to i.MX uart
> > console. The sdma will make the i.MX8MP uart driver defer probe for some
> > time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is a
> > supplier with property dmas set in device tree node.
>
> I just tested this on an i.MX6 board and observed the same behaviour.
> The same will happen on any other i.MX board as well. This will also
> likely happen on any other SoC on which the UART driver uses dmaengine.
>
> >
> > Since this uart is for console, we need log printed out as soon as
> > possible, so remove the dmas property for the uart console node.
>
> Fixing this at board level is not really an option because that means
> fixing each and every, at least i.MX board in the tree. Furthermore
> this would mean to bring the deleted property back in and to remove
> another dmas property should a user want to switch to another console
> port.
>
> For what it's worth: NACK for 71066545b48e4.

Hi Peng/Sascha/Fabio,

I was looking at a fix for this (even when stdout-path isn't set in
DT) and looking at the older code (say, 5.18), and it looks like
before my recent changes the console would still only get probed
during late_initcall(). Does that match your experience?

Thanks,
Saravana

>
> Sascha
>
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  The upper set fw_devlink.strict=1 patch is in linux-next tree.
> >
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts                  | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts  | 2 ++
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts        | 2 ++
> >  4 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > index fb11c03bc8b1..3fdb38bc0069 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -359,6 +359,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &usb3_phy1 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > index dd703b6a5e17..fb2b44e94482 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts
> > @@ -69,6 +69,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &usb3_phy0 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > index 6aa720bafe28..68a478151292 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> > @@ -99,6 +99,8 @@ &uart1 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart1>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  /* SD-Card */
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index 521215520a0f..f90c1ac2791c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -554,6 +554,8 @@ &uart2 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart2>;
> >       status = "okay";
> > +     /delete-property/ dmas;
> > +     /delete-property/ dma-names;
> >  };
> >
> >  &uart4 {
> > --
> > 2.25.1
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
