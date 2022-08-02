Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68958772D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHBGnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiHBGnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:43:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35CA39B86
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:43:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a13so14579289ljr.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BsVVyC/Z22amNBasFSTwD0frJD17UKZEk4SMZVrNHIU=;
        b=LqsvxmpWorpzOIuC6m2PTfI3qLyPXcxYoD1BefdsAJ6zN/c+uRM/ZyBDVFvUHqVVr5
         PFUFNleauUP10jwKwGBZNxk41Ub+2rSxmhC2haoWEvstGEEkiwzM8oRPnPeRsimtAzz0
         vhS4Mfuf7qZJdQie6g5PllOUJnq4bEz+xirCMM6jEkTP8PwwhgTvFrCwFvBtf0KmP9sd
         DDYzSf1pbfk1bo5WoU0wIMw7UZTdStKO8lqRy2HCQtCcOGUQVo3Pxom7srF4W3BrfL89
         GezqyLAknkdh4kLyjB89ZUhQf459poH+NOmqn9si+pcdpduhWx9lnCRxsii7vx2+Nmsw
         uu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BsVVyC/Z22amNBasFSTwD0frJD17UKZEk4SMZVrNHIU=;
        b=1Jcvf8ssinVhElT2rM/MdXOjDkpBx/anZIOjBkpTQZhrzSRoMPDWFY5ZMV03NK9Ge3
         4splkiwxhWUeHSz7Q+dYlriNJ0vMzT6f8SCe3qhzXj86MLQQP3o5dZSexoQCiy6ivjBM
         thYUjJpRAVmO2xaSnBD82Wc83TOPnSWbVglkY3d0GRk5pwMm2BPLbNZAs5jxbvHBbrDV
         5X72VkGoHWgztdPnPi0PB5NwzKXpaR47D712hg5HnanYPETrKeHBkdFBTnEnCemG1EdG
         6paJPNxg1vSg0u9yokUjZ69ngY/qkIFl4pWTFKL4k6Cks06JuKD5WrHY9oOcze19vERs
         vduA==
X-Gm-Message-State: ACgBeo1mLWlMc2/lQm3PElFskqhOJJcbRSdxqdcwZznwCsEUMuQ208IG
        FPhkPFI+cLqPk6zLLO5/2oVshA==
X-Google-Smtp-Source: AA6agR5W1350TyooKgsucDtF4STvja5/ZEelSzPbU/uzlbpxtdSurx+SHUuqPhe1zxxlb5nMwyCsKg==
X-Received: by 2002:a2e:a370:0:b0:25e:502a:5308 with SMTP id i16-20020a2ea370000000b0025e502a5308mr2336327ljn.282.1659422622264;
        Mon, 01 Aug 2022 23:43:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512201100b0048b08e25979sm199607lfb.199.2022.08.01.23.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 23:43:41 -0700 (PDT)
Message-ID: <bdf6abfe-89e3-80bb-6c5e-fcea713814e9@linaro.org>
Date:   Tue, 2 Aug 2022 09:43:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix
 tps4
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 23:13, Kuogee Hsieh wrote:
> Data Symbols scrambled is required for tps4 at link training 2.
> Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
> work.
> RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
> measurement with minimal equipment for embedded applications purpose
> and is not required to be set during normal operation.
> Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
> which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
> tps4 from working.
> This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
> be wrongly set at tps4.

Minor nits, more likely concerning feature patches:
- Please insert blank lines between paragraphs, it makes commit message 
easier to read. And please add no extra line breaks if you do not intent 
to end the paragraph here.

- "This patch" is generally the frowned upon phrase (see 
Documentation/process/submitting-patches.rst)

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Changes in v2:
> -- fix Fixes tag
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index ab6aa13..013ca02 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1214,7 +1214,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>   	if (ret)
>   		return ret;
>   
> -	dp_ctrl_train_pattern_set(ctrl, pattern | DP_RECOVERED_CLOCK_OUT_EN);
> +	dp_ctrl_train_pattern_set(ctrl, pattern);
>   
>   	for (tries = 0; tries <= maximum_retries; tries++) {
>   		drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);


-- 
With best wishes
Dmitry
