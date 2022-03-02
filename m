Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0F4CA9BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiCBP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCBP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:58:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649D4AE01
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:58:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so693090wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S7tBxL3zCrsmorspR7qPusrnc1TbsRYLggUh4+p6MEo=;
        b=x7f7c2SCinYE0MhyzXnrqP7gjrhNRCE4IyOZQSela0bBvemhD+IbNSM+fPbXcMa8Rz
         RUAvlekxqc9fQEFuKlfqxAVxZekoNANTDkXI1SdGwjelE03LqmuSltivVZmw0Ep5hSWs
         ztLpCVRSCE7uQnRGcD0GV/9CC+bfmRpWqG/FuSf8qQn7IC0A2fzeehWs4lSWICvnf7iV
         OFwl4xO0qAlqi+6VgrfyLEQbq1uscBTk0XYElKcO3NVKUstvQ1lZh++f84FUr0OLMm3S
         ZxtCLYA16yDxYWvv4N80WLNnhtm6lNgGx7e8gv6Yz6sN470Eg0A8baKKgJM7zzwpzccA
         8YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S7tBxL3zCrsmorspR7qPusrnc1TbsRYLggUh4+p6MEo=;
        b=4D/5ABYLF/uuZoKss2dDIeA9md4Se00bnVDszUbJd/WupLb77IZYS2tZYEexo5YOuS
         5YWcaL/cKgIm8qIVNF4daRhCCEF1kBTb6aSdX3AD+zArvwI5UM6mitBzMhcjQxABAgrE
         Xh31MB6VC7mb818uCy7RxhJxq/VhSp3dcq6KkD9J7UfFsldsOh+9wi08dkk9iwJl9ZSC
         ec7qXFGcDR5Tz8enPCs4q/ty865jMNyCH1lLz96oZcnUbOeRlHb//WnutJ8IA9NfnIHT
         2OO3e9b7116KbprhdsrFJ0VrlWc3/5gttEQ7biTSkTkxsDA1fFdQQQncv51DWIcSq7S6
         yVgQ==
X-Gm-Message-State: AOAM531j4WMl/TF/EVEi/oKL6Dv1Kyl9adXsgW76+Mu1wQ/OBaUbFmfn
        VL3UAltg8EhCvfEuIJ0GTlszjw==
X-Google-Smtp-Source: ABdhPJypg+b21zNLXqV+F0y7KcTaJmTZ+m1NyDelT51EGx+VrpgB4V48jUYw7ZH84y1/mFvFnaqTWQ==
X-Received: by 2002:a05:600c:1c9c:b0:386:f4ed:3f59 with SMTP id k28-20020a05600c1c9c00b00386f4ed3f59mr189896wms.27.1646236694737;
        Wed, 02 Mar 2022 07:58:14 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98? ([2a01:e34:ed2f:f020:b9e3:8853:bc0:bb98])
        by smtp.googlemail.com with ESMTPSA id l7-20020adfc787000000b001f049375350sm487067wrg.8.2022.03.02.07.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 07:58:13 -0800 (PST)
Message-ID: <d1f82398-3f94-2f48-db92-d1fe487032c7@linaro.org>
Date:   Wed, 2 Mar 2022 16:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <Yh925VvqejDe2SR8@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Yh925VvqejDe2SR8@smile.fi.intel.com>
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

On 02/03/2022 14:53, Andy Shevchenko wrote:
> On Tue, Mar 01, 2022 at 10:09:06PM +0100, Daniel Lezcano wrote:
>> On 22/02/2022 10:56, shruthi.sanil@intel.com wrote:
> 
>>> +		/* Clear interrupt for periodic timer*/
>>
>> nit: comment format is:
>>
>> /*
>>   * my comment
>>   */
>>
>> One line comment format is usually for the network subsystem
> 
> Huh?
> Any pointers to the documentation, please?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598

Well actually it is for multi line, so I may have confused with these 
one line comments.

On the other hand having one line comment telling what does the function 
right after is not really useful. The function names are self-explanatory.

>>> +		keembay_timer_clear_pending_int(tim_base);
>>> +	} else {
>>> +		/* Disable the timer for one shot timer */
>>
>> comment format
>>
>>> +		keembay_timer_disable(tim_base);
>>> +	}
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
