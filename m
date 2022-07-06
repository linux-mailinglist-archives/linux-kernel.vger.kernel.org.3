Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA345690A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiGFR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiGFRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:25:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB62DC0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:25:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w2so2962368ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JsyVsYNpDQ8zJGakyxKtjvi7pOZE5FqBAEsh3JtW6QA=;
        b=NRWx5mkTEWIKWytjf1z0cO7hyGFLCIKUeLoUKFmMtM6xjTigvO/PaPNteYAS65MSzG
         vdVJ+EuplQFAcakz/rUqERWWiiCK3jG8ETdoZu6Y9ET+yr7KGaiVip3da5sEdsPBNQjp
         FnQmumbdAoqypEjN/2j/xM2SNmDe0pLuXGpJkB/pJNapsI7oHFxe2IXcTbr1Z7VZu1h9
         KxkW1Kdcf5egxUYoSwIDsEyQSGh4btPW+3Ptug8wmwHzISHm1SSYevWHXpW4FmoUCo5t
         /tw+PaLrywznmn45dZzUG19x0JZBM/l9X7WPTaIN+RAL4QTOyRNkdOrR1kFH6FiGyoXE
         6O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JsyVsYNpDQ8zJGakyxKtjvi7pOZE5FqBAEsh3JtW6QA=;
        b=W1JWd61PyrQk7PGjs/gOSjeJbnBrZGOXQ7dNTWxbddIcnWlCOOeXtPh34M/O3/Ur9C
         P92PII0/NcxS/6mE92iC87OKS0ka2wWeYOBRbIdFSnM8UWvx8wvoaXm8v6Fbl7abIe2y
         SCl4337nsC8+ERTFMjuyYnaYmwfIF2/ciS2YEkzs0cZWXw/GjW7xYKi52hIOtBw336ay
         eHFEUgXc4GZrg5EoThRb+IkXgC8EHgUeI2q3qMV6grhRgEYHK5xmzcBA31fgp+AqdmlF
         nH7JP7d1KxZYkoP8hDEhGIBLAnnvjhcJV4eEVrK+xlqDto/I0R9B9ZVZFq4pQsU8D1Fe
         9gBg==
X-Gm-Message-State: AJIora/AL6ZFXNkglvk53tCPVBzm7GDU2tVqGrlIImyPKD4WehQ3ylyv
        RRZNWDD1PhHhipQiM1zyiDT8vQ==
X-Google-Smtp-Source: AGRyM1vF2LMbfQeR6t993SuZPpvogaQi52LTs4BKWbGufEcHutNXTzHNLjelj7R9O6jbPxTcOE+3hg==
X-Received: by 2002:a2e:a41b:0:b0:25b:b56f:1476 with SMTP id p27-20020a2ea41b000000b0025bb56f1476mr22445280ljn.381.1657128356338;
        Wed, 06 Jul 2022 10:25:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651204c600b00478df9f4d64sm6364715lfq.227.2022.07.06.10.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:25:55 -0700 (PDT)
Message-ID: <86ee9636-8827-7bad-6bd9-22191b2d293c@linaro.org>
Date:   Wed, 6 Jul 2022 20:25:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] drm/msm/dp: make eDP panel as the first connected
 connector
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1657128246-15929-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657128246-15929-1-git-send-email-quic_khsieh@quicinc.com>
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

On 06/07/2022 20:24, Kuogee Hsieh wrote:
> Some userspace presumes that the first connected connector is the main
> display, where it's supposed to display e.g. the login screen. For
> laptops, this should be the main panel.
> 
> This patch call drm_helper_move_panel_connectors_to_head() after
> drm_bridge_connector_init() to make sure eDP stay at head of
> connected connector list. This fixes unexpected corruption happen
> at eDP panel if eDP is not placed at head of connected connector
> list.
> 
> Changes in v2:
> -- move drm_helper_move_panel_connectors_to_head() to
> 		dpu_kms_drm_obj_init()
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 2b9d931..50ff666 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -763,6 +763,8 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   	if (ret)
>   		return ret;
>   
> +	drm_helper_move_panel_connectors_to_head(dev);

This should be in msm_drv.c unless you have a strong reason to have it here.

> +
>   	num_encoders = 0;
>   	drm_for_each_encoder(encoder, dev)
>   		num_encoders++;


-- 
With best wishes
Dmitry
