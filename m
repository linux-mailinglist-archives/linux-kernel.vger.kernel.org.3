Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86832491D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352949AbiARDef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355829AbiARDMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:12:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FAC094255
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:55:19 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so64915158lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xGzmg81DuUlAGTYFkIbn0LL6gpYYtNJdIrpuHBXKz4=;
        b=TCyfhuASYEMuFNk1ASL5LKWD7ok8PXJJ74hOetk36L1lGBv56RpTKWdq3Oan2zuuey
         1P7dZUsUGAZhvrWqYJhqjI4el8YWhCPLLmMgVMjM1ouVYaRdEFUb3DJFx9ur9I9WmKuV
         +wjXSSWn9Bme4/0/ekyb/STAD+5FhFBBU51Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xGzmg81DuUlAGTYFkIbn0LL6gpYYtNJdIrpuHBXKz4=;
        b=R8eKY//O5SCBdHBSQhqiFBDmgXSN0r9pL2FTTuAjtt4FMBJhQjWGIUzBR3TJybd4Wa
         WUWiFQVAeOjqTI6Y0rp4tPJlYY8Hwhka+WKB4hDyvOTMCdmN2fsOn/FbPKDaA63pa/vL
         5bb27R0NOT6JAgU1uu+Iw30GvS3us8Tjsmdabh/fTYkIaFlqtN5vLm6R1yl8WAWoDp0q
         LY+//7bnZ2KriyDf1FxH5jAlaHE8bm4ts+1qzOqiw8fg0g8ltbSVsjjb/L5US7q0Z5Gm
         GSYz4mO2lnVk8Az4LxUDfInxm4FEvJugWK7M32hiP4NZlpVur2NIwxV012nRXFnDjd6c
         N70A==
X-Gm-Message-State: AOAM532a9RdS4m3SqV2nGzSeNI638wJPfIYCaOML233smsJI2Z/wDgHs
        /mLd4eyz+s2ykKY131nKDfc5OZUyupKjVK8AjQjgng==
X-Google-Smtp-Source: ABdhPJy6Dg4mAwpGc0BC6YsAH1eqGHyBYkQUxCzn5U7IvAtaIKsJB56Z752NgaGIWVH8lotJElSk0Kxi1jaV0jfRbzY=
X-Received: by 2002:a05:6512:3682:: with SMTP id d2mr19005682lfs.678.1642474516308;
 Mon, 17 Jan 2022 18:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20220111112244.1483783-1-wenst@chromium.org> <20220111112244.1483783-8-wenst@chromium.org>
 <b1d5ca006860c85edd971ea9e20880ec8ba7f842.camel@mediatek.com>
In-Reply-To: <b1d5ca006860c85edd971ea9e20880ec8ba7f842.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Jan 2022 10:55:05 +0800
Message-ID: <CAGXv+5Egf-XM_Y8+ujYrx9k0UgAkpPj9DVpZEVz2hWdGzws2ZA@mail.gmail.com>
Subject: Re: [PATCH 7/7] pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_UA
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guodong Liu <guodong.liu@mediatek.com>, hui.liu@mediatek.com,
        light.hsieh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 18, 2022 at 10:36 AM zhiyong.tao <zhiyong.tao@mediatek.com> wrote:
>
> On Tue, 2022-01-11 at 19:22 +0800, Chen-Yu Tsai wrote:
> > Some of the MediaTek chips that utilize the Paris pinctrl driver
> > library
> > support a lower drive strength (<= 1mA) than the standard drive
> > strength
> > settings (2~16 mA) on certain pins. This was previously supported by
> > the
> > custom MTK_PIN_CONFIG_DRV_ADV parameter along with the
> > "mediatek,drive-strength-adv" device tree property.
> >
> > The drive strength values for this hardware are 125, 250, 500, and
> > 1000 mA,
> > and can be readily described by the existing "drive-strength-
> > microamp",
> > which then gets parsed by the generic pinconf library into the
> > parameter
> > PIN_CONFIG_DRIVE_STRENGTH_UA.
> >
> > Add support for PIN_CONFIG_DRIVE_STRENGTH_UA while keeping the old
> > custom parameter around for backward compatibility.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >
> > The indentation in the switch/case blocks is getting somewhat out of
> > control. I also have some cleanup changes to reverse the logic of the
> > if/break statements. Not sure if it should be done before or after
> > this
> > patch though.
> >
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-paris.c | 84
> > ++++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > index 678c8aa33012..5a94903ae372 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > @@ -48,6 +48,53 @@ static const char * const mtk_gpio_functions[] = {
> >       "func12", "func13", "func14", "func15",
> >  };
> >
> > +/*
> > + * This section supports converting to/from custom
> > MTK_PIN_CONFIG_DRV_ADV
> > + * and standard PIN_CONFIG_DRIVE_STRENGTH_UA pin configs.
> > + *
> > + * The custom value encodes three hardware bits as follows:
> > + *
> > + *   |           Bits           |
> > + *   | 2 (E1) | 1 (E0) | 0 (EN) | drive strength (uA)
> > + *   ------------------------------------------------
> > + *   |    x   |    x   |    0   | disabled, use standard drive
> > strength
> > + *   -------------------------------------
> > + *   |    0   |    0   |    1   |  125 uA
> > + *   |    0   |    1   |    1   |  250 uA
> > + *   |    1   |    0   |    1   |  500 uA
> > + *   |    1   |    1   |    1   | 1000 uA
> > + */
> > +static const int mtk_drv_adv_uA[] = { 125, 250, 500, 1000 };
> > +
> > +static int mtk_drv_adv_to_uA(int val)
> > +{
> > +     /* This should never happen. */
> > +     if (WARN_ON_ONCE(val < 0 || val > 7))
> > +             return -EINVAL;
> > +
> > +     /* Bit 0 simply enables this hardware part */
> > +     if (!(val & BIT(0)))
> > +             return -EINVAL;
> > +
> > +     return mtk_drv_adv_uA[(val >> 1)];
> > +}
> > +
> > +static int mtk_drv_uA_to_adv(int val)
> > +{
> > +     switch (val) {
> > +     case 125:
> > +             return 0x1;
> > +     case 250:
> > +             return 0x3;
> > +     case 500:
> > +             return 0x5;
> > +     case 1000:
> > +             return 0x7;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev
> > *pctldev,
> >                                         struct pinctrl_gpio_range
> > *range,
> >                                         unsigned int pin)
> > @@ -151,11 +198,38 @@ static int mtk_pinconf_get(struct pinctrl_dev
> > *pctldev,
> >
> >               break;
> >       case PIN_CONFIG_DRIVE_STRENGTH:
> > +             if (hw->soc->adv_drive_get) {
> > +                     err = hw->soc->adv_drive_get(hw, desc, &ret);
> > +                     if (!err) {
> > +                             err = mtk_drv_adv_to_uA(ret);
> > +                             if (err > 0) {
> > +                                     /* PIN_CONFIG_DRIVE_STRENGTH_UA
> > used */
> > +                                     err = -EINVAL;
> > +                                     break;
> > +                             }
> > +                     }
> > +             }
> > +
> Hi Chen-Yu,
>
> PIN_CONFIG_DRIVE_STRENGTH is seems used for 2/4/6/8ma, it is not used
> for 125/250/500/1000ma. why you change here?

If 125/250/500/1000uA is used, that mode takes precedence over 2/4/6/8 mA.
To give a correct readback, if 125/250/500/1000 uA is active, we should
return -EINVAL here to tell the pin config core that PIN_CONFIG_DRIVE_STRENGTH
is not active.

Otherwise when one reads

    /sys/kernel/debug/pinctrl/10005000.pinctrl-pinctrl_paris/pinconf-pins

it would return

    ... output drive strength (X mA), output drive strength (Y uA), ...

where the first "mA" setting isn't actually active in hardware.

> >               if (hw->soc->drive_get)
> >                       err = hw->soc->drive_get(hw, desc, &ret);
> >               else
> >                       err = -ENOTSUPP;
> >               break;
> > +     case PIN_CONFIG_DRIVE_STRENGTH_UA:
> > +             if (hw->soc->adv_drive_get) {
> > +                     err = hw->soc->adv_drive_get(hw, desc, &ret);
> > +                     if (err)
> > +                             break;
> > +                     err = mtk_drv_adv_to_uA(ret);
> > +                     if (err < 0)
> > +                             break;
> > +
> > +                     ret = err;
> > +                     err = 0;
> > +             } else {
> > +                     err = -ENOTSUPP;
> > +             }
> > +             break;
>
> Hi Chen-Yu,
> For PIN_CONFIG_DRIVE_STRENGTH_UA case, How can we use in dts node ?
> Thanks.

My original thought was to have either

    drive-strength = <2/4/6/8>;

or

    drive-strength-microamp = <125/250/500/1000>;

but not both. However I haven't figured out how to write the binding schema
to have the two properties be mutually exclusive. I'm not sure this would
be accepted either.

At the driver level, it should also have a check for the existence of
"drive-strength-microamp" to enable or disable the special mode.

Regards
ChenYu

> >       case MTK_PIN_CONFIG_TDSEL:
> >       case MTK_PIN_CONFIG_RDSEL:
> >               reg = (param == MTK_PIN_CONFIG_TDSEL) ?
> > @@ -271,6 +345,16 @@ static int mtk_pinconf_set(struct pinctrl_dev
> > *pctldev, unsigned int pin,
> >               else
> >                       err = -ENOTSUPP;
> >               break;
> > +     case PIN_CONFIG_DRIVE_STRENGTH_UA:
> > +             if (hw->soc->adv_drive_set) {
> > +                     err = mtk_drv_uA_to_adv(arg);
> > +                     if (err < 0)
> > +                             break;
> > +                     err = hw->soc->adv_drive_set(hw, desc, err);
> > +             } else {
> > +                     err = -ENOTSUPP;
> > +             }
> > +             break;
> >       case MTK_PIN_CONFIG_TDSEL:
> >       case MTK_PIN_CONFIG_RDSEL:
> >               reg = (param == MTK_PIN_CONFIG_TDSEL) ?
>
