Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB014E323B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiCUVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiCUVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:16:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CC28F814
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ii3OZp8pxT+C1BTuGgcw+63YrNr4SmJ8xYBhoY0Jnnk=; b=QM0LpZRlBphKJgtC91f9ifwaof
        BDcCZHIHvhQKSH2ghlab6L3fTaZgy1OAV+Ygtlid+iRZA434hD21AJU8LpAsztHUM4cJYpPf9eajY
        B1gH7p2Gytky0677wEqBUsgH9V39zKaJEkRt4K9IrB3baJEuj/Utl+Rr24HVtpbMYvT1wtFcTFDvd
        zggVCMqkfWBpefkSz/+dJbDQK9BCgmH/tH10Vj7OwJBzqcsR3hstCCJ03h5bNwV83hAylCDNY/eNz
        /QLbyjaZFgoMuR7FzcDVnboMCe1c1VCOj2fTDrglcAadbJP17a2N2Ha9lw+fk1jcu3E4l32gqWISV
        rDVf0x5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWPMj-003FTq-R5; Mon, 21 Mar 2022 21:15:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46F763001C0;
        Mon, 21 Mar 2022 22:14:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0159A2DC2BF17; Mon, 21 Mar 2022 22:14:58 +0100 (CET)
Date:   Mon, 21 Mar 2022 22:14:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [peterz-queue:locking/core 17/19] arch/x86/kvm/x86.h:29:30:
 error: too many arguments to function call, expected 0, have 1
Message-ID: <Yjjq0kgGjL8Nt9CJ@hirez.programming.kicks-ass.net>
References: <202203191213.tC0sjaY7-lkp@intel.com>
 <CAKwvOdnEyGLi14b0qsc2=aSRafCrQD-Zyh+Oq+E-vx+c1viErg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnEyGLi14b0qsc2=aSRafCrQD-Zyh+Oq+E-vx+c1viErg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:51:29AM -0700, Nick Desaulniers wrote:
> On Fri, Mar 18, 2022 at 9:10 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > head:   200a79c670d24d4d9a75a6a9cbfd14af2f5d0ad9
> > commit: 5c9f3806a4400c2957abeea9419547f856457a20 [17/19] lockdep: Fix -Wunused-parameter for _THIS_IP_
> > config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220319/202203191213.tC0sjaY7-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=5c9f3806a4400c2957abeea9419547f856457a20
> >         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
> >         git fetch --no-tags peterz-queue locking/core
> >         git checkout 5c9f3806a4400c2957abeea9419547f856457a20
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from arch/x86/kvm/x86.c:22:
> >    In file included from arch/x86/kvm/mmu.h:7:
> >    In file included from arch/x86/kvm/cpuid.h:5:
> > >> arch/x86/kvm/x86.h:29:30: error: too many arguments to function call, expected 0, have 1
> >            lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> >            ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~
> 
> Peter, I think you dropped the hunk to include/linux/kvm_host.h when
> applying this patch?

Could be I fat fingered some conflict, I'll try again.
