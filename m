Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4A59CA44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiHVUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiHVUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:42:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7952FF0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:42:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a16so8622332lfs.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=T2n+Lv4KvObfEMOxqTtH9zJ8A2GPm+1tT6W+HrcRbLY=;
        b=uyR1Lq08Xt37Czv3fZnuQVC5djaS3RavHhqAE/nCVhDLnogNF0T4hECW+gb+J0XekS
         QRBAGt31862H1JfZEACVl+hVxlN+IMC2vy70jeCbPeXbsk4gjBGEmbxpVg+Xs5Eu8dEr
         xLXdznl02Wmki6mmYdK0CWLvyZs3GeMF8MaxxjFHKbN206D+syv/Xzknoyph17E22L7p
         t7VkVqUua0QyUOt2KalftjWfOyu6NIIqssjZOd5ixXL+DPd2zWLVfC63eJAE3yPwSaoF
         RSEDw4hb25LQuNn/HtIgkk/luUb/j5F9LUML0zjL6P0NIAhEbAV406iw01PkA323hO7+
         f1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=T2n+Lv4KvObfEMOxqTtH9zJ8A2GPm+1tT6W+HrcRbLY=;
        b=0/Gzs9srUo/ZXHUepIlf39JZN1ykeKe8+zO896xDQsCqiRwWIl+5N7l+7Cjz3irnV2
         ZZSQSOcq+rcVftF8YIW7rZrcBIbXbXM1ptf+w0FnDXsrxH7JgfaScCkDQqponBEmN0H0
         WU31QBwNpAMZGrXTUcdFTkEPDe4AuTHAsIKEsOdJw9Lr3an6zXcTCNU0JKl8/NBQPXlv
         4pWayRUExXi2QFJpbfaXsx/KrfmTfMv3f5DVndoIo+ibQ3JQX5d+GNawgnnBojD6Q0FB
         QuZO0ZM26EJ2N0PfFB7dMe+aC6HzMgE1/waCOzdgW0hSca+PKWVPDMw4rC9R4odkJobk
         5MJw==
X-Gm-Message-State: ACgBeo07kKlmi6WKuDI2Ra3SlleN+XyqFR0Cmc/PYJrRdNqZnidH1uBs
        yrTdbPS2/hYiw2TqfTuLDXpUWQ==
X-Google-Smtp-Source: AA6agR5rCB4QhCUzVyTSuhrloe4Tlr3L7LCyjaozOGYIYqRMr4K9wKFtZ6ZXnjidUe1hpMsTfB1upg==
X-Received: by 2002:a05:6512:1385:b0:491:4152:c9d7 with SMTP id p5-20020a056512138500b004914152c9d7mr7667543lfa.675.1661200955744;
        Mon, 22 Aug 2022 13:42:35 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020a197708000000b0048a891e4d88sm2089178lfc.193.2022.08.22.13.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:42:35 -0700 (PDT)
Message-ID: <ea75b23f-d389-b24e-9ebd-2fd35bf33fd1@linaro.org>
Date:   Mon, 22 Aug 2022 23:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/msm: Add fault-injection support
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220807172848.2432845-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220807172848.2432845-1-robdclark@gmail.com>
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

On 07/08/2022 20:28, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Intended as a way to trigger error paths in mesa.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_debugfs.c |  8 ++++++++
>   drivers/gpu/drm/msm/msm_drv.c     | 15 +++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.h     |  7 +++++++
>   3 files changed, 30 insertions(+)
> -- 
With best wishes
Dmitry

