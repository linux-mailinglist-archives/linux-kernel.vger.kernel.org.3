Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449557B8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiGTOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiGTOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:53:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D0DF11;
        Wed, 20 Jul 2022 07:53:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11so4885467wmq.3;
        Wed, 20 Jul 2022 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y0wRoxXm0lXLU9vHgb65mx+sz5ayh2XUgm6rcM2W0Os=;
        b=DCcOQ/6pIyGvxCWOmJS1gJrYpFkWZT89oAWW0Ux6OQizF5MPa99CCwIX4LOJsPsX9B
         MIKDMfkNt7ahoBFEKs3Cca9tYTgh0BpStVWPIVr6tOfeV3GfP1kpCzT0RRsJrHIJUp0r
         sRoX0fzGoazOGVCzJrnwjsVm4Via8f/Wr3+oWYaKBgzplZRoO71GGex4cHaaTh3xaVw/
         LgAW498v1nQwVPf6cQNcoN6cFKGNKFh8JQX09MJLKHIIKIT4+d4/qLRHmYRL7gSUHNqi
         jsQb2kEubx44zU0PxxCYt8SXu6RRT4jRT3mGdWW8qIHIPprKiUnwt2ZlN0uxCqY1gRvq
         8YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y0wRoxXm0lXLU9vHgb65mx+sz5ayh2XUgm6rcM2W0Os=;
        b=IGCyHFOpL/7MoMI+2cGiCQx6rXDzuAja2q3Yr0WiJ4oFbi4/RMRFeP4q8xCVPdcN2x
         R3AZ9GKOtdAOWzYpVOXHY7NDE9kX+SFoOm54/jJklYjEBRJowc7k4DtEICEE7+k1Uiee
         Aq58/J3MwKKmfXf2xPutH/jaKTQj6rbibKltE8l9PiNO8cztmhR2ClLKvWDlRMH4NSjh
         TlUhmcPhwIdOVY8KhpyygxXtUBiPCwdll1RSoke5cDRGbzpyyUJMyEGmR35j6UwcUDpP
         4UBhUROTGlb81Bll/MAexGoNWWf5GKXzUvmUFjII27d+sOJnOYcJ2Ejf/HE05eRFQKMB
         NnCg==
X-Gm-Message-State: AJIora/O9St4duBM5cXB3e999a9yCR5IwpSTko235MhYehsnwgAUbf6z
        WT2PqdOHyc+P+jxzl3gWqOI=
X-Google-Smtp-Source: AGRyM1uWeUcffW8kDxoO+pUpEnNIyYERqP2oY3ASBFUAIzEgdBIasCmxz4OGqCxwoBCLupGt21noHw==
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id i19-20020a05600c355300b003a32b65299emr2373091wmq.145.1658328792662;
        Wed, 20 Jul 2022 07:53:12 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a31b79dc0esm11233827wmb.1.2022.07.20.07.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 07:53:11 -0700 (PDT)
Message-ID: <43acea66-78e1-b7da-8d1c-3a60a5ddf4b6@gmail.com>
Date:   Wed, 20 Jul 2022 16:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/6] Input: mt6779-keypad - support double keys matrix
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-4-ef9fc29dbff4@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220720-mt8183-keypad-v1-4-ef9fc29dbff4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2022 16:48, Mattijs Korpershoek wrote:
> MediaTek keypad has 2 modes of detecting key events:
> - single key: each (row, column) can detect one key
> - double key: each (row, column) is a group of 2 keys
> 
> Double key support exists to minimize cost, since it reduces the number
> of pins required for physical keys.
> 
> Double key is configured by setting BIT(0) of the KP_SEL register.
> 
> Enable double key matrix support based on the mediatek,double-keys
> device tree property.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
> index bf447bf598fb..9a5dbd415dac 100644
> --- a/drivers/input/keyboard/mt6779-keypad.c
> +++ b/drivers/input/keyboard/mt6779-keypad.c
> @@ -18,6 +18,7 @@
>   #define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
>   #define MTK_KPD_DEBOUNCE_MAX_MS	256
>   #define MTK_KPD_SEL		0x0020
> +#define MTK_KPD_SEL_DOUBLE_KP_MODE	BIT(0)
>   #define MTK_KPD_SEL_COL	GENMASK(15, 10)
>   #define MTK_KPD_SEL_ROW	GENMASK(9, 4)
>   #define MTK_KPD_SEL_COLMASK(c)	GENMASK((c) + 9, 10)
> @@ -31,6 +32,7 @@ struct mt6779_keypad {
>   	struct clk *clk;
>   	u32 n_rows;
>   	u32 n_cols;
> +	bool double_keys;
>   	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
>   };
>   
> @@ -67,8 +69,13 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
>   			continue;
>   
>   		key = bit_nr / 32 * 16 + bit_nr % 32;
> -		row = key / 9;
> -		col = key % 9;
> +		if (keypad->double_keys) {
> +			row = key / 13;
> +			col = (key % 13) / 2;
> +		} else {
> +			row = key / 9;
> +			col = key % 9;
> +		}
>   
>   		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
>   		/* 1: not pressed, 0: pressed */
> @@ -150,6 +157,8 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>   
>   	wakeup = device_property_read_bool(&pdev->dev, "wakeup-source");
>   
> +	keypad->double_keys = device_property_read_bool(&pdev->dev, "mediatek,double-keys");
> +
>   	dev_dbg(&pdev->dev, "n_row=%d n_col=%d debounce=%d\n",
>   		keypad->n_rows, keypad->n_cols, debounce);
>   
> @@ -166,6 +175,10 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>   	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
>   		     (debounce * (1 << 5)) & MTK_KPD_DEBOUNCE_MASK);
>   
> +	if (keypad->double_keys)
> +		regmap_update_bits(keypad->regmap, MTK_KPD_SEL,
> +				   MTK_KPD_SEL_DOUBLE_KP_MODE, MTK_KPD_SEL_DOUBLE_KP_MODE);
> +
>   	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_ROW,
>   			   MTK_KPD_SEL_ROWMASK(keypad->n_rows));
>   	regmap_update_bits(keypad->regmap, MTK_KPD_SEL, MTK_KPD_SEL_COL,
> 
