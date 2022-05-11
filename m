Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61702522958
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiEKCDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiEKCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:03:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D250063
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:03:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n10so849230pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cP5FmXjlq+FjSzG2orzpi8SFHkiqJDo7U4sPxlJrap8=;
        b=JLYRDr+UbqKlC9VRE5gfHW5zz+XfdKywmeSpCavJt7byw8qBintSHgcm2AkW+fIWEu
         tC07peNb+xpmmqHYCgIQNozyut9BfIadxEdodiKdO054FtJhrMJbCazbwYDK0lnmnPfZ
         LoxumNdHrd0dj7FHO6KWG7WoS3kx/YOborewNErfF1KdHtC0dq5RaRYk4f6XrUt947wI
         ajME/D054BUNKCqQ0NsB1zBIqmlgSMkiqdEPm1djHSfzyAhRceP5lqd109EDeL+CIeq3
         twLlZbimAXkv41QHbGYrTIKBMr9nbP9+vwfrNtIGidD+TBGbPx2Hzrfy/A8f+ygZDN6/
         NJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cP5FmXjlq+FjSzG2orzpi8SFHkiqJDo7U4sPxlJrap8=;
        b=vWmzEsBOVyMgsp5eTo0hNFq+NzOt/NlkxVTwufirpo3pc6VKLEke/Pb7TrpZZhontZ
         UFGCd3YNqV8ZnCUFOQ6iTt5SV6dmeYvuGGqAjrkki0Nnd07fNqLPDYa4l80TiPVmxGt6
         0dOfut28Scov4/4/N/JgeHPFwOTqShy4RoBsyFh/DO6veEcz/AQADcWpN0WUk09zjPRX
         q9/0Y8wyeedPvS5mtw12YivODg2jbsosWY3zAW6qu/u+rHQK/3N59uakPUapsCZZuY/T
         gLPWojeZfNbMkXXurdZ0nimTSgAAXbhFVo9RrXT5cLjHdnUUlbAqpe2Em83nDK9XToL+
         44sw==
X-Gm-Message-State: AOAM530S4lveZr6+XL82Dr5dVDMeG7+cHx5+pGCbTbsi12qoYMYE1KsH
        hPTobg8XeI6pt8BRNMfC751LjFMlXdouQg==
X-Google-Smtp-Source: ABdhPJyxTdxMxGPqoacAPV9+ZpatVlgKnAr1b6J+G0igZ+olCvGRTv45eT9/KCeul1x25zyXTC5j5g==
X-Received: by 2002:a17:903:230a:b0:15e:b7be:daf5 with SMTP id d10-20020a170903230a00b0015eb7bedaf5mr23096920plh.165.1652234616115;
        Tue, 10 May 2022 19:03:36 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with ESMTPSA id g24-20020a631118000000b003c6a71b2ab7sm397960pgl.46.2022.05.10.19.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 19:03:35 -0700 (PDT)
Message-ID: <d4ebca66-2899-7cd1-3cb1-4b1a587eb2bf@ozlabs.ru>
Date:   Wed, 11 May 2022 12:03:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220429053329.2278740-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20220429053329.2278740-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 15:33, Alexey Kardashevskiy wrote:
> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> a situation when files from lib/zstd/common/ are compiled once to be
> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
> even though CFLAGS are different for builtins and modules.
> So far somehow this was not a problem but enabling LLVM LTO exposes
> the problem as:
> 
> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
> 
> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> POWERPC as explained at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> but the current use of common files is wrong anyway.
> 
> This works around the issue by introducing a zstd_common module with
> shared code.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Ping? Thanks,


> ---
> Changes:
> v2:
> * add a new module instead of inlining common bits
> 
> ---
>   lib/zstd/Makefile                | 18 ++++++++----------
>   lib/zstd/common/entropy_common.c |  4 +++-
>   lib/zstd/common/zstd_common.c    |  7 +++++++
>   lib/Kconfig                      |  8 ++++++--
>   4 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index fc45339fc3a3..440bd0007ae2 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -10,14 +10,10 @@
>   # ################################################################
>   obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>   obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>   
>   zstd_compress-y := \
>   		zstd_compress_module.o \
> -		common/debug.o \
> -		common/entropy_common.o \
> -		common/error_private.o \
> -		common/fse_decompress.o \
> -		common/zstd_common.o \
>   		compress/fse_compress.o \
>   		compress/hist.o \
>   		compress/huf_compress.o \
> @@ -33,12 +29,14 @@ zstd_compress-y := \
>   
>   zstd_decompress-y := \
>   		zstd_decompress_module.o \
> -		common/debug.o \
> -		common/entropy_common.o \
> -		common/error_private.o \
> -		common/fse_decompress.o \
> -		common/zstd_common.o \
>   		decompress/huf_decompress.o \
>   		decompress/zstd_ddict.o \
>   		decompress/zstd_decompress.o \
>   		decompress/zstd_decompress_block.o \
> +
> +zstd_common-y := \
> +		common/debug.o \
> +		common/entropy_common.o \
> +		common/error_private.o \
> +		common/fse_decompress.o \
> +		common/zstd_common.o \
> diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
> index 53b47a2b52ff..f84612627471 100644
> --- a/lib/zstd/common/entropy_common.c
> +++ b/lib/zstd/common/entropy_common.c
> @@ -15,6 +15,7 @@
>   /* *************************************
>   *  Dependencies
>   ***************************************/
> +#include <linux/module.h>
>   #include "mem.h"
>   #include "error_private.h"       /* ERR_*, ERROR */
>   #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
>   {
>       return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
>   }
> -
> +EXPORT_SYMBOL_GPL(FSE_readNCount);
>   
>   /*! HUF_readStats() :
>       Read compact Huffman tree, saved by HUF_writeCTable().
> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>       U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>       return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
>   }
> +EXPORT_SYMBOL_GPL(HUF_readStats);
>   
>   FORCE_INLINE_TEMPLATE size_t
>   HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
> diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
> index 3d7e35b309b5..06f62b2026d5 100644
> --- a/lib/zstd/common/zstd_common.c
> +++ b/lib/zstd/common/zstd_common.c
> @@ -13,6 +13,7 @@
>   /*-*************************************
>   *  Dependencies
>   ***************************************/
> +#include <linux/module.h>
>   #define ZSTD_DEPS_NEED_MALLOC
>   #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
>   #include "error_private.h"
> @@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
>           return customMem.customAlloc(customMem.opaque, size);
>       return ZSTD_malloc(size);
>   }
> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
>   
>   void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>   {
> @@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>       }
>       return ZSTD_calloc(1, size);
>   }
> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
>   
>   void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>   {
> @@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>               ZSTD_free(ptr);
>       }
>   }
> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("Zstd Common");
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..33f3a7054cdd 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
>   config LZ4_DECOMPRESS
>   	tristate
>   
> +config ZSTD_COMMON
> +	select XXHASH
> +	tristate
> +
>   config ZSTD_COMPRESS
> -	select XXHASH
> +	select ZSTD_COMMON
>   	tristate
>   
>   config ZSTD_DECOMPRESS
> -	select XXHASH
> +	select ZSTD_COMMON
>   	tristate
>   
>   source "lib/xz/Kconfig"
