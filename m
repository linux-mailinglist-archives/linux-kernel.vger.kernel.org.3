Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601C957272F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiGLUYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGLUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:24:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A7C9235
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6AA4B81BE2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF8C3411C;
        Tue, 12 Jul 2022 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657657470;
        bh=hhqQotlxuYQMvfQ+G5TESytMfjVkHedSBI1blauhsp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTADQBK8y2IcwoS+vuGnUBqyTT+ysQyOY8xFRi2Jae0FFGn8JxiPI0lYeLaAY9QyR
         ZYRT9+L1njk18by4lr4qEjX33vqY6ZmVP7fZ0Y/5kv+Rsj7RTvVLihTHZJTz0ftcF5
         QU+u42MSEROFGvtnVtZrf9tVUV79s48INReqHes+e22W75JhDrOMBH+c13rRs4Ub0r
         CPbJIiXlaEwf62FHYTDuwqMrglE7pYjAb5tLALocBVib5/zLprAqwjW5kwc1+n0wtW
         XSBn0N+VWPujsRr2wmdgCYLVjTeQeM3Vz4kmI4el0P23VBRWHmGE4ycEfRxf5vqp0g
         gd/h18RRZlwng==
Date:   Tue, 12 Jul 2022 13:24:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [linux-stable-rc:linux-5.10.y 7109/7120]
 arch/x86/kernel/cpu/bugs.c:57:21: warning: section attribute is specified on
 redeclared variable
Message-ID: <Ys3Ye7OR+5IpUoTv@dev-arch.thelio-3990X>
References: <202207130344.AUqExE4E-lkp@intel.com>
 <Ys3Xu+Vikf9WgIgz@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys3Xu+Vikf9WgIgz@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:21:15PM -0700, Nathan Chancellor wrote:
> On Wed, Jul 13, 2022 at 04:07:25AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
> > commit: 855b78ccf1c8c952e148bdbd234cde117b098060 [7109/7120] KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS
> > config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220713/202207130344.AUqExE4E-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=855b78ccf1c8c952e148bdbd234cde117b098060
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc linux-5.10.y
> >         git checkout 855b78ccf1c8c952e148bdbd234cde117b098060
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> arch/x86/kernel/cpu/bugs.c:57:21: warning: section attribute is specified on redeclared variable [-Wsection]
> >    DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
> >                        ^
> >    arch/x86/include/asm/nospec-branch.h:278:12: note: previous declaration is here
> >    extern u64 x86_spec_ctrl_current;
> >               ^
> >    1 warning generated.
> > 
> > 
> > vim +57 arch/x86/kernel/cpu/bugs.c
> > 
> > c40221c4c496c5 Peter Zijlstra 2022-06-14  55  
> > c40221c4c496c5 Peter Zijlstra 2022-06-14  56  /* The current value of the SPEC_CTRL MSR with task-specific bits set */
> > c40221c4c496c5 Peter Zijlstra 2022-06-14 @57  DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
> > c40221c4c496c5 Peter Zijlstra 2022-06-14  58  EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
> > c40221c4c496c5 Peter Zijlstra 2022-06-14  59  
> > 
> > :::::: The code at line 57 was first introduced by commit
> > :::::: c40221c4c496c5c026ede111094a96f292875d88 x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value
> > 
> > :::::: TO: Peter Zijlstra <peterz@infradead.org>
> > :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > 
> 
> Looks like that declaration should be using DECLARE_PER_CPU?

Additionally, this appears to be an issue on mainline, our CI is
starting to roll in with these patches (clang-13 + x86_64 allmodconfig):

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/2658541992

https://builds.tuxbuild.com/2Br2Q4juY6VKxbmgzULKe5C3pGq/build.log

I am happy to send a patch if this is correct, unless someone else wants
to.

> Cheers,
> Nathan
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 2989b42fcf4e..cbd56675bd7e 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -281,7 +281,7 @@ static inline void indirect_branch_prediction_barrier(void)
>  
>  /* The Intel SPEC CTRL MSR base value cache */
>  extern u64 x86_spec_ctrl_base;
> -extern u64 x86_spec_ctrl_current;
> +DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
>  extern void write_spec_ctrl_current(u64 val, bool force);
>  extern u64 spec_ctrl_current(void);
>  
> 
