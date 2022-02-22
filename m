Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155AE4C04E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiBVWw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiBVWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:52:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB75F8F0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:52:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so1855593wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/EnLdcDCaY6axPEw3k6ZqOc6igFL4mnKPGEeDh9ZpYQ=;
        b=JlBU679E2RSWDtfPGZfq0mRe9IowogDAY4FI/8A2KbsQN3adCGWLzFglR/ESl0ximD
         jiiwoJjkosMGrOaWQov+altgqvmI+80/Nlm0sQA932DVQd0zeZKbu0Cq/OQIM118sEWN
         ZRNff4+TNcoySlMtlg3uQ+8O66yjEp5ROk7ukfcHedr2n9uK4nBy22SESUTa7y7QOYHh
         4fhUH5HcXrU8hy7y9rItzfvN5Uq4Gg5QB8PeeJ7TUq+OD+dxCnMXuz1IwwmQkzCXcyPo
         xdw4bedgVDHODG/3trm5BD2P0t/kqe68HvRGMj2ymEdItmrMjzgOX5ZG2og8iWfPMjhU
         H+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/EnLdcDCaY6axPEw3k6ZqOc6igFL4mnKPGEeDh9ZpYQ=;
        b=GOgVxB62JKeIMfDVEV+8ZJCL1wLte67ZVlQCZwTdnyQttqRvVw7GhVsqcX1Ax+Ny/+
         YEOXicUYAXbDoA8U5u6mjjYCdVtSOduybMOkmSlr9lJ0jimRhjjxIeopBdZ7azIOJnb0
         Nowm0F/cp6Pjp9biyhh7rhZZ+bLdO4XHCQMtnZ75cqlGdMxDAcb1tI5LkauJ9omBJLI6
         xNLBLkEy+8YE4rgmsPVewmMKp5KuMy5iqPjCbFNdm9d3Iq8lsXNhsZsoZUWccExxIHeb
         fnHrTipcvQxlB7ijtTPFPCiNEKIIffPnOy8hq6uwyBGsPWl1K8O6KHetayiVBwqg94Dy
         +UXg==
X-Gm-Message-State: AOAM530B0Sl5OYleuXN67YYNJklA75xpwlUz7iy3D14a9j4hI4tlD9A1
        K1mOM5DssiBW1bd5KcA6UTJaMrwbH6ZitQ==
X-Google-Smtp-Source: ABdhPJxnBqQUGE8FatYN5I3AE2KTzM8vUylwQpMxfwtN0+FUJdGdMooq4XpfX0P1pMsgjqsaS4xNAQ==
X-Received: by 2002:a05:6000:18a5:b0:1eb:93a3:ebcb with SMTP id b5-20020a05600018a500b001eb93a3ebcbmr2595027wri.291.1645570347524;
        Tue, 22 Feb 2022 14:52:27 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id b16sm4232325wmj.32.2022.02.22.14.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 14:52:26 -0800 (PST)
Message-ID: <1cb4e02f-f040-23bd-44d0-0675429332bd@linaro.org>
Date:   Tue, 22 Feb 2022 22:52:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
 <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
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



On 22/02/2022 19:26, Pierre-Louis Bossart wrote:
> 
> 
> 
>> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct qcom_swrm_ctrl *swrm = dev_id;
>> +	int ret = IRQ_HANDLED;
>> +	struct sdw_slave *slave;
>> +
>> +	clk_prepare_enable(swrm->hclk);
>> +
>> +	if (swrm->wake_irq > 0) {
>> +		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
>> +			disable_irq_nosync(swrm->wake_irq);
>> +	}
>> +
>> +	/*
>> +	 * resume all the slaves which must have potentially generated this
>> +	 * interrupt, this should also wake the controller at the same time.
>> +	 * this is much safer than waking controller directly that will deadlock!
>> +	 */
> There should be no difference if you first resume the controller and
> then attached peripherals, or do a loop where you rely on the pm_runtime
> framework.
> 
> The notion that there might be a dead-lock is surprising, you would need
> to elaborate here.Issue is, if wakeup interrupt resumes the controller first which can 
trigger an slave pending interrupt (ex: Button press event) in the 
middle of resume that will try to wake the slave device which in turn 
will try to wake parent in the middle of resume resulting in a dead lock.

This was the best way to avoid dead lock.

> 
>> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
>> +		ret = pm_runtime_get_sync(&slave->dev);
> 
> In my experience, you don't want to blur layers and take references on
> the child devices from the parent device. I don't know how many times we
> end-up with weird behavior.
> 
> we've done something similar on the Intel side but implemented in a less
> directive manner.
thanks, I can take some inspiration from that.


--srini
> 
> ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);
> 
> static int intel_resume_child_device(struct device *dev, void *data)
> {
> [...]	
> 	ret = pm_request_resume(dev);
> 	if (ret < 0)
> 		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
> 
> 	return ret;
> }
> 
> 
>> +		if (ret < 0 && ret != -EACCES) {
>> +			dev_err_ratelimited(swrm->dev,
>> +					    "pm_runtime_get_sync failed in %s, ret %d\n",
>> +					    __func__, ret);
>> +			pm_runtime_put_noidle(&slave->dev);
>> +			ret = IRQ_NONE;
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
>> +		pm_runtime_mark_last_busy(&slave->dev);
>> +		pm_runtime_put_autosuspend(&slave->dev);
>> +	}
>> +err:
>> +	clk_disable_unprepare(swrm->hclk);
>> +	return IRQ_HANDLED;
>> +}
>> +
> 
