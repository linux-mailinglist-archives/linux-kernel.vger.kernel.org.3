Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED35333CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiEXXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiEXXHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096C6971B;
        Tue, 24 May 2022 16:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3610B617D6;
        Tue, 24 May 2022 23:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F3CC34100;
        Tue, 24 May 2022 23:07:18 +0000 (UTC)
Date:   Tue, 24 May 2022 19:07:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <kelulanainsley@gmail.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        akpm@linux-foundation.org, sunliming@kylinos.cn
Subject: Re: [PATCH v2 RESEND] x86,trace: Remove unused headers
Message-ID: <20220524190716.6d2bb3d9@gandalf.local.home>
In-Reply-To: <CAJncD7SNDAFXFTaSf07P6-OK6j9iTHj1Xj_ssBccB-XLDZWaMA@mail.gmail.com>
References: <CAJncD7SNDAFXFTaSf07P6-OK6j9iTHj1Xj_ssBccB-XLDZWaMA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 13:41:29 +0800
sunliming <kelulanainsley@gmail.com> wrote:

> From: sunliming <sunliming@kylinos.cn>
> To: mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
> 	bp@alien8.de, dave.hansen@linux.intel.com
> Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
> 	x86@kernel.org, linux-trace-devel@vger.kernel.org, sunliming
> <sunliming@kylinos.cn>
> Subject: [PATCH v2 RESEND] x86,trace: Remove unused headers
> <https://lore.kernel.org/all/20220426120950.495950-1-sunliming@kylinos.cn/#r>
> Date: Tue, 26 Apr 2022 20:09:50 +0800
> 
> Commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")
> removed the tracing IDT from the file arch/x86/kernel/tracepoint.c,
> but left the related headers unused, remove it.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  arch/x86/kernel/tracepoint.c
> <https://lore.kernel.org/all/20220426120950.495950-1-sunliming@kylinos.cn/#Z31arch:x86:kernel:tracepoint.c>
> | 3 ---
>  1 file changed, 3 deletions(-)
> diff <https://lore.kernel.org/all/20220426120950.495950-1-sunliming@kylinos.cn/#iZ31arch:x86:kernel:tracepoint.c>
> --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
> index fcfc077afe2d..f39aad69fb64 100644
> --- a/arch/x86/kernel/tracepoint.c
> +++ b/arch/x86/kernel/tracepoint.c@@ -8,10 +8,7 @@ #include <linux/jump_label.h>
>  #include <linux/atomic.h>
>  -#include <asm/hw_irq.h>
> -#include <asm/desc.h> #include <asm/trace/exceptions.h>-#include
> <asm/trace/irq_vectors.h>
>  DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
> 

Your email client mangled the patch.

-- Steve


