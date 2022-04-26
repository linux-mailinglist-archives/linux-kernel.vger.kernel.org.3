Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3750FC98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiDZMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbiDZMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:16:39 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C837793A1;
        Tue, 26 Apr 2022 05:13:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 656C8DF9D8;
        Tue, 26 Apr 2022 05:12:57 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dHTjuC8UYzNg; Tue, 26 Apr 2022 05:12:56 -0700 (PDT)
Message-ID: <8ed3a28d59b442b531e68e95d83b187bb3392940.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1650975176; bh=VWkH8rcInUFs9UbKb0LxSIlMAJMQ6LyhGXZsVywakZs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=taDBdh5iRlir6mS4ZmFtP7KbCAz3BZMi4m9vJxr12DqzMZ5ON/6NXhuKUG9OIohlm
         N+RB/i4TcVzxALrHeMDJHWpj8jklWSF0a5CdGMR8tjHE7s1sE+Lt4iUJsFpgibv6di
         dV9qvteTuXXcjNmMsa2zbEw4eZzHpHIoCSAPUs4PLO/eCZe4rTBG/weNbx9vrHKHYp
         mr+nKNAdTs73hRw5n0DOQqUarUi6pGZcD6r1jnPfRoQwdGUeU3DdH7hWrRAk12rMmX
         zRMgahWLfheiwfpwy6ZyGa8nc8AoP8DhHBrhX1oPmjHbRgbqBJ9f12tIixFwrLErvw
         Wcj45QAVloTzA==
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
Date:   Tue, 26 Apr 2022 14:12:48 +0200
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
> 
> Regards,
> Lucas
> 

not sure whether I correctly check that, but the last
i2c_imx_runtime_suspend() (here for i2c1 and i2c3) are executed before
the power-domain disable, so that makes sense(?):

[   40.774853] imx-pgc imx-pgc-domain.5: disable regulator now
[   40.786211] imx-i2c 30a20000.i2c: i2c_imx_runtime_suspend
[   40.910189] imx-i2c 30a40000.i2c: i2c_imx_runtime_suspend
[   40.940895] Freezing user space processes ... 
[   40.968914] rfkill: input handler enabled
[   40.979955] (elapsed 0.007 seconds) done.
[   40.984033] OOM killer disabled.
[   40.987297] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   41.264683] imx-pgc imx-pgc-domain.0: disable regulator now
[   41.271679] imx-pgc imx-pgc-domain.6: disable regulator now
[   41.378759] buck4: failed to disable: -ETIMEDOUT
[   41.383405] imx-pgc imx-pgc-domain.6: failed to disable regulator: -
110

And you can see that I have the domain.0 regulator set to always-on.
Otherwise it would time out as well in this case:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi#n900

thank a lot for taking the time to look at this!

                        martin


