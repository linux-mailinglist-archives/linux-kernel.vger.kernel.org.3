Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7577849FDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbiA1QSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:18:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33374 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350001AbiA1QSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:18:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8DFDB80D74
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5CFC340E0;
        Fri, 28 Jan 2022 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643386716;
        bh=5exY9uOMkEaMytzz1h3HlcN+jA0Ebiq+qOauv1/HweE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LBRtyZLDsrS8qptMkv/VNG4XneYDFp7dNTZfcF5br6Dng/V4ieyNpqS+ATxgBI58z
         BiKGgxekz31evg68ccUEZLpCoKqX0Tgl4Y7+Y/rIXw2MGxbZYuHw1fqQEje2man3Vv
         JPHxFHqIPNXOPgse/XSIpOy9g6HtTie9X3J0CLGB1vxcKnMnJg7l8SiX/phBCEyKHj
         C2LVbe/Egqfe+Kz5MJqp8e8+9s/2gdR4TOkur0+YQaLX0KyUSvS9SVpYT8z7EOg1lV
         7IYIOhMzZClc6KhGWE+BgZTThmn8dK1Zs29oKviwOHO1oXKfY+ogu3iF9yAlm+PDY3
         OCwsTzKWShGZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C1215C098D; Fri, 28 Jan 2022 08:18:36 -0800 (PST)
Date:   Fri, 28 Jan 2022 08:18:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 94/94]
 kernel/rcu/srcutree.c:313:6: warning: no previous prototype for function
 'spin_lock_irqsave_ssp_contention'
Message-ID: <20220128161836.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202201281920.PD1buizH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201281920.PD1buizH-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 07:07:42PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   903a93309e5a59497d3c178cabb67ecc6c843a69
> commit: 903a93309e5a59497d3c178cabb67ecc6c843a69 [94/94] srcu: Add contention-triggered addition of srcu_node tree
> config: arm-s5pv210_defconfig (https://download.01.org/0day-ci/archive/20220128/202201281920.PD1buizH-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/ammarfaizi2/linux-block/commit/903a93309e5a59497d3c178cabb67ecc6c843a69
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout 903a93309e5a59497d3c178cabb67ecc6c843a69
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/rcu/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I will fold in addition of "static" with attribution, thank you!

							Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
> >> kernel/rcu/srcutree.c:313:6: warning: no previous prototype for function 'spin_lock_irqsave_ssp_contention' [-Wmissing-prototypes]
>    void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
>         ^
>    kernel/rcu/srcutree.c:313:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
>    ^
>    static 
>    1 warning generated.
> 
> 
> vim +/spin_lock_irqsave_ssp_contention +313 kernel/rcu/srcutree.c
> 
>    306	
>    307	/*
>    308	 * Acquire the specified srcu_struct structure's ->lock, but check for
>    309	 * excessive contention, which results in initiation of a transition
>    310	 * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
>    311	 * parameter permits this.
>    312	 */
>  > 313	void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
>    314	{
>    315		unsigned long j;
>    316	
>    317		if (spin_trylock_irqsave_rcu_node(ssp, *flags))
>    318			return;
>    319		spin_lock_irqsave_rcu_node(ssp, *flags);
>    320		if (!(convert_to_big & 0x10) || ssp->srcu_size_state)
>    321			return;
>    322		j = jiffies;
>    323		if (ssp->srcu_size_jiffies != j) {
>    324			ssp->srcu_size_jiffies = j;
>    325			ssp->srcu_n_lock_retries = 0;
>    326		}
>    327		if (++ssp->srcu_n_lock_retries <= small_contention_lim)
>    328			return;
>    329		__srcu_transition_to_big(ssp);
>    330	}
>    331	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
