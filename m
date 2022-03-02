Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC64CAA1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiCBQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiCBQ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:27:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DCCB92E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:26:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk29so3644846wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XjaeiEY8a1tH5c2j9KNmVI9SB++cezD6KFaef4Xjcac=;
        b=zP0BA6qB3rPhTnq8Fj9Z87v5Om3r3lpqiDAIoP2yPgV+O441mHTr7Ur1NOl002un1B
         CVZvsGx2tkNU6Uj24hNt0x2YU/ZVLnFBGj9cg7O8bGuozsHa888HLGJ6C88/M0XpnS4O
         umjN75al8ea5bXZ53+cG1qUxOZDEHfI1U7OC0nDYWYG/XoQfNi0tGXVP3IN/vngQi15O
         6GwdlyVjx7Q0LE+q03Zv7WDqsXarq6VoZxG0DMKwtHOanwWAx1QYggVsqKYT2gobrI0A
         rXKq0rnmMVduqpklvtted93fzbsSmbHEhVzt2m8NAVbd0L5v336bhFvvNZVc4qdB5FyK
         +VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XjaeiEY8a1tH5c2j9KNmVI9SB++cezD6KFaef4Xjcac=;
        b=TAjcCdcjjZ6J7a76KIDs6C47k8pfInyN4eAkCUNE4/xns/ykDAlT3roOjRgL211nDa
         onNtZmWCP79S3lo96vwo2ObIgDtraaXgZ+cgFyl2vuS5E3LZxb19lekVaOMzoinuIKsk
         y9haf8meoqSP+efDOk58gDOFd976WljYvpRo97fTvnE2lRwZqgXK7ILEdcUvsnz11m3r
         t9g9E2+x/WCpjwD+waNHj8r+Ld4TlnbvQdpAstgOtzio+M9RBx1+/HiMTJAyYrn5A5fK
         /jhPvFS3BaW/tcuaEG/lQEERu2IGfb0ZdbYCpB5M3OYCoUczi8CMEsnRhONqFUYchc3U
         o/9w==
X-Gm-Message-State: AOAM530XL6Wx1w69dS1y+LfvfjRYwEUckWy5TTawtK5psMdy6X9OG3Qi
        FdWx8LRFJYIq+1RKZbA7IaWkSjynZ23J0g==
X-Google-Smtp-Source: ABdhPJzKY+/eMiZPibbAsxw/NaB6uXT2sK3X5WA4cVQHSoWusKxMSFLA03cK79cL79Q1DUIlIf+R9A==
X-Received: by 2002:adf:f849:0:b0:1ef:5d80:c68a with SMTP id d9-20020adff849000000b001ef5d80c68amr19686368wrq.280.1646238402267;
        Wed, 02 Mar 2022 08:26:42 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98? ([2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98])
        by smtp.googlemail.com with ESMTPSA id i9-20020adffdc9000000b001f046861795sm1588244wrs.19.2022.03.02.08.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 08:26:41 -0800 (PST)
Message-ID: <3ff11b85-249f-2f47-cbc4-41d2ab6d168f@linaro.org>
Date:   Wed, 2 Mar 2022 17:26:37 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
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

On 02/03/2022 17:07, Sanil, Shruthi wrote:
>> -----Original Message----- From: Daniel Lezcano
>> <daniel.lezcano@linaro.org> Sent: Wednesday, March 2, 2022 3:54 PM 
>> To: Sanil, Shruthi <shruthi.sanil@intel.com>; tglx@linutronix.de; 
>> robh+dt@kernel.org; linux-kernel@vger.kernel.org; 
>> devicetree@vger.kernel.org Cc: andriy.shevchenko@linux.intel.com;
>> mgross@linux.intel.com; Thokala, Srikanth
>> <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai 
>> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
>> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com> Subject:
>> Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
>> 
>> On 02/03/2022 11:12, Sanil, Shruthi wrote:
>> 
>> [ ... ]
>> 
>>>>> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) { +
>>>>> pr_err("%pOF: Prescaler is not enabled\n", np); +		ret =
>>>>> -ENODEV; +	}
>>>> 
>>>> Why bail out instead of enabling the prescalar ?
>>> 
>>> Because it is a secure register and it would be updated by the
>>> bootloader.
>> Should it be considered as a firmware bug ?
> 
> No. This is a common driver across products in the series and
> enablement of this bit depends on the project requirements. Hence to
> be sure from driver, we added this check to avoid initialization of
> the driver in the case where it cannot be functional.

I'm not sure to get the meaning of 'project requirements' but (for my 
understanding) why not describe the timer in the DT for such projects?


>> -- <http://www.linaro.org/> Linaro.org │ Open source software for
>> ARM SoCs
>> 
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook | 
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro- blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
