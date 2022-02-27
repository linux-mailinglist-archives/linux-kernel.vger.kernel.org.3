Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FE4C5BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiB0N47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiB0N4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:56:54 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE321BE85;
        Sun, 27 Feb 2022 05:56:18 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y189so15434825ybe.4;
        Sun, 27 Feb 2022 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xc/7Dlh75lxyDiAYU+5HYV0L9tvJxDsTFMNP81dQQno=;
        b=UBOeYv6SwDgFKGbaBmR/0P/ERMKbg5kIeCUKKpMqQ8IES6motWVbhTR9/twlb02nVJ
         7LtSYHDAPbTVY3ga9zuHPY2Bqt4NAK91vQKc2gwb16Qy8DjchS0vqbMAJtdwdiWqZjbW
         Uc4ZWTvSAdwrxin4BNsCysnHFNKcQRcuDc7IWn2ilE9jTrFN5F/4bj9L/5YYAdxqZ4fj
         FtNEU8zYsyyTEKf1AMTh0Hmn1d2tthCXFFqENlmwbnPF7JkBSr8D5oMTCDiopwV0ocCI
         qyd4Df1zuDcevrea/9KvNaHkRP6+jqvzu0NN1Yz5LdMi2VpZsPwy4GCa6If1bsFBIYcf
         M6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xc/7Dlh75lxyDiAYU+5HYV0L9tvJxDsTFMNP81dQQno=;
        b=Dn3aUacgT97/IIYS/0HTiZCBCzGwuWWy+c39AMnQALVUQ/gS15XSeBQ5WkPKFygNMN
         0Ukao/dNCuhwlASkLl8/6ukak8ErDQNWEfe1ElALnE3usjjo+olOD81TO+uTSNBF/lEL
         4fhzCrdmjsPPUZLpWJ9p0ecSCsxexlH4wlL2Eqw+4YbTTYo2OwY/6DbJf1IXlunw9Zts
         6GP5ZOQKCfyYqGzjBAErQZz/veRPp65odBX+uLAtwNBcpM5dz0N+EaRJt2EUFxlhfk2w
         usZ6L3lsIPlxOB3RWbVQzuFSKnzA71t6o6n1JFj1YqaCf2JUyMgEApDBIbO5SD+Jp7SW
         l/gQ==
X-Gm-Message-State: AOAM530fthBe0/kx8WN7L/LzAAAZTgGeOdGFYvRXYwlW9Iuk2m5+2Wqn
        OFAFT2wKrIKLbKmG34FWo2jmfu7Wd6inxnzHY9U=
X-Google-Smtp-Source: ABdhPJz9khkLFz86gIsM8mgkVyb76HvsrmNaCS2pTufix/js3aYjXkAufdiXRIwhnYI1+4w6LnM7A7KvHfXtonDQNFY=
X-Received: by 2002:a25:8490:0:b0:624:5f70:142a with SMTP id
 v16-20020a258490000000b006245f70142amr14772699ybk.173.1645970177342; Sun, 27
 Feb 2022 05:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20220226184147.769964-1-pgwipeout@gmail.com> <20220226184147.769964-10-pgwipeout@gmail.com>
 <4a49ba17-436b-c6b3-4a7d-42902781d2f4@gmail.com>
In-Reply-To: <4a49ba17-436b-c6b3-4a7d-42902781d2f4@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 27 Feb 2022 08:56:06 -0500
Message-ID: <CAMdYzYoKfyCOHrH-o1HDiMQqqQzvVrpY2TFVH4ANNzJvPg6rBQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
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

On Sat, Feb 26, 2022 at 6:01 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 2/26/22 19:41, Peter Geis wrote:
> > Add the dwc3 device nodes to the rk356x device trees.
> > The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> > dwc3 host controller.
> > The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> > dwc3 host controller.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 12 +++++++
> >  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 +++++
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 45 +++++++++++++++++++++++-
> >  3 files changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> > index 3839eef5e4f7..a57eb68faba2 100644
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
> > @@ -18,3 +22,11 @@ power-domain@RK3568_PD_PIPE {
> >               #power-domain-cells = <0>;
> >       };
> >  };
> > +
> > +&usb_host0_xhci {
> > +     phys = <&usb2phy0_otg>;
> > +     phy-names = "usb2-phy";
> > +     extcon = <&usb2phy0>;
> > +     maximum-speed = "high-speed";
> > +     snps,dis_u2_susphy_quirk;
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
> > index 7cdef800cb3c..b22e5a514ad7 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -230,6 +230,50 @@ scmi_shmem: sram@0 {
> >               };
> >       };
> >
> > +     usb_host0_xhci: usb@fcc00000 {
> > +             compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> > +             reg = <0x0 0xfcc00000 0x0 0x400000>;
> > +             interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> > +                      <&cru ACLK_USB3OTG0>;
> > +             clock-names = "ref_clk", "suspend_clk",
> > +                           "bus_clk";
> > +             dr_mode = "host";
> > +             phy_type = "utmi_wide";
>
> > +             power-domains = <&power RK3568_PD_PIPE>;
>
> When both usb_host0_xhci and usb_host1_xhci are connected to a usb2phy
> and the combphy's disabled there's no PCLK_PIPE enabled.
> Fix logic for RK3568_PD_PIPE by adding the USB3 clocks.
>
>
> > +             resets = <&cru SRST_USB3OTG0>;
>
> > +             reset-names = "usb3-otg";
>
> remove
>
> snps,dwc3.yaml only mentions the "resets" because
> devm_reset_control_array_get_optional_shared is used.
> reset-names is only a rk3399 legacy that I included due to the YAML
> conversion.
> With unevaluatedProperties now working "resets" also could be removed
> from rockchip,dwc3.yaml I think.

I've tested removing the reset entirely, and it seems the issues that
affected the rk3399 do not affect us here.

>
> https://github.com/torvalds/linux/commit/2f8e928408885dad5d8d6afefacb82100b6b62c7
> Added properties for rk3399 are:
>   power-domains
>   resets
>   reset-names
>
> > +             snps,dis_enblslpm_quirk;
> > +             snps,dis-u2-freeclk-exists-quirk;
> > +             snps,dis-del-phy-power-chg-quirk;
> > +             snps,dis-tx-ipgap-linecheck-quirk;
>
> sort
>
> > +             snps,xhci-trb-ent-quirk;
>
> ???
>
> check snps,dwc3.yaml

I've tried dropping all of these and testing all the configurations I
can think of.
The only one we seem to absolutely need is snps,dis_u2_susphy_quirk,
without which sometimes devices fail to enumerate after being removed.
The only weird behavior I found was on the Pinenote, where there is
only the OTG port and when a state change happens from host to device
mode the controller locks up the AXI bus for a few seconds until it
times out and gets reset by core.
OTG support is still a work in progress here though and is not supported yet.

TLDR: I'll be dropping all the quirks that have no apparent effect in
the v3, they can be added in if needed following broader testing.

Thanks for all the insight here!

>
> > +             status = "disabled";
> > +     };
> > +
> > +     usb_host1_xhci: usb@fd000000 {
> > +             compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
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
>
> > +             power-domains = <&power RK3568_PD_PIPE>;
>
> dito
>
> > +             resets = <&cru SRST_USB3OTG1>;
>
> > +             reset-names = "usb3-otg";
>
> remove
>
> > +             snps,dis_enblslpm_quirk;
> > +             snps,dis-u2-freeclk-exists-quirk;
> > +             snps,dis_u2_susphy_quirk;
> > +             snps,dis-del-phy-power-chg-quirk;
> > +             snps,dis-tx-ipgap-linecheck-quirk;
>
> sort
>
> > +             status = "disabled";
> > +     };
> > +
> >       gic: interrupt-controller@fd400000 {
> >               compatible = "arm,gic-v3";
> >               reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> > @@ -297,7 +341,6 @@ pmu_io_domains: io-domains {
> >       };
> >
> >       pipegrf: syscon@fdc50000 {
> > -             compatible = "rockchip,rk3568-pipe-grf", "syscon";
> >               reg = <0x0 0xfdc50000 0x0 0x1000>;
> >       };
> >
