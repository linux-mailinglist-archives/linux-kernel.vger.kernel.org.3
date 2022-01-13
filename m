Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4148D4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiAMJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAMJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BBC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:25:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54AEBB81EFB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400F5C36AE9;
        Thu, 13 Jan 2022 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642065937;
        bh=nB7Frx+QPAsjh6WlsU2wkKdv7/0IM/UNCg18+S5bJXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8VxRXJfQJBlKHWcEriJj7hjAV7ZShyNGsDXgvHrNghOLAaoYsJaIva/RA7h5S1L1
         laAoLjCQJEri8xaDc5gKIRPlOqw0OHbPOsyBr169h31hKQdjpK5k9qazfr40Yn0vud
         AE1QV5GdCBEaaYtkkTAX58euzLcvq6hW9g1k0BSIU68hzf4YH/OSwCLWHCEsxH2WQM
         9Xikdn0/mE7m18KFLTxudPnfiZmP1nHVdK1zUCZxgzkxd+9j0zvJ6MH2rf2XP3XLF1
         F4dlVBFBpazUqAWmKzb7+ZhPZB2LmMJL5i++e9nsbb/ifa/N0BlKzr2DWtIvyQ33u6
         U0Ssi/EyhIu5w==
Date:   Thu, 13 Jan 2022 18:25:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.4.y 2563/9999]
 arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-Id: <20220113182533.15c04b3a16f02af34f2cb9e4@kernel.org>
In-Reply-To: <202201130408.tdm9swhk-lkp@intel.com>
References: <202201130408.tdm9swhk-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 04:15:43 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> head:   0a4ce4977bbeea4560a1f32632650b388c834c8a
> commit: 77fa5e15c933a1ec812de61ad709c00aa51e96ae [2563/9999] ia64: kprobes: Use generic kretprobe trampoline handler
> config: ia64-randconfig-r002-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130408.tdm9swhk-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=77fa5e15c933a1ec812de61ad709c00aa51e96ae
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.4.y
>         git checkout 77fa5e15c933a1ec812de61ad709c00aa51e96ae
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/ia64/kernel/kprobes.c: In function 'get_kprobe_inst':
>    arch/ia64/kernel/kprobes.c:325:22: warning: variable 'template' set but not used [-Wunused-but-set-variable]
>      325 |         unsigned int template;
>          |                      ^~~~~~~~

OK, this is another issue, which is in the upstream master too.

>    arch/ia64/kernel/kprobes.c: At top level:
>    arch/ia64/kernel/kprobes.c:399:15: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
>      399 | int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/ia64/kernel/kprobes.c: In function 'trampoline_probe_handler':
> >> arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'? [-Werror=implicit-function-declaration]
>      401 |         regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                        kretprobe_trampoline
>    cc1: some warnings being treated as errors

This seems that the upstream commit e792ff804f49720ce003b3e4c618b5d996256a18
has been picked to the stable-5.4.y tree accidentally.
That is a part of lockless kretprobe series and should not be picked to
the stable tree.

Greg, can you revert commit 77fa5e15c933a1ec812de61ad709c00aa51e96ae ?
(Or should I send revert patch?)

Thank you,

> 
> 
> vim +401 arch/ia64/kernel/kprobes.c
> 
>    398	
>    399	int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>    400	{
>  > 401		regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
>    402		/*
>    403		 * By returning a non-zero value, we are telling
>    404		 * kprobe_handler() that we don't want the post_handler
>    405		 * to run (and have re-enabled preemption)
>    406		 */
>    407		return 1;
>    408	}
>    409	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Masami Hiramatsu <mhiramat@kernel.org>
