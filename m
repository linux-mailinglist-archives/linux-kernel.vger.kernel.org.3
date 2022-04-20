Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A8508ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381318AbiDTRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381314AbiDTRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:49:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D346160
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:46:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1740073wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y0o19LlMLuvTnI/xl7SjhLZ4yjEbM01KZ2JzTFRO+wU=;
        b=K754ebAivn6X/9ER/aJ29m5lYECSX3zg3dPY0WZsEgvffqb2iEvH54j1KHGcZi6m9t
         +pL4xSL615v1HrTsFT1E1+lvfuarpSgBeQEnr+o6EqnmG12SfLJ1vHv0UROE7PuMVDZS
         lasMp/amHfMMIxKOkHpccnI9KAZhwOF73jpA2AeNJWN4uMaducamqBbDZ+9V518/B2gJ
         AO0QEWc5oRm8n8ddLvJ5j7AQQbugOPoh236ac29n990DqasvW9lYY5DK0FqOMAmcc1yy
         Nzr9ButMWwAgM3WhD1fuPrvSBcRwDp1HUQd1XT8wvmYNE3dD4I4lQheoFwg1+lhwatAV
         pj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y0o19LlMLuvTnI/xl7SjhLZ4yjEbM01KZ2JzTFRO+wU=;
        b=heu/56AE/PPGrtt9R5/JnAetXKylTPQry56kLd5EJXsDjRP8vPHNnNr5Sl/SAAJWN/
         7LnsIk3C49Rl/tGNi63x5IBeyOY1KgbuiDv1Pn5vMWyvIsk1+mvWuSRjNsbjhNXw5Na/
         B6+Pq3nrSJkOL3rvuAu6nAPtKwo4lzW61mbEnVbcQmRjnFUy91Skg09FJc5RjjbxxKFF
         c6Dxl9Z8nUWMmeGbpeLtz1zNr59JgcckitHUAfDH76ebCjCb2Ky26nTyiGD+b6tdvM67
         pjnm/MARlZDtEBFPnfH1kiWxrNd4PiU4bsN/0mw9bOAVYGWg+ScpmEe3g6nkhi+TOLoF
         yxZQ==
X-Gm-Message-State: AOAM531fX+aP3HJfKCSea9AEmLcxj+8rqPv5CnHiwVpGs9QlefICMaKu
        UbYvw06KXnrSWf+c/Weu10iKwQ==
X-Google-Smtp-Source: ABdhPJy4aiKqzcNlk3U2xq0/sZJ8FBAJfPZTjiM9up9l4jWht1pw6P6GPr9hofMGDUjHCxjRXhT7Uw==
X-Received: by 2002:a1c:7416:0:b0:38e:b8b7:e271 with SMTP id p22-20020a1c7416000000b0038eb8b7e271mr4705827wmc.7.1650476805039;
        Wed, 20 Apr 2022 10:46:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z6-20020a056000110600b00207aa9eec98sm374297wrw.30.2022.04.20.10.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 10:46:44 -0700 (PDT)
Message-ID: <e8ac9fab-85af-8f3c-eb68-c2d4d2f7f046@linaro.org>
Date:   Wed, 20 Apr 2022 18:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
 <10eb3973-03c4-74cd-d28a-014fc280cdf8@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <10eb3973-03c4-74cd-d28a-014fc280cdf8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2022 18:39, Pierre-Louis Bossart wrote:
>> @@ -1197,12 +1224,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>>   static int swrm_reg_show(struct seq_file *s_file, void *data)
>>   {
>>   	struct qcom_swrm_ctrl *swrm = s_file->private;
>> -	int reg, reg_val;
>> +	int reg, reg_val, ret;
>> +
>> +	ret = pm_runtime_get_sync(swrm->dev);
>> +	if (ret < 0 && ret != -EACCES) {
>> +		dev_err_ratelimited(swrm->dev,
>> +				    "pm_runtime_get_sync failed in %s, ret %d\n",
>> +				    __func__, ret);
>> +		pm_runtime_put_noidle(swrm->dev);
> ... here it's missing?
> 
> I have a fix ready but thought I would check first if this was intentional

Its not intentional.


> 
> https://github.com/thesofproject/linux/pull/3602/commits/6353eec8dc971c5f0fda0166ae1777f71784ea32

Fix looks good.

--srini
> 
