Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD18348E4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiANHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiANHEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:04:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19355C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 23:04:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C86B5B82407
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D94C36AEA;
        Fri, 14 Jan 2022 07:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642143887;
        bh=MTl6kVxkeAyYX4dcCqn7G+cDUp+gY/1SqEC9mgztTvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mec0N1kzHdtcVNY34zaCrJhq4FdQK/KipGrFErmHJ8W4/M7c/6I4ogQq6YyJmA2Wz
         wtuKzEDizdzfjsQ4taE+yNQT3xO2HQLyZ5LM/mPlCJhpwG6jn+n8caWk1HtlLfYGu1
         XqX06x5ZYiyAtYLLBZzqpNXWgaYl14+IKtUWPgg8=
Date:   Fri, 14 Jan 2022 08:04:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.4.y 2563/9999]
 arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-ID: <YeEgjJBTCAJE0wS4@kroah.com>
References: <202201130408.tdm9swhk-lkp@intel.com>
 <20220113182533.15c04b3a16f02af34f2cb9e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113182533.15c04b3a16f02af34f2cb9e4@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 06:25:33PM +0900, Masami Hiramatsu wrote:
> On Thu, 13 Jan 2022 04:15:43 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Masami,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > head:   0a4ce4977bbeea4560a1f32632650b388c834c8a
> > commit: 77fa5e15c933a1ec812de61ad709c00aa51e96ae [2563/9999] ia64: kprobes: Use generic kretprobe trampoline handler
> > config: ia64-randconfig-r002-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130408.tdm9swhk-lkp@intel.com/config)
> > compiler: ia64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=77fa5e15c933a1ec812de61ad709c00aa51e96ae
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc linux-5.4.y
> >         git checkout 77fa5e15c933a1ec812de61ad709c00aa51e96ae
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/ia64/kernel/kprobes.c: In function 'get_kprobe_inst':
> >    arch/ia64/kernel/kprobes.c:325:22: warning: variable 'template' set but not used [-Wunused-but-set-variable]
> >      325 |         unsigned int template;
> >          |                      ^~~~~~~~
> 
> OK, this is another issue, which is in the upstream master too.
> 
> >    arch/ia64/kernel/kprobes.c: At top level:
> >    arch/ia64/kernel/kprobes.c:399:15: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
> >      399 | int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
> >          |               ^~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/ia64/kernel/kprobes.c: In function 'trampoline_probe_handler':
> > >> arch/ia64/kernel/kprobes.c:401:24: error: implicit declaration of function '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'? [-Werror=implicit-function-declaration]
> >      401 |         regs->cr_iip = __kretprobe_trampoline_handler(regs, kretprobe_trampoline, NULL);
> >          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                        kretprobe_trampoline
> >    cc1: some warnings being treated as errors
> 
> This seems that the upstream commit e792ff804f49720ce003b3e4c618b5d996256a18
> has been picked to the stable-5.4.y tree accidentally.
> That is a part of lockless kretprobe series and should not be picked to
> the stable tree.
> 
> Greg, can you revert commit 77fa5e15c933a1ec812de61ad709c00aa51e96ae ?
> (Or should I send revert patch?)

I can revert it, thanks.

greg k-h
