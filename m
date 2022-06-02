Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFA53C161
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiFBXwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFBXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 19:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E762616F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF9E61935
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD62EC34119;
        Thu,  2 Jun 2022 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654213922;
        bh=ksf5ubmPKHtfc96T9Llyh8RYmVrbiXs3oh9nqY5uDe4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c6dEZMqWYas+WdmgtCvEhfq3F2OWWb+exUb/JAjMFY//KH2B2q9L9kD/x4F5y1wAl
         KFMkYRPBBX4i4ET6uN5OP2CffWaCkSDxumU79KE1GIKt4I9aVBlLr7aZgNNn1Yl2y4
         woPKz2dPBkALSNFSzdfBgjrL2TWl4b7OBKxTAGUIvNbsEE/2Klupf69UNRBdTykKh/
         npR0JdfniodVYpMT/ZPeufpRctDITe1cwtN+l0gM2iwn9EoiNT8aU6sYKS4zv+hJJ3
         teoGb7rNo8gGsAl7hxbl/fLTLSn5QgYDBukocbMq2KUm2b6DWbeODQ5u6ue4uOtbEf
         s3Md42/JbGUww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C8D65C05E6; Thu,  2 Jun 2022 16:52:02 -0700 (PDT)
Date:   Thu, 2 Jun 2022 16:52:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dinguyen@kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dave.2022.06.02a 56/78]
 kernel/rcu/tasks.h:1239:8: error: variable has incomplete type 'typeof (({
Message-ID: <20220602235202.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202206030613.IxQYmIW8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206030613.IxQYmIW8-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:15:47AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dave.2022.06.02a
> head:   2efc5c4abe4cc1259378f7c1678a93540559673c
> commit: cda3200416cdef7f25546cd6249fb411c8c32079 [56/78] rcu-tasks: Merge state into .b.need_qs and atomically update
> config: arm-buildonly-randconfig-r004-20220531 (https://download.01.org/0day-ci/archive/20220603/202206030613.IxQYmIW8-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/ammarfaizi2/linux-block/commit/cda3200416cdef7f25546cd6249fb411c8c32079
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dave.2022.06.02a
>         git checkout cda3200416cdef7f25546cd6249fb411c8c32079
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

OK, I finally get it.  The NIOS2 and ARM CPUs' implementations of
cmpxchg are not type-generic, are they?

OK, I will fix this, though the type-checking is rather nice.

Adding some NIOS2 and ARM people/lists on CC for their thoughts.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:606:
>    kernel/rcu/tasks.h:1239:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
>            ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
>            arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:52:2: note: expanded from macro 'arch_cmpxchg'
>            __atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:73:9: note: expanded from macro '__atomic_op_fence'
>            typeof(op##_relaxed(args)) __ret;                               \
>                   ^~~~~~~~~~~~~~~~~~
>    <scratch space>:39:1: note: expanded from here
>    arch_cmpxchg_relaxed
>    ^
>    arch/arm/include/asm/cmpxchg.h:212:26: note: expanded from macro 'arch_cmpxchg_relaxed'
>                                          (unsigned long)(o),               \
>                                                         ^~~
>    In file included from kernel/rcu/update.c:606:
>    kernel/rcu/tasks.h:1239:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
>            ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
>            arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:52:2: note: expanded from macro 'arch_cmpxchg'
>            __atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:73:9: note: expanded from macro '__atomic_op_fence'
>            typeof(op##_relaxed(args)) __ret;                               \
>                   ^~~~~~~~~~~~~~~~~~
>    <scratch space>:39:1: note: expanded from here
>    arch_cmpxchg_relaxed
>    ^
>    arch/arm/include/asm/cmpxchg.h:213:26: note: expanded from macro 'arch_cmpxchg_relaxed'
>                                          (unsigned long)(n),               \
>                                                         ^~~
>    In file included from kernel/rcu/update.c:606:
> >> kernel/rcu/tasks.h:1239:8: error: variable has incomplete type 'typeof (({
>    }))' (aka 'void')
>    include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
>            arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:52:2: note: expanded from macro 'arch_cmpxchg'
>            __atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:73:29: note: expanded from macro '__atomic_op_fence'
>            typeof(op##_relaxed(args)) __ret;                               \
>                                       ^
>    In file included from kernel/rcu/update.c:606:
>    kernel/rcu/tasks.h:1239:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
>            ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
>            arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:52:2: note: expanded from macro 'arch_cmpxchg'
>            __atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:75:10: note: expanded from macro '__atomic_op_fence'
>            __ret = op##_relaxed(args);                                     \
>                    ^~~~~~~~~~~~~~~~~~
>    <scratch space>:40:1: note: expanded from here
>    arch_cmpxchg_relaxed
>    ^
>    arch/arm/include/asm/cmpxchg.h:212:26: note: expanded from macro 'arch_cmpxchg_relaxed'
>                                          (unsigned long)(o),               \
>                                                         ^~~
>    In file included from kernel/rcu/update.c:606:
>    kernel/rcu/tasks.h:1239:8: error: operand of type 'union rcu_special' where arithmetic or pointer type is required
>            ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
>            arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:52:2: note: expanded from macro 'arch_cmpxchg'
>            __atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:75:10: note: expanded from macro '__atomic_op_fence'
>            __ret = op##_relaxed(args);                                     \
>                    ^~~~~~~~~~~~~~~~~~
>    <scratch space>:40:1: note: expanded from here
>    arch_cmpxchg_relaxed
>    ^
>    arch/arm/include/asm/cmpxchg.h:213:26: note: expanded from macro 'arch_cmpxchg_relaxed'
>                                          (unsigned long)(n),               \
>                                                         ^~~
>    5 errors generated.
> 
> 
> vim +1239 kernel/rcu/tasks.h
> 
>   1224	
>   1225	/*
>   1226	 * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
>   1227	 * the four-byte operand-size restriction of some platforms.
>   1228	 * Returns the old value, which is often ignored.
>   1229	 */
>   1230	u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
>   1231	{
>   1232		union rcu_special ret;
>   1233		union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
>   1234		union rcu_special trs_new = trs_old;
>   1235	
>   1236		if (trs_old.b.need_qs != old)
>   1237			return trs_old.b.need_qs;
>   1238		trs_new.b.need_qs = new;
> > 1239		ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
>   1240		return ret.b.need_qs;
>   1241	}
>   1242	EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
>   1243	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
