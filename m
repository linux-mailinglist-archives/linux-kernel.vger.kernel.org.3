Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF64C8A66
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiCALOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiCALOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:14:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889608EB79
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:13:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 10-20020a05600c26ca00b003814df019c2so1024608wmv.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uCMkFxxVgJxq/k9pyfJ1NQDpPu8aOfdTTyquXtVkJj0=;
        b=ekM0x3sEdznWAkaii/nPUwFz3ZuqhwbVwbinFP3Vec4MDKv0+Vn03k2FzZJokGl57F
         2/0hFrkSCmDUOoz0C9LJmry5Ai9ITrLQni7Z8mvhHl0v/2TRlYDJz7QFb/lN5RD5VQqX
         0OaIf7pSJjCSJr9r9A+2VExOC4ZLEd6auqPKn0oyHt2ORbyydGryahDbamre2tfMuW8a
         2fGbPc9fr7jZryOwucJG6bka9PBdz5NHGj4qQ2DBC+Gws+y3Fs1dC3amJf6Mvbgup8Js
         NxqnoI4UMUPmKYxZRO4JP6gpX3iN300M7FdoB0RCg9T72YvuGSAFLCrLWKDl5CN0Licj
         lElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uCMkFxxVgJxq/k9pyfJ1NQDpPu8aOfdTTyquXtVkJj0=;
        b=cJayXrNEazhVll2ijlysE0UYwZAS84jrX/FuzNIS5bAa5zG+yhKEA0CW4FhKdD7l6D
         b/X5fF+FYsTsRbql4qNgikhx0jJOX36YbTxANd1OCui5H6ge4XtIO1I5G++yUyWQKe55
         6HZEv6bF+9QTZyzwZT58fc3OhA6weQp/xQpMwrsIqk32OsBh3aHkodvXnlGiTWAsgwh1
         GFL5sDMzrVBJbrzYfLrxbZl+P8HBFAD0Yc23rS1v0sH0dvd42fA2GIva5VveKSNDmmc6
         FwQNQGhUCi7KlhzVCd5iH9sdffYDh7FABVuk8BkWSgGToo3gQa1tqUhJfyIdl0vBtXS5
         SBhQ==
X-Gm-Message-State: AOAM530y0kW1WhdIcKiQffrKlAV0hB1aw8gNqIr/hW9v6gvFe0UMAmjQ
        SAhORafnrqP2BCvNWhwuFlCZ9Q==
X-Google-Smtp-Source: ABdhPJyhMobJHc6nYi9FWMSgpA48zDQKAxS4s3yFZ69WkLJtS4tfOozGS6R14FjXTq20x0J2k/+UWw==
X-Received: by 2002:a05:600c:378b:b0:380:d7b4:c4a1 with SMTP id o11-20020a05600c378b00b00380d7b4c4a1mr17104878wmr.171.1646133212000;
        Tue, 01 Mar 2022 03:13:32 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm13364529wrs.16.2022.03.01.03.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:13:31 -0800 (PST)
Message-ID: <c6b0506a-24ed-d4fd-c74e-d95c6dca6fe6@linaro.org>
Date:   Tue, 1 Mar 2022 11:13:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] soundwire: qcom: add in-band wake up interrupt
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-4-srinivas.kandagatla@linaro.org>
 <28a7aa9b-8322-54df-1cfa-275805e2b044@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <28a7aa9b-8322-54df-1cfa-275805e2b044@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2022 18:01, Pierre-Louis Bossart wrote:
> 
>> @@ -1424,6 +1464,11 @@ static int swrm_runtime_resume(struct device *dev)
>>   	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	if (ctrl->wake_irq > 0) {
>> +		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
>> +			disable_irq_nosync(ctrl->wake_irq);
>> +	}
>> +
>>   	clk_prepare_enable(ctrl->hclk);
> 
> This one is quite interesting. If you disable the IRQ mechanism but
> haven't yet resumed the clock, that leaves a time window where the
> peripheral could attempt to drive the line high. what happens in that case?


We did call pm_runtime_get_sync() from Wake IRQ handler, which means 
that resume should be finished as part of Wake IRQ handler. Any new 
Interrupt conditions/status generated by slave in the meantime will be 
cleared while handling SLAVE PEND interrupt.

> 
>>   
>>   	if (ctrl->clock_stop_not_supported) {
>> @@ -1491,6 +1536,11 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>>   
>>   	usleep_range(300, 305);
>>   
>> +	if (ctrl->wake_irq > 0) {
>> +		if (irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
>> +			enable_irq(ctrl->wake_irq);
>> +	}
>> +
> 
> and this one is similar, you could have a case where the peripheral
> signals a wake immediately after the ClockStopNow frame, but you may not
> yet have enabled the wake detection interrupt.
> 
> Would that imply that the wake is missed?
Its Possible it might be missed at that instance, however as the Slave 
interrupt source condition/status (Ex: button Press) is still not 
cleared it should generate a Wake interrupt as soon as its enabled.

--srini
> 
> 
> 
>>   	return 0;
>>   }
>>   
