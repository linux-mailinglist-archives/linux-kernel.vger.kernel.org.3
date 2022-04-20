Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA2508573
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351514AbiDTKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347063AbiDTKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:07:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB4F3EAAD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:04:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z99so1596410ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O/+Bq4GD0i1aeDJZB6KF270FrYsDWC9ZLK3WKl7pvtw=;
        b=iQg0xYNVkHIZo0BFivFUh7zcofwerY9qIBuS1eg1pq1Wa+PK0moNksnXr2ibxPi8Nt
         U4lJJn9AKf4k/TObba/Cc6oO4TsZpgIvDsGSOI4d+MrBlA6kaCK7lviv+aa2F++37KgR
         N/r+QzoV+OnRGchrRwCncCZWkuUNshBr9/El/cp2eZVL39X0sLxwhSLBbrR2SosL706Q
         QGwTbqgSZE0x2tcPBwFlyXbQQGpGtE5ZbEhr9iglUhXQg2XhGbPhvxh1iQ7sSxD8Ekyp
         pSwmybpiz//I9XHylVbYKw8D03YZv3IELSfETGs8FfNIZ0DB7WpSpuQJKb7nPEVuVJ9w
         vvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O/+Bq4GD0i1aeDJZB6KF270FrYsDWC9ZLK3WKl7pvtw=;
        b=qm0eVXCxB0rCiRtHXxjwOuPoCMN7cGU+UZ8yIVeRLhTo8hH4MlgRTxvxKNNHBhYVYO
         hzvElje1rRMmdXBOCSCCyeiqQqmeGFAOkvA7CNCcf/OT9Ru59FSvXqZu8Z8jLsVn80ra
         b4QaLc06uGX2GBmh0H8bpqmDIMHPTaatiWDNhJm4RGVvRlcJ9E81em0ZHHfdrdUsNzZv
         ZOZ5QjLKzWc+nb4DrKYobXW22hlswXnmgu6RwxNRAI3c2tFp4LQUm0OrfZYiU2I1DL88
         kAyf94akXirIBhFt7/S/MWPilJc9PC0RIdpny26O9+0lpMJ+19ZL7nFxIK8JHsJqqa5a
         T5rw==
X-Gm-Message-State: AOAM530iXFwDRtbarLveKoNVsWAUKQHdIHAcWTFLKv3aDqo6ivNlj/+B
        dW9bC03rdtMLRt02CFfyXJ/hlA==
X-Google-Smtp-Source: ABdhPJzL1lJX7sEUE2x5amjeU9v9hVjpMQnJ3qC7rbHT6pjZahpCdoZq2EmtCY7VhfWQbkBr/EYySQ==
X-Received: by 2002:a05:6402:31ee:b0:41d:7038:c04a with SMTP id dy14-20020a05640231ee00b0041d7038c04amr22411161edb.142.1650449061949;
        Wed, 20 Apr 2022 03:04:21 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm6599740ejc.66.2022.04.20.03.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 03:04:21 -0700 (PDT)
Message-ID: <6dc5e28b-e84d-95c3-3967-476b2126314e@linaro.org>
Date:   Wed, 20 Apr 2022 12:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 5/6] ufs: use PM OPP when scaling gears
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-6-krzysztof.kozlowski@linaro.org>
 <20220419170149.GB8699@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419170149.GB8699@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 19:01, Manivannan Sadhasivam wrote:
> On Mon, Apr 11, 2022 at 05:43:46PM +0200, Krzysztof Kozlowski wrote:
>> Scaling gears requires not only scaling clocks, but also voltage levels,
>> e.g. via performance states.
>>
>> Use the provided OPP table, to set proper OPP frequency which through
>> required-opps will trigger performance state change.  This deprecates
>> the old freq-table-hz Devicetree property and old clock scaling method
>> in favor of PM core code.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/scsi/ufs/ufshcd-pltfrm.c |  69 +++++++++++++++++++
>>  drivers/scsi/ufs/ufshcd.c        | 115 +++++++++++++++++++++++--------
>>  drivers/scsi/ufs/ufshcd.h        |   4 ++
>>  3 files changed, 158 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> index c1d8b6f46868..edba585db0c1 100644
>> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
>> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> @@ -107,6 +107,69 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>>  	return ret;
>>  }
>>  
>> +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>> +{
>> +	struct device *dev = hba->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct ufs_clk_info *clki;
>> +	const char *names[16];
>> +	bool clocks_done;
> 
> Maybe freq_table?

ok

> 
>> +	int cnt, i, ret;
>> +
>> +	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
>> +		return 0;
>> +
>> +	cnt = of_property_count_strings(np, "clock-names");
>> +	if (cnt <= 0) {
>> +		dev_warn(dev, "%s: Missing clock-names\n",
>> +			 __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (cnt > ARRAY_SIZE(names)) {
>> +		dev_info(dev, "%s: Too many clock-names\n",  __func__);
>> +		return -EINVAL;
>> +	}
> 
> How did you come up with 16 as the max clock count? Is this check necessary?

16 was an arbitrary choice, also mentioned in the bindings:
https://lore.kernel.org/all/20220411154347.491396-3-krzysztof.kozlowski@linaro.org/

The check is necessary from current code point of view - array is
locally allocated with fixed size. Since bindings do not allow more than
16, I am not sure if there is a point to make the code flexible now...
but if this is something you wish, I can change.

> 
>> +
>> +	/* clocks parsed by ufshcd_parse_clock_info() */
>> +	clocks_done = !!of_find_property(np, "freq-table-hz", NULL);
> 
> freq-table-hz and opp-table are mutually exclusive, isn't it?

You're right, this should be an exit.

(...)

>>  	ufshcd_init_lanes_per_dir(hba);
>>  
>>  	err = ufshcd_init(hba, mmio_base, irq);
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 5bfa62fa288a..aec7da18a550 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -1022,6 +1022,9 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
>>  	int ret = 0;
>>  	ktime_t start = ktime_get();
>>  
>> +	if (hba->use_pm_opp)
>> +		return 0;
>> +
> 
> So you don't need pre and post clock changes below?

That's tricky. The UFS HCD core does not need it, but of course the
question is about the drivers actually using ufshcd_vops_clk_scale_notify().

Only QCOM UFS driver implements it and actually we might need it. Qcom
driver changes DME_VS_CORE_CLK_CTRL, so maybe this should be done here
as well. I don't know yet how to incorporate it into PM-opp framework,
because now changing frequencies and voltage is atomic from the UFS
driver perspective. Before it was not - for example first clock (with
these pre/post changes) and then voltage.

I will need to solve it somehow...


Best regards,
Krzysztof
