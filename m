Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBEC5A23C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiHZJKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiHZJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:10:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016032F03A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:10:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w22so978569ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j2KtObeVweB4PtewYavPBdUZLz9VJwwib5xRQ67zdyc=;
        b=oKatiD/7aR17ObA6DF3MveHscjyhwPg0qhz3TCUeRFLBGKOJXf6NDR9oYbEVbRXUzO
         B6O5F/uHMUPxl3Q9UWZSLS8+IPMUzbCOXFZV4BEQtycIHZb16hTRjNwCh6Rj4Xr4YjRH
         kTu3QlmCEFqpygZnHvdXFzHYEWkjLhtCKDMbsrzu8WAgw9O+T92h9c/Y7+FTBttw2UPf
         4cL3kChUNV/QKrKXSnhFEH1g25t38XfapJw2PcPGg9H79moryop6ylmJAhRKULvZ3UrY
         wONZnzpvcfWzCIr+HKn2WleikcsQUJQnCkgPHBAuPRzoiJHlwgrvG4G1KYEODqYk2P4u
         eM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j2KtObeVweB4PtewYavPBdUZLz9VJwwib5xRQ67zdyc=;
        b=tCt1tItjq2Xza426JWOyIflgfZqksaNJ9ZZdVa3tzlNvgKkLOw4iD5iWsuGrbvtZfV
         VzzRvMgCZxD/+8+UTA7a3MJdU5ypgaYMCX6f86Yzfdx7ebzTNcS0Q7vKkRK3gwWFz8Md
         KGu+vqmvkpFHyVLPENpJZS1YFGfYQohKeDuq2EOHt7a3Qm4Jo0IKVkYf4g/Idq8KH6hW
         msjWT8dbhJqP/mGYtr2dQUCTBmBVVH7Mk4J+tW2lNcSQphHPw5/bTDzyouqbqpH8UeFO
         Kl0tPQb7mzv2je49IkDZKvLRTPERwaGQNomo0a+jMfWcv7JNiNbbOwctWCD1bq3hlKVJ
         bRCA==
X-Gm-Message-State: ACgBeo0S8ncDOQFe5BFeDAzjLRXcThYzz2m7pjBOvHW7GJ4b9bqFopEp
        orklt/2aw04nBh/okMSRf4w9hA==
X-Google-Smtp-Source: AA6agR48eHVuu7caQCj51Y7Sljt2mlqruCtMZ32WU62CLQcXPd24ORg6/ufVrMRPia1ZCj244CTMFg==
X-Received: by 2002:a2e:9d5a:0:b0:25e:2c67:edaf with SMTP id y26-20020a2e9d5a000000b0025e2c67edafmr2097255ljj.437.1661505000270;
        Fri, 26 Aug 2022 02:10:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s3-20020a05651c048300b0025e42174f0csm387180ljc.70.2022.08.26.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:09:59 -0700 (PDT)
Message-ID: <713dbfbc-0111-f100-bc59-f664a25bdc3d@linaro.org>
Date:   Fri, 26 Aug 2022 12:09:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH RESEND] drm/msm/dsi: fix the inconsistent indenting
Content-Language: en-GB
To:     sunliming <sunliming@kylinos.cn>, christian.koenig@amd.com,
        robdclark@gmail.com, quic_abhinavk@quicinc.com
Cc:     freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        inux-arm-msm@vger.kernel.org, kelulanainsley@gmail.com,
        kernel test robot <lkp@intel.com>
References: <20220826084917.95409-1-sunliming@kylinos.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220826084917.95409-1-sunliming@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 11:49, sunliming wrote:
> Fix the inconsistent indenting in function msm_dsi_dphy_timing_calc_v3().
> 
> Fix the following smatch warnings:
> 
> drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350 msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting
> 
> Fixes: f1fa7ff44056 ("drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

