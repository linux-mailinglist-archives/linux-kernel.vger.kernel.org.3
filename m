Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C974467D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382495AbhLCSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbhLCSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:19:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE260C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:15:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 13so7712797ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XETtVR3trVk3mJEQkxCtSey9MCpDGt0zZTF/ap46FO4=;
        b=iE+jSRpvnSte9JQZsPdsAtZykCqnIKnwliWjcBkac6g9S8TiM0IYmlI6EKWy4QNEZw
         Ym3r0jYJScGyrC9KBtisi3lUBkl/rYPfU04BF+xB3kNL69x9DH6Fl8dVFaQChzDdLdLK
         GCu8Y5mmIDGC0OFY8sGn9SON0zMzwp0FulyeVBQFONB4YuX9OkFW176Nr9AWp4uRa1a8
         EOeuK2q9zE7/HA0RzIC7Qig8z2XBsldCOqnR3mZVWIvUDwfJMc5DowTlXKHAoCBcCX1a
         OWpFBAL4COxKVUBuciWVNH81t1oax2Y06D/jq5GGu4tD17gb9fKIr6UL514OBKFT94rg
         Symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XETtVR3trVk3mJEQkxCtSey9MCpDGt0zZTF/ap46FO4=;
        b=eqSbcYVtXd5skrN6hKg5+hDCoQ53Z1f2mKbpq7UoFlSfz3dh14gWUHa2i7WTxm7gS1
         Bs/JXgwr5kXH8fW4C7X9RcasBauIM6YKIvlR0Ghbe2xFU9gNauXCvISSyCIJaFpdWDLt
         tY0rpEnQTmTCr19uBCoElZIk0W8Utq3eDTHusaGFeTPflJ3pgOaO8YYnPYb3RAYXgcXG
         ojFer0YH3g/7vh/ORwxDdIPJOJo4g0zJrvbPZrqVGfE16SU2EcXkqk6fnCiSeXPUZqwV
         qH3xDxWaI4IvClXD1AQ+SyauWUPvXIbo43COKIc+PwCceYSylYE8SynZrFpjnKD6T0l5
         dtGQ==
X-Gm-Message-State: AOAM530hdbf/vrZjv5nu4Nf1zl4nLQhj+HnHC3H5cZCy87HtKK75Qlxo
        fYBI0wRts/2gOMadXh6MhKfaHx614lICAQ==
X-Google-Smtp-Source: ABdhPJxILDGn/88i8VPm+vst3qYWiNJp3eau+aa1yVIcKUDIXOvNW/S0cGXGWtSkxE7P8RkvkOYe0Q==
X-Received: by 2002:a05:651c:50c:: with SMTP id o12mr20110619ljp.438.1638555354010;
        Fri, 03 Dec 2021 10:15:54 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id l20sm453938lfj.36.2021.12.03.10.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:15:53 -0800 (PST)
Message-ID: <ffdf9007-d2cc-2437-684c-66c00bb0ceda@linaro.org>
Date:   Fri, 3 Dec 2021 21:15:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/msm/dpu: removed logically dead code
Content-Language: en-GB
To:     Ameer Hamza <amhamza.mgc@gmail.com>, robdclark@gmail.com,
        sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211203161846.37720-1-amhamza.mgc@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211203161846.37720-1-amhamza.mgc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 19:18, Ameer Hamza wrote:
> Fixed coverity warning by removing the dead code
> 
> Addresses-Coverity: 1494147 ("Logically dead code")
> 
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

While the patch is correct, remove the 'fail' part completely by moving 
DPU_ERROR and return statement in place of corresponding goto statements.

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 185379b18572..75f0c0cee661 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -751,8 +751,6 @@ struct dpu_encoder_phys *dpu_encoder_phys_vid_init(
>   
>   fail:
>   	DPU_ERROR("failed to create encoder\n");
> -	if (phys_enc)
> -		dpu_encoder_phys_vid_destroy(phys_enc);
>   
>   	return ERR_PTR(ret);
>   }
> 


-- 
With best wishes
Dmitry
