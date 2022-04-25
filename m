Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF81350E4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiDYPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiDYPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:50:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CC4114236;
        Mon, 25 Apr 2022 08:47:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so7115714ejb.8;
        Mon, 25 Apr 2022 08:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KITNKAeusqSJT+zGPV95UI61fvHf3AksSLlo//4H/Q=;
        b=d7uAgAim/QSjpWLL4BURUV2Si8I60jzsnYs2S3tONGckunmoXtdjA902DjChkWq72c
         rLwZOZmIce/HQITo2GaeS/xFbW4v2Tq6mkph1dTXANmave6YJy6TmWlJmHSxyN8MZ7qu
         XjhOwxiHG+LSZN3ygBiCtnD5Hv+YqIwvQenwihMzSBaumjllUhtO9S30C9hxEZMDQeiV
         Dq+7WIH01DSmv5R7svnr15yQW2D4Z9Ks5W6lh6rkbKFg+lXGaXUR3yWEdlaXlXAi8++I
         pwsg3w8TRb3MXeiBovxikYA02bC1yMObEFYkyRTJdqXO93mODKzGuHYYWTybG9zqxCIn
         TbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KITNKAeusqSJT+zGPV95UI61fvHf3AksSLlo//4H/Q=;
        b=0LTnE+adcupuZk/HjHIVVbsGokeSB0eRFWvd37eMXlCVoHoK9CA/f0F3Eep1J80/AW
         hOBUaf5tuBfby/duTlvHaTHMRMR58CN67Cvq6C3OPp3EWDXVFtyR95LlZRi3cRB5rKOQ
         Esm1I54DSjxCKs+cFUvE0xtwjA1fu3cNOJbsk7+mQcjUmxsYZyNMKqFgb8zFtexZotQp
         s+onQmxtT9bI85WCI7+WVYNUnxrKeck3VRU58Uqg2JFdVrTKW8cKwEas4YBqMHibBN2v
         2gqpJZ96VNClvb3fyyjUGdLyJsM8QkwmQ5oDVt8hPWYcjl8j5OLRSlhIeW3M78dXQ0R7
         NcDQ==
X-Gm-Message-State: AOAM533ipMNZHqzC7eiCNGlu2EbM8TjshW2R1g1j0GstxfjBdvwOuPPy
        BldTRBQeZI2ZqqMVQmSOXknck7zyS74k4LuBJoiV9x1e
X-Google-Smtp-Source: ABdhPJxnpP2VO5mNc14SXisGfERyPGY2gcFajNEbPhdVi7a7lKySSEX3vu6h8QfBzgmg3c6qhkbSumGBtJ0kug5rh48=
X-Received: by 2002:a17:907:7704:b0:6cf:48ac:b4a8 with SMTP id
 kw4-20020a170907770400b006cf48acb4a8mr16675736ejc.305.1650901636036; Mon, 25
 Apr 2022 08:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-8-aford173@gmail.com>
 <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm> <4b958892ba788a0e9e73a9135c305aacbe33294d.camel@pengutronix.de>
In-Reply-To: <4b958892ba788a0e9e73a9135c305aacbe33294d.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 25 Apr 2022 10:47:04 -0500
Message-ID: <CAHCN7xKEWT=-ujUD0KC9O=VUyCDSGzwbB1_dC51_k=Hx3i6+bg@mail.gmail.com>
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2 VPU's
 with vpu-blk-ctrl
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        linux-media <linux-media@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:34 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Martin,
>
> Am Montag, dem 25.04.2022 um 17:22 +0200 schrieb Martin Kepplinger:
> > Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> > > With the Hantro G1 and G2 now setup to run independently, update
> > > the device tree to allow both to operate.  This requires the
> > > vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> > > certain clock enabled to handle the gating of the G1 and G2
> > > fuses, the clock-parents and clock-rates for the various VPU's
> > > to be moved into the pgc_vpu because they cannot get re-parented
> > > once enabled, and the pgc_vpu is the highest in the chain.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 2df2510d0118..549b2440f55d 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
> > >                                         pgc_vpu: power-domain@6 {
> > >                                                 #power-domain-cells =
> > > <0>;
> > >                                                 reg =
> > > <IMX8M_POWER_DOMAIN_VPU>;
> > > -                                               clocks = <&clk
> > > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > +                                               clocks = <&clk
> > > IMX8MQ_CLK_VPU_DEC_ROOT>,
> > > +                                                        <&clk
> > > IMX8MQ_CLK_VPU_G1_ROOT>,
> > > +                                                        <&clk
> > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > +                                               assigned-clocks =
> > > <&clk IMX8MQ_CLK_VPU_G1>,
> > > +
> > > <&clk IMX8MQ_CLK_VPU_G2>,
> > > +
> > > <&clk IMX8MQ_CLK_VPU_BUS>,
> > > +
> > > <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > > +                                               assigned-clock-
> > > parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > > +
> > >     <&clk IMX8MQ_VPU_PLL_OUT>,
> > > +
> > >     <&clk IMX8MQ_SYS1_PLL_800M>,
> > > +
> > >     <&clk IMX8MQ_VPU_PLL>;
> > > +                                               assigned-clock-rates
> > > = <600000000>,
> > > +
> > >   <600000000>,
> > > +
> > >   <800000000>,
> > > +
> > >   <0>;
> > >                                         };
> > >
> > >                                         pgc_disp: power-domain@7 {
> > > @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
> > >                         status = "disabled";
> > >                 };
> > >
> > > -               vpu: video-codec@38300000 {
> > > -                       compatible = "nxp,imx8mq-vpu";
> > > -                       reg = <0x38300000 0x10000>,
> > > -                             <0x38310000 0x10000>,
> > > -                             <0x38320000 0x10000>;
> > > -                       reg-names = "g1", "g2", "ctrl";
> > > -                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > -                                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > > -                       interrupt-names = "g1", "g2";
> > > +               vpu_g1: video-codec@38300000 {
> > > +                       compatible = "nxp,imx8mq-vpu-g1";
> > > +                       reg = <0x38300000 0x10000>;
> > > +                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> > > +                       power-domains = <&vpu_blk_ctrl
> > > IMX8MQ_VPUBLK_PD_G1>;
> > > +               };
> > > +
> > > +               vpu_g2: video-codec@38310000 {
> > > +                       compatible = "nxp,imx8mq-vpu-g2";
> > > +                       reg = <0x38310000 0x10000>;
> > > +                       interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > > +                       power-domains = <&vpu_blk_ctrl
> > > IMX8MQ_VPUBLK_PD_G2>;
> > > +               };
> > > +
> > > +               vpu_blk_ctrl: blk-ctrl@38320000 {
> > > +                       compatible = "fsl,imx8mq-vpu-blk-ctrl";
> > > +                       reg = <0x38320000 0x100>;
> > > +                       power-domains = <&pgc_vpu>, <&pgc_vpu>,
> > > <&pgc_vpu>;
> > > +                       power-domain-names = "bus", "g1", "g2";
> > >                         clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> > > -                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> > > -                                <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > -                       clock-names = "g1", "g2", "bus";
> > > -                       assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> > > -                                         <&clk IMX8MQ_CLK_VPU_G2>,
> > > -                                         <&clk IMX8MQ_CLK_VPU_BUS>,
> > > -                                         <&clk
> > > IMX8MQ_VPU_PLL_BYPASS>;
> > > -                       assigned-clock-parents = <&clk
> > > IMX8MQ_VPU_PLL_OUT>,
> > > -                                                <&clk
> > > IMX8MQ_VPU_PLL_OUT>,
> > > -                                                <&clk
> > > IMX8MQ_SYS1_PLL_800M>,
> > > -                                                <&clk
> > > IMX8MQ_VPU_PLL>;
> > > -                       assigned-clock-rates = <600000000>,
> > > <600000000>,
> > > -                                              <800000000>, <0>;
> > > -                       power-domains = <&pgc_vpu>;
> > > +                                <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > > +                       clock-names = "g1", "g2";
> > > +                       #power-domain-cells = <1>;
> > >                 };
> > >
> > >                 pcie0: pcie@33800000 {
> >
> > With this update, when testing suspend to ram on imx8mq, I get:
> >
> > buck4: failed to disable: -ETIMEDOUT
> >
> > where buck4 is power-supply of pgc_vpu. And thus the transition to
> > suspend (and resuming) fails.
> >
> > Have you tested system suspend after the imx8m-blk-ctrl update on
> > imx8mq?
>
> I haven't tested system suspend, don't know if anyone else did. However
> I guess that this is just uncovering a preexisting issue in the system
> suspend sequencing, which you would also hit if the video decoders were
> active at system suspend time.

I have not tested it either.

>
> My guess is that the regulator disable fails, due to the power domains
> being disabled quite late in the suspend sequence, where i2c
> communication with the PMIC is no longer possible due to i2c being
> suspended already or something like that. Maybe you can dig in a bit on
> the actual sequence on your system and we can see how we can rework
> things to suspend the power domains at a time where communication with
> the PMIC is still possible?

In the meantime, should we mark the regulator with regulator-always-on
so it doesn't attempt to power it down?  It might not be ideal,but it
might be enough to let it suspend.

adam
>
> Regards,
> Lucas
>
