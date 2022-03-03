Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7754CBE73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiCCNFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiCCNFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:05:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7250068
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:04:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so7715904wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fn1mW/M+b5JfP/RL4eNIoaoJKFnoTSy8/1QRkY7yY6w=;
        b=cAfXFEhOpXumYj813HTkLEraMgQg06hYN419xoSCexoVB93sZr7EXzvNEtL0Fieqrq
         y2PG01R601L0eMlhdJEz0GtRmms3CBjweJcfL1xQZQpLD0mTvmzFfzn50yBo5Q6zHxCC
         5w98EIfIom79Bv09c7Fm9gbTpuNUAjAx4DMaBgrh/2yMSFAEkq+MVVwiZIksY0LGQmAo
         JibtNXb84wWol/uCRRSBrdJ3x8FG4tCJ0z5vDxHADTEp4kvP/VaJo/Aom7BZbPvAety6
         5vpEWUs1gS1oEsNkXh+nLaHR21sIqaY5xMf7Fn3uOokLAY+EadocHPL1ZuEAEeZIhOcf
         2Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fn1mW/M+b5JfP/RL4eNIoaoJKFnoTSy8/1QRkY7yY6w=;
        b=vNl/bk+5H1v8rylUhrqOrh1dilBYLy57xagIPQE4yM4EP7UrRpNNC5s9yUxqr6KBnM
         9OUF+c1KfRWpu9yrx3At9Lwr7C32LVbkY38KINOwAu99bTAwDvSGjLIU8Oxn4UDsA6xs
         eNDxU97VbOIJSPRfVZAOJMuGLORbZhBekiURcS6S7svwqOAMJeiteBAGW7Pl9SZL+AC/
         gZBqn+NcC52bL155CbD9jqQ6QoRX+C+WVxtrAX4GNLdSdNkW95Qy3GP65RpKbidcdkI+
         xvjqRbx2TKtFZiIZSv+sj0PNT6t3GA/s0U3UA77mjuahTkuzVWUx3fx9wvde1nsGQJcy
         nzuA==
X-Gm-Message-State: AOAM532pdSndGdm/7CU1IPBIvPCXmuVrHMbkkyl0SvO7R2tyiNpaXpQU
        sX1Z9CbwEbXQkcwAZrwONWGrFFiX2k4CMA==
X-Google-Smtp-Source: ABdhPJyvuhJeoFTwSlXcRkogHWdVBOBzuvgCFWCYYC2O1J7O8WsFAPsAMwhcS8NYLsoLeBgL6NPQdQ==
X-Received: by 2002:a05:6000:1847:b0:1e6:2783:b3e6 with SMTP id c7-20020a056000184700b001e62783b3e6mr26593796wri.163.1646312652810;
        Thu, 03 Mar 2022 05:04:12 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98? ([2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98])
        by smtp.googlemail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm8449303wmj.42.2022.03.03.05.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:04:12 -0800 (PST)
Message-ID: <ac06ce18-5997-d553-3033-6bc7ac65f608@linaro.org>
Date:   Thu, 3 Mar 2022 14:04:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Content-Language: en-US
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "Sanil, Shruthi" <shruthi.sanil@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
 <ce516de7-f1cf-c614-f9ff-439626dfafea@linaro.org>
 <YiCcu7unsP5YDxun@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YiCcu7unsP5YDxun@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 11:47, andriy.shevchenko@linux.intel.com wrote:
> On Thu, Mar 03, 2022 at 11:17:33AM +0100, Daniel Lezcano wrote:
>> On 03/03/2022 07:18, Sanil, Shruthi wrote:
> 
>>>>>>>>> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) { +
>>>>>>>>> pr_err("%pOF: Prescaler is not enabled\n", np);
>>>>>>>>> +		ret = -ENODEV; +	}
>>>>>>>>
>>>>>>>> Why bail out instead of enabling the prescalar ?
>>>>>>>
>>>>>>> Because it is a secure register and it would be updated by
>>>>>>> the bootloader.
>>>>>> Should it be considered as a firmware bug ?
>>>>>
>>>>> No. This is a common driver across products in the series and
>>>>> enablement of this bit depends on the project requirements.
>>>>> Hence
>>>>> to be sure from driver, we added this check to avoid
>>>>> initialization of the driver in the case where it cannot be
>>>>> functional.
>>>>
>>>> I'm not sure to get the meaning of 'project requirements' but (for
>>>> my understanding) why not describe the timer in the DT for such
>>>> projects?
>>>>
>>>
>>> OK, I understand your point now. We can control the driver
>>> initialization from device tree binding rather than add a check in
>>> the driver. But isn't it good to have a check, if enabling of the bit
>>> is missed out in the FW? This can help in debugging.
>>
>> So if the description is in the DT but the prescaler bit is not enabled then
>> the firmware is buggy, IIUC. Yeah, this check would help, may be add more
>> context in the error message, eg. "Firmware has not enabled the prescaler
>> bit" or something like that
> 
> For this we also use a FW_BUG prefix to printf()-like functions.

Thanks for the information, I was unaware of this prefix.

Good to know ;)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
