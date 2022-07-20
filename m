Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9718657B25A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiGTIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiGTIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:09:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF367C9B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:09:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d7-20020a17090a564700b001f209736b89so1338932pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vjmj1e5ilZcHzSooiVXEelOD0/GPuv/+UYY6S2crjho=;
        b=Dh/g9kBBDMqVx5ZQJKzdmPQxju8VIfV+7OtnNU7UZ688mgBItp/7drGha8nZQL7iRG
         TMzI9mLhcuWQ6poeV1p8tuG5NY6TjirXtpPQqZP6xu+Om+RRTBgXsgEw6jzhUR34k7tl
         MbtJaqDe1s1VwggvF69/LGKhJeJJ/SF6ipBVcOUTZFUyEtUxmeUAcHzyo98hGHiczJ3p
         XuI+1+6TtrhbLhHNTOc86779nvmxuS2MI834rBCPoqBr4fD68ve/xc4eSmXTN2GF4gxm
         2yEbQrbVlkssAbP31nBkRA1bFfnYIGPg0ERIjzbYCGH/bNLx2szEX9IWufRpyw19VRml
         jdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vjmj1e5ilZcHzSooiVXEelOD0/GPuv/+UYY6S2crjho=;
        b=xyeCEoZXtONMGNxgU3sK0/XBjRwFdta0Mv+1XYYDTS4KIhH1hwlgSC5iIZ6AXTX6hG
         MJhOERxDjkIjZrEjedk6YDAiMltWiUE0IQl0oXkxFm6EaSmuuiPfj6qJwvLzdgdvfYii
         N0JnlZaa4EyOYtBiXj8A6Emg4JYb7Vo5y2WkJ5378DgnN2fs+EImoPyNmhPcStqrH5O5
         dntRpt168llLhxpCtnaaTDO3NphDwy5VTh9+3oqWNJ1mcDMXWNB2nc9PBbPF/+U9tRmC
         K+WbbDK4YoZ6zZdnkGbUJmEjrtHM9jRLO7BZfiJs+U0cgS2Oda6S7nRHY3Z/MIDnNJW+
         FCSg==
X-Gm-Message-State: AJIora+3g/NpasuV+uHQoZ5rvE4/0N2VH8fTsjolawUEGjzNCWRK6JAh
        c7BGcJaiPY6JWm7uZo3avn+ptCkv/KxS2A==
X-Google-Smtp-Source: AGRyM1sVwohh0bM9m4mMkOvgMH8V+/8FfdM5gU1oqT8RRazle84Lm9koabhiRV9BxMroh0zPZorBiw==
X-Received: by 2002:a17:903:4094:b0:16b:df0e:6312 with SMTP id z20-20020a170903409400b0016bdf0e6312mr39531338plc.61.1658304564419;
        Wed, 20 Jul 2022 01:09:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b0016cf195eb16sm6086244plh.185.2022.07.20.01.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 01:09:23 -0700 (PDT)
Message-ID: <e0637b5f-572f-5db8-e546-22f69d7c1e09@linaro.org>
Date:   Wed, 20 Jul 2022 13:39:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] thermal: qcom: tsens: Add support for
 'needs_reinit_wa' for sm8150
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-3-bhupesh.sharma@linaro.org>
 <YtYdPG8ofmmiVe4P@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <YtYdPG8ofmmiVe4P@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for your review.

On 7/19/22 8:25 AM, Bjorn Andersson wrote:
> On Fri 01 Jul 09:58 CDT 2022, Bhupesh Sharma wrote:
> 
>> QCoM sm8150 tsens controller might require re-initialization
> 
> Please spell out Qualcomm.

Ok.

>> via trustzone [via scm call(s)] when it enters a 'bad state'
>> causing sensor temperatures/interrupts status to be in an
>> 'invalid' state.
>>
>> Add hooks for the same in the qcom tsens driver which
>> can be used by followup patch(es).
>>
> 
> This patch enables needs_reinit_wa, which is actually implemented in
> patch 3, wouldn't it make more sense to flip them around; to first
> implement the feature and then enable it in this patch?

Yes, this was reported by the kernel test bot as well.
I will address this in v2.

>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/thermal/qcom/tsens-v2.c | 11 +++++++++++
>>   drivers/thermal/qcom/tsens.c    |  4 ++++
>>   drivers/thermal/qcom/tsens.h    |  6 +++++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index b293ed32174b..61d38a56d29a 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -101,6 +101,17 @@ struct tsens_plat_data data_tsens_v2 = {
>>   	.fields	= tsens_v2_regfields,
>>   };
>>   
>> +/* For sm8150 tsens, its suggested to monitor the controller health
> 
> /*
>   * Outside the network stack, the first line should be left empty in
>   * multiline comments.
>   */

Ok.

>> + * periodically and in case an issue is detected to reinit tsens
>> + * controller via trustzone.
>> + */
>> +struct tsens_plat_data data_tsens_sm8150 = {
> 
> I doubt this is sm8150-specific, so the first question is if this should
> be attempted on all data_tsens_v2 platforms. Otherwise, how about naming
> this data_tsens_v2_reinit?

I agree. Konrad reported one more use case of the same.
So, I will take care of the same in v2.

'data_tsens_v2_reinit' makes sense to me.

Regards,
Bhupesh

>> +	.ops		= &ops_generic_v2,
>> +	.feat		= &tsens_v2_feat,
>> +	.needs_reinit_wa = true,
>> +	.fields	= tsens_v2_regfields,
>> +};
>> +
>>   /* Kept around for backward compatibility with old msm8996.dtsi */
>>   struct tsens_plat_data data_8996 = {
>>   	.num_sensors	= 13,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 7963ee33bf75..97f4d4454f20 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -991,6 +991,9 @@ static const struct of_device_id tsens_table[] = {
>>   	}, {
>>   		.compatible = "qcom,msm8996-tsens",
>>   		.data = &data_8996,
>> +	}, {
>> +		.compatible = "qcom,sm8150-tsens",
>> +		.data = &data_tsens_sm8150,
>>   	}, {
>>   		.compatible = "qcom,tsens-v1",
>>   		.data = &data_tsens_v1,
>> @@ -1135,6 +1138,7 @@ static int tsens_probe(struct platform_device *pdev)
>>   
>>   	priv->dev = dev;
>>   	priv->num_sensors = num_sensors;
>> +	priv->needs_reinit_wa = data->needs_reinit_wa;
>>   	priv->ops = data->ops;
>>   	for (i = 0;  i < priv->num_sensors; i++) {
>>   		if (data->hw_ids)
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 1471a2c00f15..48a7bda902c1 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -515,6 +515,7 @@ struct tsens_features {
>>    * @num_sensors: Number of sensors supported by platform
>>    * @ops: operations the tsens instance supports
>>    * @hw_ids: Subset of sensors ids supported by platform, if not the first n
>> + * @needs_reinit_wa: tsens controller might need reinit via trustzone
>>    * @feat: features of the IP
>>    * @fields: bitfield locations
>>    */
>> @@ -522,6 +523,7 @@ struct tsens_plat_data {
>>   	const u32		num_sensors;
>>   	const struct tsens_ops	*ops;
>>   	unsigned int		*hw_ids;
>> +	bool			needs_reinit_wa;
>>   	struct tsens_features	*feat;
>>   	const struct reg_field		*fields;
>>   };
>> @@ -544,6 +546,7 @@ struct tsens_context {
>>    * @srot_map: pointer to SROT register address space
>>    * @tm_offset: deal with old device trees that don't address TM and SROT
>>    *             address space separately
>> + * @needs_reinit_wa: tsens controller might need reinit via trustzone
>>    * @ul_lock: lock while processing upper/lower threshold interrupts
>>    * @crit_lock: lock while processing critical threshold interrupts
>>    * @rf: array of regmap_fields used to store value of the field
>> @@ -561,6 +564,7 @@ struct tsens_priv {
>>   	struct regmap			*tm_map;
>>   	struct regmap			*srot_map;
>>   	u32				tm_offset;
>> +	bool				needs_reinit_wa;
>>   
>>   	/* lock for upper/lower threshold interrupts */
>>   	spinlock_t			ul_lock;
>> @@ -593,6 +597,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
>>   extern struct tsens_plat_data data_tsens_v1, data_8976;
>>   
>>   /* TSENS v2 targets */
>> -extern struct tsens_plat_data data_8996, data_tsens_v2;
>> +extern struct tsens_plat_data data_8996, data_tsens_sm8150, data_tsens_v2;
>>   
>>   #endif /* __QCOM_TSENS_H__ */
>> -- 
>> 2.35.3
>>
