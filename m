Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2250C5A60B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiH3KX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiH3KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:22:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F177579;
        Tue, 30 Aug 2022 03:22:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p7so3732264lfu.3;
        Tue, 30 Aug 2022 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ewFvocVNfh/1BMVRJJhj6y+q9DXa1cklPYO4jJJ+ZPI=;
        b=G9w+EHsaYTf3RTd0wF+VIfFaIZEtTiw4ylQgi2J4gfawcB7MJij1hAOQqp127Cp3sV
         9Tzei6RF70Zq7P0eHDXPdurkyOZKpYeFgoxBN0D5cMrM0uLxYqhKS0l/yQ44wCBmxaY1
         AUBPV/+Z8fqfQYJ8GHWpjeAs5IfSkBqKmy7vOWlOkf8c5T+fXxDFhYycK2i6UO53EhTY
         cG5QhtsblzJeRgBxxQjOmn9uK0CJfYkOLVZ3wmGlUZ6MuDmSfKC5y/ZbnjyB+sUEmXyL
         jv0sIEergg/34/jqdrJr6jA1UbDviYTis75trAfEUisn8YAmdt9KwvPDvprXRBd0r+Wp
         1VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ewFvocVNfh/1BMVRJJhj6y+q9DXa1cklPYO4jJJ+ZPI=;
        b=nWihu9Z4Jfx4rVigjr9y4GmfqfpNuoS0cMe7W2ak8+6APlH68PZ1AT/p/wWFJt2agH
         h8Dxr/EmZl4DY+V/dmRhMEpM03wJNehhFxgsPuq7kHnozmmjLUuwScb6h1xESjftN3Dp
         IRkRWzIwK6E01wsJTIFS9+bJ/dD7ZP7rVNzPIvJgxRJzOTc6rBgm5iE+KK6zv36yhObp
         wdBXg9qarBsgM7ZoisXrOJZkshSPHD5xnGzP7NLdogMgRU9SvNbRybyKNYeV66L+60he
         Ax+4Jm2O4iH3//fUd+IgwqjtmMPmohg+DX/3u+DlSYaMTAqxHxkx3E7CN/A0wb+06F+c
         xaaQ==
X-Gm-Message-State: ACgBeo1r62u8Hm1kaIeRO2fqmfih65FG7au16y0DKeMnv1C+2/rEaU+g
        rVvyp4Yar6Us/3YhcW/4/Y0=
X-Google-Smtp-Source: AA6agR6roG+6pfy1GbA43X3JSuD5tBGJOEwN6P3O5bTo8eY5FYH8nUbstwZW9bi3uCb39lJN5D/lvA==
X-Received: by 2002:a19:911d:0:b0:494:6701:1d17 with SMTP id t29-20020a19911d000000b0049467011d17mr3991390lfd.31.1661854936337;
        Tue, 30 Aug 2022 03:22:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t17-20020ac25491000000b004946d1f3cc4sm613954lfk.164.2022.08.30.03.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:22:15 -0700 (PDT)
Message-ID: <a97be2ae-b7d2-2ecf-fa17-de2d8755fb83@gmail.com>
Date:   Tue, 30 Aug 2022 13:22:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v9 05/10] lib: add linear range index macro
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, jic23@kernel.org,
        lars@metafoo.de, deller@gmx.de, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
 <20220830034042.9354-6-peterwu.pub@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220830034042.9354-6-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 06:40, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add linear_range_idx macro for declaring the linear_range struct simply.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
> 
> v9
> - Revise LINEAR_RANGE() and LINEAR_RANGE_IDX()
> ---
>   include/linux/linear_range.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
> index fd3d0b3..2e4f4c3 100644
> --- a/include/linux/linear_range.h
> +++ b/include/linux/linear_range.h
> @@ -26,6 +26,17 @@ struct linear_range {
>   	unsigned int step;
>   };
>   
> +#define LINEAR_RANGE(_min, _min_sel, _max_sel, _step)		\
> +	{							\
> +		.min = _min,					\
> +		.min_sel = _min_sel,				\
> +		.max_sel = _max_sel,				\
> +		.step = _step,					\
> +	}
> +
> +#define LINEAR_RANGE_IDX(_idx, _min, _min_sel, _max_sel, _step)	\
> +	[_idx] = LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
> +
>   unsigned int linear_range_values_in_range(const struct linear_range *r);
>   unsigned int linear_range_values_in_range_array(const struct linear_range *r,
>   						int ranges);


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
