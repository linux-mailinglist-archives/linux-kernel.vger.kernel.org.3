Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C94CBB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiCCKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiCCKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:18:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A795B3E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:17:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i66so2811301wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TtOHWLLsa7rSXRza0fGN1cBKMNwfwygfgSB4i7ej/Go=;
        b=Nbxsqfpf4U//4kMEYQgwampDN3L5Q2TZvU6x4HLIh5rHGeSfTWOiwOWf7WlZqw6Frz
         zabhNvVrT6tq8E8cRpfzQby2OfWLCvBQS6NEKRHlj/5MZ486/unuIlHEcozP6A2obxrZ
         vgvn9NR7WrxE6k4h/FVtUhMxA0XamBacTNXmPndxgT1s1Gzq1iOClFR7LzN8VEfyDUNC
         CPyh7ZV2CDvjdanG5kRemUYkgHYqpusnawgCP2gFBEL0axzKiQyl7FN0TM/0pSmF7XrP
         rg+gzo7zHRPIMjtAOSzVsLtTBGl1VLlODl7eu5qVrzYcg95eWFhHCKqTy7XYy/L5UnL1
         6HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TtOHWLLsa7rSXRza0fGN1cBKMNwfwygfgSB4i7ej/Go=;
        b=2R30nmmSs8Xl/BlhBi+dv4nKmcbPSFfSh3Ps0xUR2lVm+rbZ46bnpf3ILDCUjrXrPu
         EO8s7o8QT34lH+iBDD/GzOZUVhSsZxOL76OteIiTRZDfxteejTdz09necghPGRXRWSR4
         0dFrInsAjXCwaR/Kw6WFlC8D4sctbAISKF/rTh2J7sciIL1kPj0yvYZzmBmtSLHq6dRR
         ICUt+q4lbgF0czlr+T2oOc8ddK4d8yL2WFa71UgIIXaN55rU6YL/D31tnoBTTpbl4jtb
         ISmrYwCziCMwkfzHtD6oSdq0q5FpbKJUQz9AkrcnS3URqYb8SwVK6imQ8sZqoHCXJ9W7
         8uRA==
X-Gm-Message-State: AOAM533nL0eVivXHYWA3YpIe9gMDyYnJCDoTI+gXCfZK9aNlqFTPXkxS
        d5X65FEallvH3gmorqN5i9eqhQ==
X-Google-Smtp-Source: ABdhPJymkgSussHvNIxK2wwqP7NcLV6g47ibW+vjezWNLiFeFT+TfibQHdlBZqfWNbFWWCD8pOD30Q==
X-Received: by 2002:a05:600c:4401:b0:387:1bcb:af41 with SMTP id u1-20020a05600c440100b003871bcbaf41mr2793032wmn.101.1646302655488;
        Thu, 03 Mar 2022 02:17:35 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98? ([2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98])
        by smtp.googlemail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm1713098wrj.76.2022.03.03.02.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 02:17:34 -0800 (PST)
Message-ID: <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
Date:   Thu, 3 Mar 2022 11:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Content-Language: en-US
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
 <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
 <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <DM4PR11MB554994532B3D128F85553C38F1049@DM4PR11MB5549.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 07:18, Sanil, Shruthi wrote:

[ ... ]

>>>>>>> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) { + 
>>>>>>> pr_err("%pOF: Prescaler is not enabled\n", np); +		ret = 
>>>>>>> -ENODEV; +	}
>>>>>> 
>>>>>> Why bail out instead of enabling the prescalar ?
>>>>> 
>>>>> Because it is a secure register and it would be updated by
>>>>> the bootloader.
>>>> Should it be considered as a firmware bug ?
>>> 
>>> No. This is a common driver across products in the series and 
>>> enablement of this bit depends on the project requirements. Hence
>>> to be sure from driver, we added this check to avoid
>>> initialization of the driver in the case where it cannot be
>>> functional.
>> 
>> I'm not sure to get the meaning of 'project requirements' but (for
>> my understanding) why not describe the timer in the DT for such
>> projects?
>> 
> 
> OK, I understand your point now. We can control the driver
> initialization from device tree binding rather than add a check in
> the driver. But isn't it good to have a check, if enabling of the bit
> is missed out in the FW? This can help in debugging.

So if the description is in the DT but the prescaler bit is not enabled 
then the firmware is buggy, IIUC. Yeah, this check would help, may be 
add more context in the error message, eg. "Firmware has not enabled the 
prescaler bit" or something like that

Thanks for the clarification

   -- D.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
