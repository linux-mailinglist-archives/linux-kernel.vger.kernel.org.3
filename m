Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED84A7BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiBBXV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiBBXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:21:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD4C061714;
        Wed,  2 Feb 2022 15:21:53 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u13so1316341oie.5;
        Wed, 02 Feb 2022 15:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hdKH4tXgHY4cT+RB1bvOiaNomE0XVykpxJcXrke+vqk=;
        b=ahUVIzCsG7UmQFv3UKQdrfqui2QGTQZCBFE9qIIRoJBK/Vi4phbSMT5axQxpfxM2PD
         X2L6P853sHMqI3KozRMWBLaotNA80PqAfd0KUZnliq/4RH59DfN098IYFPaTF00s4gPo
         ZPFgIYIkGGzpvCmdfizsRx1LDy2MeRNNIS7gcen9Ab5iGv4LdIVL0iGyAvzR7MV718hj
         D8f5TqjhePo6h2EzeAfl41GFuNptREP9wDGvr5ksdFboplULvmcaOgpAZtj44A6f2TmV
         27gTnWUDzQpK6hM02lcHNuNCNCtcwh2/+noRaDkbuNq9FjHDnGSnyM5RLTlgOeydJ6II
         r+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hdKH4tXgHY4cT+RB1bvOiaNomE0XVykpxJcXrke+vqk=;
        b=6DMBLcu+mAAJHHOgZjepk0XHKhBzIfGCYSlkS7DwkwX7iNKXLURtOMhAixnTwuZUuY
         6jCLl2aTGsAALTKeCVV6NVA7x/Y2dMzbakShKqSnVIU8NxXxC46z0subif5Ixd9w7XLl
         ULGAYOb8OVnDuKNgDJa1mq2KRew2u1a5MP44K7H5AUeGiFFZHu0U81QXD37Bp1PDlo5p
         ePA9/t8kiQRoRdRrzEzqHKgWiQ0jtft+ELI+JLkhLwrB3S76jSbV63uOhQQMo7goK6An
         TGW0ts8rptf/St6GUvBzbDEGJsq8i/r/PWgBACxfzJT05UxWV5tTUF0tPDt4ZkntbCE4
         yjNw==
X-Gm-Message-State: AOAM530HrLlBm20p0tqZD4KKEWKeKVr/mK3Trq+jjpyUrtXNyXODc2uY
        oIoNzDBD66ss0GWteIA2cJk=
X-Google-Smtp-Source: ABdhPJyF9ihmFyrP/iAi+4muZGLyMY6QrV946GJop1i1WoECKvVAUcx7ezlVj7IYKEUkVl2UcXpFNQ==
X-Received: by 2002:a05:6808:1aa6:: with SMTP id bm38mr5803076oib.109.1643844112525;
        Wed, 02 Feb 2022 15:21:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11sm15250609otq.69.2022.02.02.15.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 15:21:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ce016f8-fb4b-ef50-c543-886b4cfda225@roeck-us.net>
Date:   Wed, 2 Feb 2022 15:21:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net> <202202021409.2AA6A4246@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <202202021409.2AA6A4246@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 14:11, Kees Cook wrote:
> On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
>> On Wed, Aug 18, 2021 at 01:11:17AM -0700, Kees Cook wrote:
>>> With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
>>> coverage, it is now possible to enable -Warray-bounds. Since both
>>> GCC and Clang include -Warray-bounds in -Wall, we just need to stop
>>> disabling it.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>> Cc: linux-kbuild@vger.kernel.org
>>> Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>   Makefile | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index a4aca01a4835..af22b83cede7 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1072,7 +1072,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>>>   
>>>   # We'll want to enable this eventually, but it's not going away for 5.7 at least
>>>   KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
>>> -KBUILD_CFLAGS += -Wno-array-bounds
>>>   KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>>>   
>>>   # Another good warning that we'll want to enable eventually
>>
>> alpha:defconfig:
>>
>> In function '__memset',
>>      inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
>>        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>> In function '__memset',
>>      inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
>>        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>> In function '__memset',
>>      inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
> 
> Ah! With Arnd and Nathan's help, I saw:
> https://lore.kernel.org/all/20210912160149.2227137-3-linux@roeck-us.net/

Guilty as charged. Sorry, I didn't try to analyze the problem,
or I might have noticed (and saved you some work).

Guenter

> which is solving the same problem (just manifested through different
> diagnostics). The same solution works here. I'll get the patches sent...
> 

