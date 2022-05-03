Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F65517B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiECBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiECBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:11:36 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A47F42
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:07:59 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 7so9026817pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J01ulpJYuD85Ua2b4Z3CSKv7anNmbjAMoLL+x9ZEpM=;
        b=NClZTO1lrag4qnroLMDkkbP3isGuZ96PhtjlMZj1F0gnm+ax+Xj8U85biRRxbeFUy4
         7Z39bmQ2sP99StT//gfXtj6MyuFynilZ67Oy2Rcy/kmmSvIlLx/hnwdjd7B3x4zlomA2
         b6kgxvm8ub5U1185hSRCTnkl4b+ME1h+jNO00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J01ulpJYuD85Ua2b4Z3CSKv7anNmbjAMoLL+x9ZEpM=;
        b=tR8KvccVBfRlNy3r5HwulKwLZq3D6ulwHibqdnQ1+3K0BCMl4bH4C71vbmK2D3kDFB
         rcBRrHeZaf+gH7CoW9ZIlhzzm3mVEnKidQR2UGFKFkvjuUBXutzHeK7URRnSoSpBa4zO
         dYdhvwvNn5xJZfGBVl2LGW6cPQ+2L9Qs5jajY7ymDTtQoY03+nZCgXHcnLzPC31WKA6a
         pBRIvC3a6PGTM6WoQpw6hR1X6LUbA6Ir0ZJ31E4mxZfiHP8TyLLrSUz3ZmfUqug3e/K6
         fGRypDF2yiEDePIQZE5miJfcG9V8Biw/yvCPAndaDr3ThEVkw9psZJybEWvOyCXdMdrY
         1KSg==
X-Gm-Message-State: AOAM530xfm/TNALLUrDWh3iEENpixOvx1HHfx+LdQYceEckBf4iEwRoD
        L1bv0Xa+geAyCyo/ebCpO951hlEKnx8mJDFJSDvh4b2RQuylgQ==
X-Google-Smtp-Source: ABdhPJwRFgrMh1pooiPeQoY3V/x6VQ9V4gTsYXNEYYLcxTsk9rJSzar3B8D3rxcceDM7NfH0Ukgctl/xhPy5vBiLNuw=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr5054846ion.63.1651539057290; Mon, 02
 May 2022 17:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220503004156.3559940-1-swboyd@chromium.org> <20220503004156.3559940-3-swboyd@chromium.org>
In-Reply-To: <20220503004156.3559940-3-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 2 May 2022 17:50:46 -0700
Message-ID: <CAPUE2uvQ0cg0HJ5GrCtUR0v2+BKtSD044NEjB-eGJXS8fExBcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: sx9324: Add setting for CS idle mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, May 2, 2022 at 5:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Based on device tree setting, set the CS idle mode.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 7f367f63e362..79683f0d4e9a 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -57,6 +57,11 @@
>         GENMASK(SX9324_REG_AFE_CTRL0_RINT_SHIFT + 1, \
>                 SX9324_REG_AFE_CTRL0_RINT_SHIFT)
>  #define SX9324_REG_AFE_CTRL0_RINT_LOWEST       0x00
> +#define SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT      4
> +#define SX9324_REG_AFE_CTRL0_CSIDLE_MASK \
> +       GENMASK(SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT + 1, \
> +               SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT)
> +#define SX9324_REG_AFE_CTRL0_RINT_LOWEST       0x00
>  #define SX9324_REG_AFE_CTRL1           0x21
>  #define SX9324_REG_AFE_CTRL2           0x22
>  #define SX9324_REG_AFE_CTRL3           0x23
> @@ -872,6 +877,8 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  {
>         static const char * const sx9324_rints[] = { "lowest", "low", "high",
>                 "highest" };
> +       static const char * const sx9324_csidle[] = { "hz", "hz", "gnd",
> +               "vdd" };
>  #define SX9324_PIN_DEF "semtech,ph0-pin"
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> @@ -901,6 +908,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
>                 reg_def->def = raw;
>                 break;
>         case SX9324_REG_AFE_CTRL0:
> +               ret = device_property_read_string(dev,
> +                               "semtech,cs-idle-sleep", &res);
> +               if (!ret)
> +                       ret = match_string(sx9324_csidle, ARRAY_SIZE(sx9324_csidle), res);
> +               if (ret >= 0) {
> +                       reg_def->def &= ~SX9324_REG_AFE_CTRL0_CSIDLE_MASK;
> +                       reg_def->def |= ret << SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT;
> +               }
> +
>                 ret = device_property_read_string(dev,
>                                 "semtech,int-comp-resistor", &res);
>                 if (ret)
> --
> https://chromeos.dev
>
