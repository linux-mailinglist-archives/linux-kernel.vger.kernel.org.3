Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A15549D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbiFMTK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351644AbiFMTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4415F30F5C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:08:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so6573302pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZWAPWwrm8+A0CgIBwRq++T65dkqg+V1CymCWTXMIwM=;
        b=LIOySr/baoj4EAyTjKf+aH+Qatb2p3UHDovP+gotSlTiSN1yTcg4GCjyqC3fyUX7wl
         npmmJtdNhVDNh5XKGkUnpjvg/YJI9/ZyQwGvcnz/SS0pPOuUekmDMJRnmbvEUG9D+H7+
         BZM1DLAMJ8q+I+4MvG2IfeZzZu5Z2p2pmZvJH76I7ELfeoqXCbnsuzr33o2epyIJ5WeO
         vlWeMTh3YdX80pJSfJHrPWOfpq4BMQV7PRBFhgbMKMVtr4faZ0ISbwZoAbpm/guz5Lxu
         3Q1Lh7nmkcWUV2iquou5G8hgE2UlhX7m7htGh4cx10X02rbX81xYSe5d64L24n5jYZOT
         up1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZWAPWwrm8+A0CgIBwRq++T65dkqg+V1CymCWTXMIwM=;
        b=g9FSksw5leGGiPxW1rTeYg1a5ZCfALcf+CH2Jcgj8VeU2g/fimwa+q8i2ZkzeiF0np
         FmBna16Edqlvzr8HRPYkFzk6YwXlVIIqp1e4PfXOpu4iHSM1q2sXKSDaiQr8b0hsvP99
         f/8iskptykJ78pHLpYj23VjHOFAF/V4VhikmIAn5pU5E7vVEsYLoUbrzxMhCbHYGczpg
         +c6cqkFWKK+5tzH/VuqI9emRKFKX1GqHeM4kEKx6R/xXkZX+OkOBdnFX6MmX1JZnEO9K
         zMIw8S9GCI5Fk+H6bmKsvynwcLm7kCyCE2EcJGV3dyxOtLoIPYpJrYQ4n8F4HkbQQ0Ij
         tdhA==
X-Gm-Message-State: AJIora+BEn9FTSwBVPeNC5/oA9QPBxfx8JlemysWcFLeUdtMw+Bx+ttc
        sZzhPBs6kroWCLsOVeao8itjUQ==
X-Google-Smtp-Source: AGRyM1sELmzXAHQOaDg6BJ3FBShrRSur5yPmIKoRf1jf9G2G72yJQERR+jxqILTIiQmADcP/b1HsAg==
X-Received: by 2002:a17:902:c94b:b0:166:4f65:cffb with SMTP id i11-20020a170902c94b00b001664f65cffbmr14965pla.103.1655140137656;
        Mon, 13 Jun 2022 10:08:57 -0700 (PDT)
Received: from ash.lan ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 142-20020a621994000000b00518b4cfbbe0sm5632766pfz.203.2022.06.13.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:08:56 -0700 (PDT)
Date:   Mon, 13 Jun 2022 18:08:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: Re: [PATCH v2 15/15] video: backlight: mt6370: Add Mediatek MT6370
 support
Message-ID: <20220613170853.bffuwkcmflfgg4gt@ash.lan>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-16-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613111146.25221-16-peterwu.pub@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:11:46PM +0800, ChiaEn Wu wrote:
> +static int mt6370_init_backlight_properties(struct mt6370_priv *priv,
> +					    struct backlight_properties *props)

Most of the changes in this version looks good... but it looks the new
code in this function has a number of problems. See below...


> +{
> +	struct device *dev = priv->dev;
> +	u8 prop_val;
> +	u32 brightness;
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* Vendor optional properties
> +	 * if property not exist, keep value in default.
> +	 */

That's not the right strategy for booleans. Not existing means false
(e.g. flags should actively be unset).


> +	if (device_property_read_bool(dev, "mediatek,bled-pwm-enable")) {
> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
> +					 MT6370_BL_PWM_EN_MASK,
> +					 MT6370_BL_PWM_EN_MASK);
> +		if (ret)
> +			return ret;
> +	}

As above comment... all of the boolean properties are now being read
incorrectly.


> +
> +	if (device_property_read_bool(dev, "mediatek,bled-pwm-hys-enable")) {
> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
> +					 MT6370_BL_PWM_HYS_EN_MASK,
> +					 MT6370_BL_PWM_HYS_EN_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = device_property_read_u8(dev, "mediatek,bled-pwm-hys-input-bit",
> +				      &prop_val);
> +	if (!ret) {
> +		val = min_t(u8, prop_val, 3)
> +		      << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1);
> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
> +					 MT6370_BL_PWM_HYS_SEL_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = device_property_read_u8(dev, "mediatek,bled-ovp-microvolt",
> +				      &prop_val);
> +	if (!ret) {
> +		val = min_t(u8, prop_val, 3)
> +		      << (ffs(MT6370_BL_OVP_SEL_MASK) - 1);

This has been renamed but still seems to the using 0, 1, 2, 3 rather
than an actual value in microvolts.


> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
> +					 MT6370_BL_OVP_SEL_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (device_property_read_bool(dev, "mediatek,bled-ovp-shutdown")) {
> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
> +					 MT6370_BL_OVP_EN_MASK,
> +					 MT6370_BL_OVP_EN_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = device_property_read_u8(dev, "mediatek,bled-ocp-microamp",
> +				      &prop_val);
> +	if (!ret) {
> +		val = min_t(u8, prop_val, 3)
> +		      << (ffs(MT6370_BL_OC_SEL_MASK) - 1);

Likewise, should this be accepting a value in microamps?


> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
> +					 MT6370_BL_OC_SEL_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (device_property_read_bool(dev, "mediatek,bled-ocp-shutdown")) {
> +		ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
> +					 MT6370_BL_OC_EN_MASK,
> +					 MT6370_BL_OC_EN_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Common properties */
> +	ret = device_property_read_u32(dev, "max-brightness", &brightness);
> +	if (ret)
> +		brightness = MT6370_BL_MAX_BRIGHTNESS;
> +
> +	props->max_brightness = min_t(u32, brightness,
> +				      MT6370_BL_MAX_BRIGHTNESS);
> +
> +	ret = device_property_read_u32(dev, "default-brightness", &brightness);
> +	if (ret)
> +		brightness = props->max_brightness;
> +
> +	props->brightness = min_t(u32, brightness, props->max_brightness);
> +
> +
> +	ret = device_property_read_u8(dev, "mediatek,bled-channel-use",
> +				      &prop_val);
> +	if (ret) {
> +		dev_err(dev, "mediatek,bled-channel-use DT property missing\n");
> +		return ret;
> +	}
> +
> +	if (!prop_val || prop_val > MT6370_BL_MAX_CH) {
> +		dev_err(dev, "No channel specified (ch_val:%d)\n", prop_val);

Error string has not been updated to match condition that triggers it.


> +		return -EINVAL;
> +	}


Daniel.
