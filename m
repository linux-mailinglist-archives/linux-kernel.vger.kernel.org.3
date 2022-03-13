Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9F4D78D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 00:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiCMXuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 19:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiCMXrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 19:47:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D564C7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647215205; x=1678751205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wMf00R80cVF9qHEEHx61TQwqkfmpJ3tk31BJz9qEcok=;
  b=a6vzues0T1oEWS6nQDX+qrbdGvgfE0ESPGK4xIzSX+/acngcNslSijSV
   polp7waZxiaexoO4b4tNK0KYmYqMZEDhCvfIEpl26CgzY464ZpvbY31Ea
   VqTKRW7gVrLlqURVpvRU/sNfjHfLO2SYnp+UwODDzb/yy0EWlzrmpAsIX
   v1BS+uTrvk+UtWMMsXJJHFkmWRAn6x3eiHcA4ANOuZ7i+tRn8tFIKzVNK
   wBfGmHBWOB0MDP7/VqKL60BF70S5935BIChTyf4Huo2HLnCPFBuLtjr9Y
   sHTIYbtpC2HjO47y+DYHSObO83mHOYxASyo6cM+yCuuVe5bPf7zOuGX4W
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255637274"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="255637274"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 16:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="515207768"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 16:46:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTXv8-0009OV-ES; Sun, 13 Mar 2022 23:46:42 +0000
Date:   Mon, 14 Mar 2022 07:45:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 7/9] include/linux/bpf.h:2064:9: warning:
 incompatible pointer to integer conversion returning 'void *' from a
 function with result type 'int'
Message-ID: <202203140739.otiRAMwr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 28d9ca982b9ae96bcad2bee81647ba18ae049a69 [7/9] bpf: Enable direct packet access for dequeue packets
config: hexagon-randconfig-r045-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140739.otiRAMwr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=28d9ca982b9ae96bcad2bee81647ba18ae049a69
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 28d9ca982b9ae96bcad2bee81647ba18ae049a69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/core/sock.c:133:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:2064:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EINVAL);
                  ^~~~~~~~~~~~~~~~
   1 warning generated.
--
   In file included from net/core/dev.c:95:
>> include/linux/bpf.h:2064:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EINVAL);
                  ^~~~~~~~~~~~~~~~
   net/core/dev.c:5011:1: warning: unused function 'sch_handle_ingress' [-Wunused-function]
   sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
   ^
   net/core/dev.c:5160:19: warning: unused function 'nf_ingress' [-Wunused-function]
   static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
                     ^
   3 warnings generated.
--
   In file included from net/core/filter.c:38:
   In file included from include/linux/skmsg.h:7:
>> include/linux/bpf.h:2064:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EINVAL);
                  ^~~~~~~~~~~~~~~~
>> net/core/filter.c:9720:14: warning: incompatible integer to pointer conversion assigning to 'struct btf *' from 'int' [-Wint-conversion]
           btf_vmlinux = bpf_get_btf_vmlinux();
                       ^ ~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:9848:14: warning: incompatible integer to pointer conversion assigning to 'struct btf *' from 'int' [-Wint-conversion]
           btf_vmlinux = bpf_get_btf_vmlinux();
                       ^ ~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
   In file included from net/core/net-traces.c:35:
   In file included from include/trace/events/tcp.h:12:
   In file included from include/net/tcp.h:35:
   In file included from include/net/sock_reuseport.h:5:
   In file included from include/linux/filter.h:9:
>> include/linux/bpf.h:2064:9: warning: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
           return ERR_PTR(-EINVAL);
                  ^~~~~~~~~~~~~~~~
   In file included from net/core/net-traces.c:50:
   In file included from include/trace/events/neigh.h:255:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:873:
   include/trace/events/neigh.h:42:20: warning: variable 'pin6' set but not used [-Wunused-but-set-variable]
                   struct in6_addr *pin6;
                                    ^
   2 warnings generated.


vim +2064 include/linux/bpf.h

  2061	
  2062	static inline bpf_get_btf_vmlinux(void)
  2063	{
> 2064		return ERR_PTR(-EINVAL);
  2065	}
  2066	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
