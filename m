Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F654527D65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbiEPGKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiEPGKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:10:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E820F7A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:10:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx33so16814390ljb.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zib3uaRuFHQp5m+3/8oVVWs2fT/RhjrDBvhpgKAcf3A=;
        b=T8a68Wcn4gY9NFXddamoH+rRrUy8g81C6ugx+hQrWs90thVEoFpfoW5rfePda8J8Ti
         KhYLE5GeSNkseGhg6lt7Uw3CFsrabahfUTN6w49xWFaBgVGI0x9XP77w7igMPyaJ68Cq
         qg8vUoA0kBuM1wr5DCpHhE3FpkgNX+KKJZK6qCoalPD/rQiLoRs9/bYs/l0ErwlkoH0P
         1viy/5jm8JiHRHEICvrFZ3mP4KXxz85YQeOIAL0QqJ1J/jLc0LdzwVX5OH8SXaqpQEH3
         cNP78pu268Ud97vfkkEiS4RW+MJ/RzJICDEG0kc8MdHqBzJU5DPGyHb+S8K2sDRzFhMV
         K1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zib3uaRuFHQp5m+3/8oVVWs2fT/RhjrDBvhpgKAcf3A=;
        b=Hrt8JfJJI8/mLr2Gi7cqpadmD7UM0DIwO9s7Ab53E2crnl5CPXyxakoJ594T7BtKGG
         UtJYW+xpce8Y+otAGdJQPHiqzqwYVzU90VEGiuQzE1JpZxfUE8jshmBMCWEXz6aJlxHg
         R2DYhP4MYl5x3Mw43sw+yXBdeHozbRNm48FE65RIw7NrA3wN5m4KsojpWhpC3gTYqgWM
         HKsylDbfffGjGb1Op0nIydkIcMtv9hBrp28zoi586NYxREr3PLamdmJfzlKJezMAPgD6
         71tDIBUeWVqFCSB6AMy2WaNIg2jOfLQYYpOUeEyFjPpE0duTFeQLVfc2tHqJkXBDG1H9
         VNrA==
X-Gm-Message-State: AOAM531OkZZcoFmP/1o5Y9Day9KHdz4eC0llT0ufRLkGX+G1B5Gq/Rck
        F1hffOPE7mEbF259pH/8Ig7p6A==
X-Google-Smtp-Source: ABdhPJyrZUQf7WD5zZ0nqfhRfXzM6EGNE+a7PhnPAP8HR3cuJ7y91FoKEpx/vEUszqhSySkNWYqKKw==
X-Received: by 2002:a05:651c:399:b0:24f:18d:5bbd with SMTP id e25-20020a05651c039900b0024f018d5bbdmr10166934ljp.481.1652681429224;
        Sun, 15 May 2022 23:10:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j9-20020a19f509000000b0047255d210f2sm1208147lfb.33.2022.05.15.23.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 23:10:28 -0700 (PDT)
Message-ID: <eecf3117-772a-f50a-5d09-4d729dea7561@linaro.org>
Date:   Mon, 16 May 2022 08:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 7/7] ufs: use PM OPP when scaling gears
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
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-8-krzysztof.kozlowski@linaro.org>
 <20220513182546.GD1922@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513182546.GD1922@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 20:25, Manivannan Sadhasivam wrote:
> On Fri, May 13, 2022 at 08:13:47AM +0200, Krzysztof Kozlowski wrote:
>> Scaling gears requires not only scaling clocks, but also voltage levels,
>> e.g. via performance states.
>>
>> Use the provided OPP table, to set proper OPP frequency which through
>> required-opps will trigger performance state change.  This deprecates
>> the old freq-table-hz Devicetree property and old clock scaling method
>> in favor of PM core code.
>>
> 
> To be clear, you are not changing the voltages (UFS supplies) through OPP. But
> rather handle only clks and leave the power domain handling to parent OPP
> device.

Correct, the patchset itself does not introduce itself regulator
control. For Qualcomm (and maybe others) these will be scaled via OPP
performance states.

> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> ---
>>
>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  drivers/scsi/ufs/ufshcd-pltfrm.c |  73 +++++++++++++++
>>  drivers/scsi/ufs/ufshcd.c        | 150 ++++++++++++++++++++++++-------
>>  drivers/scsi/ufs/ufshcd.h        |   6 ++
>>  3 files changed, 195 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> index 3ab555f6e66e..a603ca8e383b 100644
>> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
>> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/of.h>
>>  
>> @@ -108,6 +109,72 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>>  	return ret;
>>  }
>>  
>> +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>> +{
>> +	struct device *dev = hba->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct ufs_clk_info *clki;
>> +	const char *names[16];
>> +	int cnt, i, ret;
>> +
>> +	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
>> +		return 0;
>> +
>> +	cnt = of_property_count_strings(np, "clock-names");
>> +	if (cnt <= 0) {
>> +		dev_warn(dev, "%s: Missing clock-names\n",
>> +			 __func__);
> 
> This is a hard error, right? So why not dev_err()?

Good point, but actually this (and following cases) should be return 0,
because clocks/freq-table/opp-points are not required properties. The
original code (parsing it for freq-table-hz) also does not treat it as
error.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (cnt > ARRAY_SIZE(names)) {
>> +		dev_info(dev, "%s: Too many clock-names\n",  __func__);
> 
> dev_err()?
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_find_property(np, "freq-table-hz", NULL)) {
>> +		dev_info(dev, "%s: operating-points and freq-table-hz are incompatible\n",
>> +			 __func__);
> 
> dev_err()?
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		ret = of_property_read_string_index(np, "clock-names", i,
>> +						    &names[i]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
>> +		if (!clki)
>> +			return -ENOMEM;
>> +
>> +		clki->name = devm_kstrdup(dev, names[i], GFP_KERNEL);
>> +		if (!clki->name)
>> +			return -ENOMEM;
>> +
>> +		if (!strcmp(names[i], "ref_clk"))
>> +			clki->keep_link_active = true;
>> +
>> +		list_add_tail(&clki->list, &hba->clk_list_head);
>> +	}
>> +
>> +	ret = devm_pm_opp_set_clknames(dev, names, i);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_pm_opp_register_set_opp_helper(dev, ufshcd_set_opp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_pm_opp_of_add_table(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	hba->use_pm_opp = true;
>> +
> 
> Since you are only handling the clks in UFS driver's OPP implementation, it
> warrants atleast a comment. Otherwise, someone will add voltage to the OPP
> table and complain that it is not getting changed. Eventhough the UFS driver
> won't allow doing it, it is safer to mention it explicitly.

Sure.

> 
> Also I'm worried about the implementation specific to Qcom platforms. Like we
> rely on RPMHPD to handle the power domains, but that may not be true for other
> platforms. I know that we cannot support all possible implementations but
> atleast we should document this limitation.
> 
> Rest looks fine to me. I'll take one more look after testing this series on
> SM8450.

Using OPPs is quite generic, so other platform could implement also
regulator scaling. The changes are indeed targetting Qcom platforms, but
they are not restricting any other usage.

Best regards,
Krzysztof
