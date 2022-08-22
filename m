Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671559CA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiHVUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiHVUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:33:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516415834
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:33:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so11692168ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=K9ObQ97ISx4Clb2EU3qigRcWkQ6jJk32rWADiTnPB+w=;
        b=HuR5Jhu4zVf25w1uhem4PvXtNLZjHJwxvHsr3LBLE32U2npuz5LTsoWBb/HaYycPdv
         tLKGtDcYAdTDkv4aG8D8rKzLSbmKrUai8AGSfFnHc/PfuoWzx+mY5b/SWbMHIa7Lqf/w
         /LjxODb+uB3sw0hWq7BwxuJIGfGxMCTT2fspo7nnYcqr4hFMI6dcbn+JrcKCZFGB4MS/
         gRMPS7zIwgQY7SPqY13UMnMNh7B+aYg9PIYppCmkK0qpxNhUc8RQiwVNAOUl+y2yi3uN
         Eu9VuDN/HbmpWuoIy9dK6VYnU9wx9anKXtKQrgxQxd+jmm0FHyvHGIk9a2Lur/Iyv0r0
         ip6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=K9ObQ97ISx4Clb2EU3qigRcWkQ6jJk32rWADiTnPB+w=;
        b=i+tk0fnl+Lam3+VJHxQaCGZtXrxUkL3Lq/lfbYdawdwW6wMyZcvbvYPQIFr/BVhuxT
         EEnmXr8M3LefdXX6aMUWvX0GUSDX1fCjeCfMm+m9WDlAD2t+dD8QZIc2XfADnCdk+qC6
         xAecO1rdyqCK+2V6nIs82dvroQArvY+IuoHA4uUA7TzIvhCGu4oWk2rzUIFd8NbdAm7g
         gE1sZ5qty4p9xsg/Jfh+V6Uv5a7J5YdPtMMuqYg1JHTP/WOX5defgew2LvkUuo9kKh6b
         QQFrITEGUXGds787BoFpzvCz2ljQdA1NHuES7CJ5K+aVXfO04uw4gl8DwfCXD+VlSItm
         U1sQ==
X-Gm-Message-State: ACgBeo3Gn/dheucvyV3ET4PO0SZSCci2lxSb6xqRlK8upkN04/gmP3L+
        /KXtWuEx/VYJw1oZFexV8tjFlw==
X-Google-Smtp-Source: AA6agR6WVHEiENVXSb3cj+S907V1F8Xb4V+GL/frT2pmZ0hKCfKocjlQl883hDG+8Q/TBumk2USBTQ==
X-Received: by 2002:a05:651c:1544:b0:25f:5036:ece2 with SMTP id y4-20020a05651c154400b0025f5036ece2mr6589760ljp.73.1661200428065;
        Mon, 22 Aug 2022 13:33:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020a19ad48000000b0048ae316caf0sm2090513lfd.18.2022.08.22.13.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:33:47 -0700 (PDT)
Message-ID: <2d9db562-1746-64d9-7ca3-f1a7f405bd77@linaro.org>
Date:   Mon, 22 Aug 2022 23:33:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/7] drm/msm/dp: Add DP and EDP compatibles for SC8280XP
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
 <20220810035013.3582848-4-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220810035013.3582848-4-bjorn.andersson@linaro.org>
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

On 10/08/2022 06:50, Bjorn Andersson wrote:
> The SC8280XP platform has four DisplayPort controllers, per MDSS
> instance, all with widebus support.
> 
> The first two are defined to be DisplayPort only, while the latter pair
> (of each instance) can be either DisplayPort or Embedded DisplayPort.
> The two sets are tied to the possible compatibels.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.h       |  1 +
>   2 files changed, 23 insertions(+)-- 
With best wishes
Dmitry

