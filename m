Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565CC5A23B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiHZJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHZJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:04:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3893D39B9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:04:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n15so1190723lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AjQiG4EgjmYRn7Cg4E7RAYUNnb1Av4V8ZZtkQ1I3e+4=;
        b=hHIeZDnJuAFCgFgfQpFKWOqQxdQGMecO6XOIfthmP2g9jbqB1VY8dkv94z/m3BeXm4
         Tf1N4D+Jbpakj+f5VOnzfWR2VNBljEBk98ZwgYJV8lWVsZB2Y/ycZmqsruALQMjV4u22
         DM8OF4PaoP3NGoKl97AZ5Mkm2Q6ZoP1Klf1BCZw9WbEmyVIEQPMZhKa8k6QEp1HP6BhG
         6juyhvxxLMe3PkzLHn7X8GoOgX2OlA+UzGFznNEpiE5AvaodjNKejZj1sZ11XJFLKiav
         uOUsYcOtzgVxSlKA7Dh3rSXWkfeKmVHDVLyQI2ymJM73+wT9NCyM23ibDBCE50yAZowe
         ctjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AjQiG4EgjmYRn7Cg4E7RAYUNnb1Av4V8ZZtkQ1I3e+4=;
        b=UrVmqp3NDWUBV5ev5sTcG3c8s29KI5toRoK22ZKn6dfaQsoBpLcz/rm0F6iNw7oKJP
         v6LbKfvC+K2ipq8nveAyIpcFf1fgbibtlDPQpMFTzxvqkMA+xJdH3Uco8eoPOHpzi3+6
         nkKh20XkHZwJXz/MFuwJY/w2U4yig0VS3D2fDq6JxkY69ndbafTDrd3MlE9MeWi9O5Dz
         sl3m8etDntUizGk2fTQZVZLnvcgrJR0s43HFAREMfEPAZwt+j3mQrN97ChmHePfgbvFM
         kvYGTLSJwRK3GaeH+XMw+1k8ZxiLs84idP0YXgJDplJM0Gw4Avlkf8IfPLWTu3nH+cby
         Iy3Q==
X-Gm-Message-State: ACgBeo0y1Gq/5Q2TBPA3snwY4l6Udv85xga0lPApM/YYndv+HXWrO4/A
        N78HF0LMRG/QX5ZXVtP+cV0oKg==
X-Google-Smtp-Source: AA6agR7dh79FCl2FsfmNeeOKbVCCJZcOlRaDjGQ/56qG/mm45vx3UOGF5F3lMLWqud1gracnsstj/g==
X-Received: by 2002:a05:6512:b1c:b0:492:8835:1e4c with SMTP id w28-20020a0565120b1c00b0049288351e4cmr2095766lfu.442.1661504655030;
        Fri, 26 Aug 2022 02:04:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d11-20020a056512368b00b00492e10b1723sm310683lfs.139.2022.08.26.02.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:04:14 -0700 (PDT)
Message-ID: <bd791d9b-3b64-22ab-723c-86003c25554f@linaro.org>
Date:   Fri, 26 Aug 2022 12:04:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 3/3] drm/msm/dp: Get rid of
 dp_ctrl_on_stream_phy_test_report()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20220623002540.871994-1-swboyd@chromium.org>
 <20220623002540.871994-4-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220623002540.871994-4-swboyd@chromium.org>
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

On 23/06/2022 03:25, Stephen Boyd wrote:
> This API isn't really more than a couple lines now that we don't store
> the pixel_rate to the struct member. Inline it into the caller.
> 
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 44 ++++++++++++--------------------
>   1 file changed, 17 insertions(+), 27 deletions(-)
> 

-- 
With best wishes
Dmitry

