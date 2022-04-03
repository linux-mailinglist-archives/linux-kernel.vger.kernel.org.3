Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A84F0B36
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359406AbiDCQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiDCQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:22:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA537A9D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649002836; x=1680538836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gmkp8AXOIJEwg8UkE1UtAwUzPUka2ylntopXEhVphGA=;
  b=nh1J7mej4o2h1u27Y8fBvEn4cDMEBEGvafhJtnMWMlw7q7QD6KbR5Db9
   H0trQTcSgv5TdNhqMCbc5wKDsQOEWbTvFpHO2Ulz7gyOln64JsBLhiDFs
   KrMYpzr6NXn3J9gphXrBAWoBC0dkCUUnV8KgtR8caup7fFPQBQhtYkBuh
   cBNybYMOJpa4lKLDIdTTAMHWt6AF66oOJGvaFzjXd+1KzVjHPqQSVjvFd
   7b9Rg4CLCmDS3Mr0o9c72zAfOAuV5fAJaz4sIr9a0dmVhic4XbZzUEDvM
   5UxikqzafchPN0Y01hdMIDb4QiHQ5dns/Uxs9jrgr1o2odcOP8pmQUnci
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="346834062"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="346834062"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 09:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="523328082"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Apr 2022 09:20:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb2xu-00015w-A7;
        Sun, 03 Apr 2022 16:20:34 +0000
Date:   Mon, 4 Apr 2022 00:20:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/fastexp.2022.04.01a 109/158]
 WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference
 from the function ieee802154_iface_init() to the variable .init.text:.L0
Message-ID: <202204040012.4Fu9uBps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/fastexp.2022.04.01a
head:   d9f3e7d671416fdf5b61f094765754269b652db0
commit: c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba [109/158] rcu: Add polled expedited grace-period primitives
config: riscv-randconfig-r002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204040012.4Fu9uBps-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/fastexp.2022.04.01a
        git checkout c1468fd1496363a0b2b2cb89e8ec2ba5e1dce9ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xbcac06): Section mismatch in reference from the function ieee802154_iface_init() to the variable .init.text:.L0
The function ieee802154_iface_init() references
the variable __init .L0 .
This is often because ieee802154_iface_init lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x432e6): Section mismatch in reference from the function dma_get_required_mask() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xe35ca): Section mismatch in reference from the function mlock_page_drain() to the variable .init.text:.LVL125
<< WARNING: modpost: vmlinux.o(.text+0x96a46e): Section mismatch in reference from the function rpmsg_create_ept() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a5b4): Section mismatch in reference from the function rpmsg_destroy_ept() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a5c0): Section mismatch in reference from the function rpmsg_send() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a5d4): Section mismatch in reference from the function rpmsg_sendto() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a5e8): Section mismatch in reference from the function rpmsg_send_offchannel() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a5fc): Section mismatch in reference from the function rpmsg_trysend() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a610): Section mismatch in reference from the function rpmsg_trysendto() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x96a624): Section mismatch in reference from the function rpmsg_poll() to the variable .init.text:.L0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
