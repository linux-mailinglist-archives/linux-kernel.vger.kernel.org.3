Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C652116B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiEJJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiEJJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:53:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9E2A18BD
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:49:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so22962138wrn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qm5RREdXQYpD9UHeciW2nIxgirPQgGEeBKiqx8FamVc=;
        b=efU5E2c+QJFiheymKzvrh090KLPPHIS0arcOJx/Bb75Oj2COjqe/Yqmuol7AQna1Yf
         5zmuJ3pG0sehWYpBbumWjxmLp0mpfoYj1TrUb8AMsPFIhoZCljEU9T+7XdvE5K3InNDj
         Nm00jEsKJu8JvvQ7ebG722Un6xcxu+nR6mOWh84UXxgkvlyVOtD3UrDiCYSUTNNpXi8R
         0NJx/qAPlQDHthJI9/qYDjDES4vYVUXAoT9J2bcP20b+XvA3AGQYUQoMcuPiADGW2eFU
         JkJok6xFmy5rGJAqiUyjiOsjVDtJzqjI3AeM7Ueu+So1M0OlzTsOXSr+AEEiZXKyjoUx
         thyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qm5RREdXQYpD9UHeciW2nIxgirPQgGEeBKiqx8FamVc=;
        b=07Khnr1iWbcwQ9S5dZg7+ID1tCMtBuB+XZOLsouZDWZAS0sjG4j+JhYHDeePw1SyIc
         B6n4H3S0XNUViKst7DNPWau9rJwhQVjoQ/cjDwktCsmH98Nx6PpgfmkxpKotrPd2cLZB
         7eA5Ddhf+kTy0zmbAqEpBiI2QnROUkzC8VN3EX4U6PmKwaz3lI/Uyo2m5v6yQScyOta1
         tbqpBEsykg6eRgJKkX0TRaECIDx29XHo97BeB2CWizcd/YtWgKgACmBRLmnarLV1Ljgf
         0rQwlikJO81N+y3c8oGhWkKP8aOvB70jePp/Ofaqa0c3lVadZLCyyvWc+zwjZ33E6p2Y
         yaVg==
X-Gm-Message-State: AOAM531UOyfAbcGpzacbO8MJG4VDhxgrZq+48IGh8rPjb/J/TeBNMGVG
        4u8ydbX/xI6ZzuIEn8AIkaIbfA==
X-Google-Smtp-Source: ABdhPJyjggIJx3KuEgtm3jMKrZaNgrv7vbn4kBIFKQ0Pvz4AFU7h8xKtBQP0OqIEzfO5SXHyR7+J+Q==
X-Received: by 2002:adf:e104:0:b0:206:109a:c90f with SMTP id t4-20020adfe104000000b00206109ac90fmr17781979wrz.259.1652176197268;
        Tue, 10 May 2022 02:49:57 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m7-20020adffa07000000b0020cb42671aasm8877630wrr.105.2022.05.10.02.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 02:49:56 -0700 (PDT)
Message-ID: <3cf688f6-63b3-3860-db25-c63733b33ef1@linaro.org>
Date:   Tue, 10 May 2022 10:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] slimbus: qcom: Remove unnecessary print function
 dev_err()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
 <20220429165051.6187-3-srinivas.kandagatla@linaro.org>
 <YnkaTOk3SzcyFJyP@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YnkaTOk3SzcyFJyP@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2022 14:42, Greg KH wrote:
> On Fri, Apr 29, 2022 at 05:50:51PM +0100, Srinivas Kandagatla wrote:
>> From: Yang Li <yang.lee@linux.alibaba.com>
>>
>> The print function dev_err() is redundant because
>> platform_get_irq_byname() already prints an error.
>>
>> Eliminate the follow coccicheck warning:
>> ./drivers/slimbus/qcom-ctrl.c:514:2-9: line 514 is redundant because
>> platform_get_irq() already prints an error
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/slimbus/qcom-ctrl.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
>> index ec58091fc948..c0c4f895d76e 100644
>> --- a/drivers/slimbus/qcom-ctrl.c
>> +++ b/drivers/slimbus/qcom-ctrl.c
>> @@ -510,10 +510,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	ctrl->irq = platform_get_irq(pdev, 0);
>> -	if (ctrl->irq < 0) {
>> -		dev_err(&pdev->dev, "no slimbus IRQ\n");
>> +	if (ctrl->irq < 0)
>>   		return ctrl->irq;
>> -	}
>>   
>>   	sctrl = &ctrl->ctrl;
>>   	sctrl->dev = &pdev->dev;
>> -- 
>> 2.21.0
>>
> 
> Does not apply to my tree :(
Sorry my bad..
I see there was a depended fix[1] that needs to go in first.
I was hoping that that will be applied first..
Let me resend them together in v2.


[1] https://lkml.org/lkml/2022/4/29/1093

Thanks,
srini
> 
> 
