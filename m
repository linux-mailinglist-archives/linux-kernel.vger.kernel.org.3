Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1448E6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiANIhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiANIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:37:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BBDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D3f1pkjr+Pszti/n7Bu1RalB/cBra72+cXMo9Jb2q/M=; b=vFcR3B5/hf6mGOnk/o7nRNP2C2
        G22vh4/w0Fu4By/WrcdJxSrpziBIBsjQGriZPIaHr919TygeVzuaAu/fCP6jCj7zWHqDevX/dkYyW
        jQKuOQlq9qQmhm/zKXzZo4DTZpHU26ns7dwVQG7W6HZ6drtBv0aCFGdDQm1q5kiSv1hDh0GCkyD6m
        XRvzfgWUJOFiAQYCYAOJcXusyrYVRJCLG/nSS9ukxsUw0pUd0ibvbqLoxI+g5IAW0xGaWjVGEKMGP
        e96Q35Y/t8wgO92RshsTgA7e8U3bZ46wTn+wkq+KzV2SbsQlZpaSN9+SFiJyyoLiNm0iii4Dl+xUH
        +w5yJdyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8I5e-005ePK-7y; Fri, 14 Jan 2022 08:37:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BD713001C0;
        Fri, 14 Jan 2022 09:37:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6ECD2058F054; Fri, 14 Jan 2022 09:37:41 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:37:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: arch/powerpc/kernel/stacktrace.c:171:9: error: implicit
 declaration of function 'nmi_cpu_backtrace'
Message-ID: <YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net>
References: <202201140631.ZuSwa9QF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201140631.ZuSwa9QF-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 06:13:37AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
> commit: 1614b2b11fab29dd4ff31ebba9d266961f5af69e arch: Make ARCH_STACKWALK independent of STACKTRACE
> date:   5 weeks ago
> config: powerpc64-randconfig-r025-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140631.ZuSwa9QF-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1614b2b11fab29dd4ff31ebba9d266961f5af69e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 1614b2b11fab29dd4ff31ebba9d266961f5af69e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
> >> arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace' [-Werror=implicit-function-declaration]
>      171 |         nmi_cpu_backtrace(regs);
>          |         ^~~~~~~~~~~~~~~~~
>    arch/powerpc/kernel/stacktrace.c: At top level:
>    arch/powerpc/kernel/stacktrace.c:224:6: warning: no previous prototype for 'arch_trigger_cpumask_backtrace' [-Wmissing-prototypes]
>      224 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/kernel/stacktrace.c: In function 'arch_trigger_cpumask_backtrace':
> >> arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of function 'nmi_trigger_cpumask_backtrace'; did you mean 'arch_trigger_cpumask_backtrace'? [-Werror=implicit-function-declaration]
>      226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |         arch_trigger_cpumask_backtrace
>    cc1: some warnings being treated as errors

I suppose this ought to cure things...

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index a2443d61728e..bde1aaedeb72 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -165,7 +165,7 @@ int __no_sanitize_address arch_stack_walk_reliable(stack_trace_consume_fn consum
 	return 0;
 }
 
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
 static void handle_backtrace_ipi(struct pt_regs *regs)
 {
 	nmi_cpu_backtrace(regs);
