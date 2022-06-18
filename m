Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B382550374
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiFRIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFRIKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CC2AE0E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7478060C51
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CF1C341C4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655539834;
        bh=8HqkVwJIXaewnnCfLQg07r1yOIW+/2JIykG8STwS1DU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=otucdKci5Ir2QEgy7iQEmH9Uz5ug9sBcixhkEtYnpDS2T0x2bAOKRDR1/YlBRG33N
         oLmdLWte8hCKuMtd3HHC/PjNz82pYC2aCE6Tboo62xE2sP6ownXNtgca5xi/5s4rGE
         PyWAjYsJrhVamQFVv29wVD4c2NkzAYyD51yiTlsufA33Yd3Tb8LTn6rATQ3NL0e0G5
         Dfb1dQ8F0zKIH8+puIjwinAkX6JQH4xNIKHM8T6G6DMIKAZPSjRZJvduKdLlTH7vL2
         V+3FVF3KP24lM03X6B/WGAQGWFUovwpuVVAukfhhpgEVhbnH2qJlHMn20I+YVHtQZ0
         oLn4Fw3BkZvOg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1016409cf0bso8137485fac.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:10:34 -0700 (PDT)
X-Gm-Message-State: AJIora8P+Bm0b+sCRrSjafAnDhQWJGMV8UdRXaXw/FzJiNV9/2VYPBq1
        wwBhRCj3x98tAny+902YHYgz0G6qp7rvlL7R/pU=
X-Google-Smtp-Source: AGRyM1u/fZ43nB2flF69eJ2ExNQUGoqGkZ7hUnNh1tG2x3KvlRgGYs3FGIfGvbqNNYErEB6/VDqOE4TWYiN8YuaPWKo=
X-Received: by 2002:a05:6870:1d4:b0:101:b0d6:8613 with SMTP id
 n20-20020a05687001d400b00101b0d68613mr3111306oad.126.1655539833758; Sat, 18
 Jun 2022 01:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <202206180532.mOqwM8Wu-lkp@intel.com>
In-Reply-To: <202206180532.mOqwM8Wu-lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 18 Jun 2022 10:10:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjzwYfoF0ut+7SzToAd35hRnTF0ppODvL0fPUyVQimDQ@mail.gmail.com>
Message-ID: <CAMj1kXHjzwYfoF0ut+7SzToAd35hRnTF0ppODvL0fPUyVQimDQ@mail.gmail.com>
Subject: Re: [peterz-queue:locking/core 2/4] ld.lld: error: undefined symbol: jump_label_apply_nops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 at 23:54, kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> head:   c4e2db802ebbc639960404b97c9b8a6284634428
> commit: 74c632a2a5738bd18864610e34f6b6d2db664bb7 [2/4] jump_label: mips: move module NOP patching into arch code
> config: mips-randconfig-r026-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180532.mOqwM8Wu-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mipsel-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=74c632a2a5738bd18864610e34f6b6d2db664bb7
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue locking/core
>         git checkout 74c632a2a5738bd18864610e34f6b6d2db664bb7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: jump_label_apply_nops
>    >>> referenced by module.c
>    >>>               kernel/module.o:(module_finalize) in archive arch/mips/built-in.a
>

Aargh.

--- a/arch/mips/kernel/jump_label.c
+++ b/arch/mips/kernel/jump_label.c
@@ -89,7 +89,7 @@ void arch_jump_label_transform(struct jump_entry *e,
        mutex_unlock(&text_mutex);
 }

-#ifdef CONFIG_MODULE
+#ifdef CONFIG_MODULES
 void jump_label_apply_nops(struct module *mod)
 {
        struct jump_entry *iter_start = mod->jump_entries;

Sorry about that.
