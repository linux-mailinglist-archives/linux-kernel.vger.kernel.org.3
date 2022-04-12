Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337824FDDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352297AbiDLLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiDLLe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:34:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14B75E48
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:12:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ks6so11680752ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=itN8DLSGRDfdoHiYI2K1Ahismc5l5HE7NC2jbmc/tE4=;
        b=SoOVnulN7DU7nz2VPxkQxVIlEenouSL9YwRZBcKdr6BDxuy/CKP5tPbvhkCvBZeV4v
         IpaSLBrSK3TuSRvfChYmaPzpwD07KXovk/HHY8qbn9SffqbKw1t2hDzkCDfHWHNTWp3t
         XOfO+bjlQ/j7Q6BJpvBSU/xusDZ8tRuVeMW3p/RGVx+jUGbmzqqoJCgtueF1S5xfBFLO
         MwrWiaF8kWOUlecoCLCIVAB0NgUiidAAOWHjpAHCtPCmrIjkcWbZAMAE/GW5hjmnVpoN
         rxCfCazNocz3e4R2EKfaTl4MK6SUvHhTBdP+R+zP9bKGswnfbifBTvceCMgJzIUVL4kH
         L43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=itN8DLSGRDfdoHiYI2K1Ahismc5l5HE7NC2jbmc/tE4=;
        b=g4PO4t1GluQN9tT+DdUEXQf4QGnUO6hFUM0Uo2OaN/Y3W8ERNbUMYtyR5nodjQ2LuI
         o51AF9qqvb8gScBGKa9Ig0YbIuNB4It+FvLOF/UC/PmC+E7lbz3Y34i5Tj/YLQY4YJwP
         bFpB5f/y8auNat1K8UK0O1JSSc95bSRlFL8FOkzNxu/LKDb1Ej5cRxwP1dmAKDiu13vO
         8n40cWMNSsk09VRgBwTt/gTMZxVxK06CdqxhtfVeU69kyx/spml1wkK3dnUDwcpnprxG
         9//qOXRTp/D62xmJqEGqYh40hcjBEvqw/tNQfBNtNZT+32VUJA2qH5e7QII6XiEBX23z
         lO1w==
X-Gm-Message-State: AOAM530ur2zWi3VEAa/W7zS9a12HbRnjbs88dkEwp/VIOsZRxrANGYpf
        FiP7mP1LNCXpI0EamtuwO37OUA==
X-Google-Smtp-Source: ABdhPJy8WVl1Tif6xf+AE5S8L1WUh8eggrkrv7TFbXy++NeW6uVZxUwzM2WeoDWQF12YhO5REvH/oA==
X-Received: by 2002:a17:907:1c8c:b0:6e0:eb0c:8ee8 with SMTP id nb12-20020a1709071c8c00b006e0eb0c8ee8mr34505312ejc.265.1649758359825;
        Tue, 12 Apr 2022 03:12:39 -0700 (PDT)
Received: from [192.168.1.18] (hst-221-53.medicom.bg. [84.238.221.53])
        by smtp.googlemail.com with ESMTPSA id z10-20020a170906944a00b006e8a6b20129sm1270630ejx.29.2022.04.12.03.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 03:12:39 -0700 (PDT)
Message-ID: <587f078d-e21c-4781-58d3-7de6fc2f75fa@linaro.org>
Date:   Tue, 12 Apr 2022 13:12:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] media: venus: vdec: ensure venus is powered on during
 stream off
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1649747356-3207-1-git-send-email-quic_vgarodia@quicinc.com>
 <1649747356-3207-3-git-send-email-quic_vgarodia@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <1649747356-3207-3-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 4/12/22 10:09, Vikash Garodia wrote:
> Video decoder driver auto-suspends the hardware if there is no
> exchange of command or response for certain amount of time.
> In auto suspended state, it becomes mandatory to power on the
> hardware before requesting it to process a command. The fix
> ensures the hardware is powered on during stop streaming.
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 91da3f5..4ac1132 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1200,6 +1200,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  	struct venus_inst *inst = vb2_get_drv_priv(q);
>  	int ret = -EINVAL;
>  
> +	vdec_pm_get_put(inst);
> +
>  	mutex_lock(&inst->lock);
>  
>  	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)

-- 
regards,
Stan
