Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491934C4D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBYSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiBYSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:00:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE8F21EBBF;
        Fri, 25 Feb 2022 09:59:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p19so7392558ybc.6;
        Fri, 25 Feb 2022 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kz9NZiBiYRGALk1m6Ovqtpeje/s73CVTmwpIkcwCPk=;
        b=hfTP4XLAu13JbblnqvqrPPBprgC2sJvvAMS82h4kde46sTUPoP2znvX9fVRePJkvJC
         mS98ljMkDQl9zM7EXXrk8OftTVLzhNiZ8H6guVcGqbYEXulJv4hAb3UKv69TW6lRt1Ef
         eclAa9DjvURNdF0K1eWL7BLQYivkIB3Xo9FgfgsMdrMneY/ncss9JPA1psd72UpxHImw
         grdvsKAl/7uwdFGso5zFtdKEhTgkXuPUHAtfZDaOySBL/jzfyfqcZXMK/pKk9/Js5CYn
         pH621ABn/mLic79WR+Fbd9EgSKAX2zL4ZMdBDIpHgcrtUP6ALzD3PetJS5DB3cILAiPP
         tPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kz9NZiBiYRGALk1m6Ovqtpeje/s73CVTmwpIkcwCPk=;
        b=qxYWUV5SBghQx9KBPndR6OdvWxo6u47O69ozTSuvDXjReN2RN55h4f7EEBTEHxmwdN
         f3OlSKP+3yHrdJjW5SPCQvIPJWC5wWDgKwwLixBgMZE0X7eXEQmC4qHTGUwJCPfM+o0g
         oeu57Mp0gyCJKZsJainRzJZX4oKtdMUb6jV1+US87DhcgGDkStWZktVJKGyuOU6sCHi2
         1Xx2bl7+zZRNagP6NzuRT4nNrdvOqBS2qJBHrK3yCTyXd8npqpDMA1yNMjgagBKl9KhO
         6j0IWFvHs4OLJro5JdnpqBL9tjwBiF1j23HkrhRedKZD7xIYlpDN8t3eWm1B+Ykdiq6t
         ZS+Q==
X-Gm-Message-State: AOAM53027zyq9Vt8mKGe8eMww5pxXhLwl+NAqxFwhcX+S5fFB7v5CwZt
        bPo0hE/sfKCKB8gHjOeSI3E6A1utzIf0DQ8ID/w=
X-Google-Smtp-Source: ABdhPJwN67LxqhBHaYtXPLv7XV+GoM49N48Yf33dmmVit7EySdc2NF93LIYx/FOayyAsdbW85jFSjza7i7o2pXzqYjE=
X-Received: by 2002:a25:c752:0:b0:624:71ee:65d7 with SMTP id
 w79-20020a25c752000000b0062471ee65d7mr8379627ybe.366.1645811977842; Fri, 25
 Feb 2022 09:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20220225145432.422130-1-pgwipeout@gmail.com> <20220225145432.422130-8-pgwipeout@gmail.com>
 <2f1f09c0-9b7e-5145-fb25-a5f1fe4d0ab4@wolfvision.net>
In-Reply-To: <2f1f09c0-9b7e-5145-fb25-a5f1fe4d0ab4@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 25 Feb 2022 12:59:26 -0500
Message-ID: <CAMdYzYqRsOji3PfxK_FgOUbg4KomC+LnWgkTXS7=YRKTuPYVow@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Fri, Feb 25, 2022 at 12:01 PM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> (It should be noted that there was a slight mishap in communications
> between the two of us resulting in two series with the same goal. Now
> let's clean up the mess :-)
>
> Thanks for your series. Seeing that it contains more patches than mine
> it probably makes sense to use your series as basis. Please Cc: me in
> future iterations of this patch series and consider my comments below.

Will do.
If you'd like I can also pull your enablement patch.

>
> On 2/25/22 15:54, Peter Geis wrote:
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
> > index 3839eef5e4f7..8e8b52f58f44 100644
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
> > +&usbdrd30 {
>
> I would really love to have some alignment with the other USB controllers
>
> usb_host{0,1}_{e,o}hci
>
> here. I am aware that older SoCs and the SDK are using these names and
> it might be painful to have different versions to maintain at the
> moment, but can we please agree on
>
> usb_host0_xhci
> usb_host1_xhci
>
> or something like that?

I agree, I like your naming better.

>
> > +     phys = <&usb2phy0_otg>;
> > +     phy-names = "usb2-phy";
> > +     extcon = <&usb2phy0>;
> > +     maximum-speed = "high-speed";
> > +     snps,dis_u2_susphy_quirk;
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > index 5b0f528d6818..77c044cbaaad 100644
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
> > +&usbdrd30 {
> > +     phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> > +     phy-names = "usb2-phy", "usb3-phy";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 84d5d607e693..4fae5b3b326e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -230,6 +230,50 @@ scmi_shmem: sram@0 {
> >               };
> >       };
> >
> > +     usbdrd30: usbdrd@fcc00000 {
> > +             compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> > +             reg = <0x0 0xfcc00000 0x0 0x400000>;
> > +             interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> > +                      <&cru ACLK_USB3OTG0>, <&cru PCLK_PIPE>;
> > +             clock-names = "ref_clk", "suspend_clk",
> > +                           "bus_clk", "grf_clk";
>
> Please consider Johan's comments on my first series. In my tests
> removing the PCLK_PIPE clock did not make any difference.

I'd like to test that this isn't being used, or isn't just working
because it's enabled elsewhere.
If both of those are false, then I'll be happy to drop this.

>
> > +             dr_mode = "host";
>
> Based on the description in the commit message above it should be "otg",
> right? Boards are free to overrule this, of course.

Currently the usb2phy does not support OTG mode correctly.
There are patches in the works for this, but at the moment it's safer
to default to host.

>
> > +             phy_type = "utmi_wide";
> > +             power-domains = <&power RK3568_PD_PIPE>;
> > +             resets = <&cru SRST_USB3OTG0>;
> > +             reset-names = "usb3-otg";
> > +             snps,dis_enblslpm_quirk;
> > +             snps,dis-u2-freeclk-exists-quirk;
> > +             snps,dis-del-phy-power-chg-quirk;
> > +             snps,dis-tx-ipgap-linecheck-quirk;
> > +             snps,xhci-trb-ent-quirk;
>
> In my first version I had all those quirks as well, but are they
> actually necessary? I decided to remove them all to have a fresh start
> (also activating them did not seem to affect my test setup).

I'm now curious about this, can someone weigh in on valid ways of
testing each one of these in a way that is definite?

>
> > +             status = "disabled";
> > +     };
> > +
> > +     usbhost30: usbhost@fd000000 {
>
> Please reconsider the this name as well.
>
> > +             compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
> > +             reg = <0x0 0xfd000000 0x0 0x400000>;
> > +             interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> > +                      <&cru ACLK_USB3OTG1>, <&cru PCLK_PIPE>;
> > +             clock-names = "ref_clk", "suspend_clk",
> > +                           "bus_clk", "grf_clk";
> > +             dr_mode = "host";
>
> Here "host" clearly makes sense, as this controller is not capable of otg.
>
> > +             phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> > +             phy-names = "usb2-phy", "usb3-phy";
> > +             phy_type = "utmi_wide";
> > +             power-domains = <&power RK3568_PD_PIPE>;
> > +             resets = <&cru SRST_USB3OTG1>;
> > +             reset-names = "usb3-host";
> > +             snps,dis_enblslpm_quirk;
> > +             snps,dis-u2-freeclk-exists-quirk;
> > +             snps,dis_u2_susphy_quirk;
> > +             snps,dis-del-phy-power-chg-quirk;
> > +             snps,dis-tx-ipgap-linecheck-quirk;
>
> What was said about quirks above holds here as well (although one quirk
> not documented in the bindings is missing here).

Same thing here, I'd like absolute testing to determine that these are
not necessary, since downstream (the oem) felt they were.

>
> Best regards,
> Michael
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
