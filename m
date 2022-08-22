Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F207A59CA24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiHVUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiHVUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:36:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE64550B1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:36:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s1so14113649lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8D3kUn5fYBM4V+Qs+cFN60c+8X0EDIzJuQL8ZIXGtI0=;
        b=crXnr7WSIJwe1LInUIsK4LNFPOGh5mN+5s2zzq1nXujtNd3RRj/DRM3kLgyM/gi6lu
         xbfXCwDKH58rWlCZOt/t5D8Boo65PkGx2s1dfYJAn+PRBCzHRfRY5+O9CmHk3fx9Zn2y
         aPzxUldwe/F1sOF74kJS1PGBASzKpk2CuHyyw8L3tCn8B8xb/UScZHDs8FGG/UvrmN4V
         Ke/+fqHL68cGgUH13Tx8SW4t0W2vGeq5CL/x8GQJBwOgtCaIbTvfiWtdDvSdTrCR8vcL
         xCv4KsTq/PedsIS9mrXZv/lYHHnyIu0hZyAnRhNdf2LAv9AY1yUJwbNZ4l7Se25sPw7O
         VueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8D3kUn5fYBM4V+Qs+cFN60c+8X0EDIzJuQL8ZIXGtI0=;
        b=WVvPHJ98NI2mO3RXr1USsY9yWXoQg7XbBs+s/gNqT4Vhz4bKLlbUI2Jc2KVzmEDz66
         ZcLDg+JgpLAFjAOrG8uasepWWVpLCG+qK7dIkKj5g20jma6Z15oFFy0AlKTJiCb4ws5r
         hLIyFb2A02uZ5fzVMq9dIPDdiAKxVQ3TCJiuzpcoFdx36EoKwQgU793E4HG4h4akoKbM
         f7J0aJqgzAz/H0IPcnuNPg3Nh9oMgt5BjDrBahUTpfoI9p2liMm8H3OU7Ny+JCJOsKg1
         WCSjMrYben2qfD6e7A5SS3QfZIl0TAyqo28L+5HilUGFNTdevfemmYw7/ZFwDHmiLU4T
         INBg==
X-Gm-Message-State: ACgBeo3YKjdyGgkY8PHHbroXIzFQ/M8vrui/KdYfOxQXv50fclTldo08
        GyB5c3hMmtD1ZZHxyDqjJfKXkw==
X-Google-Smtp-Source: AA6agR5cdOIA5bjk6MSUS24/EuVsIoVixrTAZEkulSiVqyuG5sAd5QPCKb+kYXxThno3+OKHwkiEFQ==
X-Received: by 2002:ac2:4c55:0:b0:492:d91d:363f with SMTP id o21-20020ac24c55000000b00492d91d363fmr4737919lfk.116.1661200597302;
        Mon, 22 Aug 2022 13:36:37 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512348300b0048af6242892sm533741lfr.14.2022.08.22.13.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:36:36 -0700 (PDT)
Message-ID: <b10b4e8f-e0ee-f92f-e65e-1ea8511804d4@linaro.org>
Date:   Mon, 22 Aug 2022 23:36:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 6/7] drm/msm/dp: Don't enable HPD interrupts for edp
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
 <20220810035013.3582848-7-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220810035013.3582848-7-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 06:50, Bjorn Andersson wrote:
> Most instances where HPD interrupts are masked and unmasked are guareded
> by the presence of an EDP panel being connected, but not all. Extend
> this to cover the last few places, as HPD interrupt handling is not used
> for the EDP case.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

-- 
With best wishes
Dmitry

