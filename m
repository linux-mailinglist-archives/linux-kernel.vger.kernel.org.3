Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD946478A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhLAHEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhLAHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:04:44 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B95C061574;
        Tue, 30 Nov 2021 23:01:23 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so12375398otu.10;
        Tue, 30 Nov 2021 23:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYilZAr1XgVC2x2mUvEXmNb/Lzj5sp/I1LTXImqfXgo=;
        b=E7h/aNP17QfujnTX1wvPftzQV9Hzuo9zOEvLmbgLwuf4lCAp2zgnoibc989OnQmwlf
         DNWnqbaKslDFFUcbUtGjAf7HorTyhfDgryS+d0sdXPmHJgGW8Ha3v2rJ0cP4EC5nzNVX
         WPnJpkWUNSj7EfLQvorhVDGk5IpCOk8+rSoJ5okQCGI3Iwlf2/OXRyX7QGa1pT1oM9Gk
         0TYZq8iJt+wS9C6FrJT0nNOaQzwy8sqPjuO3XGTeVc0qWSURKCrfO/e7MbYDPVYP38K9
         RvRaLTFl8laFGPzXfO5rGJ2FSTzZqhnscAcAhO8x/Y8lLs910dmpNnox5WWr2KQZHpXB
         t/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYilZAr1XgVC2x2mUvEXmNb/Lzj5sp/I1LTXImqfXgo=;
        b=ttLpVT/HT0xclvqmYhEJ62YibacXCFcAz/rtmBcwkEa7ShG5gTi5V6DKKlbvMbJ+D3
         KrVFY9vA3QW8cTvfWBNOBLCJwEiBT6F/H4hRLtNpyeRadkUta3x8FkiU5gBWTFvdBVZ7
         bTAsXBo5Xvo/MXnngU6Iw3ARhOvrSYecwIlq5w1PKcYVdiFD79//y+RxGdTSUKbtnuLd
         o9SGk683cfDDfJWYnq8J89bBY5C5f0tjQEzrJ+trCUbHfD7g0JNf7ZgJwVqPO7gzhIDa
         +nscDu2GHO6b7hIZkHL47DH+DIFzAlorIIiv/bVqdDBCrUzEYx2D2YFMYgY0wDhwUZfP
         eSIw==
X-Gm-Message-State: AOAM532MiyjI3Fq2p5UlasA2IHCcmI1hkOPqg9+sy2RAGA46d4LGEchy
        fPTvLGim3xc1sewpMQgqfuU=
X-Google-Smtp-Source: ABdhPJwDqSVOzbMh5UlP1usCqj1ZQj4ihpaFKe9IE1jY8hgddn9SF0K5ldrJfzq7IDZWTir3ymNWpg==
X-Received: by 2002:a05:6830:8:: with SMTP id c8mr4077177otp.115.1638342083100;
        Tue, 30 Nov 2021 23:01:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s26sm4470106oiw.19.2021.11.30.23.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 23:01:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
To:     Andrej Picej <andrej.picej@norik.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-3-andrej.picej@norik.com>
 <4591cdd6-9a7b-cd1d-817d-8950c8976d10@roeck-us.net>
 <DB9PR10MB4652C8A69A6A3F38B93ED18880679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <dcd75a82-5837-8d78-0a9f-6e5b7eafff28@roeck-us.net>
 <DB9PR10MB46521F419F43685F7103D32480679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <ef3f98e1-6661-84ed-1bde-747b1330aba2@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8257f965-7f0f-f513-9d86-e43baf010967@roeck-us.net>
Date:   Tue, 30 Nov 2021 23:01:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ef3f98e1-6661-84ed-1bde-747b1330aba2@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 10:42 PM, Andrej Picej wrote:
> 
> On 30. 11. 21 18:46, Adam Thomson wrote:
>> On 30 November 2021 16:40, Guenter Roeck wrote:
>>
>>>>> Why does it need a value ? Why not just bool ?
>>>>
>>>> One argument might be that if the property isn't provided then the OTP
>>>> configured value can persist without needing a FW change around this DT
>>> binding.
>>>>
>>>> My belief though is that the majority of users would have this property set to 0
>>>> by default in OTP, so a boolean would be OK I think here to enable watchdog
>>>> shutdown.
>>>>
>>>
>>> Sorry, you lost me.
>>>     dlg,wdt-sd = <0>;
>>> is the current situation, and identical to not having the property in
>>> the first place.
>>>     dlg,wdt-sd = <1>;
>>> is new. I don't see the difference to
>>>     dlg,wdt-sd;
>>> vs. not having the property at all (which is, again, the current situation).
>>> Since it has to be backward compatible,
>>>     dlg,wdt-sd = <0>;
>>> will always be identical to not having the property at all.
>>> I can not find a situation where an integer would have any benefits over a
>>> boolean.
>>
>> So if you have a binary DT binding, it's either there or it isn't which implies
>> the bit to be set to 0/1 in this case. If you have a binding which has a value,
>> there can be 3 outcomes in this discussion:
>>
>>   1) Binding = 0, bit is set to 0
>>   2) Binding = 1, bit is set to 1
>>   3) Binding NOT present in DT, OTP default value in HW remains untouched
>>
>> Say a platform updates to a later kernel version, but sticks with existing DT
>> FW (i.e. the new boolean binding isn't present in FW), then the following could
>> happen:
>>
>>   1) OTP for DA9061/2 has this bit set to 1, system expectation is that watchdog
>>      triggers SHUTDOWN.
>>   2) New driver checks existance of 'dlg,wdt-sd' but it's obviously not there so
>>      assumes the bit should be set to 0 and does so
>>   3) When the watchdog fires, it will no longer trigger SHUTDOWN but instead
>>      POWER-DOWN due to binary handling of new boolean binding.
>>
> 
> This was my thinking exactly. I also first thought about boolean value, but I then moved to the integer value of 0 or 1 after checking the OTP default for this bit. The da9062 I'm working with has the bit set to 1 by default.

That needs to be be documented.

Guenter
