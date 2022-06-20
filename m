Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF57551178
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiFTH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiFTH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:27:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CF8E0D1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yM3F4/cwOrMFpz6WpdBpNnEJFlWX+wr6PDeDgK9wQwY=; b=jF801S+zwAE3Y0a9Lpn6wy9Law
        HhDhj65dMXzcJv03nBADpFB9QdxsP+AtsCJCZw258a9qSsdmf9vXr5/lOQawWPnOTMGHefkFIB/iX
        7P9sbhnLdD4h7RP2+TCouonluMZqU+izVlR7oJFL+CRWeL+1NGAxZA9/6LfPNAWZUlLEUwucx1wVr
        1ljuOoiRuX8ZHaNVlMrQe8leqLu30fxLVtRPtDtab1jCHt5JEtRksZejRmUor2OuofGtKJlmfi6bd
        t+LnZ6C17AjVCDoVW23SUh7wUj5n6RawpwQpZV5i1R2/LGg0qLr8VnSe2EnHHrHTNr0f31xwTCpSh
        NyouIPQw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3Bo9-009PcB-CW; Mon, 20 Jun 2022 07:26:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C997930022D;
        Mon, 20 Jun 2022 09:26:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B34E5299D22F0; Mon, 20 Jun 2022 09:26:48 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:26:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [peterz-queue:locking/core 2/4] ld.lld: error: undefined symbol:
 jump_label_apply_nops
Message-ID: <YrAhONjbYQkLSlmG@hirez.programming.kicks-ass.net>
References: <202206180532.mOqwM8Wu-lkp@intel.com>
 <CAMj1kXHjzwYfoF0ut+7SzToAd35hRnTF0ppODvL0fPUyVQimDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHjzwYfoF0ut+7SzToAd35hRnTF0ppODvL0fPUyVQimDQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 10:10:23AM +0200, Ard Biesheuvel wrote:
> On Fri, 17 Jun 2022 at 23:54, kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > head:   c4e2db802ebbc639960404b97c9b8a6284634428
> > commit: 74c632a2a5738bd18864610e34f6b6d2db664bb7 [2/4] jump_label: mips: move module NOP patching into arch code
> > config: mips-randconfig-r026-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180532.mOqwM8Wu-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mipsel-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=74c632a2a5738bd18864610e34f6b6d2db664bb7
> >         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
> >         git fetch --no-tags peterz-queue locking/core
> >         git checkout 74c632a2a5738bd18864610e34f6b6d2db664bb7
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: undefined symbol: jump_label_apply_nops
> >    >>> referenced by module.c
> >    >>>               kernel/module.o:(module_finalize) in archive arch/mips/built-in.a
> >
> 
> Aargh.
> 
> --- a/arch/mips/kernel/jump_label.c
> +++ b/arch/mips/kernel/jump_label.c
> @@ -89,7 +89,7 @@ void arch_jump_label_transform(struct jump_entry *e,
>         mutex_unlock(&text_mutex);
>  }
> 
> -#ifdef CONFIG_MODULE
> +#ifdef CONFIG_MODULES
>  void jump_label_apply_nops(struct module *mod)
>  {
>         struct jump_entry *iter_start = mod->jump_entries;
> 
> Sorry about that.

Heh, no worries, that's what we have the robot for ;-)
