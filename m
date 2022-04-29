Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2395145FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357024AbiD2Jzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356785AbiD2Jzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:55:37 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFA10FC;
        Fri, 29 Apr 2022 02:52:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 20B98DF653;
        Fri, 29 Apr 2022 02:52:19 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hbKJT36Pj-0Y; Fri, 29 Apr 2022 02:52:18 -0700 (PDT)
Message-ID: <7ecd4575c4702217141ebde059887b5938abdcff.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1651225938; bh=ZgGix2F2Sn/TSNDXA4kdVYqPvzE5HeGdUQPm0srQjRc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lkc2wxs1yiQjlRGWDAOCU8T7k3ETCu1/ZF84rGQNvv739mlgV18RTRfXudyPgu91m
         I7qw6Z+WX9eObPAHMT7JHvRkfgIQf3bzIfBEcQW8DbGH0EXj7NuKULQMungs1FLsI/
         ptN+p/PCpyfZZkA7sI3YQrc1DK73FLO/rAu2fSyLdPO41Qto2DQKDu5+hF4QMvuphe
         pg1nGM0EreuFCyJ0LeD1YujQPD8UQG1ZTHjsHH85htu+UrJ+iJS4knhTjTvlmIwVvW
         JlZt9jjW5AMGbF/mJ0Shhgxq+TV6Dqr3A8ijqDiQRD00LeO3jMfVZY2DJCe9QkPbSS
         d8xsVdNXi80UQ==
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2
 VPU's with vpu-blk-ctrl
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
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
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Fri, 29 Apr 2022 11:52:10 +0200
In-Reply-To: <17c5ef22479cfea3f43dce1885f6613f1bef8064.camel@pengutronix.de>
References: <20220125171129.472775-1-aford173@gmail.com>
         <20220125171129.472775-8-aford173@gmail.com>
         <d6c5c5663f8ae904d409240063295cf516e17dd1.camel@puri.sm>
         <4b958892ba788a0e9e73a9135c305aacbe33294d.camel@pengutronix.de>
         <c11a58ecc5da2e206fc2b942980223a04a103f19.camel@puri.sm>
         <17c5ef22479cfea3f43dce1885f6613f1bef8064.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 26.04.2022 um 12:43 +0200 schrieb Lucas Stach:
> Am Dienstag, dem 26.04.2022 um 09:38 +0200 schrieb Martin Kepplinger:
> > Am Montag, dem 25.04.2022 um 17:34 +0200 schrieb Lucas Stach:
> > > Hi Martin,
> > > 
> > > Am Montag, dem 25.04.2022 um 17:22 +0200 schrieb Martin
> > > Kepplinger:
> > > > Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> > > > > With the Hantro G1 and G2 now setup to run independently,
> > > > > update
> > > > > the device tree to allow both to operate.  This requires the
> > > > > vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> > > > > certain clock enabled to handle the gating of the G1 and G2
> > > > > fuses, the clock-parents and clock-rates for the various
> > > > > VPU's
> > > > > to be moved into the pgc_vpu because they cannot get re-
> > > > > parented
> > > > > once enabled, and the pgc_vpu is the highest in the chain.
> > > > > 
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > index 2df2510d0118..549b2440f55d 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
> > > > >                                         pgc_vpu: power-
> > > > > domain@6 {
> > > > >                                                 #power-
> > > > > domain-
> > > > > cells =
> > > > > <0>;
> > > > >                                                 reg =
> > > > > <IMX8M_POWER_DOMAIN_VPU>;
> > > > > -                                               clocks =
> > > > > <&clk
> > > > > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > > > +                                               clocks =
> > > > > <&clk
> > > > > IMX8MQ_CLK_VPU_DEC_ROOT>,
> > > > > +                                                       
> > > > > <&clk
> > > > > IMX8MQ_CLK_VPU_G1_ROOT>,
> > > > > +                                                       
> > > > > <&clk
> > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > +                                               assigned-
> > > > > clocks =
> > > > > <&clk IMX8MQ_CLK_VPU_G1>,
> > > > > +                                                            
> > > > >     
> > > > > <&clk IMX8MQ_CLK_VPU_G2>,
> > > > > +                                                            
> > > > >     
> > > > > <&clk IMX8MQ_CLK_VPU_BUS>,
> > > > > +                                                            
> > > > >     
> > > > > <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > > > > +                                               assigned-
> > > > > clock-
> > > > > parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >     <&clk IMX8MQ_VPU_PLL_OUT>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >     <&clk IMX8MQ_SYS1_PLL_800M>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >     <&clk IMX8MQ_VPU_PLL>;
> > > > > +                                               assigned-
> > > > > clock-
> > > > > rates
> > > > > = <600000000>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >   <600000000>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >   <800000000>,
> > > > > +                                                            
> > > > >     
> > > > >     
> > > > >   <0>;
> > > > >                                         };
> > > > >  
> > > > >                                         pgc_disp:
> > > > > power-domain@7
> > > > > {
> > > > > @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
> > > > >                         status = "disabled";
> > > > >                 };
> > > > >  
> > > > > -               vpu: video-codec@38300000 {
> > > > > -                       compatible = "nxp,imx8mq-vpu";
> > > > > -                       reg = <0x38300000 0x10000>,
> > > > > -                             <0x38310000 0x10000>,
> > > > > -                             <0x38320000 0x10000>;
> > > > > -                       reg-names = "g1", "g2", "ctrl";
> > > > > -                       interrupts = <GIC_SPI 7
> > > > > IRQ_TYPE_LEVEL_HIGH>,
> > > > > -                                    <GIC_SPI 8
> > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > -                       interrupt-names = "g1", "g2";
> > > > > +               vpu_g1: video-codec@38300000 {
> > > > > +                       compatible = "nxp,imx8mq-vpu-g1";
> > > > > +                       reg = <0x38300000 0x10000>;
> > > > > +                       interrupts = <GIC_SPI 7
> > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                       clocks = <&clk
> > > > > IMX8MQ_CLK_VPU_G1_ROOT>;
> > > > > +                       power-domains = <&vpu_blk_ctrl
> > > > > IMX8MQ_VPUBLK_PD_G1>;
> > > > > +               };
> > > > > +
> > > > > +               vpu_g2: video-codec@38310000 {
> > > > > +                       compatible = "nxp,imx8mq-vpu-g2";
> > > > > +                       reg = <0x38310000 0x10000>;
> > > > > +                       interrupts = <GIC_SPI 8
> > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                       clocks = <&clk
> > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > +                       power-domains = <&vpu_blk_ctrl
> > > > > IMX8MQ_VPUBLK_PD_G2>;
> > > > > +               };
> > > > > +
> > > > > +               vpu_blk_ctrl: blk-ctrl@38320000 {
> > > > > +                       compatible = "fsl,imx8mq-vpu-blk-
> > > > > ctrl";
> > > > > +                       reg = <0x38320000 0x100>;
> > > > > +                       power-domains = <&pgc_vpu>,
> > > > > <&pgc_vpu>,
> > > > > <&pgc_vpu>;
> > > > > +                       power-domain-names = "bus", "g1",
> > > > > "g2";
> > > > >                         clocks = <&clk
> > > > > IMX8MQ_CLK_VPU_G1_ROOT>,
> > > > > -                                <&clk
> > > > > IMX8MQ_CLK_VPU_G2_ROOT>,
> > > > > -                                <&clk
> > > > > IMX8MQ_CLK_VPU_DEC_ROOT>;
> > > > > -                       clock-names = "g1", "g2", "bus";
> > > > > -                       assigned-clocks = <&clk
> > > > > IMX8MQ_CLK_VPU_G1>,
> > > > > -                                         <&clk
> > > > > IMX8MQ_CLK_VPU_G2>,
> > > > > -                                         <&clk
> > > > > IMX8MQ_CLK_VPU_BUS>,
> > > > > -                                         <&clk
> > > > > IMX8MQ_VPU_PLL_BYPASS>;
> > > > > -                       assigned-clock-parents = <&clk
> > > > > IMX8MQ_VPU_PLL_OUT>,
> > > > > -                                                <&clk
> > > > > IMX8MQ_VPU_PLL_OUT>,
> > > > > -                                                <&clk
> > > > > IMX8MQ_SYS1_PLL_800M>,
> > > > > -                                                <&clk
> > > > > IMX8MQ_VPU_PLL>;
> > > > > -                       assigned-clock-rates = <600000000>,
> > > > > <600000000>,
> > > > > -                                              <800000000>,
> > > > > <0>;
> > > > > -                       power-domains = <&pgc_vpu>;
> > > > > +                                <&clk
> > > > > IMX8MQ_CLK_VPU_G2_ROOT>;
> > > > > +                       clock-names = "g1", "g2";
> > > > > +                       #power-domain-cells = <1>;
> > > > >                 };
> > > > >  
> > > > >                 pcie0: pcie@33800000 {
> > > > 
> > > > With this update, when testing suspend to ram on imx8mq, I get:
> > > > 
> > > > buck4: failed to disable: -ETIMEDOUT
> > > > 
> > > > where buck4 is power-supply of pgc_vpu. And thus the transition
> > > > to
> > > > suspend (and resuming) fails.
> > > > 
> > > > Have you tested system suspend after the imx8m-blk-ctrl update
> > > > on
> > > > imx8mq?
> > > 
> > > I haven't tested system suspend, don't know if anyone else did.
> > > However
> > > I guess that this is just uncovering a preexisting issue in the
> > > system
> > > suspend sequencing, which you would also hit if the video
> > > decoders
> > > were
> > > active at system suspend time.
> > > 
> > > My guess is that the regulator disable fails, due to the power
> > > domains
> > > being disabled quite late in the suspend sequence, where i2c
> > > communication with the PMIC is no longer possible due to i2c
> > > being
> > > suspended already or something like that. Maybe you can dig in a
> > > bit
> > > on
> > > the actual sequence on your system and we can see how we can
> > > rework
> > > things to suspend the power domains at a time where communication
> > > with
> > > the PMIC is still possible?
> > 
> > What exactly would you like to see? Here's all gpcv2 regulators
> > disabling on suspend. (gpu (domain 5) is disabled by runtime pm
> > often):
> > 
> > [   47.138700] imx-pgc imx-pgc-domain.5: disabling regulator
> > [   47.298071] Freezing user space processes ... (elapsed 0.008
> > seconds) done.
> > [   47.313432] OOM killer disabled.
> > [   47.316670] Freezing remaining freezable tasks ... (elapsed
> > 2.221
> > seconds) done.
> > [   49.672052] imx8m-blk-ctrl 38320000.blk-ctrl:
> > imx8m_blk_ctrl_suspend
> > start
> > [   49.704417] imx-pgc imx-pgc-domain.0: disabling regulator
> > [   49.711114] imx-pgc imx-pgc-domain.6: disabling regulator
> > [   49.819064] buck4: failed to disable: -ETIMEDOUT
> > 
> > The stack looks pretty much the same for all of them, from
> > pm_suspend()
> > over genpd_suspend_noiry().
> 
> So the GPU domain is already suspended before the system suspend,
> probably due to short runtime PM timeouts.
> 
> Can you please check at which point the i2c subsystem is suspended? I
> think we are already past that point when running the PM domain
> suspend
> from a _noirq callback. I'll take a look on how we can properly
> change
> this ordering.

hi Lucas, when I just add the same system suspend hook you added to
gpcv2 (pm_runtime_get()), I get the same timeout:

[  366.100154] Freezing remaining freezable tasks ... (elapsed 2.863
seconds) done.
[  369.228387] imx-i2c 30a50000.i2c: pm_runtime get.
[  369.234204] imx-i2c 30a40000.i2c: pm_runtime get.
[  369.239834] imx-i2c 30a30000.i2c: pm_runtime get.
[  369.247417] imx-i2c 30a20000.i2c: pm_runtime get.
[  369.277838] imx-pgc imx-pgc-domain.0: disable regulator now
[  369.284758] imx-pgc imx-pgc-domain.6: disable regulator now
[  369.394954] buck4: failed to disable: -ETIMEDOUT

do you have an idea?

                              martin


