Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D751FF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiEIOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiEIOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:05:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E841625
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652104902; x=1683640902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uupMX9zHYvI4gNmf/oxsxQtSsp4d1IYNBRa3cNNwg9Y=;
  b=jq9UfWMao9qOdgbvSSzF9e9DaDJY08dvf/95elauAQVf8c3MhyMG6hHs
   MSkcryW9KXWbdB4A8d+0dZoscAlEseO2ze/hwVD5G2fJdU/bZzqMFQ19o
   Y/Jg2VO/XKvFl1Y8aC1zNtXIDhPDvVSLJfTFqmZkme+5fAM57YFoZ9eWE
   2f4ycFIfW6Rr6FCCqV8gHfR+GRZLDpvOOsy4g8H06hvjwNjdi0mGB4fXl
   6ZVf6ZoY5K7WPO01fWhXasgknHZyqKwZhIqLre4amcE1++m0ZxRJU9o3G
   lk5t1fzh9vj7MVV+LviqEdSiNm0j4DGxxGn2zjHqSSX2uDCKO/+BZ4u34
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269194323"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="269194323"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:01:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592430745"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:01:10 -0700
Date:   Mon, 9 May 2022 21:59:23 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:timers/core 1/8] WARNING: modpost:
 vmlinux.o(.text+0xc28c04): Section mismatch in reference from the function
 sock_from_file() to the variable .init.text:.LFB3599
Message-ID: <YnkeO+9cLB+Ydsun@rli9-dbox>
References: <202205091925.kRfA1mR4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091925.kRfA1mR4-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:26:29PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> head:   f4b62e1e1137507268c2c63dc4e6da279dc58e9f
> commit: 3dc6ffae2da201284cb24af66af77ee0bbb2efaa [1/8] timekeeping: Introduce fast accessor to clock tai
> config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091925.kRfA1mR4-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3dc6ffae2da201284cb24af66af77ee0bbb2efaa
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip timers/core
>         git checkout 3dc6ffae2da201284cb24af66af77ee0bbb2efaa
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):

Sorry, kindly ignore this report, which is a false positive. We will
block such report in future.

> 
> >> WARNING: modpost: vmlinux.o(.text+0xc28c04): Section mismatch in reference from the function sock_from_file() to the variable .init.text:.LFB3599
> The function sock_from_file() references
> the variable __init .LFB3599.
> This is often because sock_from_file lacks a __init
> annotation or the annotation of .LFB3599 is wrong.
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xbad7d2): Section mismatch in reference from the function comedi_proc_cleanup() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.exit.text+0x8562): Section mismatch in reference from the function lirc_dev_exit() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_rnglists:.LLRL39
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
