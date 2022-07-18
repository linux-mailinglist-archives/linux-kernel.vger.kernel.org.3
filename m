Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43907577ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiGRGLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:11:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A113D48
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658124689; x=1689660689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cnaZL0okJWu2Bne9sqAJpwDk2N2K9An+W28MpsD19Ds=;
  b=EsKVCe6zDaOs8oxZ4GVEvRW9/Ozxdz4Ppzh46mLe529onAtT8rLtSmLJ
   LuOXPVj74WhJgRjb4WGi2MyJf1icAW4Zy+6Nwo6EGH0KVNR03/3Y7YtEn
   hzZIx7XRwwUGGGozbh1l6jSX4EMe3miFvj29huNG+pqd0EQ+vzq4hqHJX
   axToTfur24KihiHJhIwps9qZjQzYZseZuIis+REgQAWyFAXml70SP9pm+
   Jw7dENWhqLNAP+TDbqyVHqiJzmyaGRqErKpXbckMMOodRTc5JrWXcEq3o
   X0hFIZ4hbCAexALkAdmhJ0JBOr/oQB7t0nDXDk/QsxS4Hi13n/4p19Zpz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269166490"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269166490"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="843162746"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2022 23:11:26 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDJyY-00045M-46;
        Mon, 18 Jul 2022 06:11:26 +0000
Date:   Mon, 18 Jul 2022 14:10:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: [linux-stable-rc:linux-4.19.y 458/3297] net/core/sock.c:1090: Error:
 unrecognized opcode `csrs sstatus,s9'
Message-ID: <202207181435.EWCRFx9Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   e8b2a9c3318357b7661c6075acdb723587def656
commit: 7581fdf6c01991f03b1b51d524f1b7b64c920ce3 [458/3297] cred: allow get_cred() and put_cred() to be given NULL.
config: riscv-randconfig-c024-20220717 (https://download.01.org/0day-ci/archive/20220718/202207181435.EWCRFx9Y-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=7581fdf6c01991f03b1b51d524f1b7b64c920ce3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 7581fdf6c01991f03b1b51d524f1b7b64c920ce3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/include/asm/irqflags.h: Assembler messages:
   arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc a5,sstatus,2'
   arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,a5'
   net/core/sock.c:673: Error: unrecognized opcode `csrs sstatus,a5'
   net/core/sock.c:673: Error: unrecognized opcode `csrc sstatus,a5'
   net/core/sock.c:1112: Error: unrecognized opcode `csrs sstatus,a5'
   net/core/sock.c:1112: Error: unrecognized opcode `csrc sstatus,a5'
   net/core/sock.c:1267: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrc sstatus,a4'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrs sstatus,s9'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrc sstatus,s9'
   net/core/sock.c:610: Error: unrecognized opcode `csrs sstatus,a5'
   net/core/sock.c:610: Error: unrecognized opcode `csrc sstatus,a5'
   net/core/sock.c:1420: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1420: Error: unrecognized opcode `csrc sstatus,a4'


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
