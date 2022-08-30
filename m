Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFF5A6081
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH3KRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiH3KQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:16:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D9F8260
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661854425; x=1693390425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6z+he6W5PM2UZdejK5EeZjXD+k1l6Ef9YraX41eHvS8=;
  b=lhAoHaAQRzySk3O/BIQdcEqTtcsS4sMF9LpGQI/wkuygt8M9zYQveFIO
   UaUgmYsbR7Y4tfIuglxf0XkqnGFB4N6qsYWgmaPR2lBiSarnoAf/n28wx
   aPUUTEmXavydIddH3MXEseL3IDtogx9/vChYW4UiR7jA0Z7hHMWUe/04N
   p4xEPwTt+3ZPC3a5/5kK/DGJ6D43T+YVnto7qeORMWk2Mo/09G+cR9efn
   fol2VE2m72j5dWKFkQ7XGGeNUuGD1I46is3AUTwaxpuOuiQde9jZI6t1p
   TysS8fgEHvqwaeVqF6w7o5Eut8U6iF08jQt2wNPG8tXDsAahq6qUHo6TC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359099940"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="359099940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="700934087"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 03:13:03 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSyEw-0000Am-1C;
        Tue, 30 Aug 2022 10:13:02 +0000
Date:   Tue, 30 Aug 2022 18:12:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.19.y 437/3764] net/core/sock.c:1090: Error:
 unrecognized opcode `csrs sstatus,s9'
Message-ID: <202208301804.Vok0kvBk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   cbdeb714075662db12b9a4819f15f1856e8ed7ec
commit: 0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86 [437/3764] af_unix: fix races in sk_peer_pid and sk_peer_cred accesses
config: riscv-randconfig-c042-20220829 (https://download.01.org/0day-ci/archive/20220830/202208301804.Vok0kvBk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
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

   net/core/sock.c: Assembler messages:
   net/core/sock.c:673: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:673: Error: unrecognized opcode `csrc sstatus,a4'
   net/core/sock.c:1112: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1112: Error: unrecognized opcode `csrc sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrc sstatus,a4'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrs sstatus,s9'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrc sstatus,s9'
   net/core/sock.c:1420: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1420: Error: unrecognized opcode `csrc sstatus,a4'


vim +1090 net/core/sock.c

3f551f9436c05a3 Eric W. Biederman 2010-06-13  1083  
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1084  static int groups_to_user(gid_t __user *dst, const struct group_info *src)
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1085  {
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1086  	struct user_namespace *user_ns = current_user_ns();
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1087  	int i;
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1088  
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1089  	for (i = 0; i < src->ngroups; i++)
28b5ba2aa0f55d8 David Herrmann    2017-06-21 @1090  		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1091  			return -EFAULT;
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1092  
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1093  	return 0;
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1094  }
28b5ba2aa0f55d8 David Herrmann    2017-06-21  1095  

:::::: The code at line 1090 was first introduced by commit
:::::: 28b5ba2aa0f55d80adb2624564ed2b170c19519e net: introduce SO_PEERGROUPS getsockopt

:::::: TO: David Herrmann <dh.herrmann@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
