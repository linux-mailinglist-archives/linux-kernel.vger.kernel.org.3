Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91024A375C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355460AbiA3QAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbiA3QAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:00:36 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E063C061714;
        Sun, 30 Jan 2022 08:00:36 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q186so22141910oih.8;
        Sun, 30 Jan 2022 08:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zsLv8RieDK/LADd0OqJIk3WeIzS/hzLzJYF6j1aoRwY=;
        b=k8yQKmaIWi6AokdJPzGvP0jxKwJ68ElzR4DmZ24lC9dJIFNc7NH6BXbA/qjInHipO+
         IFvFVA0fWAb5h9O3uJam51kZCOXOnS+xaWmtwCVcG79V5exNJ6a2QJhO24XkOtOw9X7S
         hNfXa8AXFErrE5vf1IWy4FRJiDCeqJ0dQG/v35XKN1jH6iDmpR7BBCFH1jPHtDPmdsoO
         8NkjO5v3ffcRusTbMN8MS0Yd8VLOuokApp14FfC6ERfhUnz8jt2pYFEdbmGJ0q7bhBmh
         qlBsJgMIeMVV85XRZcnxeOJZKR+B9ktQVXGxGveOQXPyZTa8gS1OKd7sGt2x8Aw8Jtux
         52qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zsLv8RieDK/LADd0OqJIk3WeIzS/hzLzJYF6j1aoRwY=;
        b=FdKNS8Sd3go7IwmzNESd/zzDSyEcXCDj6YHf4vj6pFtuTNf1uq72PIajl0Wnoo6k85
         aVZZKGbuA9HzbZcUI+hDq7lWFnbbNvsAykrCZVCc8z4u/kstD2IgvlNadIZYDf5s9spQ
         AcPjUl3j5ZLmS+OPBAf0iUdqhxHUAvydjhJ4UjnJG1yBmbwcikF8GbxsxJTzNEagzX5O
         iWwyUxIVErdBigiPNmTiA7nhfdARhOsP/wvWAF1i7KiGq7nLNNloBLPT0IKtfL4y8x2W
         pIYMVJV/hqnBXAKAI0ekDcAMeTRx56JsLO/HDM7p4Y6ZHex+sS+T+oqJvEQ4eOMP7mY5
         AAKA==
X-Gm-Message-State: AOAM533yOT9mHj7VEVGwlk2tei2JdJddE4g+Rea7QeMy7BtASDd+uc9Q
        fkOp+1RzExPYf/wtZKHkX7E=
X-Google-Smtp-Source: ABdhPJx1bPTluapxKQaQB6WfeK/W5hHQKVHNGM3wywQGTaT3utImOfIyq+Rn2bJA27zswGyxMNYHOw==
X-Received: by 2002:a05:6808:23ce:: with SMTP id bq14mr1010332oib.311.1643558435229;
        Sun, 30 Jan 2022 08:00:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p11sm15745654oiv.17.2022.01.30.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 08:00:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ea1d8ab-9d76-c19a-56c8-f66599534deb@roeck-us.net>
Date:   Sun, 30 Jan 2022 08:00:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/9] Add MAX77714 PMIC minimal driver (RTC and watchdog
 only)
Content-Language: en-US
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <d8aacb8a-5e41-fd96-daac-e9257358ca71@lucaceresoli.net>
 <4532b372-f16a-7658-623d-71af93306e44@lucaceresoli.net>
 <900e896a-f1c3-aafa-2ed4-a23104d65b74@roeck-us.net>
 <3a186067-50e9-ce20-0ed6-696ca658de4a@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3a186067-50e9-ce20-0ed6-696ca658de4a@lucaceresoli.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/22 04:45, Luca Ceresoli wrote:
> Hi Guenter,
> 
> On 30/01/22 02:48, Guenter Roeck wrote:
>> On 1/29/22 00:40, Luca Ceresoli wrote:
>>> Hi Lee, all,
>>>
>>> On 11/01/22 11:10, Luca Ceresoli wrote:
>>>> Hi All,
>>>>
>>>> On 11/12/21 18:59, Luca Ceresoli wrote:
>>>>> Hi,
>>>>>
>>>>> this series adds minimal drivers for the Maxim Semiconductor MAX77714
>>>>> (https://www.maximintegrated.com/en/products/power/power-management-ics/MAX77714.html).
>>>>>
>>>>> Only RTC and watchdog are implemented by these patches.
>>>>>
>>>>> All implemented functionality is tested and working: RTC read/write,
>>>>> watchdog start/stop/ping/set_timeout.
>>>>>
>>>>> Patches 1-3 + 6 are trivial cleanups to the max77686 drivers and
>>>>> Kconfig
>>>>> indentation and can probably be applied easily.
>>>>>
>>>>> Patches 4, 5, 7, 8 and 9 add: dt bindings, mfd driver, watchdog
>>>>> driver and
>>>>> rtc driver.
>>>>
>>>> A gentle ping about this series. It's at v5, all patches have at least
>>>> one ack/review tag and most patches are unchanged since ~v2. It applies
>>>> cleanly on current master.
>>>>
>>>> Is there anything I should do to help making progress?
>>>
>>> Apologies for pinging again... but as I got no further comments about
>>> these patches I guess I can really do nothing at the moment.
>>>
>>> Lee, is this series completely in charge to you or should it be applied
>>> by the respective subsystem maintainers?
>>>
>>
>> I hesitated to take the watchdog patches because an earlier patch of the
>> series
>> introduces MFD_MAX77714 and the watchdog Kconfig entry lists it as
>> dependency.
>> I now added patch 7/9 and 8/9 to my watchdog-next tree anyway. If the
>> mfd part
>> doesn't make it we can still decide to take it out at some point.
> 
> OK, thank you! In the meanwhile the kernel test robot also reported a
> build failure due to missing max77714.h file, which is added by patch 5.
> 

Yes, I noticed. Which means I'll have to drop the patch again, and we'll have
to wait for the mfd patch to land, sorry.

Guenter

>> Note that patch 6/9 has already been applied.
> 
> Indeed, it's in Linus' master already.
> 
> Regards.

