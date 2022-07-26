Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697CF580A35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiGZEEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiGZEE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:04:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A092A402
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:04:28 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n8so3947607yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X0WA+kebRC6mPq3dqdjSQFAk2sYowHyB2qCeMP7O6M=;
        b=S9w8M90liuvaIw1ZfTS+HP0fbRUfVP4FKs1zYR2wsbdAc/LIYKZEwDSZRJ3PVd9niI
         WOdYSAmVJ3kokTsI95tUVlk1qcJzfnOASGSbc3G0Xz+L/nePrU3c9daZKj7ePg8JOmMa
         mZA376is49CSoCqeSYkJuacoE8AQu6QvZkhB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X0WA+kebRC6mPq3dqdjSQFAk2sYowHyB2qCeMP7O6M=;
        b=ZLFiLkq01eQy5+LIyWN0lRe+BsTPj0JmMdRP1I7MA0I5o0q+4ZjK6qDwJg0BNTTAA9
         miPwVbwvYsFvSfXnu+4995Klzar0LQezl3ZdDUlOEecM09Fh6giNfZ3yW1yT2Eg7vwog
         EIG8HsGjVpAHluc4dIENHmJxObC2aKYsMY3K62Q9/UrZjpz2QE+UdoW0vHD+/2MCeYk1
         rIl3yvyYzuK8k3KmEqWZi7+ioVFOD13qKJn1QNH76fTY4D4LbYrbIZb8DRx1mla016TG
         QsxNAQIEfXbeVEJfOsKtgsQquQ8IMOg38bMRHXpU9MtmqNM47dFdLLSNpQuduHTbF76V
         O/cQ==
X-Gm-Message-State: AJIora/kVVfznFWjFLeg9LBTCfB5KWEU91LspmW3KWcLjgsq+ldtYNdf
        wEhXp4AV6wmVN7BToVJOWR+C66+aGOFGtJWSz+cujw==
X-Google-Smtp-Source: AGRyM1uP48hjj3jsBDjgKChjyZ2zuY+tmqTb7maY9L6QDMxw3VUhyT+58wQYtUAL2USTYtbhj0Z0phTWRZL5gh5ClF0=
X-Received: by 2002:a25:6a43:0:b0:66f:d259:7918 with SMTP id
 f64-20020a256a43000000b0066fd2597918mr12011506ybc.486.1658808267687; Mon, 25
 Jul 2022 21:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
 <20220721145017.918102-5-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FutJb_MRwSVgjV7tByBvfq3AFsSxs6ETUZaNzrfpywgg@mail.gmail.com> <781f6d3e-412e-1553-c2c2-23c9a897626b@collabora.com>
In-Reply-To: <781f6d3e-412e-1553-c2c2-23c9a897626b@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Jul 2022 12:04:16 +0800
Message-ID: <CAGXv+5Gdwcj1n0q8e8ReoUOZX18pbtbxV7oof06Q2_nJMNY-cw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: mediatek: cherry: Enable secondary
 SD/MMC controller
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 6:20 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/07/22 10:54, Chen-Yu Tsai ha scritto:
> > On Thu, Jul 21, 2022 at 10:51 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> As of now, all of the boards based on the cherry platform have a
> >> usable secondary SD/MMC controller, usually for SD cards: enable
> >> it to allow both booting from it and generally accessing external
> >> storage.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 62 +++++++++++++++++++
> >>   1 file changed, 62 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> index 2853f7f76c90..8859957c7b27 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> @@ -17,6 +17,7 @@ aliases {
> >>                  i2c5 = &i2c5;
> >>                  i2c7 = &i2c7;
> >>                  mmc0 = &mmc0;
> >> +               mmc1 = &mmc1;
> >>                  serial0 = &uart0;
> >>          };
> >>
> >> @@ -227,6 +228,24 @@ &mmc0 {
> >>          vqmmc-supply = <&mt6359_vufs_ldo_reg>;
> >>   };
> >>
> >> +&mmc1 {
> >> +       status = "okay";
> >> +
> >> +       bus-width = <4>;
> >> +       cap-sd-highspeed;
> >> +       cd-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
> >> +       max-frequency = <200000000>;
> >> +       no-mmc;
> >> +       no-sdio;
> >> +       pinctrl-names = "default", "state_uhs";
> >> +       pinctrl-0 = <&mmc1_pins_default>;
> >> +       pinctrl-1 = <&mmc1_pins_uhs>;
> >> +       sd-uhs-sdr50;
> >> +       sd-uhs-sdr104;
> >> +       vmmc-supply = <&mt_pmic_vmch_ldo_reg>;
> >> +       vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
> >> +};
> >> +
> >>   /* for CPU-L */
> >>   &mt6359_vcore_buck_reg {
> >>          regulator-always-on;
> >> @@ -575,6 +594,49 @@ pins-rst {
> >>                  };
> >>          };
> >>
> >> +       mmc1_pins_default: mmc1-default-pins {
> >> +               pins-cmd-dat {
> >> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> >> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> >> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> >> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> >> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> >> +                       input-enable;
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> >> +               };
> >> +
> >> +               pins-clk {
> >> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> >> +               };
> >> +
> >> +               pins-insert {
> >> +                       pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
> >> +                       bias-pull-up;
> >> +               };
> >> +       };
> >> +
> >> +       mmc1_pins_uhs: mmc1-uhs-pins {
> >> +               pins-cmd-dat {
> >> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> >> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> >> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> >> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> >> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> >> +                       input-enable;
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> >> +               };
> >> +
> >> +               pins-clk {
> >> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> >> +                       drive-strength = <8>;
> >> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> >> +               };
> >
> > I wonder if pins-insert should be duplicated here. And there's no
> > difference between the standard and UHS pinconfigs. One would expect
> > higher drive strength on the UHS set, if two sets were required.
> > So maybe we should just have one set, and use that one for both
> > the default and uhs states.
> >
>
> I don't think that it would really make a lot of sense to duplicate the
> insertion pin setup in the UHS-specific pinctrl set...
>
> Whenever you remove the uSD card, the controller goes back to default,
> as the first steps in card initialization are always happening at low
> speed and only after that we can switch to UHS speeds... so we do expect
> that the first-ever state is always `default` (by spec!), which means
> that we are also ensuring that the insertion pin setup is always done.

Right. What I wanted to say was that, besides the insertion pin, there's
no difference between the default and uhs states here. So why have two
copies instead of one that is referenced twice? (the uhs state is required
by the binding).

ChenYu

> Cheers,
> Angelo
>
> > Otherwise,
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> >> +       };
> >> +
> >>          nor_pins_default: nor-default-pins {
> >>                  pins-ck-io {
> >>                          pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> >> --
> >> 2.35.1
> >>
> >>
>
