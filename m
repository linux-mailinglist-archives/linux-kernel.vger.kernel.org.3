Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7446211E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbhK2T57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhK2Tz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:55:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FAC07CA20;
        Mon, 29 Nov 2021 08:18:38 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m6so35606913oim.2;
        Mon, 29 Nov 2021 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N417LwmoteEpLw0/alZmqR2O+gPqKzTspenGXxKY7N0=;
        b=m7UHSKLOVjOM7y+LuL9980vJ30xbpJssiYQbA9wU1ShVfCUFv5x4Mjf/icFLXlRZmG
         r6J/UPYGDM2ZSil1ot3/kvwDwQAnGchI2PWt3aaEih15jT/1Mv+/EPZtClOiTw1CZAnB
         IVkddThv03/usS+Vob1eXCySU/8PxrQQ86SB4jvWrOx12DM+Eni39ki1FaVUBb2tsneA
         p3+qe7dBtaY2pPlOFJKb0lIrKM45E58s2S6zO2PNx06xyptJvfXr/a21/v9XmwVm29p7
         EERDCpBdhvant2AEZrjWzs14QbwqOAcwMYLa5C5Ew5Vj6kJkVkTH6inOvD3IEa6QbX8g
         X9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N417LwmoteEpLw0/alZmqR2O+gPqKzTspenGXxKY7N0=;
        b=d/9lSZ/o1/jTcC3NoIfg2xCJ/XUs18M/L02KqmTtipnwpQiVdddTDKGAMqe0BpPFkQ
         7PAPgy75g+ZiOfOlxMdH9YCEGOUv2+2xum6H4ew/bjMRdMYsslDezyjuwVPZqkntP4L1
         ejkPiGuj6ohiN50CICNGnnp5AsufE4npr+MMfQBVd4f8Hn6vx6vpMUuKQh42IQdi0/on
         Q4E3GFqGVWbEl9tQayKc8GwdRBSSVIGXmHgmDt6XQI7aye6vjoafDVzvYwkICvG+IzFb
         6McotW3DGLJ5XdnxVrhTW5j64U9Rhu7cxBEvVqnMmwfdxmL8f6NNtF+NI8D8h75aL3Vj
         zFPg==
X-Gm-Message-State: AOAM530GvG71ssz2wwkMdBlCwez2nFQLOJRd7mI67gWi87DuCnUvplHe
        x4Gkq6ox8Lx1La37UsBo2u72LgRI3Ss=
X-Google-Smtp-Source: ABdhPJyhS4x1H6+R4piCkf/zaDbqnQlCe+fibbDdsjWk/w+3PrsBMQV8sGAxmuzeSioizHmiqXRPPQ==
X-Received: by 2002:a05:6808:a03:: with SMTP id n3mr40398231oij.125.1638202717249;
        Mon, 29 Nov 2021 08:18:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w18sm2706411otm.1.2021.11.29.08.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 08:18:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 8/9] watchdog: max77620: add comment to clarify
 set_timeout procedure
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211120155707.4019487-1-luca@lucaceresoli.net>
 <20211120155707.4019487-9-luca@lucaceresoli.net>
 <20211129160414.GA3014810@roeck-us.net>
 <0e08d0e0-489c-342b-4fa4-d4457af20a65@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f05f33ae-d0be-fcf2-0774-c7d0dbda3d36@roeck-us.net>
Date:   Mon, 29 Nov 2021 08:18:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0e08d0e0-489c-342b-4fa4-d4457af20a65@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 8:08 AM, Luca Ceresoli wrote:
> Hi Guenter,
> 
> On 29/11/21 17:04, Guenter Roeck wrote:
>> On Sat, Nov 20, 2021 at 04:57:06PM +0100, Luca Ceresoli wrote:
>>> Clarify why we need to ping the watchdog before changing the timeout by
>>> quoting the MAX77714 datasheet.
>>>
>>
>> Unless I am missing something, this adds confusion instead of clarifying
>> anything, and it is misleading. The added comment in the code makes it
>> sound like clearing the watchdog timer is only needed for MAX77614.
>> However, the code was in place for MAX77620, suggesting that it was needed
>> for that chip as well and is not MAX77614 specific.
> 
> You're right, the comment comes from the max77714-only driver, but now
> that it is in a multi-chip  driver the confusion started to exist.
> 
>> Please either drop this patch or rephrase it to clarify that it applies
>> to both chips.
> 
> What if I rephrase to:
> 
> 	/*
> 	 * "If the value of TWD needs to be changed, clear the system
> 	 * watchdog timer first [...], then change the value of TWD."
> -	 * (MAX77714 datasheet)
> +	 * (MAX77714 datasheet but applies to MAX77620 too)
> 	 */
> 

Sounds good.

Guenter


