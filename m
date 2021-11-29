Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27A9462570
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhK2WjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhK2Wib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:38:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758EC21884D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=03RItMg0M2HfikfUQJ2uQM/WPVH5m+4bpjbxZJ5j+s8=; b=3HEudj3w0x4FaRvV6GSN6VghFW
        0ilwuhNDZZ0PNXqAFhUbGi5hr7xpnjH0KEnFNSJHXCEYxYsVG6KHgnn8jn8BUzBBWVh+GboRGLnjm
        UX0rvhgY/hBHEtKLYGEj0OfWa3/FQUgnKc3JXsdxh69aFVVdWqfWEXM5LoY6BPNoIUhA6SpvgSFcq
        eO/odnUC9AYOmITea5UuaL75Y9/pB49vzaL6YAvczYPqJPmJNXg0E3gcvIqwLTy+SRpIYz/ECThOS
        s9288SDEqZgy82LHO6t+HCRXG/S4Qbg/78Kpsry4Acja4MUIff1ogy1/OyKGXoeA8aPSzE0twXr3L
        hkF9eGhA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrn0M-002H2F-VF; Mon, 29 Nov 2021 20:12:02 +0000
Date:   Mon, 29 Nov 2021 12:12:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mcgrof-next:20211124-sysctl-cleanups-v2 41/41]
 kernel/kprobes.c:2605:2: error: implicit declaration of function
 'kprobe_sysctls_init'
Message-ID: <YaU0EuR8neVB9hEX@bombadil.infradead.org>
References: <202111271451.VDtFz59Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111271451.VDtFz59Q-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 02:48:14PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211124-sysctl-cleanups-v2
> head:   c66aee3b7120f4a5f1d40cc9109dcf684643cc17
> commit: c66aee3b7120f4a5f1d40cc9109dcf684643cc17 [41/41] kprobe: move sysctl_kprobes_optimization to kprobes.c
> config: arm64-randconfig-r006-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271451.VDtFz59Q-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=c66aee3b7120f4a5f1d40cc9109dcf684643cc17
>         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>         git fetch --no-tags mcgrof-next 20211124-sysctl-cleanups-v2
>         git checkout c66aee3b7120f4a5f1d40cc9109dcf684643cc17
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/kprobes.c:2605:2: error: implicit declaration of function 'kprobe_sysctls_init' [-Werror,-Wimplicit-function-declaration]
>            kprobe_sysctls_init();
>            ^
>    1 error generated.

Fixed.

  Luis
