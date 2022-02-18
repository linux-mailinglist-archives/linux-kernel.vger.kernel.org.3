Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EFE4BBBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiBRPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:06:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiBRPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:06:56 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECF64F8;
        Fri, 18 Feb 2022 07:06:39 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id f10so4063729qkg.9;
        Fri, 18 Feb 2022 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p9R4Qbl1+Fke2USVYBHOXtByycRkBlwvs/en1SwU+yY=;
        b=Tl8dQyBGtTQFt6p3x17y1IbiNg6fWCjxF+z4FvgOb95smC9cy6zRRfEGncEBf1lYHL
         zgXtBjq+a+eq4McOh7/D0GPSOa320B57fhxQk7/qD2VwfQg1gZymAhgzuUu3tktYfetZ
         Q5uMe7H9LGJuVFzH8vxZG25AVfHbvJhy23P9YotFMZdvCw7r3eE6Ml9XT8Q7rSq+4Vsl
         xc6N2PVZg1z20Jw3aPw/nQg1zPz97PSulvHTh+EWqJJf5pq5USbEZZPSWvt7JjJ4MHnl
         04PMvLEKYBvXPoCjTC5Hm+kcyl5tToPdQTySumYm843NRvBq1Plq/Pd+3cTo+U+tMSnV
         5LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p9R4Qbl1+Fke2USVYBHOXtByycRkBlwvs/en1SwU+yY=;
        b=T0fC/t+qIOU6tuNzfvSco1oSCIk55kAVpfNBQh9H5SpBqlYBtrFeUimAW2xiuL4JLr
         RTeAEJZ7aPrGTY/yzA/lNi/qxdEnY4PJqE5loPmcBz2lR/vUBlPdURpKqWZJhInVUh4y
         PhXv+1JtC5B6bZdLc2OJ+EPlGwmE/7szXyazoOKfgij9FHgc3kSleKPkfFrOXIVTBOMV
         IEN24g7A5clO1vPIraFgiDDOTcVk9WYKv9KHnM04OT+QsvJrsDyb8AGyFg7s2DnaJV41
         4E42rb01TkCwkHCfeZ0ObWLrn+zX031ihrR0s3Sy6tk9z/SlcrKktmALy81G6vJLRVz6
         O72g==
X-Gm-Message-State: AOAM533gFxdXIoiy5dQ1HhrKnpcoi4FPI5tZ2I0TAXJVpBEHyuUNOQgk
        QxG5X95+JJcxGfglyC8Ptzk=
X-Google-Smtp-Source: ABdhPJwQkiB/rQP8ZOfhhYoYc1AfwVl+tt/gpiSIQWKLCM2/tgvrrSYLFfQNTnH9ZYJqbTIR8JUlcA==
X-Received: by 2002:a37:63cf:0:b0:60d:274b:5211 with SMTP id x198-20020a3763cf000000b0060d274b5211mr4801529qkb.725.1645196798491;
        Fri, 18 Feb 2022 07:06:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10sm1168531qkf.46.2022.02.18.07.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 07:06:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f5236a5-93be-a35e-e86a-450e5e98f9ba@roeck-us.net>
Date:   Fri, 18 Feb 2022 07:06:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: add tmp464.yaml
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220218065856.1899086-1-linux@roeck-us.net>
 <a828b1b2-9e32-57b2-6d60-b1b8de90222a@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <a828b1b2-9e32-57b2-6d60-b1b8de90222a@nokia.com>
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

On 2/18/22 01:41, Agathe Porte wrote:
> Hi Guenter,
> 
> Le 18/02/2022 à 07:58, Guenter Roeck a écrit :
>> From: Agathe Porte <agathe.porte@nokia.com>
>>
>> Add basic description of the tmp464 driver DT bindings.
>>
>> Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
>> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v4:
>> - No changes
>>
>> +        channel@0 {
>> +          reg = <0x0>;
>> +          ti,n-factor = /bits/ 8 <(-10)>;
>> +          label = "local";
>> +        };
> 
> Setting the n-factor for the local channel is not supported, so we should remove this attribute for this example and move it to another channel.
> 

Done, thanks!

Guenter

> Here is the output on a hardware test:
> 
> [165599.122883] tmp464 16-0049: n-factor can't be set for internal channel
> [165599.123833] tmp464: probe of 16-0049 failed with error -22
> 
>> +
>> +        channel@1 {
>> +          reg = <0x1>;
>> +          ti,n-factor = /bits/ 8 <0x0>;
>> +          label = "somelabel";
>> +        };
> No particular issue when defining a property for channel that is not internal during driver probe.
>> +
>> +        channel@2 {
>> +          reg = <0x2>;
>> +          status = "disabled";
>> +        };
> 
> Works as expected on target:
> 
> root@fct-0a:/sys/class/hwmon/hwmon2 >cat temp3_input
> cat: temp3_input: No data available
> 
> Best regards,
> 
> Agathe.
> 

