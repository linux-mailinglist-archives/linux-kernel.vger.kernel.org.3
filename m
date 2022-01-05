Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9748563F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbiAEPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiAEPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:53:06 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF8C061245;
        Wed,  5 Jan 2022 07:53:05 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r131so1047674oig.1;
        Wed, 05 Jan 2022 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kxTc5oF0m/jCeg55cpMiw03himnlyOBY5YgtcF+TpkE=;
        b=cP+Sb9AkokqDWUbUOITE/CvWQ01hkKy1Ai2BUFuMaDvTq8dwlA68ARR8ZuLKkJHW/p
         i5WyCncILBT4e/xGFwLZ5ENbGQ8W0dB0+3pknmHRqHcbFF6hq15ZmsM/eZDwX0pdTepS
         EEEE/JyHjlm7XV6ELZ3NRV6N5sq5kxeCB0DCQzYdwvtAMxz5kIOnhbgLR0OxaKLkO1dV
         iGCCX1JKtH1WGTabDqaBZUcbOWf4/Nfhs2Z9+VziUxtPZ/Ys2iMjtXcB5LmNCNJbY1v2
         MjRGoKOUzjYF9xGsRviz3gIxJ8fbvB3Q+BK+x06XZhHl8IxK4oWIdcxmRpR+txXVjGoU
         fLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxTc5oF0m/jCeg55cpMiw03himnlyOBY5YgtcF+TpkE=;
        b=fSr8YmbiB0b6k6VuIw6Wls6csvedCEPOrp9SEmzrtgFGaPz025tKdS3oYIU8vY4+LT
         JpaKYx3rMQz0hi3TBpc1EEhCF3i2aM4pO7bgNxnjGfh9+SWs1mG/PU2tvg+R5tRZtqou
         w1wt8+/nkh12jMsItrc6eP23V7xl8ibEjidwQl3gWrK1WcbU5Ke4UGqQfYi/4HxN+XN2
         ujgNU1RZZJmgyg6CgW/Pxegdyavc+lAZ9xTaWk6R14JEw+7RJAo1j8oOwzP06Y9CW8H5
         1hoqFUmMBSXlapH+bG1xCTnr9tHIPf0UsYxjF8OW7rv9oleUdTu83Q6BsVljpx3LC9dy
         o4iQ==
X-Gm-Message-State: AOAM533OREPBRRH3LwgCpWEkasZRNFbLQUQMuUeka1TJV3GwhF0e/g/7
        mkaFvPItxUTn+ZGQCX8X9VLR/lDmmdw=
X-Google-Smtp-Source: ABdhPJwhivJ5YLULoVD5dbqH9mpAxQYe5aAc6j/IbPIYAOEgXPM+qpMMxw7M2Pb7YQ9mGZxuXEHaRA==
X-Received: by 2002:a05:6808:1246:: with SMTP id o6mr2986307oiv.73.1641397985056;
        Wed, 05 Jan 2022 07:53:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w29sm8489493ooe.25.2022.01.05.07.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 07:53:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
To:     =?UTF-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
References: <17803809bef1499fb051cf79fc3c7245@cqplus1.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8af9cf3d-c048-b9ed-0bac-832ee262917d@roeck-us.net>
Date:   Wed, 5 Jan 2022 07:53:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <17803809bef1499fb051cf79fc3c7245@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 6:50 PM, xt.hu[胡先韬] wrote:
> Hi Chrustophe,
> 
> 	Thanks for your respond.
> 
> Best Regards,
> Xiantao
>> -----Original Message-----
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> To: Xiantao Hu <xt.hu@cqplus1.com>,
>> 	wim@linux-watchdog.org, p.zabel@pengutronix.de,
>> 	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
>> 	linux@roeck-us.net, robh+dt@kernel.org,
>> 	devicetree@vger.kernel.org
>> Cc: wells.lu@sunplus.com, qinjian@cqplus1.com
>> Subject: Re: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
>> Date: Wed, 29 Dec 2021 10:39:08 +0100	[thread overview]
>> Message-ID: <0b102fa0-cbfc-a97e-8e7f-cce8146450bc@wanadoo.fr> (raw)
>> In-Reply-To: <20211229054308.63168-3-xt.hu@cqplus1.com>
>>
>> ...
>>
>>> +static int sp_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct sp_wdt_priv *priv;
>>> +	int err;
>>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(priv->clk)) {
>>> +		dev_err(dev, "Can't find clock source\n");
>>> +		return PTR_ERR(priv->clk);
>>> +	}
>>> +
>>> +	err = clk_prepare_enable(priv->clk);
>>> +	if (err) {
>>> +		dev_err(dev, "Clock can't be enabled correctly\n");
>>> +		return err;
>>> +	}
>>> +
>>> +	/* The timer and watchdog shared the STC reset */
>>> +	priv->rstc = devm_reset_control_get_shared(dev, NULL);
>>> +	if (!IS_ERR(priv->rstc))
>>> +		reset_control_deassert(priv->rstc);
>>> +
>>> +	err = devm_add_action_or_reset(dev, sp_reset_control_assert,
>>> +				       priv->rstc);
>>> +	if (err)
>>> +		return err;
>> This looks odd.
>> We could undo something that was not done. (if IS_ERR(priv->rstc))
>> This is also not really consistent with what is done in suspedn/resume.
>> In these functions, we don't check for IS_ERR(priv->rstc).
>>
> 
> Here I refer to mt7621_wdt.c. I'm sure I need deassert reset to reset
> watchdog register value when driver probe. accordingly I assert reset
> in devm_add_action_or_reset() to ensure that the registers of watchdog
> can't be operated after module remove.
> 

You are missing the point here. This is called even after
devm_reset_control_get_shared() failed, and it is called even though
the reset was not yet deasserted. The above code should be called after
(and only after) deasserting the reset.

>>> +
>>> +	err = devm_add_action_or_reset(dev, sp_clk_disable_unprepare,
>>> +				       priv->clk);
>>> +	if (err)
>>> +		return err;
>> Shouldn't this be just after clk_prepare_enable()?
> 
> I tested the order of execution of the added functions which is similar to
> push and pop. First in, last out. I think I should disable clock last.
> 
Correct. That is why you have to call devm_add_action_or_reset on disable_unprepare
first, because on driver removal the devm_ cleanup will be called in reverse order.

Guenter
