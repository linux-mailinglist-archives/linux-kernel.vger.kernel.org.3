Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067ED515019
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378718AbiD2QDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378698AbiD2QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:02:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5D3AC93F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:59:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5000456wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U8HrbFqgCBfb/RS3uJbNmvqXXJbn594jDlyVmtK764U=;
        b=OUSBU7IakIZzrQL74ICWLqDfwhhkDremyYGPrYch6LLTeJLPScBA4ElPwRmEUb1YQB
         tqXV381ukmV/MHplLtVHw+xzdajJH+PDrEr1gv4SJAOfsQdbSJSl5Fm72o+5rCPIDctU
         YqJZYpgUUmW7hAtlH8TjEB5fko1P5bn53P7fkZg/0WgGvOhMSFHjvE1OCYiIxejwQkJY
         KAw+n0w6x9IcL+81Uu4g+bTQNgfPJbDPIIjdoBBDUwryvfMZNIKV41Z04awYUjcb/CFr
         9IKQSo1DbkmTeYGrpZTAahMJTcVmtfj25Oy+yPlGuNChdBq0unl0u11VxuGcUrRlKD9t
         hGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U8HrbFqgCBfb/RS3uJbNmvqXXJbn594jDlyVmtK764U=;
        b=R1qNt8d+lpr0eUAN7yX+ZSHntA3VLrTdifot0ji/jI3kRohwer1hBVwfhuhKzT0PtP
         ZpQC5p9xtmDmAeCby9pa+QmfU9pwWPTzJ5qIt97uY+jihCzh4HvuMAXaMXU9Tc3bIuNR
         ENiyp4hV5cXIllR1WrKiDy/3M4NmO9RDf4XpXHxek+VxEXPZK7S89L6dJNJhTsLjwPKJ
         Beseipzt3T52FDfkCVp6TfEyaF22D0ZB8Xf0FEm9uR3i1BVSonOcUa29zHweovcgvirN
         sPRjLYb/G2mDfP6mcZbilEKij+gVVwZqWjQBdrgUQjJ+j7J8MK21szN2GZnYkPPtdzI/
         9F0Q==
X-Gm-Message-State: AOAM530GvIF5QqbOPWl8tujZUlwpJMDdVVxboeNo640JWdpO82goEiia
        wFP4cc80D296UtvuX9FCoHeu2ZFwa2c8vg==
X-Google-Smtp-Source: ABdhPJww59Ilmdm1wcQYRmLg+RLw05DqkftO7wIpU3DywUjRDqpzisiSnOBqRs/YCLN3xi/gJbV5mg==
X-Received: by 2002:a1c:ed01:0:b0:394:89d:6277 with SMTP id l1-20020a1ced01000000b00394089d6277mr3920685wmh.28.1651247968575;
        Fri, 29 Apr 2022 08:59:28 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e9-20020a056000178900b0020a9f995a3csm3190248wrg.24.2022.04.29.08.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:59:27 -0700 (PDT)
Message-ID: <28a05a2d-06e7-a958-6873-24634423b4e0@linaro.org>
Date:   Fri, 29 Apr 2022 16:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] soundwire: qcom: return error when
 pm_runtime_get_sync fails
Content-Language: en-US
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
 <20220426235623.4253-2-yung-chuan.liao@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220426235623.4253-2-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2022 00:56, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> For some reason there's a missing error return in two places.
> 
> Fixes: 74e79da9fd46a ("soundwire: qcom: add runtime pm support")
> Fixes: 04d46a7b38375 ("soundwire: qcom: add in-band wake up interrupt support")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/soundwire/qcom.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index f5fc8c27012a..c40c25f2d264 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -516,6 +516,7 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>   				    "pm_runtime_get_sync failed in %s, ret %d\n",
>   				    __func__, ret);
>   		pm_runtime_put_noidle(swrm->dev);
> +		return ret;
>   	}
>   
>   	if (swrm->wake_irq > 0) {
> @@ -1258,6 +1259,7 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
>   				    "pm_runtime_get_sync failed in %s, ret %d\n",
>   				    __func__, ret);
>   		pm_runtime_put_noidle(swrm->dev);
> +		return ret;
>   	}
>   
>   	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
