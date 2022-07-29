Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76047584AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiG2Es0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2EsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:48:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD4F48E90
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659070103; x=1690606103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GwIJZ/2I+Nh+IzmWCA7HuykA1BfbRTab2WxplwBqde4=;
  b=ByRb/Kifo7UcZ4merX9MtI576fTgeXrjY5ZO8dyZuH9TBod6AEyOxwNS
   6VWF1XAa2uF0CbW7tPcPTIBlGjmq80Juz54L15Ga+YHK/hqqUy4lyrrWb
   FqnKRP7CJkhG8e1xuQriIidFKdsg7qRGh32jxZa5rNlBW50WiiRZ3YoPg
   Q4ZY9pymNt/g+pmnxwUBhsEHXGverqW9G0RVclz4zGhgkGJmPH66gAXYN
   UWuI0KGkV7hnZmSzQ4MVwKWU1k4Tj5vGRqEepXqyRjF3DG8D/yqBu423s
   idbK0l3rwk1uJTiNPa+7SMvL34da2CNvty7UxBPMiQyajzAvklIVMwA88
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="287444305"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="287444305"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 21:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="669150026"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 21:48:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHHvA-000B74-2g;
        Fri, 29 Jul 2022 04:48:20 +0000
Date:   Fri, 29 Jul 2022 12:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.19.y 437/3409] net/core/sock.c:1090: Error:
 unrecognized opcode `csrs sstatus,s11'
Message-ID: <202207291224.I3LLPz5B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   f68ffa0f9e2ab245b3284831e972b55c677ce706
commit: 0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86 [437/3409] af_unix: fix races in sk_peer_pid and sk_peer_cred accesses
config: riscv-randconfig-r012-20220726 (https://download.01.org/0day-ci/archive/20220729/202207291224.I3LLPz5B-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:419:41: note: in expansion of macro 'unlikely'
     419 | #define static_branch_unlikely(x)       unlikely(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~
   include/linux/memcontrol.h:1247:36: note: in expansion of macro 'static_branch_unlikely'
    1247 | #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:2530:13: note: in expansion of macro 'mem_cgroup_sockets_enabled'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:61:31: warning: ignoring attribute 'section ("_ftrace_branch")' because it conflicts with previous 'section ("_ftrace_annotated_branch")' [-Wattributes]
      61 |                 static struct ftrace_branch_data                        \
         |                               ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:49: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                                 ^~~~
   net/core/sock.c:2530:9: note: in expansion of macro 'if'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:419:41: note: in expansion of macro 'unlikely'
     419 | #define static_branch_unlikely(x)       unlikely(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/jump_label.h:327:9: note: in expansion of macro 'if'
     327 |         if (!__builtin_types_compatible_p(typeof(*x), struct static_key) &&     \
         |         ^~
   include/linux/jump_label.h:419:50: note: in expansion of macro 'static_key_enabled'
     419 | #define static_branch_unlikely(x)       unlikely(static_key_enabled(&(x)->key))
         |                                                  ^~~~~~~~~~~~~~~~~~
   include/linux/memcontrol.h:1247:36: note: in expansion of macro 'static_branch_unlikely'
    1247 | #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:2530:13: note: in expansion of macro 'mem_cgroup_sockets_enabled'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:28:33: note: previous declaration here
      28 |                                 ______f = {                             \
         |                                 ^~~~~~~
   include/linux/compiler.h:58:49: note: in definition of macro '__trace_if'
      58 |         if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
         |                                                 ^~~~
   net/core/sock.c:2530:9: note: in expansion of macro 'if'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:419:41: note: in expansion of macro 'unlikely'
     419 | #define static_branch_unlikely(x)       unlikely(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~
   include/linux/memcontrol.h:1247:36: note: in expansion of macro 'static_branch_unlikely'
    1247 | #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:2530:13: note: in expansion of macro 'mem_cgroup_sockets_enabled'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   net/core/sock.c:2530:9: note: in expansion of macro 'if'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:419:41: note: in expansion of macro 'unlikely'
     419 | #define static_branch_unlikely(x)       unlikely(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~
   include/linux/memcontrol.h:1247:36: note: in expansion of macro 'static_branch_unlikely'
    1247 | #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~
   net/core/sock.c:2530:13: note: in expansion of macro 'mem_cgroup_sockets_enabled'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   net/core/sock.c:2530:9: note: in expansion of macro 'if'
    2530 |         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
         |         ^~
   net/core/sock.c: Assembler messages:
   net/core/sock.c:610: Error: unrecognized opcode `csrs sstatus,a5'
   net/core/sock.c:610: Error: unrecognized opcode `csrc sstatus,a5'
   net/core/sock.c:1112: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1112: Error: unrecognized opcode `csrc sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrc sstatus,a4'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrs sstatus,s11'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrc sstatus,s11'
   net/core/sock.c:1420: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1420: Error: unrecognized opcode `csrc sstatus,a4'
   net/core/sock.c:673: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:673: Error: unrecognized opcode `csrc sstatus,a4'


vim +1090 net/core/sock.c

3f551f9436c05a Eric W. Biederman 2010-06-13  1083  
28b5ba2aa0f55d David Herrmann    2017-06-21  1084  static int groups_to_user(gid_t __user *dst, const struct group_info *src)
28b5ba2aa0f55d David Herrmann    2017-06-21  1085  {
28b5ba2aa0f55d David Herrmann    2017-06-21  1086  	struct user_namespace *user_ns = current_user_ns();
28b5ba2aa0f55d David Herrmann    2017-06-21  1087  	int i;
28b5ba2aa0f55d David Herrmann    2017-06-21  1088  
28b5ba2aa0f55d David Herrmann    2017-06-21  1089  	for (i = 0; i < src->ngroups; i++)
28b5ba2aa0f55d David Herrmann    2017-06-21 @1090  		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
28b5ba2aa0f55d David Herrmann    2017-06-21  1091  			return -EFAULT;
28b5ba2aa0f55d David Herrmann    2017-06-21  1092  
28b5ba2aa0f55d David Herrmann    2017-06-21  1093  	return 0;
28b5ba2aa0f55d David Herrmann    2017-06-21  1094  }
28b5ba2aa0f55d David Herrmann    2017-06-21  1095  

:::::: The code at line 1090 was first introduced by commit
:::::: 28b5ba2aa0f55d80adb2624564ed2b170c19519e net: introduce SO_PEERGROUPS getsockopt

:::::: TO: David Herrmann <dh.herrmann@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
