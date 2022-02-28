Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C354C6D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiB1NDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiB1NDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:03:48 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343A3818D;
        Mon, 28 Feb 2022 05:03:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id w63so20296527ybe.10;
        Mon, 28 Feb 2022 05:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNRpJ8Jt0R4tLiHb+HbtNStgEz1uJPOasiJ9YaxoRyE=;
        b=Kzl42XOXSMpcT+U+yQtmSD3Oi1GMkdaYWBvnvpS1Bsc2B8RW3KHhAfMl+eNytnrtQ6
         jpXjmVLFo9aEjiVP38S8tnzVWAOMmsoAxmSnJ4HnJQuKYV8oQJJxfmLZ5tnAEy4UPF3X
         UbLmGkryDBNour+hvbHxTLvZ62Av4nzaO3tix9SsyaSp+USYzyyqzzZ9Dl/uBPAfzS6k
         KzKcLDFy/mXsRdUZbd7x18KB8RuS/s85Yi/+wwGzyyka6FrFdfmkgMn3Q24NHhDydeVB
         x0hbJ667CR5RvMlzwyo5mdON4aypx97qQk/Gqtp7qcYTX/ItDGW38EN++tLTYTOHZVNv
         6Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNRpJ8Jt0R4tLiHb+HbtNStgEz1uJPOasiJ9YaxoRyE=;
        b=Rd5CTDITsYIzcvh50WtFmlcf1RLVQYe5BrCMIvkXB2AAW3BpHhyJtLj45jmI1vsHhf
         sBRQnCfrea18+UNigSd8yiJTr7ZcaEAyoG9R3FDnptn7Ux1j+/e4Mi+zWAK2i7v0SSzI
         GwdpunR+R23346bJrW1IkS0T5M18cu6fYOcWWMLPVfobNQ0wpLoY3Z4IRel5woDYdKR6
         eEjQwqVbms9KBteO6Dyy2hICp1y2NwfrTtZ+L4KbDnDeKgniZTs82Yyc6T9LGhmrripe
         mRr4JsFQt1MTRhkQF9v8yEB9pfD7DzPq4AQ4eOPYorN5dokPyerRkg7IKmA3wJ6F/o5s
         BG9Q==
X-Gm-Message-State: AOAM5305QX1etqqwx66Nevu0F2Hm+mnR1UYZ0wmU/U0rsITWNAzKdy8X
        IP6WqqwnSj4xjph4ZIU3qx2mJupJ1MK3+SfhXTA=
X-Google-Smtp-Source: ABdhPJzdvs82iiLgz3fdUf6D7AXDXcRrUJFEWDi/y6IeOiMBH50lTEy7Evn/Bj6NJNrAgF97jy+vsGyQmDKcXjxwBMk=
X-Received: by 2002:a25:5d0:0:b0:61d:932b:6fc0 with SMTP id
 199-20020a2505d0000000b0061d932b6fc0mr18827087ybf.585.1646053388782; Mon, 28
 Feb 2022 05:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20220227153016.950473-1-pgwipeout@gmail.com> <20220227153016.950473-6-pgwipeout@gmail.com>
 <7b20fccd-4394-da3c-6556-4732d67cde3d@gmail.com> <CAMdYzYp8x_mKffm1WkHD4D1Fx_tVJ8WdBc=u-j+j_zRbJmyaCQ@mail.gmail.com>
 <3ac3cdf9-17c0-654f-b204-c5b4b0436c98@gmail.com>
In-Reply-To: <3ac3cdf9-17c0-654f-b204-c5b4b0436c98@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 28 Feb 2022 08:02:57 -0500
Message-ID: <CAMdYzYrxQUhFNog1hvwme=V-3xptE6C9Se09FxEoEQm9bPdEEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
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

On Mon, Feb 28, 2022 at 4:10 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 2/27/22 23:44, Peter Geis wrote:
> > On Sun, Feb 27, 2022 at 12:50 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >>
> >>
> >> On 2/27/22 16:30, Peter Geis wrote:
> >>> Add the dwc3 device nodes to the rk356x device trees.
> >>> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> >>> dwc3 host controller.
> >>> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> >>> dwc3 host controller.
> >>>
> >>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
> >>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
> >>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
> >>>  3 files changed, 54 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> >>> index 3839eef5e4f7..0b957068ff89 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> >>> @@ -6,6 +6,10 @@ / {
> >>>       compatible = "rockchip,rk3566";
> >>>  };
> >>>
> >>> +&pipegrf {
> >>> +     compatible = "rockchip,rk3566-pipe-grf", "syscon";
> >>> +};
> >>> +
> >>>  &power {
> >>>       power-domain@RK3568_PD_PIPE {
> >>>               reg = <RK3568_PD_PIPE>;
> >>> @@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
> >>>               #power-domain-cells = <0>;
> >>>       };
> >>>  };
> >>> +
> >>> +&usb_host0_xhci {
> >>> +     phys = <&usb2phy0_otg>;
> >>> +     phy-names = "usb2-phy";
> >>> +     extcon = <&usb2phy0>;
> >>> +     maximum-speed = "high-speed";
> >>> +};
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >>> index 5b0f528d6818..8ba9334f9753 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> >>> @@ -99,6 +99,10 @@ opp-1992000000 {
> >>>       };
> >>>  };
> >>>
> >>> +&pipegrf {
> >>> +     compatible = "rockchip,rk3568-pipe-grf", "syscon";
> >>> +};
> >>> +
> >>>  &power {
> >>>       power-domain@RK3568_PD_PIPE {
> >>>               reg = <RK3568_PD_PIPE>;
> >>> @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
> >>>               #power-domain-cells = <0>;
> >>>       };
> >>>  };
> >>> +
> >>> +&usb_host0_xhci {
> >>> +     phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> >>> +     phy-names = "usb2-phy", "usb3-phy";
> >>> +};
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >>> index 7cdef800cb3c..072bb9080cd6 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >>> @@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
> >>>               };
> >>>       };
> >>>
> >>> +     usb_host0_xhci: usb@fcc00000 {
> >>
> >>> +             compatible = "snps,dwc3";
> >>
> >> compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> >>
> >> compatible strings must be SoC orientated.
> >> Add binding like you did before.
> >
> > Okay, should this go in the core yaml, since it's not really handled
> > by of-simple?
>
> Nothing to change in core.c, because the fall back string does the
> trick, so we don't have to change the driver for every new SoC.
> Change the node compatible here and add the binding.
> That's it. The rest comes later if needed.

It's the binding I'm referring to here.
snps,dwc3.yaml seems the logical place, but I want to make sure you
concur first.

>
> > Also, should I add in the compatible for rk3328 as well?
>
> No, same story the fall back string does the trick in core.c

Same thing here, since I'm in snps,dwc3.yaml anyways I can add the
rk3328 binding in and silence that error in one go.

>
>
> >
> >>
> >>> +             reg = <0x0 0xfcc00000 0x0 0x400000>;
> >>> +             interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> >>> +             clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> >>> +                      <&cru ACLK_USB3OTG0>;
> >>> +             clock-names = "ref_clk", "suspend_clk",
> >>> +                           "bus_clk";
> >>> +             dr_mode = "host";
> >>> +             phy_type = "utmi_wide";
> >>> +             power-domains = <&power RK3568_PD_PIPE>;
> >>> +             resets = <&cru SRST_USB3OTG0>;
> >>> +             snps,dis_u2_susphy_quirk;
> >>> +             status = "disabled";
> >>> +     };
> >>> +
> >>> +     usb_host1_xhci: usb@fd000000 {
> >>
> >>> +             compatible = "snps,dwc3";
> >>
> >> compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> >>
> >>> +             reg = <0x0 0xfd000000 0x0 0x400000>;
> >>> +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> >>> +             clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> >>> +                      <&cru ACLK_USB3OTG1>;
> >>> +             clock-names = "ref_clk", "suspend_clk",
> >>> +                           "bus_clk";
> >>> +             dr_mode = "host";
> >>> +             phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> >>> +             phy-names = "usb2-phy", "usb3-phy";
> >>> +             phy_type = "utmi_wide";
> >>> +             power-domains = <&power RK3568_PD_PIPE>;
> >>> +             resets = <&cru SRST_USB3OTG1>;
> >>> +             snps,dis_u2_susphy_quirk;
> >>> +             status = "disabled";
> >>> +     };
> >>> +
> >>>       gic: interrupt-controller@fd400000 {
> >>>               compatible = "arm,gic-v3";
> >>>               reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> >>> @@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
> >>>       };
> >>>
> >>>       pipegrf: syscon@fdc50000 {
> >>> -             compatible = "rockchip,rk3568-pipe-grf", "syscon";
> >>>               reg = <0x0 0xfdc50000 0x0 0x1000>;
> >>>       };
> >>>
