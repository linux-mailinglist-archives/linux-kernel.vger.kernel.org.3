Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F65A51B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH2Q2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiH2Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:28:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D598A63;
        Mon, 29 Aug 2022 09:28:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q15so3314925pfn.11;
        Mon, 29 Aug 2022 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=gCZZsnbKqIn6Pul+FARDO4ikZmQMWaCl2U0vMfz40Lw=;
        b=NliKrb0KmMdFjqeWvmk/hW6UCpph7Vkc3ZKnZ0W5VaJHKer0ZAsAuLL5XRNaC9GhLZ
         LPqIohiEy/i36W5HJ6NbTRyu7CPWml6C5DPixaIlwXc2P6Z/csXi8cEe4njG8cUQDGgH
         R6T2NgYG1fDvz8SotqNv5fGbzcWUj7ovg8O+irrqoviUctR6kTjTmA7yTCuvj3jq2Agd
         1d605imz0wDaX5QSz2Sigcomfl00RIX7HhBT5aFiJ5yQ6w1X61adeFYSMWcH0QEbM1Or
         b2epz7hUQZp4Wrl6uNuExKmHDUyivKGPvFh7a0vgLM9jBfzyB9cjlj7AA81Cy+OufdUO
         +0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=gCZZsnbKqIn6Pul+FARDO4ikZmQMWaCl2U0vMfz40Lw=;
        b=lY6qRAGqr4adokXrPCBPXZkjN4RSQbfeDb7q9j5ypPESV9f9uD3FmwujuvD9L5ergF
         s4NQ4Y7mI1PDovcvFHAIdQrOBjICtoesCLJ+QXJ2ODt9wdenIf6ahFQxHm/TSx6bsHD3
         8pCtELeID9LdweOAol4iOohP+5fbtMc6Nf91uSpdmEVdXDhsrKrvEsIK2Jitmmy3vTRU
         zSj8cfRyhs4JPkdQ8BZm4phNPWQMQLYr39nDwq+3IBTSdKs3aRMNU5oFWgr9r9+1UTAp
         LrhxUV3olZbkruaMWOHbZBOAlSu49Dc9dnh/Nk+DeF4AiWYUcIIszkp31yMLfrRL15RK
         56NQ==
X-Gm-Message-State: ACgBeo2TGHhAurihieeQuUJa39k1lX5gY1GgNEXlLsr3UhS0WnyswlqI
        2iW/UkoNqgPzXCBP56RFui6r4zVLtXWa3Q==
X-Google-Smtp-Source: AA6agR7l4fnmZgzT4CW8hKUqnsTD93wuUW9Tcg0UvC0CsZpOSqxVnvo+PI9cF8476jisS3+5qd+uXQ==
X-Received: by 2002:a05:6a00:170a:b0:537:4212:5f5d with SMTP id h10-20020a056a00170a00b0053742125f5dmr17154647pfc.40.1661790496514;
        Mon, 29 Aug 2022 09:28:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i196-20020a6287cd000000b00537dde5ff7csm6196855pfe.176.2022.08.29.09.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:28:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1ea7ac6-092e-07de-0c51-eee7e13e34ee@roeck-us.net>
Date:   Mon, 29 Aug 2022 09:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwmon: (nct6775) Add Asus PRIME Z390-A to WMI monitoring
 list
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Kurkela <Matti.Kurkela@iki.fi>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9f3cef03-6efd-138e-8552-e3078ed9b4f7@iki.fi>
 <6015717f-baea-7baf-e834-bb087f34819a@roeck-us.net>
In-Reply-To: <6015717f-baea-7baf-e834-bb087f34819a@roeck-us.net>
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

On 8/29/22 09:25, Guenter Roeck wrote:
> On 8/28/22 07:43, Matti Kurkela wrote:
>> Asus PRIME Z390-A (and presumably other Asus Z390 motherboard versions) also requires the nct6775 chip to be accessed by the WMI method. Add it to the asus_wmi_boards list.
>>
>> Tested-by: Matti Kurkela <Matti.Kurkela@iki.fi>
>> Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
> 
> This is your patch. You should have tested it; that is implied in Signed-off-by:.
> Tested-by: is not appropriate.
> 

Also, your patch didn't make it to patchwork, presumably due to a formatting
problem. I would suggest to check your formatting and make sure that it is
set to plain with no formatting options. I suspect that patchwork doesn't
like

Content-Type: text/plain; charset=UTF-8; format=flowed

Thanks,
Guenter

>> ---
>> Should apply to any kernel version that includes the commit c3963bc0a0cf9ecb205a9d4976eb92b6df2fa3fd
>> (hwmon: (nct6775) Split core and platform driver).
> 
> This is irrelevant; it is a functional change and will be applied
> to linux-next.
>>
>> --- linux-5.19.4/drivers/hwmon/nct6775-platform.c.orig  2022-08-25 12:45:54.000000000 +0300
>> +++ linux-5.19.4/drivers/hwmon/nct6775-platform.c       2022-08-28 16:28:09.531738685 +0300
>> @@ -1054,6 +1054,7 @@ static const char * const asus_wmi_board
>>          "PRIME H410M-R",
>>          "PRIME X570-P",
>>          "PRIME X570-PRO",
>> +       "PRIME Z390-A",
> 
> checkpatch says:
> 
> WARNING: please, no spaces at the start of a line
> #77: FILE: drivers/hwmon/nct6775-platform.c:1057:
> +       "PRIME Z390-A",$
> 
> 
> Please fix.
> 
> Thanks,
> Guenter
> 
>>          "ROG CROSSHAIR VIII DARK HERO",
>>          "ROG CROSSHAIR VIII FORMULA",
>>          "ROG CROSSHAIR VIII HERO",
>>
>>
> 

