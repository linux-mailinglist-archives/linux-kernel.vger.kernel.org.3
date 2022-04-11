Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF404FC540
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349713AbiDKTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349685AbiDKTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:46:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3913DF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:44:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id z128so15103522pgz.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5zxsoCIC2GpilLCrO46c2SjLv4QY7bGAV9knagNys8=;
        b=SoJiypDQOPX8j2ruN1UvWPz3ZXfxYooNw78Sj8hVwp7hS2T4l+c19y7hkh33iu+CWN
         pMMAQ+van2ku0XhY/2EANqEfbTKq8hrOZKIGLHNMiKGvXQ7YNG5FmzvODEOTm4Kzw69J
         W8U/l17YFjJ7Zkz5BXIwnO5qTACHvKZCvmSP9CrD6+wQSXnUCE/pos9MQL/nZGGbI+8s
         dbcDKVnNjFAfyH/XqoOh959dbOJxWZP9jADIi6VFRCxoyk446aEaZ3ygTknFPqhTQIc3
         M7UEt3j8656Y6/PEUB/p4wwjMnTRqJA5rVB0uSz1p2Qyc5oe06ltuOPe5b4Z3g0R/N3e
         tKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5zxsoCIC2GpilLCrO46c2SjLv4QY7bGAV9knagNys8=;
        b=UkZ7VbymibqAHDnT+kNuMNBImjQ2Mchz1ZGlhbptMpxVgkLpLANdw9YjszkMLybQ0B
         OQHzujKtHTcfvd3AtszKcs0ZBejQufkLOLGc9HiCTylFnuQvb9CLl7R2IozG+bXuXxoF
         g1Vb8UDAb3xi3A7HBoCgksSxy9adTFQ4W59e5686eCDE6kH1m67SHHE82acHHst/d1mw
         ZXnBqltgsM9+4ENHAG+jnb4cPhWexJAmemvfz3WZ0nTQvcHPREOUwY03lc5Ye1fFE5kQ
         RfWIwjk93kbsP62/DcED/vmYaqp8gNHrdq8DpT0k+aIvf+k0I/Nw7Srj5DHvyDsbbxax
         hoNw==
X-Gm-Message-State: AOAM530FC7wU8+yGbnaOL4BpyfmWwcGo6d0v/mqk2PH3pfMe5ky7Mh+3
        KgIoBhDFjTMxkmhI/J0ytwVFg8xicBa05B4GSV5jPQ==
X-Google-Smtp-Source: ABdhPJxcwxU1FsEJQWMka18EWe5GntoUEKLckNmYE3iHDoPhoLJGWCP4/jL+YXX0/f/YmQw8mPpWUp3Ko4mWHmrHxL4=
X-Received: by 2002:a63:6d06:0:b0:39d:6cba:9058 with SMTP id
 i6-20020a636d06000000b0039d6cba9058mr3157068pgc.440.1649706275011; Mon, 11
 Apr 2022 12:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220405200625.19359-1-tharvey@gateworks.com> <20220411013106.GD129381@dragon>
In-Reply-To: <20220411013106.GD129381@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 11 Apr 2022 12:44:23 -0700
Message-ID: <CAJ+vNU0VVpDGDXivz=r8C4U8dYjA08SqnzPXwmtOv4ujvc3=Zg@mail.gmail.com>
Subject: Re: [PATCH] imx8mm-venice-gw7902: update pci refclk
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 6:31 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Apr 05, 2022 at 01:06:25PM -0700, Tim Harvey wrote:
> > Use the correct PCI clock bindings.
>
> Please improve the commit log to explain why clock "pcie_phy" can be
> dropped.
>

Shawn,

The original PCIe bindings for this board were wrong - they were from
a version of the bindings that was not yet approved (my mistake) and
I'm just trying to bring them up to date.

That said, I looked at the latest fsl,imx6q-pcie.yaml dt-bindings [1]
and see that there should be a min of 3 clocks called 'pcie',
'pcie_bus', and 'pcie_phy'. However I notice that all of the current
imx8mm boards that enable PCI have clock-names of 'pcie', 'pcie_aux',
and 'pcie_bus'. It seems like all the imx8mm boards having pcie have
clock-names this way:

arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts

Does the binding need to change or do the clock names need to change
in the above?

Best Regards,

Tim
[1]

> Shawn
>
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> > index 6aa0eb463647..f71416be29a7 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
> > @@ -595,7 +595,7 @@
> >  &pcie_phy {
> >       fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> >       fsl,clkreq-unsupported;
> > -     clocks = <&clk IMX8MM_CLK_DUMMY>;
> > +     clocks = <&pcie0_refclk>;
> >       status = "okay";
> >  };
> >
> > @@ -604,8 +604,8 @@
> >       pinctrl-0 = <&pinctrl_pcie0>;
> >       reset-gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
> >       clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
> > -              <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
> > -     clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > +              <&pcie0_refclk>;
> > +     clock-names = "pcie", "pcie_aux", "pcie_bus";
> >       assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
> >                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
> >       assigned-clock-rates = <10000000>, <250000000>;
> > --
> > 2.17.1
> >
