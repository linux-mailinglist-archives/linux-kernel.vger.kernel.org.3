Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C01479A76
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhLRLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:00:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhLRLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:00:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F84D210F2;
        Sat, 18 Dec 2021 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639825214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiGN5O4Z5frElOkczYbGazujChLqnsdC7EABO3jzJaM=;
        b=fFagaALuTZ3E7dIOiBiYa5E49VIKmpyEEFzmD7CkH1cFTYLUwNozzzA4NAUDMHVylh+2cS
        231jXKeib+6GPYlkb6OXcsNKD6G5e857I/qP6U0rDNTbf94JK2ibqPwhtRwRWKZ+XQpO6R
        PnFa2Z6YhPNHTS4h3XZozSSrSz83Wxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639825214;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiGN5O4Z5frElOkczYbGazujChLqnsdC7EABO3jzJaM=;
        b=9VmT0hgWsxscRs7CeycyhdgtTNyfuFkLcCi1BI4rHvVIOCKfgiSEXMPE9U6Mv+4awxji64
        6WMHHhYI2btTx4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B24139F0;
        Sat, 18 Dec 2021 11:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MspLED6/vWHLHgAAMHmgww
        (envelope-from <bp@suse.de>); Sat, 18 Dec 2021 11:00:14 +0000
Date:   Sat, 18 Dec 2021 12:00:16 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, bfields@fieldses.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <Yb2/QCOExDEsj47w@zn.tnic>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <YbzRHXEMnZjyXzWa@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbzRHXEMnZjyXzWa@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:04:13AM -0700, Nathan Chancellor wrote:
> This is GCOV, -fprofile-arcs.

Aha, and no_profile_instrument_function disables that.

> I am not reallys ure how exactly GCOV works under the hood so I cannot
> really comment on it (Nick might); it seems like llvm_gcov_init needs to
> get called for __llvm_gcov_ctr to get set up properly and maybe that
> hasn't happened at the point.

Hmm, right, there is a

        .p2align        4, 0x90                         # -- Begin function __llvm_gcov_init
        .type   __llvm_gcov_init,@function
__llvm_gcov_init:                       # @__llvm_gcov_init

in arch/x86/kernel/cpu/common.s which contains native_write_cr4() which does

	jmp     llvm_gcov_init@PLT

and that function is part of initcalls:

	.section	.init_array.0,"aw",@init_array
	.p2align	3
	.quad	__llvm_gcov_init
	.section	.init_array.1,"aw",@init_array
	.p2align	3
	.quad	asan.module_ctor
	.section	.fini_array.1,"aw",@fini_array
	.p2align	3
	.quad	asan.module_dtor
	.type	.L___asan_gen_.313,@object      # @___asan_gen_.313
	.section	.rodata.str1.1,"aMS",@progbits,1

which, AFAICT, gets called by kernel_init_freeable->do_basic_setup->do_ctors()

which is a lot later than x86_64_start_kernel() so I guess the
__no_profile tag for that function probably makes sense as a fix.

> This is a bit of a brain dump, apologies for not offering much upfront
> analysis, I am not as familiar with LLVM internals as Nick but this
> might help others look into the problem.

No, this is still highly appreciated - thanks for taking the time!

> I ended up seeing this thread yesterday through a lore filter that I
> have

Nice filtering. :-)

I did Cc llvm@lists.linux.dev in the hope that you guys would see it.

> and I bisected LLVM based on the fact that it happened with
> clang-13 but not clang-12; that bisect pointed out Nick's commit in LLVM
> that added the no profile attribute, which means that GCOV and KASAN
> need to be enabled to see this bug. I was not able to reproduce it with
> just one of them enabled at a time.

Ah, that's an interesting point:

$ grep -E "(GCOV|KASAN)" /tmp/config-5.16.0-rc3-00003-gf154f290855b | grep -v "^#"
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_VMALLOC=y

> With that, I removed the no profile attribute dependency on GCOV_KERNEL
> and bisected again, landing on the commit in LLVM 13 that enables the
> new pass manager, which fundamentally changes how LLVM transforms its
> IR. Whenever that has happened in the past, it usually points to a
> pre-existing issue; if I go back to clang-11 (the current minimum of
> -next) and enable the NPM there with -fexperimental-new-pass-manager, I
> see this hang so it seems like there might be some issue how GCOV and
> KASAN are manipulated together in the context of the NPM that was not
> present with the legacy pass manager.

Aha, so it used to work, apparently. Or the NPM is adding additional
code which needs to be initialized because it works ok after the
constructors have run.

> I do see tests in LLVM that test to make sure __llvm_gcov_ctr does not
> get instrumented with KASAN, maybe there is another interaction that
> should not be happening between those two?

Right.

Ok, thanks for the insights, let's see what Nick figures out here.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
