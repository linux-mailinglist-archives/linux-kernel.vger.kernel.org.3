Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70157021C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiGKMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:32:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E54E603
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:32:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so7379214ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx4Xj0vKM3i9b8JRtUJiv/sbaqsj2HeLHhMvN2rvbzQ=;
        b=InkBM8ViDKm5aLb2MeT/zAOxVF3eGAC8WlnxhjWChE7n2CDLvHpCe3Dq+yAnlWY6y5
         op0wpFNoTFP1AXUj0T5v2K8D4abTewJPr26cMOYUUGI2dz2GvGghJxuuSMSlRRKm68qS
         fBIllUi8s5VTs6u0fczmV+Gy3C/hJFD1sLOnGNDY/2tR+JLiWaK9SMpHm5b4XrwCEFea
         KruUDwljlzZF2DhfpSyArfYq9nTxQ8udeAM0Aw7SZE/saGyCdscgpovFlPcNS5oN1hBI
         orvTarntKuH2FOtLUxG4AQI3V1yi2zV1EN5AnftGKZV3CUBjHsuRIgUzXnwjYAyU8W3G
         9EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx4Xj0vKM3i9b8JRtUJiv/sbaqsj2HeLHhMvN2rvbzQ=;
        b=rR1eVqM5yFWpOiiiIbR0QXa7GQv6QvTjPdZprsZWsu9x8pgMipSC/t0c4ymxQxfrHR
         97pZLgkmKQQHmaSr7CqR+FceG7H3kZ8d1kznHG4s1rE3p9sgbT03ZhMywVA+FXP8gciq
         KMdNNtRNT4hmoznu0+SggojSVoeZ7nCnJV8JdLcaJP8AUyXSjNZTfCePUAT8/4OA3uXE
         mwVQSME/mrLBapMUB3waOYVK+SNlv6rApHr4QSnU0i2k7BcnQzgaP8WnZlChWH8FKBec
         0+2W1vFK9NSaPwgw5Pj1F5dTUvXpaFODjUpON4I1F+lm4kMdjdBwQf12DdHCeZKF2LOk
         uofw==
X-Gm-Message-State: AJIora/dtC7z3nPDrHo61QdutfItAcbbFoabYfXvWraVGgQPkiuwhr1u
        OowFKWLWyPiMV0lVVOrvyY4PF+03rlBHN8KbB52WbA==
X-Google-Smtp-Source: AGRyM1t2GYOvYiSczm91nCPcsRJRH4FqjR9E7NVKZ+m4L5fqZwnWxrxafS/w6hG5adH2Z02J62sZu85S85XMttB+tZA=
X-Received: by 2002:a17:906:2086:b0:717:4e91:f1db with SMTP id
 6-20020a170906208600b007174e91f1dbmr18061273ejq.345.1657542766827; Mon, 11
 Jul 2022 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-8-aford173@gmail.com>
 <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm> <4b958892ba788a0e9e73a9135c305aacbe33294d.camel@pengutronix.de>
 <c11a58ecc5da2e206fc2b942980223a04a103f19.camel@puri.sm> <17c5ef22479cfea3f43dce1885f6613f1bef8064.camel@pengutronix.de>
 <2f25ea965289f6fdcd5fc0f12f445b174637ce74.camel@puri.sm>
In-Reply-To: <2f25ea965289f6fdcd5fc0f12f445b174637ce74.camel@puri.sm>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 11 Jul 2022 09:32:35 -0300
Message-ID: <CAAEAJfACXrhHwF-Z9ygnZTUgKBQ3u1jHNDaMhgivq_rDr8xTNw@mail.gmail.com>
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2 VPU's
 with vpu-blk-ctrl
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, Jul 11, 2022 at 6:53 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Dienstag, dem 26.04.2022 um 12:43 +0200 schrieb Lucas Stach:
> > Am Dienstag, dem 26.04.2022 um 09:38 +0200 schrieb Martin Kepplinger:
> > > Am Montag, dem 25.04.2022 um 17:34 +0200 schrieb Lucas Stach:
> > > > Hi Martin,
> > > >
> > > > Am Montag, dem 25.04.2022 um 17:22 +0200 schrieb Martin
> > > > Kepplinger:
> > > > > Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> > > > > > With the Hantro G1 and G2 now setup to run independently,
> > > > > > update
> > > > > > the device tree to allow both to operate.  This requires the
> > > > > > vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> > > > > > certain clock enabled to handle the gating of the G1 and G2
> > > > > > fuses, the clock-parents and clock-rates for the various
> > > > > > VPU's
> > > > > > to be moved into the pgc_vpu because they cannot get re-
> > > > > > parented
> > > > > > once enabled, and the pgc_vpu is the highest in the chain.
> > > > > >
> > > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > index 2df2510d0118..549b2440f55d 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
> > > > > >                                         pgc_vpu: power-
> > > > > > domain@6 {
> > > > > >                                                 #power-
> > > > > > domain-
> > > > > > cells =
> > > > > > <0>;
> > > > > >                                                 reg =
> > > > > > <IMX8M_POWER_DOMAIN_VPU>;
> > > > > > -                                               clocks =
> > > > > > <&clk
> > > > > > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > > > > +                                               clocks =
> > > > > > <&clk
> > > > > > IMX8MQ_CLK_VPU_DEC_ROOT>,
> > > > > > +
> > > > > > <&clk
> > > > > > IMX8MQ_CLK_VPU_G1_ROOT>,
> > > > > > +
> > > > > > <&clk
> > > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > > +                                               assigned-
> > > > > > clocks =
> > > > > > <&clk IMX8MQ_CLK_VPU_G1>,
> > > > > > +
> > > > > >
> > > > > > <&clk IMX8MQ_CLK_VPU_G2>,
> > > > > > +
> > > > > >
> > > > > > <&clk IMX8MQ_CLK_VPU_BUS>,
> > > > > > +
> > > > > >
> > > > > > <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > > > > > +                                               assigned-
> > > > > > clock-
> > > > > > parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >     <&clk IMX8MQ_VPU_PLL_OUT>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >     <&clk IMX8MQ_SYS1_PLL_800M>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >     <&clk IMX8MQ_VPU_PLL>;
> > > > > > +                                               assigned-
> > > > > > clock-
> > > > > > rates
> > > > > > = <600000000>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >   <600000000>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >   <800000000>,
> > > > > > +
> > > > > >
> > > > > >
> > > > > >   <0>;
> > > > > >                                         };
> > > > > >
> > > > > >                                         pgc_disp:
> > > > > > power-domain@7
> > > > > > {
> > > > > > @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
> > > > > >                         status = "disabled";
> > > > > >                 };
> > > > > >
> > > > > > -               vpu: video-codec@38300000 {
> > > > > > -                       compatible = "nxp,imx8mq-vpu";
> > > > > > -                       reg = <0x38300000 0x10000>,
> > > > > > -                             <0x38310000 0x10000>,
> > > > > > -                             <0x38320000 0x10000>;
> > > > > > -                       reg-names = "g1", "g2", "ctrl";
> > > > > > -                       interrupts = <GIC_SPI 7
> > > > > > IRQ_TYPE_LEVEL_HIGH>,
> > > > > > -                                    <GIC_SPI 8
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > -                       interrupt-names = "g1", "g2";
> > > > > > +               vpu_g1: video-codec@38300000 {
> > > > > > +                       compatible = "nxp,imx8mq-vpu-g1";
> > > > > > +                       reg = <0x38300000 0x10000>;
> > > > > > +                       interrupts = <GIC_SPI 7
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                       clocks = <&clk
> > > > > > IMX8MQ_CLK_VPU_G1_ROOT>;
> > > > > > +                       power-domains = <&vpu_blk_ctrl
> > > > > > IMX8MQ_VPUBLK_PD_G1>;
> > > > > > +               };
> > > > > > +
> > > > > > +               vpu_g2: video-codec@38310000 {
> > > > > > +                       compatible = "nxp,imx8mq-vpu-g2";
> > > > > > +                       reg = <0x38310000 0x10000>;
> > > > > > +                       interrupts = <GIC_SPI 8
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                       clocks = <&clk
> > > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > > +                       power-domains = <&vpu_blk_ctrl
> > > > > > IMX8MQ_VPUBLK_PD_G2>;
> > > > > > +               };
> > > > > > +
> > > > > > +               vpu_blk_ctrl: blk-ctrl@38320000 {
> > > > > > +                       compatible = "fsl,imx8mq-vpu-blk-
> > > > > > ctrl";
> > > > > > +                       reg = <0x38320000 0x100>;
> > > > > > +                       power-domains = <&pgc_vpu>,
> > > > > > <&pgc_vpu>,
> > > > > > <&pgc_vpu>;
> > > > > > +                       power-domain-names = "bus", "g1",
> > > > > > "g2";
> > > > > >                         clocks = <&clk
> > > > > > IMX8MQ_CLK_VPU_G1_ROOT>,
> > > > > > -                                <&clk
> > > > > > IMX8MQ_CLK_VPU_G2_ROOT>,
> > > > > > -                                <&clk
> > > > > > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > > > > -                       clock-names = "g1", "g2", "bus";
> > > > > > -                       assigned-clocks = <&clk
> > > > > > IMX8MQ_CLK_VPU_G1>,
> > > > > > -                                         <&clk
> > > > > > IMX8MQ_CLK_VPU_G2>,
> > > > > > -                                         <&clk
> > > > > > IMX8MQ_CLK_VPU_BUS>,
> > > > > > -                                         <&clk
> > > > > > IMX8MQ_VPU_PLL_BYPASS>;
> > > > > > -                       assigned-clock-parents = <&clk
> > > > > > IMX8MQ_VPU_PLL_OUT>,
> > > > > > -                                                <&clk
> > > > > > IMX8MQ_VPU_PLL_OUT>,
> > > > > > -                                                <&clk
> > > > > > IMX8MQ_SYS1_PLL_800M>,
> > > > > > -                                                <&clk
> > > > > > IMX8MQ_VPU_PLL>;
> > > > > > -                       assigned-clock-rates = <600000000>,
> > > > > > <600000000>,
> > > > > > -                                              <800000000>,
> > > > > > <0>;
> > > > > > -                       power-domains = <&pgc_vpu>;
> > > > > > +                                <&clk
> > > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > > +                       clock-names = "g1", "g2";
> > > > > > +                       #power-domain-cells = <1>;
> > > > > >                 };
> > > > > >
> > > > > >                 pcie0: pcie@33800000 {
> > > > >
> > > > > With this update, when testing suspend to ram on imx8mq, I get:
> > > > >
> > > > > buck4: failed to disable: -ETIMEDOUT
> > > > >
> > > > > where buck4 is power-supply of pgc_vpu. And thus the transition
> > > > > to
> > > > > suspend (and resuming) fails.
> > > > >
> > > > > Have you tested system suspend after the imx8m-blk-ctrl update
> > > > > on
> > > > > imx8mq?
> > > >
> > > > I haven't tested system suspend, don't know if anyone else did.
> > > > However
> > > > I guess that this is just uncovering a preexisting issue in the
> > > > system
> > > > suspend sequencing, which you would also hit if the video
> > > > decoders
> > > > were
> > > > active at system suspend time.
> > > >
> > > > My guess is that the regulator disable fails, due to the power
> > > > domains
> > > > being disabled quite late in the suspend sequence, where i2c
> > > > communication with the PMIC is no longer possible due to i2c
> > > > being
> > > > suspended already or something like that. Maybe you can dig in a
> > > > bit
> > > > on
> > > > the actual sequence on your system and we can see how we can
> > > > rework
> > > > things to suspend the power domains at a time where communication
> > > > with
> > > > the PMIC is still possible?
> > >
> > > What exactly would you like to see? Here's all gpcv2 regulators
> > > disabling on suspend. (gpu (domain 5) is disabled by runtime pm
> > > often):
> > >
> > > [   47.138700] imx-pgc imx-pgc-domain.5: disabling regulator
> > > [   47.298071] Freezing user space processes ... (elapsed 0.008
> > > seconds) done.
> > > [   47.313432] OOM killer disabled.
> > > [   47.316670] Freezing remaining freezable tasks ... (elapsed
> > > 2.221
> > > seconds) done.
> > > [   49.672052] imx8m-blk-ctrl 38320000.blk-ctrl:
> > > imx8m_blk_ctrl_suspend
> > > start
> > > [   49.704417] imx-pgc imx-pgc-domain.0: disabling regulator
> > > [   49.711114] imx-pgc imx-pgc-domain.6: disabling regulator
> > > [   49.819064] buck4: failed to disable: -ETIMEDOUT
> > >
> > > The stack looks pretty much the same for all of them, from
> > > pm_suspend()
> > > over genpd_suspend_noiry().
> >
> > So the GPU domain is already suspended before the system suspend,
> > probably due to short runtime PM timeouts.
> >
> > Can you please check at which point the i2c subsystem is suspended? I
> > think we are already past that point when running the PM domain
> > suspend
> > from a _noirq callback. I'll take a look on how we can properly
> > change
> > this ordering.
> >
> > Regards,
> > Lucas
> >
>
> hi Lucas, sorry for not following up on this for so long. This fixes
> suspend/resume for me:
>
> https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t
>
> thank you for you help so far,
>

Thanks a lot for keeping us posted. The fix for suspend/resume
looks great!

Ezequiel
