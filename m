Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47349BBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiAYTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiAYTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:08:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A3C06173B;
        Tue, 25 Jan 2022 11:08:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id p12so65136428edq.9;
        Tue, 25 Jan 2022 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KHYuO9BIb/dJb7fY+KxNNxhyGeTxeET42tjQ6h3Wb8=;
        b=PErttFt/Al+rGnJ4DLDMNiS9Bze6yfOzYGODufHp62yyztZZkWj4PIVOYGWYHnan1T
         RGENBNcXptSl3gN9P7z6h9NVeXjj0etWWXfDw6+ZnBYM3XJy8dTJI58ZQz+Z2T7aGH4V
         +Wf8KIPfakDj7RWHkRnl4XhDvdwt+RnNHfUaRdLQfiPCVV5ihAl8WXwPXbDiAodMExl/
         t1QcUZPwW8hQ6IQAlHRWc4RxnxCuWZADQUpS02Qvt1D2DxNS59zlRB+d2j/kHqPlMEGC
         zq3Wp6WUBBzYefo03eGVqgIEQKWYHhiCw3u3fb86naoZyXBbU0s5GlIDafVZR3oPyHpS
         d/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KHYuO9BIb/dJb7fY+KxNNxhyGeTxeET42tjQ6h3Wb8=;
        b=YiAxJIayfHAz6CxBqCm90WVpwICFLH2+ot3bgBHJ8tchCVf0yGNzRa3sw5m38QAvv6
         AsIE/RFqLnynFQxt3QNVTfhMfqd5oGa2szVf+y6soNicmJUvQ8/MtMhtHNHGQGJt9AO0
         op+OOaJD2ITIbtJr4YZzgV3ponzz0EAJQ8T8w8VlEXTgDZcrkmuKOvcKi/dDdN2OaLWa
         k3EkOH1MJgD7EcAOcktLiFHCedfcAQTs56LRBPIJbEmbB//XbXW63vOElSrhMmW/sfTL
         y/DWASIQ6KNhL1jcg4UH+5H461aplRBZZ8xwxuuJ7qypF1F6JKjQ8twok3GqdcL3i5VJ
         VW9w==
X-Gm-Message-State: AOAM533emUNxiJQyrEa5NgHq8ziRnTZ4h0NWLqOAXngR59UPi/DA++pg
        kX7X5JqE5lmwAUnLXd2W0fBcdCPfv9tC4PVYQJk=
X-Google-Smtp-Source: ABdhPJzYHpFJlqDny6UdInSzsBm83WymJLGUWmYMSCU/OrIsUErfJZw2nBNbbNX7o16vjFmSwnoDr7q+9M1Wx8ARXyQ=
X-Received: by 2002:a05:6402:1119:: with SMTP id u25mr21599441edv.367.1643137719736;
 Tue, 25 Jan 2022 11:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-8-aford173@gmail.com>
 <YfBJxmgwLGbVqGba@eze-laptop>
In-Reply-To: <YfBJxmgwLGbVqGba@eze-laptop>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 25 Jan 2022 13:08:28 -0600
Message-ID: <CAHCN7xL-c4rXFW3cO4c0QmnqtaRpU_HfPb46UQFzPzb2RojChw@mail.gmail.com>
Subject: Re: [PATCH V4 07/11] arm64: dts: imx8mq: Enable both G1 and G2 VPU's
 with vpu-blk-ctrl
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 1:04 PM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> On Tue, Jan 25, 2022 at 11:11:24AM -0600, Adam Ford wrote:
> > With the Hantro G1 and G2 now setup to run independently, update
> > the device tree to allow both to operate.  This requires the
> > vpu-blk-ctrl node to be configured.  Since vpu-blk-ctrl needs
> > certain clock enabled to handle the gating of the G1 and G2
> > fuses, the clock-parents and clock-rates for the various VPU's
> > to be moved into the pgc_vpu because they cannot get re-parented
> > once enabled, and the pgc_vpu is the highest in the chain.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> It doesn't seem correct to have the Reported-by on this commit.

I didn't put it here, because I fixed it in a whole different patch
(Patch 1/11).  This patch remains unchanged.  I probably should have
put in the other patch, but I didn't think it was essential.  Sorry
about that. Do I need to resend to just add the r-b tag?

adam

>
> Thanks,
> Ezequiel
>
> > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 2df2510d0118..549b2440f55d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -737,7 +737,21 @@ pgc_gpu: power-domain@5 {
> >                                       pgc_vpu: power-domain@6 {
> >                                               #power-domain-cells = <0>;
> >                                               reg = <IMX8M_POWER_DOMAIN_VPU>;
> > -                                             clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> > +                                             clocks = <&clk IMX8MQ_CLK_VPU_DEC_ROOT>,
> > +                                                      <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> > +                                                      <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                                             assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> > +                                                               <&clk IMX8MQ_CLK_VPU_G2>,
> > +                                                               <&clk IMX8MQ_CLK_VPU_BUS>,
> > +                                                               <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > +                                             assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > +                                                                      <&clk IMX8MQ_VPU_PLL_OUT>,
> > +                                                                      <&clk IMX8MQ_SYS1_PLL_800M>,
> > +                                                                      <&clk IMX8MQ_VPU_PLL>;
> > +                                             assigned-clock-rates = <600000000>,
> > +                                                                    <600000000>,
> > +                                                                    <800000000>,
> > +                                                                    <0>;
> >                                       };
> >
> >                                       pgc_disp: power-domain@7 {
> > @@ -1457,30 +1471,31 @@ usb3_phy1: usb-phy@382f0040 {
> >                       status = "disabled";
> >               };
> >
> > -             vpu: video-codec@38300000 {
> > -                     compatible = "nxp,imx8mq-vpu";
> > -                     reg = <0x38300000 0x10000>,
> > -                           <0x38310000 0x10000>,
> > -                           <0x38320000 0x10000>;
> > -                     reg-names = "g1", "g2", "ctrl";
> > -                     interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > -                                  <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > -                     interrupt-names = "g1", "g2";
> > +             vpu_g1: video-codec@38300000 {
> > +                     compatible = "nxp,imx8mq-vpu-g1";
> > +                     reg = <0x38300000 0x10000>;
> > +                     interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> > +                     power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
> > +             };
> > +
> > +             vpu_g2: video-codec@38310000 {
> > +                     compatible = "nxp,imx8mq-vpu-g2";
> > +                     reg = <0x38310000 0x10000>;
> > +                     interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                     power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
> > +             };
> > +
> > +             vpu_blk_ctrl: blk-ctrl@38320000 {
> > +                     compatible = "fsl,imx8mq-vpu-blk-ctrl";
> > +                     reg = <0x38320000 0x100>;
> > +                     power-domains = <&pgc_vpu>, <&pgc_vpu>, <&pgc_vpu>;
> > +                     power-domain-names = "bus", "g1", "g2";
> >                       clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> > -                              <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> > -                              <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> > -                     clock-names = "g1", "g2", "bus";
> > -                     assigned-clocks = <&clk IMX8MQ_CLK_VPU_G1>,
> > -                                       <&clk IMX8MQ_CLK_VPU_G2>,
> > -                                       <&clk IMX8MQ_CLK_VPU_BUS>,
> > -                                       <&clk IMX8MQ_VPU_PLL_BYPASS>;
> > -                     assigned-clock-parents = <&clk IMX8MQ_VPU_PLL_OUT>,
> > -                                              <&clk IMX8MQ_VPU_PLL_OUT>,
> > -                                              <&clk IMX8MQ_SYS1_PLL_800M>,
> > -                                              <&clk IMX8MQ_VPU_PLL>;
> > -                     assigned-clock-rates = <600000000>, <600000000>,
> > -                                            <800000000>, <0>;
> > -                     power-domains = <&pgc_vpu>;
> > +                              <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> > +                     clock-names = "g1", "g2";
> > +                     #power-domain-cells = <1>;
> >               };
> >
> >               pcie0: pcie@33800000 {
> > --
> > 2.32.0
> >
