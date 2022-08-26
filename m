Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BC5A24C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbiHZJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245479AbiHZJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:45:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9B175AC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:45:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l8so1280699lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MRX0Q3WFNIyiJmZ3N40sithEPWIDpqa2XOG7FbBr3D0=;
        b=DdKZMvLy1XEM5WRjVugHdAX4mR9xI5f62NbewhpZWwoafdfHcdoAXDVc/YrZbu23kD
         MM8Lc0U7QhsaSQLgsaE6/7OTRqvm2h+9oL/UYC13P3tPufMFH7nNH1bVIm4J2PD+w2SA
         BgFEkxo+COMALZs9JP45pQNhm2DFWt6K1Y/1NeoLzu8EJCVobi/SSPH2mgCxcQnyRtNY
         L7C2TQPU6ELdcqIwaWdN72y+HtR3S3wy/lnDxN+jerJV7CRJ+tIJXcPFsCWgsv7VDA3D
         wezhM8uUvafqGDIjlgv/aM9A4xtPmK7BXitVAMfuL29zZndhA+xRJ8jT9QcsP/hN0gAz
         4+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MRX0Q3WFNIyiJmZ3N40sithEPWIDpqa2XOG7FbBr3D0=;
        b=uGLBkKT7B1TNfOTYBsJi9nMs/iXgjCKpqRBduljE1RO3WV0Q+C6/76SGXAUrz34LD3
         SD5pmHwLyVh9+ZPFRPuCYOMTpjX+XdMCEBFquwBbhjZqMzXRU8KM2s54CWmN+q01lM1c
         DpqwooS3V2/04PrQ5rCQgO92Qi3+utFIpjySrqaKGqiWXkHUlZmAIzTLOaCyZZ2Tq9vL
         1qe1Ak4XzbRZwlssxt5qavu9TVVQtsi2FPiV+j/09pPHqDRvYOzIEXP6ke6p+3cvateA
         R/Gwd+ZmVsddwl3OAmw4zcNi+EotLxlA565i6RNXhiiSBx62b/jUeiVhkFGv10ODxxW7
         nxFA==
X-Gm-Message-State: ACgBeo1Dla/2B5ypciefvWWRwKJag5V6/MQ7uX0xiyLaW7AialnYukmq
        Uofy7jshfP7w2UbIq9tnuKKJKQ==
X-Google-Smtp-Source: AA6agR5grWoSeTNkOaTdkov5yXG2RspFnS/8kO38DF7QXqH412ouT7J2ahv8u3r5wPWv5QcnQ30ghg==
X-Received: by 2002:a05:6512:2629:b0:492:b1e7:bf26 with SMTP id bt41-20020a056512262900b00492b1e7bf26mr2092332lfb.254.1661507110668;
        Fri, 26 Aug 2022 02:45:10 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id be28-20020a05651c171c00b0025e72aae6bdsm399882ljb.28.2022.08.26.02.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:45:10 -0700 (PDT)
Message-ID: <0e16e719-4eb2-bfb3-6b77-88d5314757a1@linaro.org>
Date:   Fri, 26 Aug 2022 12:45:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] msm/adreno: fix repeated words in comments
Content-Language: en-GB
To:     wangjianli <wangjianli@cdjrlc.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, wangqing@vivo.com, dan.carpenter@oracle.com,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220724073650.16460-1-wangjianli@cdjrlc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220724073650.16460-1-wangjianli@cdjrlc.com>
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

On 24/07/2022 10:36, wangjianli wrote:
>   Delete the redundant word 'in'.

Could you please:
- adjust the commit subject to follow the rest of commit messages,
- drop the extra whitespace at the beginning of the commit message,
- add a correct Fixes tag.

Thank you

> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 9f76f5b15759..9303a011b81d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1277,7 +1277,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>   		}
>   
>   		/*
> -		 * Look for a level in in the secondary list that matches. If
> +		 * Look for a level in the secondary list that matches. If
>   		 * nothing fits, use the maximum non zero vote
>   		 */
>   

-- 
With best wishes
Dmitry

