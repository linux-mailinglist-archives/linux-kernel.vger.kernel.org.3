Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4441C463C01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbhK3Qnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhK3Qnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:43:40 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6606DC061574;
        Tue, 30 Nov 2021 08:40:21 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r26so42341422oiw.5;
        Tue, 30 Nov 2021 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eg2/gpyOdiIomdCdelA6H7DCG0PWicFoqQpH5lOFnDs=;
        b=RnktTIw+dSyyOAS1q1ZCi7423/03SJvhJ800pC0zSszQogcR9Z2QtI0vrJa7q2f8yJ
         lNLlcK7G4U/hx0InOTfEed+OgL7+EyqFMGDe69i4L2DXJ1K43lFpeQ0P7iInY/P+kdi7
         V+2ZMguDhQizW5xBFjODd9QY5eCRLmLFuI9bTeh3iMmVivDNP2a95xfY7qM1rqvdZ+EV
         zD5V+id/mvsEixIdn7a5QmmmP9VuR4X549agw/L89MacGhyr3d675XJcQuJa4MqIanII
         7TE2OVUNlSJ4oIRK25JUSOZcNR2ylX9DHaF3oGsSArummjMt8liCEhyVMGD6vHmXqaO5
         eswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eg2/gpyOdiIomdCdelA6H7DCG0PWicFoqQpH5lOFnDs=;
        b=SWxygVw5vCuQoyGEqBnoCdZfCaGcIE4ulKsZEBpOtByqPKQR6A/ta/5kc0TZbguYPB
         EGafz8JTlkvo6yL+ygLxq19hh0AJHRmm/vZBRkEE9njE4NtiJe7N6t0VGqnDikQkIcrx
         SFlLw9CnnKCCqSHIiBlfvit93n68qYbIMJzrPw5zzPmUXyNa/8TS+zMMTPAhPT2P4YlZ
         Fy5AlWrID+afo+sgTqYgrO83E2xbWGvQIOsSrumcC26avoEVccsLdBclf6yGPzTrUAOD
         WqrTYb8UXsET+oQbnvvSstJdlTftf75UujvSqt76jesX/nYYnrsX2uHGLZ9E6Me4Mk5V
         dAbQ==
X-Gm-Message-State: AOAM532Xrd6gza9G4yB/OMWMzNoxI1RLoM49JuP1FObwBcoYg2LleHAC
        WIJcOTCP81GYo+bQy8WXj+A=
X-Google-Smtp-Source: ABdhPJwLW7RWf2bJLcllr9oXFsxnRR7DaHlPuADOa93/8O9xTtx9b0JUWVFr6BWeFUsYJ5Q+VFckNw==
X-Received: by 2002:a05:6808:1a01:: with SMTP id bk1mr33582oib.46.1638290420694;
        Tue, 30 Nov 2021 08:40:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1sm3210587otj.5.2021.11.30.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:40:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dcd75a82-5837-8d78-0a9f-6e5b7eafff28@roeck-us.net>
Date:   Tue, 30 Nov 2021 08:40:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652C8A69A6A3F38B93ED18880679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 8:11 AM, Adam Thomson wrote:
> On Guenter Roeck wrote:
> 
>>> Document the watchdog timeout mode property. If this property is used
>>> the user can select what happens on watchdog timeout. Set this property
>>> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
>>> will go to POWERDOWN on watchdog timeout.
>>>
>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>> ---
>>>    Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>> b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>>> index 950e4fba8dbc..e3e6e56cee21 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>>> +++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>>> @@ -10,6 +10,9 @@ Optional properties:
>>>    - dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
>>>    	Only use this option if you can't use the watchdog automatic suspend
>>>    	function during a suspend (see register CONTROL_B).
>>> +- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
>>> +	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
>>> +	POWERDOWN. Can be 0 or 1.
>>>
>>
>> Why does it need a value ? Why not just bool ?
> 
> One argument might be that if the property isn't provided then the OTP
> configured value can persist without needing a FW change around this DT binding.
> 
> My belief though is that the majority of users would have this property set to 0
> by default in OTP, so a boolean would be OK I think here to enable watchdog
> shutdown.
> 

Sorry, you lost me.
	dlg,wdt-sd = <0>;
is the current situation, and identical to not having the property in
the first place.
	dlg,wdt-sd = <1>;
is new. I don't see the difference to
	dlg,wdt-sd;
vs. not having the property at all (which is, again, the current situation).
Since it has to be backward compatible,
	dlg,wdt-sd = <0>;
will always be identical to not having the property at all.
I can not find a situation where an integer would have any benefits over a boolean.

Guenter
