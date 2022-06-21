Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3925539A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347202AbiFUSkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiFUSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:40:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CD10FEE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:40:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f39so8214327lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uDyittP64vQtB3M07CJp4QeN+56SAqdK1J0XQGpRBNo=;
        b=fpcGPwaFqceX/cmFvUoJ5QF+vl0m5i9zqNt5QSuFTn+JjvEO+6alOPrbo19Jrl2zyV
         0+guPaVkW6yUcY9p7gw6o23WlqsmcEsVxMDwiU848Mshx01t24FI4QrpSf8ii6F9G1Dd
         5oJICdaCNpeFqaAXjtnZpwif2QeQm83p3uKl9S8qatOQZHk+LTSa5MR2N9kob6boDHYU
         YfXybzBaE/x+VTTjnlg4ShuD8hYBI92rGGRySxLtjzFVEw4PuF6wWKph74VOGVwy16wF
         QqWA75CvOZ0uFIJnefwC+cTQzIkYjDyQqLrLUsd1n83o1wPZYkUe7pDTa7M4XKWTIGba
         wnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uDyittP64vQtB3M07CJp4QeN+56SAqdK1J0XQGpRBNo=;
        b=byCx6Tqimtv/ns4YjwIfuurOmVYNOdQIAoJQhLjU70SXJMm4RNaajk3Kjut3f7YczP
         iDJziTq7R5LWaaxKj+kmfKU0CvvYErcGSf7QG7FLx+d0CszWNbFXzCju0J9cOI4XTjJn
         ybyLFZlnaKUcq4paAWkAOdobJ97tjAVGXrf7sSPzBI3XTB7ZxUNC3vbuhrXoFidW/QuQ
         j0TS7vAkpyBbhLF75eawueL5bj0Sbhs/o9ydISWVVtWBxtpaxX1ZQIT3nxF+bIV6e20C
         wRR5bUmYikJ5pBS7iKY1mlibWqyHu6dh4C72mJ+oT9kL4ScCsea12IMB7NLWONh3riyQ
         GYdg==
X-Gm-Message-State: AJIora8La2Zr189cnzft96WwmnbEJWizaoYBGy71gRl+nVhcCowXqq8O
        /pw+PQBRPTWs3IhUEgITZSGwqQ==
X-Google-Smtp-Source: AGRyM1uhpfmmJNlYBdq65hirTMs/vSoZDLblmci38dLR13tm6bWLAc5IouVaSgnfb/4mTHqgIb03JA==
X-Received: by 2002:a05:6512:515:b0:479:11a0:8132 with SMTP id o21-20020a056512051500b0047911a08132mr17892802lfb.344.1655836805207;
        Tue, 21 Jun 2022 11:40:05 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.230])
        by smtp.gmail.com with ESMTPSA id g2-20020ac24d82000000b0047dc46b466esm2262741lfe.85.2022.06.21.11.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 11:40:04 -0700 (PDT)
Message-ID: <33a9a76a-5f6e-b790-17d4-62869a04529d@linaro.org>
Date:   Tue, 21 Jun 2022 21:40:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [v3 0/5] Add PSR support for eDP
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>, y@qualcomm.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com
References: <y> <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
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

Please fix your mailer. You've got the following headers, which clearly 
confuse the threading:

In-Reply-To: <y>
References: <y>

Also the y@qualcomm.com address (present in To:) rejects incoming mail.


On 21/06/2022 13:53, Vinod Polimera wrote:
> Changes in v2:
>    - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>    - Don't modify whitespaces.
>    - Set self refresh aware from atomic_check.
>    - Set self refresh aware only if psr is supported.
>    - Provide a stub for msm_dp_display_set_psr.
>    - Move dp functions to bridge code.
> 
> Changes in v3:
>    - Change callback names to reflect atomic interfaces.
>    - Move bridge callback change to separate patch as suggested by Dmitry.
>    - Remove psr function declaration from msm_drv.h.
>    - Set self_refresh_aware flag only if psr is supported.
>    - Modify the variable names to simpler form.
>    - Define bit fields for PSR settings.
>    - Add comments explaining the steps to enter/exit psr.
>    - Change DRM_INFO to drm_dbg_db.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> 
> Vinod Polimera (5):
>    drm/msm/dp: Add basic PSR support for eDP
>    drm/bridge: use atomic enable/disable callbacks for panel bridge
>      functions
>    drm/bridge: add psr support during panel bridge enable & disable
>      sequence
>    drm/msm/disp/dpu1: use atomic enable/disable callbacks for encoder
>      functions
>    drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver
> 
>   drivers/gpu/drm/bridge/panel.c              | 110 ++++++++++++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  36 +++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  30 ++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
>   drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
>   drivers/gpu/drm/msm/dp/dp_ctrl.c            |  76 ++++++++++++-
>   drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
>   drivers/gpu/drm/msm/dp/dp_display.c         |  14 +++
>   drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
>   drivers/gpu/drm/msm/dp/dp_drm.c             | 166 +++++++++++++++++++++++++++-
>   drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
>   drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
>   drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
>   drivers/gpu/drm/msm/dp/dp_reg.h             |  27 +++++
>   15 files changed, 591 insertions(+), 24 deletions(-)
> 


-- 
With best wishes
Dmitry
