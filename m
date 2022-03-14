Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725A94D78E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiCNAR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiCNARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:17:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079BC14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647217007; x=1678753007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sfFBQAo7hXLFgUm37R6x+20YBYCyNxyG94GPVGWMing=;
  b=Z+NzlzTfSj0+98XwsvohOIge5bAB7Ay75kFzkQ2FZmoSJHvN1PIOGG2K
   9oWCJJq6rjOyz7VplE0xvpGhLh1mxosxJ01Z4hz7pNuoqExIyGALHwSa2
   k69lC+WlPc8Cci34fNZPnr3cmf0Mvrto76W4S/sV+ME3U1iiH5LfMMeeK
   S9c4zsz4cKR2vyCYKVMu3I3fHc1tTEZxbZrnCqjG7NpChnoOvLkUzDZMh
   kfdEcTarIGab5zS+PQRtkXLmr+win76DTpbGnuWoAAJV4dVSi9HUUJwc3
   qbbArb++pD1uX+DWa54ObaTNSzNsSnyABOIgpUQZSbXla60SVxzNwq2rX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238079871"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="238079871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 17:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="713519179"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 17:16:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTYOC-0009Pc-IA; Mon, 14 Mar 2022 00:16:44 +0000
Date:   Mon, 14 Mar 2022 08:16:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] include/linux/bpf.h:2064:16: warning:
 returning 'void *' from a function with return type 'int' makes integer from
 pointer without a cast
Message-ID: <202203140827.59L5Sn1E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 28d9ca982b9ae96bcad2bee81647ba18ae049a69 [7/9] bpf: Enable direct packet access for dequeue packets
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220314/202203140827.59L5Sn1E-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=28d9ca982b9ae96bcad2bee81647ba18ae049a69
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 28d9ca982b9ae96bcad2bee81647ba18ae049a69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:99:
   include/linux/bpf.h:2062:15: error: return type defaults to 'int' [-Werror=return-type]
    2062 | static inline bpf_get_btf_vmlinux(void)
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h: In function 'bpf_get_btf_vmlinux':
>> include/linux/bpf.h:2064:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2064 |         return ERR_PTR(-EINVAL);
         |                ^~~~~~~~~~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:764:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     764 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:859:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     859 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/filter.h:9,
                    from kernel/sysctl.c:35:
   include/linux/bpf.h:2062:15: error: return type defaults to 'int' [-Werror=return-type]
    2062 | static inline bpf_get_btf_vmlinux(void)
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h: In function 'bpf_get_btf_vmlinux':
>> include/linux/bpf.h:2064:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2064 |         return ERR_PTR(-EINVAL);
         |                ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/filter.h:9,
                    from kernel/kallsyms.c:25:
   include/linux/bpf.h:2062:15: error: return type defaults to 'int' [-Werror=return-type]
    2062 | static inline bpf_get_btf_vmlinux(void)
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h: In function 'bpf_get_btf_vmlinux':
>> include/linux/bpf.h:2064:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2064 |         return ERR_PTR(-EINVAL);
         |                ^~~~~~~~~~~~~~~~
   kernel/kallsyms.c: At top level:
   kernel/kallsyms.c:587:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     587 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2064 include/linux/bpf.h

  2061	
> 2062	static inline bpf_get_btf_vmlinux(void)
  2063	{
> 2064		return ERR_PTR(-EINVAL);
  2065	}
  2066	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
