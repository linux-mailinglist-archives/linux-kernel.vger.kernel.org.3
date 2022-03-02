Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680FC4CA218
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiCBKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiCBKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:25:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF5AC92C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:24:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so921933wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zf3t59YuuxCNJPUz/HY2r4h+HKYXoaw1e4s0ZaR15GE=;
        b=tQVsBVO07MjcksiaS/uaKMdejreMdo52VHClB4yRNGHQIKJisEdQba1H/wrEUmxpNr
         Epyf9UVis88yqtGydUngITuzdK2pH8M/yr+u9MqWwnvT6GEsZ68OqOyuoNIXotb6oqWL
         M9QzYRVYcs9J3OId8gJywtG4LVXEyx3auR5CoQjRXQRRRyugmfiVdj7Hd2umBQ29O30x
         hObiAmFyaRnm+sDzcCY0DXsHJl+j+u9gGwGXdu+giWxNvKcKPIDEtHaFdF9uyGY6ncZV
         hfVe/pISTwgyCLydjWkPXfT8E631bRoKmGVN1yT+G7caWClpZ1uA3YKS+P3wyzjv4hLL
         3h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zf3t59YuuxCNJPUz/HY2r4h+HKYXoaw1e4s0ZaR15GE=;
        b=jxH2sI1k8lF7Fyh1YBBf+6+R7ASAr6klE+V3Ak15FvFFgQgt3oMbA65xUl3ePu/+Sk
         op6u5NBHR1xh08uymr0EApwhAOdGZ5yPo5GV/gTo+tiWzEP0Rxk/GS0SYrzdj3wcUupI
         m21MX2A25VcGMv8oz+OLW09+0aH90tFj3qJj/ZXvbsua41Vjk2xCbM5fIOA4W9C0gwk9
         PjzloWOlMC3WiHhzYBDddlm1SG1jQ0JbZZrGk0uOJR+IMpsm1KnFFuFy9l/Kl3Y+DELP
         2KLlNBZwLVVsHG8otyp/Z1Ih2H0XvBTWDHpsqHwb0b+MTWGb9kWYFUPGEERe6foIfGfh
         6aMQ==
X-Gm-Message-State: AOAM533G/FbkVKu8S0zRsD+0aFJzgsYTeeYAMK596hB8H3pvljvTg//J
        1/RdR9WBTS5vCYeaQruaYK2NhA==
X-Google-Smtp-Source: ABdhPJzXp6FHTG7RSsowKR7IPxM7MXRY8kmzfyBIvDDrAdkaP8nlOFVzNi+edlFGoCDmUpL9LisIwg==
X-Received: by 2002:a1c:4603:0:b0:381:19fe:280b with SMTP id t3-20020a1c4603000000b0038119fe280bmr19946383wma.67.1646216660031;
        Wed, 02 Mar 2022 02:24:20 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55? ([2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55])
        by smtp.googlemail.com with ESMTPSA id f9-20020adffcc9000000b001e9e8163a46sm23514078wrs.54.2022.03.02.02.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 02:24:19 -0800 (PST)
Message-ID: <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
Date:   Wed, 2 Mar 2022 11:24:18 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
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

On 02/03/2022 11:12, Sanil, Shruthi wrote:

[ ... ]

>>> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) {
>>> +		pr_err("%pOF: Prescaler is not enabled\n", np);
>>> +		ret = -ENODEV;
>>> +	}
>>
>> Why bail out instead of enabling the prescalar ?
> 
> Because it is a secure register and it would be updated by the bootloader.
Should it be considered as a firmware bug ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
