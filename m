Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D904BBBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiBRPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:07:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiBRPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:07:44 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4517E95F;
        Fri, 18 Feb 2022 07:07:26 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n6so15224244qvk.13;
        Fri, 18 Feb 2022 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZhgMN9Y8qBcc8YGa9U6sLk3eYcQWBNZevK+546EBJ1k=;
        b=qIQG3afKmJFnM9d3UiPVX2r/wN+GvKrRzK9THFQwXH7zo8J0hGAPaVTzGJG3XLQFSJ
         UQuRKlMxrk6pfFphfO72D78g3ZlzMzxFMxzY73RGTBbG13vrPxs8+nlwKpF2kBVqwexF
         jxhcBxYU18xdnW0+wS+LTM8e9j8ipOAbb1X7nlb864lcUZLCYBManADJ8Zx1PMq9cOXt
         ySZ6g0v5SfGozDHhNoO0xTQWq07i9pRQ8dFcZLKUsYsCInYH1oyKITrlWswW9XAohpEW
         Wd7VIuftDM6nlCOyvLBoqlhZdFcE7fui9ZxrdVqM+LBJ8BTRniMAU47qeTCd8M2VynLx
         1UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZhgMN9Y8qBcc8YGa9U6sLk3eYcQWBNZevK+546EBJ1k=;
        b=oK0U3G0rr8PNkJcYN4aRsToQDtV2fOArPMj4To+B6G8dt54ADWw/ly5mwnlo/ss4GB
         5l113q7LL15Foe195ijIzq1/mqrmhPXl4dyQoUuWeF5OyEzESVtOze5JENCEXqomCdoX
         MFK7nIFMf5l1NGVEsSwmOt2iwi9GiEzw5ZC7hpLN3xMtR/Pc4f88dDOBwUPjZeA/XT+x
         h7wOzN5SwvDpH9Z5lGWlGmWYI4hfZh/esRNwAvEpNiwf98hvWLom5oikUQ21pj1v8Jks
         wQ1uZJTt30QuZWd+hsORVbfmduBIGK+H72kQG7qLsVbH/Ef/J3h238KkYk/LE7hlb5dQ
         YQsg==
X-Gm-Message-State: AOAM530BUuEPHQpoVhySrhmNIvMYpnmsYcT0XhlXwuT7qU5qv1z5QY6s
        YP3XTDySEVonT3RtfpE0CXU=
X-Google-Smtp-Source: ABdhPJxPj6KFAgVZSXo8bZyFDqRGlFPG7D+gFGABIvifLDj63FEusJTipGPOb92u+mICxFnGhItHvg==
X-Received: by 2002:a05:622a:164f:b0:2d5:8e77:8050 with SMTP id y15-20020a05622a164f00b002d58e778050mr6994063qtj.481.1645196845785;
        Fri, 18 Feb 2022 07:07:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17sm25490999qta.11.2022.02.18.07.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 07:07:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c0b1562-aeca-52d1-96cb-93e4a252604c@roeck-us.net>
Date:   Fri, 18 Feb 2022 07:07:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220218065856.1899086-1-linux@roeck-us.net>
 <20220218065856.1899086-2-linux@roeck-us.net>
 <bb9d1f78-7f4d-a865-922e-ebf7362f6b64@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <bb9d1f78-7f4d-a865-922e-ebf7362f6b64@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 01:50, Agathe Porte wrote:
> Hi Guenter,
> 
> Le 18/02/2022 à 07:58, Guenter Roeck a écrit :
>> Add support for Texas Instruments TMP464 and TMP468 temperature sensor
>> ICs.
>>
>> TI's TMP464 is an I2C temperature sensor chip. This chip is similar
>> to TI's TMP421 chip, but with 16bit-wide registers (instead of
>> 8bit-wide registers). The chip has one local sensor and four remote
>> sensors. TMP468 is similar to TMP464 but has one local and eight
>> remote sensors.
>>
>> Originally-from: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v4:
>> - Fixed reading n-factor information from devicetree
>>    [Use of_property_read_u8 instead of of_property_read_s32 to read the
>>     property value, and write n-factor value into the upper 8 bit of the
>>     n-factor register]
> 
> Changing n-factor with DT seems to work:
> 
> temp2_input=38500 (nfactor=10)
> temp2_input=35500 (nfactor=-10)
> 
> Driver probes just fine with this attribute set.
> 
>> +static int tmp464_probe_child_from_dt(struct device *dev,
>> +                      struct device_node *child,
>> +                      struct tmp464_data *data)
>> +
>> +{
>> +    struct regmap *regmap = data->regmap;
>> +    u32 channel;
>> +    u8 nfactor;
>> +    s32 val;
> 
> val is not used according to the compiler, and thus should be removed (module does not compile with -Werror)
> 

Fixed.

> PS: TMP464 samples will be sent by DHL today and should arrive to you on Feb, 23rd.
> 
Thanks a lot!

Guenter
