Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191B4F8F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiDHGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiDHGpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:45:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E82EF0B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:42:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id be5so1106281plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYAWmA2mzvjlynkITTRP/QBtHX3DhppNiVnqizFawyk=;
        b=m3eYQ2SnsKAcXforZE0s4H1JXIupwn57zG7A5EQuiAUeTmfB/YyOuJHhZ9yQ22aUF0
         3kfjqC5krkpaxIthl7/vQy19PpxneYBHPRMJcaxknoh+6MdmvYpx7Lhy3ta5XYHHXjc/
         AKtVXXTuaCKISLYE7p7qwwYQ5kSIJn7feeTslmOfyFWPTyt46OPW/mQnvQi4a9RL+eeM
         uNX9FazyIfGRhHoa3yBGa8oj3ZUS05YB0SXqa1vcQp1todBt5YDNWmIBeUUrMXW9s3tS
         3BdsLGxJt/ZWuHu2bI3uahgcfBUNOv7NKZmsE5JcQmrJ2Agnx47JhHBJb06JYarwEwUJ
         q78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYAWmA2mzvjlynkITTRP/QBtHX3DhppNiVnqizFawyk=;
        b=BmU/gDs2EpCqa68iXPFEX0RGsE5+Slmc0DUv5VyXLyCf8h+QHbvRshLqxcu5XVCUYK
         tG0tduh0vqB2DGGx1p3CO/sfo3SeCo+DWX+QNbtQ9hw3qw+vluebrl3yuPuYsBduP3Sk
         QSctWtfhJIRLoVnIECRw5zBabLTAYiKHkX5DFBP6lfXCWZq2kAVj52L/c1CrGl6nh2RP
         1deAKLY0Y+J41pH3NFPVzgVZZsemlBQiUfWr53wRsre0lRCCrFsvBWMg2x4ECe9GbEoP
         AagZK3YeHw3qCOeYCdq4eKalNj9zcUsyzsTXnQp0bw4TOykwsYdFxjeZEG1HtCc2J0X5
         tLnQ==
X-Gm-Message-State: AOAM533QdZ5zZUcVQ8NeYx6lDTLbDfrb1AbKF2mPMafsuHh1NSZXfGJs
        evL+jvnLjVoLYycikw9HIws=
X-Google-Smtp-Source: ABdhPJwzWfhiEuvayiUnpNnk4zCnrgrOkuebnQasPetk1mTi8/i/6CSqaM+0Z7ybryAGQdYAW9vLBA==
X-Received: by 2002:a17:903:2446:b0:154:3bb0:7ba0 with SMTP id l6-20020a170903244600b001543bb07ba0mr17352444pls.38.1649400143908;
        Thu, 07 Apr 2022 23:42:23 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y24-20020a056a00181800b004fac7d687easm25036917pfa.66.2022.04.07.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 23:42:20 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:42:13 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <Yk/ZRTggY3wZ00o4@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-2-catalin.marinas@arm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> In preparation for supporting a dynamic kmalloc() minimum alignment,
> allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> an architecture does not override it.
> 
> After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> alignment annotations and defined by an architecture to be the maximum
> alignment for all supported configurations/SoCs in a single Image.
> ARCH_KMALLOC_MINALIGN, if different, is the minimum alignment guaranteed
> by kmalloc().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/slab.h | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 373b3ef99f4e..d58211bdeceb 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -187,17 +187,30 @@ bool kmem_valid_obj(void *object);
>  void kmem_dump_obj(void *object);
>  #endif
>  
> +/*
> + * slob does not support independent control of ARCH_KMALLOC_MINALIGN and
> + * ARCH_DMA_MINALIGN.
> + */
> +#ifdef CONFIG_SLOB
> +#undef ARCH_KMALLOC_MINALIGN
> +#endif

I think you should replace ARCH_KMALLOC_MINALIGN with ARCH_DMA_MINALIGN
in mm/slob.c too? Or detect minimum kmalloc alignment in runtime like SLAB/SLUB?

current code seem to break with SLOB on machines that has 128 byte cache lines
because ARCH_KMALLOC_MINALIGN is 64?

> +
>  /*
>   * Some archs want to perform DMA into kmalloc caches and need a guaranteed
>   * alignment larger than the alignment of a 64-bit integer.
> - * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
> + * Setting ARCH_DMA_MINALIGN in arch headers allows that.
>   */
> -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> +#ifndef ARCH_DMA_MINALIGN
> +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> +#elif ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
>  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> -#else
> +#endif
> +
> +#ifndef ARCH_KMALLOC_MINALIGN
>  #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> +#else
> +#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> +#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
>  #endif
>  
>  /*
> 

-- 
Thanks,
Hyeonggon
