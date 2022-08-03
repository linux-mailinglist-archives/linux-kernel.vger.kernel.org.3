Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55558897D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiHCJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiHCJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:33:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015605A15F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:33:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z17so16145144wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ddO3ywJTMVY8uUYUGZPTsg2lBYXEiN0lWJt0Y7mrAIQ=;
        b=YDGKu39f+OtWlmddc8xVSJYhf6YlhhWkJlNG8TE5ZBDGj4WQ1rpDVjWq8ztcP1YIH8
         CJ8Q/K5dZBPyXeD8nbA2YxDRbHqgvIrzvDZIgrtChfSh5SB5hP7FXaHZHV8yG57JdUmP
         pGvCbkTuVqY/3nwiZXDvED8fFG1ZCsF+bJYkOlVc740fccJHkWtifgMlDJKlgpWvknyK
         E2PKGtJbS1dbWZI52lwCuaClbmNPpj+Aw9AcBbns5vxV/AVU7qWteu3Pbn6FkYvvKxLH
         /Tagw/JNzUuGOXsYBe+mAgzNSTrQijETwGYOc2hyTkcDN6du5IGuDxP18IqFSaq1yeKs
         DyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ddO3ywJTMVY8uUYUGZPTsg2lBYXEiN0lWJt0Y7mrAIQ=;
        b=HH06Xs+21hyj2Wx8o2aj7M4gphG4e6qwpVdVtZneroUJcILYnbsKXpNzkC/InU2u7L
         DlRy1fX88QcnBXjwIT50iCFCOQU9We3DQZo1yVrEnCPzuAvmQyjOoZFemC5I9sIeQaX0
         OIcfxPd3SyDvu9QTwqdg590e5yoCgqqUM+cobx4HaEZdCZteamGYiMTqO3QtE3cOq1+T
         ZtV9FaWyXcgpij3aqjUlzkcM1WeO36bJHLwCQXox8BuBIZesBVN6r1pChFjSKzxzy8Gg
         /VfDi7bJnWfg5HDKHadSWU6Dp/OmWKaOh/5l/saapHmUvJsh7lLFDlnMwTx0B58aFK9U
         EVrw==
X-Gm-Message-State: ACgBeo36AEm8Vx/TPEqffU0WL9/1VHM094l30DGpDb81RCH+sr77KnTQ
        dYrpe31hDjgueTF0yvCbEVE=
X-Google-Smtp-Source: AA6agR5Dk0UkJV9JoFdhfw2ZgjIQZnnZIKLTm9bifqG/n998YPmlQ2ZcI/YsV+ItxNiJEG/duvWPNQ==
X-Received: by 2002:a5d:47c4:0:b0:21f:f34:56fd with SMTP id o4-20020a5d47c4000000b0021f0f3456fdmr14812442wrc.585.1659519224593;
        Wed, 03 Aug 2022 02:33:44 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c088700b003a35ec4bf4fsm1726292wmp.20.2022.08.03.02.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:33:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:33:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/arch/variable: I don't think (void *) Pointers
 need to be cast
Message-ID: <YupA9iqo4PxDvVTY@gmail.com>
References: <20220725042358.3377-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725042358.3377-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Li kunyu <kunyu@nfschina.com> wrote:

> I first observe (void *) type coercion and non coercion through assembly
> language. It seems that there is no difference.
> Then I output the assigned information through the print function and
> found that the pointer that is not coerced is directly assigned when
> executing the print function (opcode a1), while the coerced pointer
> needs to execute the assembly instruction xlat (opcode d7), which seems
> to be more efficient without coerced conversion.
> At present, I just started to try to analyze this part of knowledge
> (machine code), please forgive me if the analysis is wrong.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  arch/x86/boot/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
> index 02e1dea11d94..8518ae214c9b 100644
> --- a/arch/x86/boot/bitops.h
> +++ b/arch/x86/boot/bitops.h
> @@ -19,13 +19,13 @@
>  
>  static inline bool constant_test_bit(int nr, const void *addr)
>  {
> -	const u32 *p = (const u32 *)addr;
> +	const u32 *p = addr;
>  	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
>  }
>  static inline bool variable_test_bit(int nr, const void *addr)
>  {
>  	bool v;
> -	const u32 *p = (const u32 *)addr;
> +	const u32 *p = addr;
>  
>  	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
>  	return v;

It's true that the forced-type casting of 'addr' is unnecessary in the 
cases above, I'm not sure how the kernel would end up with an XLAT 
instruction being generated in that sequence.

But your patch is a good cleanup in its own right - I've applied the patch 
below to tip:x86/cleanups, with a different changelog.

Thanks,

	Ingo

===================>
From: Li kunyu <kunyu@nfschina.com>
Date: Mon, 25 Jul 2022 12:23:58 +0800
Subject: [PATCH] x86/boot: Remove superfluous type casting from arch/x86/boot/bitops.h

'const void *' will auto-type-convert to just about any other const pointer type,
no need to force it.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220725042358.3377-1-kunyu@nfschina.com
---
 arch/x86/boot/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 02e1dea11d94..8518ae214c9b 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -19,13 +19,13 @@
 
 static inline bool constant_test_bit(int nr, const void *addr)
 {
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
 }
 static inline bool variable_test_bit(int nr, const void *addr)
 {
 	bool v;
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 
 	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
