Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B854B996E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiBQGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:46:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiBQGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:46:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC20E23E5E6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:46:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j15so8067498lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aWFKmjSTHV/1Uy7sHNTLFB57odwAHYMJXSbwkdw6WT4=;
        b=YIa0i4ieE1eaH5m5gYuX+zksrscCOi3t4ujD/UWVuUJpVu7gPr+XmKBMepc7/Z0UFD
         gn4GgBcpHyPN2+lYhDgMRyc5r9nI22Qp8koxghYZj8o37kg8plt5LL5IpAcLbwCQw13G
         XtCHQ4FfaXTY0HnXTCuIomu98rE1YBUGqW3KrXMmew0S7BC92M6wjeea/vJCoqEYoSOx
         aSp7xdnkKm0F24W34p9nnkmdSU1l1JKh4D8gAgGDcPN7d0NF3l4CXuSEUWl3oyZJeSra
         rdrsyJqRf0qE/Uj8k511E19EF2ARa0FgDoJwAukjhiw4k2FRGokMglDtHJL3Ke+x7Mwp
         gUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aWFKmjSTHV/1Uy7sHNTLFB57odwAHYMJXSbwkdw6WT4=;
        b=iN5MKNqMrWAEi4SiyEG/k4dKhnBG0/kEpNkx7i9YuJQjWjMG2HK49B0aUN/4B2pl7U
         +07h2d54gspbcIxNllWEOYBnVm908jxQG+UD/qBdZnLU5X1F9JYS/4fNrKYf7PeW5PdK
         Ypb76BdULq7nLn9zuw9XY1u5fbx8VnrHcxA0Iw352mi6X1XiMugYS/sjgjgQ9C9sVC9T
         J8fG/u1YLeJerVa069rdvegv4FQJN7f9iGiZzmF+YxC1t6y5DmY7FJzCjBl/cYRHkpgr
         WEDQl9kwVKGHaRHPwnj8CTSUJ1wu+H0J6MFyKFZIXeBGPco0AKhtTZ+lYt89sCEc+NZD
         edOA==
X-Gm-Message-State: AOAM533dSu7QMx6ucDsO/DlCfDMqGgE6yjsEHgp0oGxk3PqSx6wYYl6n
        j8PS8CU/7trjTJgmkpAtlLFUoQ==
X-Google-Smtp-Source: ABdhPJwTmA8+bpvfuxQXEMcZ9qVRfdTf7xH/IPQHvG+6uIqEFJP3XicNP9Reesg25IqAybbsMTVmyg==
X-Received: by 2002:a05:6512:224b:b0:443:ac94:3de3 with SMTP id i11-20020a056512224b00b00443ac943de3mr148169lfu.60.1645080374335;
        Wed, 16 Feb 2022 22:46:14 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g20sm1872269lja.50.2022.02.16.22.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 22:46:13 -0800 (PST)
Message-ID: <82707bbf-5005-9765-292b-1f883a32946c@linaro.org>
Date:   Thu, 17 Feb 2022 09:46:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 3/4] drm/msm/dpu: replace BIT(x) with correspond marco
 define string
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1645049106-30481-1-git-send-email-quic_khsieh@quicinc.com>
 <1645049106-30481-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1645049106-30481-4-git-send-email-quic_khsieh@quicinc.com>
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

On 17/02/2022 01:05, Kuogee Hsieh wrote:
> To improve code readability, this patch replace BIT(x) with
> correspond register bit define string
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

This patch should come first.

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index b68e696..8f10aab 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -61,6 +61,12 @@
>   
>   #define   INTF_MUX                      0x25C
>   
> +#define INTF_CFG_ACTIVE_H_EN    BIT(29)
> +#define INTF_CFG_ACTIVE_V_EN    BIT(30)
> +
> +#define INTF_CFG2_DATABUS_WIDEN BIT(0)
> +#define INTF_CFG2_DATA_HCTL_EN  BIT(4)
> +
>   static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
>   		const struct dpu_mdss_cfg *m,
>   		void __iomem *addr,
> @@ -139,13 +145,13 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   
>   	if (active_h_end) {
>   		active_hctl = (active_h_end << 16) | active_h_start;
> -		intf_cfg |= BIT(29);
> +		intf_cfg |= INTF_CFG_ACTIVE_H_EN;
>   	} else {
>   		active_hctl = 0;
>   	}
>   
>   	if (active_v_end)
> -		intf_cfg |= BIT(30);
> +		intf_cfg |= INTF_CFG_ACTIVE_V_EN;
>   
>   	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>   	display_hctl = (hsync_end_x << 16) | hsync_start_x;
> @@ -156,7 +162,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   	 * if compression is enabled in 1 pixel per clock mode
>   	 */
>   	if (p->wide_bus_en)
> -		intf_cfg2 |=  (BIT(0) | BIT(4));
> +		intf_cfg2 |= (INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN);
>   
>   	data_width = p->width;
>   
> @@ -178,8 +184,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>   		active_hctl = (active_h_end << 16) | active_h_start;
>   		display_hctl = active_hctl;
>   
> -		intf_cfg |= BIT(29);
> -		intf_cfg |= BIT(30);
> +		intf_cfg |= INTF_CFG_ACTIVE_H_EN;
> +		intf_cfg |= INTF_CFG_ACTIVE_V_EN;
>   	}
>   
>   	den_polarity = 0;


-- 
With best wishes
Dmitry
