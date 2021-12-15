Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54647542C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhLOIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbhLOIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:20:36 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE336C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:20:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id k4so19574100pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dVW69TmCJnTv5pUkbvRYzOl3hIL8o0Ev8E5MCNMu3v4=;
        b=G/3L4rDd1Goqt0d0b2dj/cMhsDvkaMD7Z1+8qFaNab+J/SE+VpMr8z5qIjIgg31BP3
         6Rgv6T1J2UpaqpYj4Ko/HrsvNIinACGkY9Lq5IoHJmoAfHdOCZaVIS8KCXKSYD+RXgZa
         /tkVzDLzR++mtz40WJdnBEWAHCVJHeYyEp/qf6PSLI0VfhlzOWEmckna48+po0it3yNf
         LAXJXzd9ucGOc72u1drmRWGY/oxGZGNbXHlqHYO3Q1Mbr9iGZI5uUeGNv079dUH+i/uQ
         cRClz28G6WpGzT/Iu1lkboFSdf/KTwa+NTw7eq9XCNDI29f50wCdZFXoICXU1S0PMGXY
         mLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dVW69TmCJnTv5pUkbvRYzOl3hIL8o0Ev8E5MCNMu3v4=;
        b=OFSvyHyGemKENIHsEZe4J5Ow/p8ClWqfczTnZyML0XRhNjuIPswQSU5ZNGZJCIIzpT
         VzVNAcu5NrUZNgxOYhZwHTTJsAo9DAWVdnYJbtv5B1Zv7vpgqtg1madaJna3NQdkwTFA
         bNak2cQQh2Bl4B3CqF4C7tD93fA+XZMgI9WuDA62P7NwRmZ/tCh1N6ljQkrvQfhiQ7J9
         QZ0LMHpwmsYi/ZOqI5ZZ1hFQl1fO+/G4V/n/+OPR2fTbQHIBfHJSLCAdO0hmYRqGQJ1j
         qLn/iOCqHjx4g+Bmph2ETgxi+FEUJib7vrG35Otaws+9LSliiG5ZmkOB8cguMR5rIVyT
         XKxA==
X-Gm-Message-State: AOAM533gbR+eOXcmlNr4x8/eUEv74957otmwOKOLsrbopC9s82owd3Oh
        GH8s97mXFi6GB9sFLyj9CAwd8w==
X-Google-Smtp-Source: ABdhPJzqmCCROdTAh4mINIHDWtKReeWzZihdPEwTeamzuw2CuCOAX2lKwuAQZGGVSBG5s+y4UQgjig==
X-Received: by 2002:a63:5350:: with SMTP id t16mr6987808pgl.321.1639556435096;
        Wed, 15 Dec 2021 00:20:35 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:754d:1c44:62a9:6d30])
        by smtp.gmail.com with ESMTPSA id j127sm1679143pfg.14.2021.12.15.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:20:34 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:20:31 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jiaxin.yu@mediatek.com,
        shumingf@realtek.com
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8195: update control for RT5682
 series
Message-ID: <YbmlT+OSwpGuylsx@google.com>
References: <20211215065835.3074-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215065835.3074-1-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 02:58:34PM +0800, Trevor Wu wrote:
> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
[...]
> +static int mt8195_set_bias_level_post(struct snd_soc_card *card,
> +	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
> +{
> +	struct snd_soc_component *component = dapm->component;
> +	struct mt8195_mt6359_rt1011_rt5682_priv *priv =
> +		snd_soc_card_get_drvdata(card);
> +	int ret = 0;

ret doesn't need to be initialized.

> +	/*
> +	 * It's required to control mclk directly in the set_bias_level_post
> +	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
> +	 * at the end of playback.
> +	 */
> +	if (!component ||
> +	    (strcmp(component->name, RT5682_DEV0_NAME) &&
> +	    strcmp(component->name, RT5682S_DEV0_NAME)))
> +		return 0;
> +
> +	if (IS_ERR(priv->i2so1_mclk))
> +		return 0;

I doubt if it needs to check priv->i2so1_mclk.  In other words, if IS_ERR(priv->i2so1_mclk) is true in _probe, does mt8195_set_bias_level_post() get called?

> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		if (!__clk_is_enabled(priv->i2so1_mclk))
> +			return 0;
> +
> +		dev_dbg(card->dev, "Disable i2so1");
> +		clk_disable_unprepare(priv->i2so1_mclk);

I would suggest move dev_dbg() later than clk_disable_unprepare() which means "Disable i2so1" is done.

> +		break;
> +	case SND_SOC_BIAS_ON:
> +		dev_dbg(card->dev, "Enable i2so1");
> +		ret = clk_prepare_enable(priv->i2so1_mclk);
> +		if (ret) {
> +			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);

The error message can be more specific.  "Cannot enable i2so1" for example.

> +			return ret;
> +		}

Also, I would suggest move dev_dbg() later than clk_prepare_enable().  Otherwise, it could fail to prepare or enable but still can see "Enable i2so1" message.

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;

The function doesn't use any gotos.  To be concise, "return 0;".

> @@ -1072,6 +1119,19 @@ static int mt8195_mt6359_rt1011_rt5682_dev_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
> +	if (IS_ERR(priv->i2so1_mclk)) {
> +		ret = PTR_ERR(priv->i2so1_mclk);
> +		if (ret == -ENOENT) {
> +			dev_dbg(&pdev->dev,
> +				"Failed to get i2so1_mclk, defer probe\n");
> +			return -EPROBE_DEFER;
> +		}

Does devm_clk_get_optional() could make the block more concise?

> +
> +		dev_err(&pdev->dev, "Failed to get i2so1_mclk, err:%d\n", ret);

If devm_clk_get() is possible to return -EPROBE_DEFER too, use dev_err_probe().

> --- a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
> +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c
[...]
> +static int mt8195_set_bias_level_post(struct snd_soc_card *card,
> +	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
> +{
> +	struct snd_soc_component *component = dapm->component;
> +	struct mt8195_mt6359_rt1019_rt5682_priv *priv =
> +		snd_soc_card_get_drvdata(card);
> +	int ret = 0;

Ditto, see comments above.

> +
> +	/*
> +	 * It's required to control mclk directly in the set_bias_level_post
> +	 * function for rt5682 and rt5682s codec, or the unexpected pop happens
> +	 * at the end of playback.
> +	 */
> +	if (!component ||
> +	    (strcmp(component->name, RT5682_DEV0_NAME) &&
> +	    strcmp(component->name, RT5682S_DEV0_NAME)))
> +		return 0;
> +
> +	if (IS_ERR(priv->i2so1_mclk))
> +		return 0;

Ditto, see comments above.

> +
> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		if (!__clk_is_enabled(priv->i2so1_mclk))
> +			return 0;
> +
> +		dev_dbg(card->dev, "Disable i2so1");
> +		clk_disable_unprepare(priv->i2so1_mclk);
> +		break;
> +	case SND_SOC_BIAS_ON:
> +		dev_dbg(card->dev, "Enable i2so1");
> +		ret = clk_prepare_enable(priv->i2so1_mclk);
> +		if (ret) {
> +			dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		break;
> +	}

Ditto, see comments above for the block.

> +
> +	return ret;

Ditto, see comments above.

> @@ -1285,6 +1326,19 @@ static int mt8195_mt6359_rt1019_rt5682_dev_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	priv->i2so1_mclk = devm_clk_get(&pdev->dev, "i2so1_mclk");
> +	if (IS_ERR(priv->i2so1_mclk)) {
> +		ret = PTR_ERR(priv->i2so1_mclk);
> +		if (ret == -ENOENT) {
> +			dev_dbg(&pdev->dev,
> +				"Failed to get i2so1_mclk, defer probe\n");
> +			return -EPROBE_DEFER;
> +		}
> +
> +		dev_err(&pdev->dev, "Failed to get i2so1_mclk, err:%d\n", ret);
> +		return ret;
> +	}

Ditto, see comments above for the block.
