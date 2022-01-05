Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C448523C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiAEMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:04:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:48520 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239972AbiAEMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641384282; x=1672920282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kYIb/dOGRrqK3IjlCBA1zi0pKK37fygCdMsbt9ergPk=;
  b=lxAdILwGc+wCrLMrjyG+wc/Fn+kAc/7zv4InaZfPMCtqykNFJU7nxU5d
   Krsd4uwv3fxMBV+pxWpcRYcQQkDUTnk/2DVE/5SVnmm+ZfoDwcKjvcJH1
   QQvy0zVnRRhJduVbd3vZDEt9aE6Np653IGx/raJ/3dy1rZ5ac8Zuzf5z/
   UMFcIxQs/dw+BBgNftZAuHRjDUBZxyzXAjOYnG7t88dUS/RRaoq2naEm/
   iRSL/Oh0+bUmY03kDTg0oCnKVBsyYgeqCuvV/+bxP8PA38RtPIXTzcuaK
   nis6C8rA75+5+xxdnOAD898j0R55FRKJW0iLyAA9Q1x/NIUmhuGkTh2wm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229242469"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="229242469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="472469743"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2022 04:04:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n551x-000Ga0-Sy; Wed, 05 Jan 2022 12:04:37 +0000
Date:   Wed, 5 Jan 2022 20:03:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/ipv6/ip6_gre.c:861:20: warning: unused function
 'ip6gre_tnl_addr_conflict'
Message-ID: <202201051937.PF3UZQy3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 919067cc845f323a80b6fe987b64238bd82d309e net: add CONFIG_PCPU_DEV_REFCNT
date:   10 months ago
config: mips-randconfig-r002-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051937.PF3UZQy3-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=919067cc845f323a80b6fe987b64238bd82d309e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 919067cc845f323a80b6fe987b64238bd82d309e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/msm/ fs/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv6/ip6_gre.c:861:20: warning: unused function 'ip6gre_tnl_addr_conflict'
   static inline bool ip6gre_tnl_addr_conflict(const struct ip6_tnl
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/atomic.h", .line = 154, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-d5b6e30ed3/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel net nr_bisected scripts sound source usr


vim +/ip6gre_tnl_addr_conflict +861 net/ipv6/ip6_gre.c

c12b395a46646b xeb@mail.ru 2012-08-10  846  
c12b395a46646b xeb@mail.ru 2012-08-10  847  /**
7ccbdff13e8df6 Sun Lianwen 2018-05-03  848   * ip6gre_tnl_addr_conflict - compare packet addresses to tunnel's own
c12b395a46646b xeb@mail.ru 2012-08-10  849   *   @t: the outgoing tunnel device
c12b395a46646b xeb@mail.ru 2012-08-10  850   *   @hdr: IPv6 header from the incoming packet
c12b395a46646b xeb@mail.ru 2012-08-10  851   *
c12b395a46646b xeb@mail.ru 2012-08-10  852   * Description:
c12b395a46646b xeb@mail.ru 2012-08-10  853   *   Avoid trivial tunneling loop by checking that tunnel exit-point
c12b395a46646b xeb@mail.ru 2012-08-10  854   *   doesn't match source of incoming packet.
c12b395a46646b xeb@mail.ru 2012-08-10  855   *
c12b395a46646b xeb@mail.ru 2012-08-10  856   * Return:
c12b395a46646b xeb@mail.ru 2012-08-10  857   *   1 if conflict,
c12b395a46646b xeb@mail.ru 2012-08-10  858   *   0 else
c12b395a46646b xeb@mail.ru 2012-08-10  859   **/
c12b395a46646b xeb@mail.ru 2012-08-10  860  
c12b395a46646b xeb@mail.ru 2012-08-10 @861  static inline bool ip6gre_tnl_addr_conflict(const struct ip6_tnl *t,
c12b395a46646b xeb@mail.ru 2012-08-10  862  	const struct ipv6hdr *hdr)
c12b395a46646b xeb@mail.ru 2012-08-10  863  {
c12b395a46646b xeb@mail.ru 2012-08-10  864  	return ipv6_addr_equal(&t->parms.raddr, &hdr->saddr);
c12b395a46646b xeb@mail.ru 2012-08-10  865  }
c12b395a46646b xeb@mail.ru 2012-08-10  866  

:::::: The code at line 861 was first introduced by commit
:::::: c12b395a46646bab69089ce7016ac78177f6001f gre: Support GRE over IPv6

:::::: TO: xeb@mail.ru <xeb@mail.ru>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
