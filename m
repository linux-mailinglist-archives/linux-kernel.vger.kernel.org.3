Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6260592EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiHOMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiHOMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:02:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B822B3F;
        Mon, 15 Aug 2022 05:02:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so10363165lfb.1;
        Mon, 15 Aug 2022 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=/XsHCAAUo/oLtA4l5n4XUmocauuvUzyU7VbH9wcjXcQ=;
        b=ErUX/iJM60mg/GIhgD9m2o8Zsimzt51AWru/dx19gtiQS8+UJAccBHKTCddaet4TL/
         rEMwij3r1MnT4WMxRr+n8tI+hgQvFYSU4A+na+zrazwGfgyPwI2qpZ6NcVpZgYBQU1vw
         YnYlPGp8CSlmgHsuOypQ+2k2G75mzmpUIAyAQblYZWsbHoZ3D7uBunM2iAEjxonZUruq
         XmQvyKmgrdxBuqrUSY5a5XnpN/CCCP/7/hdlyeD+ChsNjOc1+g5KERM6GSB1gIbDR8ZM
         elh7UJtmD8U4ToCIwcM8PvG0qMTtWsCzvISExiM7RTPenDiFEYWS5gDjaJp7M3FiYxci
         wuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/XsHCAAUo/oLtA4l5n4XUmocauuvUzyU7VbH9wcjXcQ=;
        b=LFFj5s08rSZp3sXCny7WCK5034M0l/8oHJlWATkNeff2f3qBL2FfBMcwXOUbhnOcXt
         SsZVzMV+GR6l1EKroSvENxU+oN3jEW9V9G+9VO1HFwgAh75VbCrJUjv5+6XEyUyTVhiS
         LihtREIiNkBr4onWiGCNCPD4hI7gBYXcYlAuK5B/m1JZPl56P4ObRuo6osqchmy5qq6n
         bRk3KLWdN5WdzjFLSlqZgXiWIvfOKqBZc+cN/ZXE8TZUi22acMyZCCk5NPmQa++BPo3l
         1EnV2FvqPbJPAdZf0hFND/Q5CW94pfGo2d5EU6ZzYodM9s4Bmk5cnhmckK1PAiOkBdN1
         bKHw==
X-Gm-Message-State: ACgBeo3YVFrvkJpPG9f9a+tUMxAJ4+VByHBiw6XgyDqxfCA3kj7bXfK2
        YZLaNBDQojTm5UZoFT3LzBw=
X-Google-Smtp-Source: AA6agR5bn+jCdjoc5L3WS7gsgG/DC+Ia6If8+ihGn5S9bGfb+XvBKScyMfO5upO4+SQ2quD69RF6Lg==
X-Received: by 2002:a05:6512:1581:b0:492:8c61:5bef with SMTP id bp1-20020a056512158100b004928c615befmr1251567lfb.518.1660564975422;
        Mon, 15 Aug 2022 05:02:55 -0700 (PDT)
Received: from [172.16.192.210] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f26-20020a2e381a000000b0025e2e70b41fsm1384223lja.71.2022.08.15.05.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 05:02:54 -0700 (PDT)
Message-ID: <5a1a5a80-526c-2f76-0086-15cc76e88a06@gmail.com>
Date:   Mon, 15 Aug 2022 15:02:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        broonie@kernel.org, lgirdwood@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220815090125.27705-1-peterwu.pub@gmail.com>
 <20220815090125.27705-7-peterwu.pub@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RESEND PATCH v8 06/12] lib: add linear range index macro
In-Reply-To: <20220815090125.27705-7-peterwu.pub@gmail.com>
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

Hi ChiaEn,

On 8/15/22 12:01, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add linear_range_idx macro for declaring the linear_range struct simply.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>   include/linux/linear_range.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
> index fd3d0b358f22..fb53ea13c593 100644
> --- a/include/linux/linear_range.h
> +++ b/include/linux/linear_range.h
> @@ -26,6 +26,14 @@ struct linear_range {
>   	unsigned int step;
>   };
>   
> +#define LINEAR_RANGE_IDX(_min, _min_sel, _max_sel, _step)	\
> +	{							\
> +		.min = _min,					\
> +		.min_sel = _min_sel,				\
> +		.max_sel = _max_sel,				\
> +		.step = _step,					\
> +	}
> +

I think this somewhat differs from what you had originally scetched. Eg, 
if I didn't misread the patch earlier - you had:

#define MT6370_CHG_LINEAR_RANGE(_rfd, _min, _min_sel, _max_sel, _step) \
[_rfd] = {                                                             \
	...

instead of the
 > +#define LINEAR_RANGE_IDX(_min, _min_sel, _max_sel, _step)	\
 > +	{							\

I think the latter (without the []-index) is more generic, and very 
welcome. However, the IDX-suffix does no longer make much sense, right? 
I suggested name LINEAR_RANGE_IDX for macro taking the array index as it 
would also be useful when dealing with arrays.

Do you think you could still drop the IDX from macro name or keep the 
array index as the original did?

Maybe ideally introduce both macros (unless Mark has objections), one 
with the [_rfd] and suffix IDX, and the other w/o the suffix and w/o the 
[_rfd]?

Thanks for the improvements and the patience! ;)

Yours
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
