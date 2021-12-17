Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD54790EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhLQQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhLQQFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:05:20 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD769C061574;
        Fri, 17 Dec 2021 08:05:20 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so850575oog.2;
        Fri, 17 Dec 2021 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+RYYMyAC255ngvKr7ej8GXX/5rfv/bQjmLP0iJ8A7I=;
        b=AiESwx+UVSv/jxu2pyy+csFCKtk7b2SwG1h1a9ORfhSYnJntga5tQSu+KfXLIL0Rn/
         FnpkyTirsKY7JArj3n+ZVvROW5D3lFJce43btcxVIwouBD6WoYHewQ2O8OpA/hHvxlHB
         AF/dCe/U+7d39cJE955XqjrYfcGEK+TVfVyfN8K0bPECIXq2ISnxg4CCA6LtMwCL5p6D
         Hry7G+ac6C6ZkBYISfUqUqJf09JEmDBW58XpTngCjAn0Ku222ALtWanzBQZN7AB5aAEP
         CNQp/Ni4c7lEBRFY3d4GjXeiB+xGoPI8sMP40d0H5Yyr9FM5u8jYWDDeKpgCQcyBrwLg
         NMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+RYYMyAC255ngvKr7ej8GXX/5rfv/bQjmLP0iJ8A7I=;
        b=FSbMebMi0NOht4l1QQDKV/+15o/K54gPXiCpf2NNSG+xi0woQrfxaKKishlU2sj0Xc
         5Trn7JdCPi4FumohQO9zYZfpcGYs8QTKyiDsJEkD87ds+hZcRlMu/F7R1YQGQRZ64PxZ
         nO8E8NifLoEuKrrw22SuQHEenf36T+4NYEOuSRPM54lcLaFGajNlgDnY3FMCgXbvtM2W
         ZenAta0lEu+NKFr3k7598pyjPk/A3cpuW3wVwftwG0oVgybUaeN7jpzpeOSftmGDT9gb
         UMqQI2hqyJvbLAChz7zYYW98ZTZLf1J1Ac4JCiWJDlPTxDTGfBs6x/q5Hkfs3B/g1cK/
         RBUA==
X-Gm-Message-State: AOAM531PsR4kTmJC3Qw9v+v/KOE2LWAWLDfJuLNqfTml1/z1wp/gRhiT
        Cs3MDJykvzO0Z4L8xI88oj3ooUMB6Xo=
X-Google-Smtp-Source: ABdhPJyfkek1rEfr2BN6NY2jDcuv+eDhmSrtGdXKBkTC4n7SQ02w7Cuo/aP3r8aIzIg86nqLv8alEQ==
X-Received: by 2002:a4a:d47:: with SMTP id 68mr2381251oob.92.1639757119848;
        Fri, 17 Dec 2021 08:05:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm1643616ota.76.2021.12.17.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:05:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arseny Demidov <arsdemal@gmail.com>
Cc:     rahul.tanwar@linux.intel.com, Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211216083302.986-1-a.demidov@yadro.com>
 <YbtK4mHxpdF5VtOk@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a93a4cc-5b37-4524-add9-541bfbe3980e@roeck-us.net>
Date:   Fri, 17 Dec 2021 08:05:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbtK4mHxpdF5VtOk@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 6:19 AM, Andy Shevchenko wrote:
> On Thu, Dec 16, 2021 at 11:33:02AM +0300, Arseny Demidov wrote:
>> In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256,
>> the correct value should be 0x100. The register ip_tmr is expressed
>> in units of IP clk cycles, in accordance with the datasheet.
>> Typical power-up delays for Temperature Sensor are 256 cycles i.e. 0x100.
> 
> Should you provide Fixes tag?

Yes. Also, please update the subject. This is not about "fix macro typo".
it fixes a wrong/bad delay value.

> 
> ...
> 
>> -#define POWER_DELAY_CYCLE_256	0x80
>> +#define POWER_DELAY_CYCLE_256	0x100
>>   #define POWER_DELAY_CYCLE_64	0x40
> 
> I;m wondering why they are in hex? Perhaps the decimal is better for both.
> 
Maybe, but that is POV, and I tend to leave it up to driver authors to decide.
It is definitely not something we would want to change as part of a bug fix.

Thanks,
Guenter
