Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359804C6D45
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiB1M6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiB1M6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:58:43 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB098506D7;
        Mon, 28 Feb 2022 04:58:04 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h126so5396815ybc.1;
        Mon, 28 Feb 2022 04:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPns1/npz7Dlc50rQYvlC2uiB8hqGLU7hoL0Zgx0XJ0=;
        b=pEolgqNiqpxngoF3DgV5antmR2xK1ESw6GfdlgaC1VRT62KrVi1FE94NVxvHe2y040
         DCgDJOZ8s0kSQSPw6C9sx78FJavBTotCFHL/anc4DfXGcrgvPo8okv1JUkhqVfi/se9i
         hW06Ah3qyMKaaKOTNtTu8wbusrbB7phNlPF+AySvdDIO7u1QsCzFU7mpPGJHlzk9Mby6
         UdsH3Nd6/98kA7DwkBYhjYGX9ZL6TzuOELKMCJfbDGjyY8VVL4mqSLXGaumytYsPQ2HJ
         9J/sCwpo1GpeL79zD5T/i/qLvHLVrKyKmbC72hCBVyK1VCZmw12EYO+c52RVTUKHhVzh
         rDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPns1/npz7Dlc50rQYvlC2uiB8hqGLU7hoL0Zgx0XJ0=;
        b=UDc3wWgvAiDsxDBd8oRzclr4XX1NBcSMdez0RVuFiFiclm12iU4YDvY1t5MjuwAu2+
         E/XEm1iGejBesR9VoKpGeDyeVH2nLy5k7OmGXqgVIecpjJBPQfOA2JBtirMqtI4zuj3r
         DL7UT/K8St9v1zJ8eAEur0z1Qwz8sXRmAZgR+jDRaY2rBIzBUd96Bu3TYcsma70StjVD
         f+aENmhB1Uq3VTVu97q/LtfrlG0vUgkNNb0g7ukPx0DFy8xYzQpZJS1OIZhiyfm2B3l8
         NTfWUf9oDFoIqhx2JE22sbWQZkOxIZAbCH7jWAKcJnM2dGx6BKuTss89Pg2Hr04etmW9
         XSJg==
X-Gm-Message-State: AOAM533bzQ0COzHYLi4oKO4LKs3kcpv5HJgz27uM9SkHHmclO38ckiNq
        l7LknXgYZTfWJdbMlL4FQT+QswfiFsqt5tHOLQM=
X-Google-Smtp-Source: ABdhPJyMMcn4V8F4Xi286fHhfGSOe0I5iwgQNzJBxzAM62I7vOIac08EqoIzl0comFG8kmVNvryVHX5S6ObASHPyNZo=
X-Received: by 2002:a25:5145:0:b0:61d:ad99:6e5a with SMTP id
 f66-20020a255145000000b0061dad996e5amr18295765ybb.228.1646053084143; Mon, 28
 Feb 2022 04:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20220227153016.950473-1-pgwipeout@gmail.com> <20220227153016.950473-6-pgwipeout@gmail.com>
 <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net>
In-Reply-To: <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 28 Feb 2022 07:57:52 -0500
Message-ID: <CAMdYzYoEEY6-kGVDeWj9AoA98BL5hxnc_4CnUPiuStUnSrFXLA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 2:24 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> On 2/27/22 16:30, Peter Geis wrote:
> > Add the dwc3 device nodes to the rk356x device trees.
> > The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> > dwc3 host controller.
> > The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> > dwc3 host controller.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
> >  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
> >  3 files changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> > index 3839eef5e4f7..0b957068ff89 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> > @@ -6,6 +6,10 @@ / {
> >       compatible = "rockchip,rk3566";
> >  };
> >
> > +&pipegrf {
> > +     compatible = "rockchip,rk3566-pipe-grf", "syscon";
> > +};
> > +
> >  &power {
> >       power-domain@RK3568_PD_PIPE {
> >               reg = <RK3568_PD_PIPE>;
> > @@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
> >               #power-domain-cells = <0>;
> >       };
> >  };
> > +
> > +&usb_host0_xhci {
> > +     phys = <&usb2phy0_otg>;
> > +     phy-names = "usb2-phy";
> > +     extcon = <&usb2phy0>;
>
> I wonder what the correct place for this extcon property is. You defined
> it on SoC (RK3566) level, in my patch for the RK3568 EVB1 it is added on
> board level. Is this common to all RK356x variants?

Yes, the usb2phy is always available as an extcon unless you make a
device that doesn't have usb2 capability.
In that case you'd have to override the device anyways.
If we want to turn on default role otg here, we'd need this defined
here as well or things break.

>
> Best regards,
> Michael
>
> > +     maximum-speed = "high-speed";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > index 5b0f528d6818..8ba9334f9753 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > @@ -99,6 +99,10 @@ opp-1992000000 {
> >       };
> >  };
> >
> > +&pipegrf {
> > +     compatible = "rockchip,rk3568-pipe-grf", "syscon";
> > +};
> > +
> >  &power {
> >       power-domain@RK3568_PD_PIPE {
> >               reg = <RK3568_PD_PIPE>;
> > @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
> >               #power-domain-cells = <0>;
> >       };
> >  };
> > +
> > +&usb_host0_xhci {
> > +     phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> > +     phy-names = "usb2-phy", "usb3-phy";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 7cdef800cb3c..072bb9080cd6 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
> >               };
> >       };
> >
> > +     usb_host0_xhci: usb@fcc00000 {
> > +             compatible = "snps,dwc3";
> > +             reg = <0x0 0xfcc00000 0x0 0x400000>;
> > +             interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> > +                      <&cru ACLK_USB3OTG0>;
> > +             clock-names = "ref_clk", "suspend_clk",
> > +                           "bus_clk";
> > +             dr_mode = "host";
> > +             phy_type = "utmi_wide";
> > +             power-domains = <&power RK3568_PD_PIPE>;
> > +             resets = <&cru SRST_USB3OTG0>;
> > +             snps,dis_u2_susphy_quirk;
> > +             status = "disabled";
> > +     };
> > +
> > +     usb_host1_xhci: usb@fd000000 {
> > +             compatible = "snps,dwc3";
> > +             reg = <0x0 0xfd000000 0x0 0x400000>;
> > +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> > +                      <&cru ACLK_USB3OTG1>;
> > +             clock-names = "ref_clk", "suspend_clk",
> > +                           "bus_clk";
> > +             dr_mode = "host";
> > +             phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> > +             phy-names = "usb2-phy", "usb3-phy";
> > +             phy_type = "utmi_wide";
> > +             power-domains = <&power RK3568_PD_PIPE>;
> > +             resets = <&cru SRST_USB3OTG1>;
> > +             snps,dis_u2_susphy_quirk;
> > +             status = "disabled";
> > +     };
> > +
> >       gic: interrupt-controller@fd400000 {
> >               compatible = "arm,gic-v3";
> >               reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> > @@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
> >       };
> >
> >       pipegrf: syscon@fdc50000 {
> > -             compatible = "rockchip,rk3568-pipe-grf", "syscon";
> >               reg = <0x0 0xfdc50000 0x0 0x1000>;
> >       };
> >
