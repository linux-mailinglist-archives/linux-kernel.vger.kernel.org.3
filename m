Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1A554356
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351833AbiFVG4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiFVG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:56:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2E855BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:56:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so15863401pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=H9Q+6TcB54BTdw1TZgpEIKdLHEZXFlF8aDl9td7310U=;
        b=BjhC0Df9Jo86rj8WcdrxSUmhjqjSOxSilp7u3KgsFTlGv/dCDTmjZSLhXn4aNl7SBT
         GnTfeuZFC+v17uwzhSlWY64QsDhpAFt4hr5elfNqLl43XWJVOm8N2NALcrCu375xo63C
         thxpRgTzjroSZbO13bF/5glDma+mOFAq1l7pEo3oa3ybZB0XCP3rZiJGJT4M8M1hsRG7
         DYGm1rEFp9ia8nou+YSjhIH3+YVd7/jD2W/mIhLsIMXjdnguSsa05clqXMPW/iY8oZtN
         QXhcXh3KO0QKbf9L3Wr142+9WFftoe8MRYXQKKJHf24rM8TDCPulAgdntpc3JNe5hcib
         mPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=H9Q+6TcB54BTdw1TZgpEIKdLHEZXFlF8aDl9td7310U=;
        b=ZufbKwXD3vaXQudpKwmo6O9aTPHG2ukfXxWXqmvibhCFiw+tqgvLz4AjKB3W97+DI8
         PiH6hccqZenp32kr9mInwd4o4y7Ggns2NJbbXTGhorV7cF9/9iOBYJ4G6b366L7aGCc1
         VtsKKjuj6recA3YZeQtGI7zwTcZHqHM+MRFTZSrLcwVARa03QQnwOZaKcQLvXQx/mpMZ
         RobUFoxDSz7FVZgGSgnDGFiJHOLzfhDX0OA+cFSMtRr1X1xFv06L6kR4TuCMiFD5w4nT
         QyUUtQ+IrqAf78BQASw4XqRic7tlLuvUQPB5zt+Py8ImayHDsFZzftvRuqWCjqRx9opc
         6l7Q==
X-Gm-Message-State: AJIora8fTT2IArVhPFV6t8kG9GZz2wcUBVVyFDhFu+jsR73oHS8ttvqt
        zI/tdhpdGn1Z9R3U++9CQbX2jg==
X-Google-Smtp-Source: AGRyM1u+nUb9A780sPduNLb9PjFWf7l/pcFip0Cbi57M+dJh75DbzQZiyoTuWfRS8hTp9c3llApXnw==
X-Received: by 2002:a17:902:cec9:b0:16a:416c:3d27 with SMTP id d9-20020a170902cec900b0016a416c3d27mr4153397plg.107.1655880970715;
        Tue, 21 Jun 2022 23:56:10 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b00161ccdc172dsm6630239plr.300.2022.06.21.23.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 23:56:09 -0700 (PDT)
Message-ID: <ba973bf8-fee6-ba17-244e-32c00d6a06e4@ozlabs.ru>
Date:   Wed, 22 Jun 2022 16:56:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220429053329.2278740-1-aik@ozlabs.ru>
 <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
 <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru>
In-Reply-To: <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? It's about 2 months now :)


On 6/6/22 15:12, Alexey Kardashevskiy wrote:
> Ping?
> 
> 
> On 5/17/22 09:52, Nathan Chancellor wrote:
>> Hi Nick,
>>
>> Did you have any thoughts on this patch? It is necessary for enabling
>> LTO with PowerPC:
>>
>> https://lore.kernel.org/20220429064547.2334280-1-aik@ozlabs.ru/
>>
>> If you don't have anything to send to Linus for the next cycle, perhaps
>> this patch could be carried by the PowerPC folks with your ack?
>>
>> Cheers,
>> Nathan
>>
>> On Fri, Apr 29, 2022 at 03:33:29PM +1000, Alexey Kardashevskiy wrote:
>>> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
>>> a situation when files from lib/zstd/common/ are compiled once to be
>>> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
>>> even though CFLAGS are different for builtins and modules.
>>> So far somehow this was not a problem but enabling LLVM LTO exposes
>>> the problem as:
>>>
>>> ld.lld: error: linking module flags 'Code Model': IDs have 
>>> conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 
>>> 'ld-temp.o'
>>>
>>> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
>>> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
>>> POWERPC as explained at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
>>> but the current use of common files is wrong anyway.
>>>
>>> This works around the issue by introducing a zstd_common module with
>>> shared code.
>>>
>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> Changes:
>>> v2:
>>> * add a new module instead of inlining common bits
>>>
>>> ---
>>>   lib/zstd/Makefile                | 18 ++++++++----------
>>>   lib/zstd/common/entropy_common.c |  4 +++-
>>>   lib/zstd/common/zstd_common.c    |  7 +++++++
>>>   lib/Kconfig                      |  8 ++++++--
>>>   4 files changed, 24 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
>>> index fc45339fc3a3..440bd0007ae2 100644
>>> --- a/lib/zstd/Makefile
>>> +++ b/lib/zstd/Makefile
>>> @@ -10,14 +10,10 @@
>>>   # ################################################################
>>>   obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>>>   obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>>> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>>>   zstd_compress-y := \
>>>           zstd_compress_module.o \
>>> -        common/debug.o \
>>> -        common/entropy_common.o \
>>> -        common/error_private.o \
>>> -        common/fse_decompress.o \
>>> -        common/zstd_common.o \
>>>           compress/fse_compress.o \
>>>           compress/hist.o \
>>>           compress/huf_compress.o \
>>> @@ -33,12 +29,14 @@ zstd_compress-y := \
>>>   zstd_decompress-y := \
>>>           zstd_decompress_module.o \
>>> -        common/debug.o \
>>> -        common/entropy_common.o \
>>> -        common/error_private.o \
>>> -        common/fse_decompress.o \
>>> -        common/zstd_common.o \
>>>           decompress/huf_decompress.o \
>>>           decompress/zstd_ddict.o \
>>>           decompress/zstd_decompress.o \
>>>           decompress/zstd_decompress_block.o \
>>> +
>>> +zstd_common-y := \
>>> +        common/debug.o \
>>> +        common/entropy_common.o \
>>> +        common/error_private.o \
>>> +        common/fse_decompress.o \
>>> +        common/zstd_common.o \
>>> diff --git a/lib/zstd/common/entropy_common.c 
>>> b/lib/zstd/common/entropy_common.c
>>> index 53b47a2b52ff..f84612627471 100644
>>> --- a/lib/zstd/common/entropy_common.c
>>> +++ b/lib/zstd/common/entropy_common.c
>>> @@ -15,6 +15,7 @@
>>>   /* *************************************
>>>   *  Dependencies
>>>   ***************************************/
>>> +#include <linux/module.h>
>>>   #include "mem.h"
>>>   #include "error_private.h"       /* ERR_*, ERROR */
>>>   #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
>>> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
>>>   {
>>>       return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, 
>>> tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
>>>   }
>>> -
>>> +EXPORT_SYMBOL_GPL(FSE_readNCount);
>>>   /*! HUF_readStats() :
>>>       Read compact Huffman tree, saved by HUF_writeCTable().
>>> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t 
>>> hwSize, U32* rankStats,
>>>       U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>>>       return HUF_readStats_wksp(huffWeight, hwSize, rankStats, 
>>> nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 
>>> */ 0);
>>>   }
>>> +EXPORT_SYMBOL_GPL(HUF_readStats);
>>>   FORCE_INLINE_TEMPLATE size_t
>>>   HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>>> diff --git a/lib/zstd/common/zstd_common.c 
>>> b/lib/zstd/common/zstd_common.c
>>> index 3d7e35b309b5..06f62b2026d5 100644
>>> --- a/lib/zstd/common/zstd_common.c
>>> +++ b/lib/zstd/common/zstd_common.c
>>> @@ -13,6 +13,7 @@
>>>   /*-*************************************
>>>   *  Dependencies
>>>   ***************************************/
>>> +#include <linux/module.h>
>>>   #define ZSTD_DEPS_NEED_MALLOC
>>>   #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, 
>>> ZSTD_memset */
>>>   #include "error_private.h"
>>> @@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem 
>>> customMem)
>>>           return customMem.customAlloc(customMem.opaque, size);
>>>       return ZSTD_malloc(size);
>>>   }
>>> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
>>>   void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>>>   {
>>> @@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem 
>>> customMem)
>>>       }
>>>       return ZSTD_calloc(1, size);
>>>   }
>>> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
>>>   void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>>>   {
>>> @@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem 
>>> customMem)
>>>               ZSTD_free(ptr);
>>>       }
>>>   }
>>> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
>>> +
>>> +MODULE_LICENSE("Dual BSD/GPL");
>>> +MODULE_DESCRIPTION("Zstd Common");
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 087e06b4cdfd..33f3a7054cdd 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
>>>   config LZ4_DECOMPRESS
>>>       tristate
>>> +config ZSTD_COMMON
>>> +    select XXHASH
>>> +    tristate
>>> +
>>>   config ZSTD_COMPRESS
>>> -    select XXHASH
>>> +    select ZSTD_COMMON
>>>       tristate
>>>   config ZSTD_DECOMPRESS
>>> -    select XXHASH
>>> +    select ZSTD_COMMON
>>>       tristate
>>>   source "lib/xz/Kconfig"
>>> -- 
>>> 2.30.2
>>>
>>>
> 

-- 
Alexey
