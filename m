Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5156ACF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiGGUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiGGUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:51:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B42CDE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:51:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e12so33143639lfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1yCn9FzE3TgPn9G9aMPiVPfAOGS2N8GQpGxVZMGerPY=;
        b=xOPoHYFsS3NPMHesqsz3d/V7flw6QibIRa52MJorz6ZxvJKN9QBEIYgo0qcMCT933D
         XLChc0UZYhnk66+HrEPy+AjH0K3NCiJ2Nd2Wi+cDxK2OJOeqa5oI+6+xfeEuLTVE1Kwc
         jdCw0eAubPWWwY6SLkdR7tFbawyksR/tx2pRe2fEuw1tMid/UMGjep+YwCLQFtq9n68k
         Ng2sagiJPQG80XifY2wKkPd1g7eNcfK8arcTcOYKzbzc5Hhl4IrcsGOKjMjHe/qh/4A2
         1Q+J8SqXGvSpHcSnN/zhZPv8gR4U6T8l2v60uv61WJAU0GmpLT4Qsn7aH5vTK4hFWWUR
         Ck5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1yCn9FzE3TgPn9G9aMPiVPfAOGS2N8GQpGxVZMGerPY=;
        b=XVmrpoxMCJ47ip6QxB1gdcnrxEzC5qgfkKVhdkx5xXlOXEuACYZ5y5QIl17Zsm+i3k
         QrHSBT2zxKz2vdCTqZdkwQVKAQr5+iXEGHH2W2KKZWmPUL79dgvspTgJkET4AA2g1jRG
         UHwBYqFzXRLNlNgj3KpAhHS9sQCG1IbCatTAbCyvqiDMbpmEu+/KCDv8qY7UXfn3enuq
         q2Xugj846ez7cTRKkCgBLXSU3yOp7QBC34o29A+rTr73Z0nnvIYCo5szZk2NrndQJixW
         BVJm3ztxuZ8omrds4ZcM2NI3zyEGrNwvuHnAhRePOTO5jAkizPTYHd7Ft+tJBusgLAEd
         ealg==
X-Gm-Message-State: AJIora/m49jfFClNXrs8Z5zD7As3YHIepdnsfv7tDoCkxRmc2pFvrP+V
        vz/mXnFCu/vbGToiuAHrptgolQ==
X-Google-Smtp-Source: AGRyM1tMDs6Igfr2CIm7SALgNlpy/riEx4RV4z/bsOQ3j14KxMMU9E3LGwhg9JehjwtKyPbRJFvJlQ==
X-Received: by 2002:a05:6512:3084:b0:47f:6c9e:952e with SMTP id z4-20020a056512308400b0047f6c9e952emr43810lfd.332.1657227063392;
        Thu, 07 Jul 2022 13:51:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512358600b0047f8de9734asm7040369lfr.123.2022.07.07.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 13:51:02 -0700 (PDT)
Message-ID: <ecbbe366-b7c7-885d-f574-0ac900d7599a@linaro.org>
Date:   Thu, 7 Jul 2022 23:51:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] drm/msm/dp: make eDP panel as the first connected
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
References: <1657135928-31195-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657135928-31195-1-git-send-email-quic_khsieh@quicinc.com>
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

On 06/07/2022 22:32, Kuogee Hsieh wrote:
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
> Changes in v4:
> -- move drm_helper_move_panel_connectors_to_head() to msm_drm_init()
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 4a3dda2..4d518c2 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -419,6 +419,8 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
>   		}
>   	}
>   
> +	drm_helper_move_panel_connectors_to_head(ddev);
> +
>   	ddev->mode_config.funcs = &mode_config_funcs;
>   	ddev->mode_config.helper_private = &mode_config_helper_funcs;
>   


-- 
With best wishes
Dmitry
