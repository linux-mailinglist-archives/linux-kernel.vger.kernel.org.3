Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81A486718
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbiAFPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiAFPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:52:52 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE31C0611FD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:52:52 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l17so2675075qtk.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GhPv3TCVMNdzUlnrS7GkeARVb8jWq6T2I9klaQoUwbI=;
        b=mHj9cU1mZ6+AB2dMfeWCnzQpmvDTSdjQ5h89UiEllr8fDgUmgLQN5aAd0vSd5pEJaA
         mxouS/6Sbd2IF2gwVQR8Mc5mTxut8muKa8K5E8Zg0bKborLAHXPib8E3Mu75W8mVuEa1
         CnnOkkjJTOs0lLWA8n90R8AdshgTb//mTalunZPjrNeERzpCjWv0ligUJaD53pPFYmve
         /Sm4At6DaJZrbvx3TgAR9+qYvzjxCGlw2wPEJR6V1Lv02QAFKaqdAs4GSnfXS2DZi9w9
         WbOsdM5KctOO5LQJiNZDxjiRwKhPhCFhP8ZqIlO+eamevz1IkEuszxQEIUAXKSxWteZi
         GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhPv3TCVMNdzUlnrS7GkeARVb8jWq6T2I9klaQoUwbI=;
        b=4ESja1Zh67HMZWNK9KjAVtVSnJuEtAy9HrBXKG/Dj8GXr0fyC0SlW8MXAsfZbTrslr
         K7kF7HNWxbYNcC22sF90mlZfVC6mMA3Rzq4isdExb5JfXGifySvfGOkUQiVPZ2NtqTqW
         l8iIly/FMBcDy9vWyZLCMyEdLRPSJP9u7jxHqxc5p+UOMMHAMpQCSAj3+gyxYxvoiCXG
         v9aND+rGL44ok13UsANf17zphXN5r0ehy6I7Szo0BXIEKkgAO+N9lS9sSzC7kDWBCWzc
         QHL0zPM611RgRaS8ZVnW6jwTJfrWamCz1byIcKHymSDJR/Yv49OB7T2sFbqGx8FOWYK+
         BlHQ==
X-Gm-Message-State: AOAM533LsFUqm9SbG0dYiUuaao5J6ihjh0PpykL/tsa+eeD6FZ3BHn4M
        ZQZuoQjVbWQjfuoNvE789lpioui1VaOLIg==
X-Google-Smtp-Source: ABdhPJzsQPvOoewQNO3rShMtgLaJZlLZfDc1vqyDvuNjeB4XHvY9hmxC9cyUio4pPyQleEFz0K3wiA==
X-Received: by 2002:ac8:5993:: with SMTP id e19mr51906451qte.568.1641484370843;
        Thu, 06 Jan 2022 07:52:50 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id y6sm1696596qtn.23.2022.01.06.07.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 07:52:50 -0800 (PST)
Subject: Re: [Patch v2 1/3] thermal: qcom: lmh: Add support for sm8150
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211215163400.33349-1-thara.gopinath@linaro.org>
 <20211215163400.33349-2-thara.gopinath@linaro.org> <YdYTFu/QTZ5DS95M@ripper>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <efe8205e-aaea-fda6-c556-f42bfd6ec82c@linaro.org>
Date:   Thu, 6 Jan 2022 10:52:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YdYTFu/QTZ5DS95M@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 4:52 PM, Bjorn Andersson wrote:
> On Wed 15 Dec 08:33 PST 2021, Thara Gopinath wrote:
> 
>> Add compatible to support LMh for sm8150 SoC.
>> sm8150 does not require explicit enabling for various LMh subsystems.
>> Add a variable indicating the same as match data which is set for sdm845.
>> Execute the piece of code enabling various LMh subsystems only if
>> enable algorithm match data is present.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v1->v2:
>> 	- Added LMH_ENABLE_ALGOS of_device_id match data to indicate
>> 	  whether LMh subsytems need explicit enabling or not.
>>
>>   drivers/thermal/qcom/lmh.c | 62 +++++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> index eafa7526eb8b..80d26d043498 100644
>> --- a/drivers/thermal/qcom/lmh.c
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -28,6 +28,8 @@
>>   
>>   #define LMH_REG_DCVS_INTR_CLR		0x8
>>   
>> +#define LMH_ENABLE_ALGOS		((void *)1)
>> +
>>   struct lmh_hw_data {
>>   	void __iomem *base;
>>   	struct irq_domain *domain;
>> @@ -87,6 +89,7 @@ static int lmh_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct device_node *np = dev->of_node;
>> +	const struct of_device_id *of_id;
>>   	struct device_node *cpu_node;
>>   	struct lmh_hw_data *lmh_data;
>>   	int temp_low, temp_high, temp_arm, cpu_id, ret;
>> @@ -141,32 +144,36 @@ static int lmh_probe(struct platform_device *pdev)
>>   	if (!qcom_scm_lmh_dcvsh_available())
>>   		return -EINVAL;
>>   
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret) {
>> -		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = qcom_scm_lmh_profile_change(0x1);
>> -	if (ret) {
>> -		dev_err(dev, "Error %d changing profile\n", ret);
>> -		return ret;
>> +	of_id = of_match_device(dev->driver->of_match_table, dev);
> 
> I think it would be preferable to use of_device_get_match_data() and
> assign this to an unsigned long.

Sure.. I will fix this and the comment below and send out v3.

-- 
Warm Regards
Thara (She/Her/Hers)
> 
>> +
>> +	if (of_id && of_id->data == LMH_ENABLE_ALGOS) {
> 
> Then you don't need to check of_id for NULL here and this would lend
> itself nicely to be a bitmask of enabled algorithms if some platform
> would need to enable a subset of these.
> 
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret) {
>> +			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = qcom_scm_lmh_profile_change(0x1);
>> +		if (ret) {
>> +			dev_err(dev, "Error %d changing profile\n", ret);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	/* Set default thermal trips */
>> @@ -213,7 +220,8 @@ static int lmh_probe(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id lmh_table[] = {
>> -	{ .compatible = "qcom,sdm845-lmh", },
>> +	{ .compatible = "qcom,sdm845-lmh", .data = LMH_ENABLE_ALGOS},
> 
> Make LMH_ENABLE_ALGOS just an integer define and add the explicit (void
> *) cast here.
> 
> Regards,
> Bjorn
> 
>> +	{ .compatible = "qcom,sm8150-lmh", },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, lmh_table);
>> -- 
>> 2.25.1
>>


