Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27E6515018
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378740AbiD2QDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378698AbiD2QDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:03:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1BFC9B60
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:59:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k2so11364676wrd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qwzc9FpCSz0qYfi90/a+oI4zUvRcyTR9uF9e5GlaFYk=;
        b=kpu2e3hoMvbGf4KZrs1ZwopuoSWpvL5Z1QBQCdWeIAt83oTjkF9nANtk/JwwtDF/oq
         IxPDa9NAIGiBI9X7vXsMr7SOg4sVQkRWGXZKpC0XpxqQCVfJr2LCtNNcUfHs7AEP8wTH
         S191+ez6mC7f8a8IZtl3sAyNzBwU381YcXs5BZQ7So3OtEQQi3lVw2xEmxyEk3QBBOxJ
         g/WksCFjGJotvy5/4JkQR2E4YqV2YZtOV7NE1ng0fYub8jihQfSL1L00GlDOteKe8tmd
         pRGsHr6fVxtU+vFVj09AdlENRB0OlfK6U9evtUKlKPGk8WCv0B7noPBMvB7/EAHbOok2
         xHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qwzc9FpCSz0qYfi90/a+oI4zUvRcyTR9uF9e5GlaFYk=;
        b=cNkgTruqcKr5HCqE8ulu/C1KhugGitguqaMH2UmWDVX4iuvsyqXbRd/ytnB9NbieGH
         6AK80NZKL/fedpyYpVfUqRmmQz3ZmUzWrKVmkb7oChVuDvFJtN7rSNVduyrO4n89ka27
         Z25ojm5purvSaFRlH5GGs8MC5Zei+nKOTp1ZiZbO8ypOXraz8LW1Rx2xnnU8+Lm0VT8s
         6+d3NtU6yF4zuYUHySy1Vp9Eg5SDcR2A7hIDqw7G75Zndz9DYb7tTZ1KYgDEC2mBrCH6
         phvrRTbg9KjraQ2xuZIh7HGZxmoI4sAqQYoVW6V/iw5KN7KpX7kH6vf9RuJXJHOx/D3X
         fk4A==
X-Gm-Message-State: AOAM532zfHZMRGA1aRSPuOmRn69cnogNYp6JDZspkeiYARfdSQcI14qq
        1UiJMMNQZsCBT/DJsHhPu+cqMQ==
X-Google-Smtp-Source: ABdhPJwboWFlK14XxhOvzRQMiKUYaS7nkctHz9phfhIzjJ75HBJUacL+7vOigxl2HVkU0hc+Y5KgJw==
X-Received: by 2002:a05:6000:1ac9:b0:20a:f656:e925 with SMTP id i9-20020a0560001ac900b0020af656e925mr7887056wry.554.1651247983973;
        Fri, 29 Apr 2022 08:59:43 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 190-20020a1c19c7000000b00392c344c842sm2845015wmz.43.2022.04.29.08.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:59:43 -0700 (PDT)
Message-ID: <d18fb6ea-6da6-cab3-1aca-48cbfcc74efa@linaro.org>
Date:   Fri, 29 Apr 2022 16:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] soundwire: qcom: use pm_runtime_resume_and_get()
Content-Language: en-US
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
 <20220426235623.4253-6-yung-chuan.liao@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220426235623.4253-6-yung-chuan.liao@linux.intel.com>
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
> Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
> pm_runtime_put_noidle() pattern.
> 
> No functional changes.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/soundwire/qcom.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index c40c25f2d264..c244d31805cc 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -510,12 +510,11 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>   	struct qcom_swrm_ctrl *swrm = dev_id;
>   	int ret;
>   
> -	ret = pm_runtime_get_sync(swrm->dev);
> +	ret = pm_runtime_resume_and_get(swrm->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(swrm->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(swrm->dev);
>   		return ret;
>   	}
>   
> @@ -1059,12 +1058,11 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>   	struct snd_soc_dai *codec_dai;
>   	int ret, i;
>   
> -	ret = pm_runtime_get_sync(ctrl->dev);
> +	ret = pm_runtime_resume_and_get(ctrl->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(ctrl->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(ctrl->dev);
>   		return ret;
>   	}
>   
> @@ -1253,12 +1251,11 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
>   	struct qcom_swrm_ctrl *swrm = s_file->private;
>   	int reg, reg_val, ret;
>   
> -	ret = pm_runtime_get_sync(swrm->dev);
> +	ret = pm_runtime_resume_and_get(swrm->dev);
>   	if (ret < 0 && ret != -EACCES) {
>   		dev_err_ratelimited(swrm->dev,
> -				    "pm_runtime_get_sync failed in %s, ret %d\n",
> +				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>   				    __func__, ret);
> -		pm_runtime_put_noidle(swrm->dev);
>   		return ret;
>   	}
>   
