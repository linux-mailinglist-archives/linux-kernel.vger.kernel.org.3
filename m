Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35994BEE19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiBUXLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiBUXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:11:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9A245A3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645485046; x=1677021046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4lo2AvmltOX0wyJzTroUsy4VMiEZ3dGjiHN2nL60HAQ=;
  b=Xgs7lBX4wCIeAdEuM3AUOB/uuwle1qo43Sxb47o+d8oi6hutVRKqNSWc
   iaaghspRwslHFYrFrzESF9Z9CB0h+oOSoQqAQjdGPYe/tUGR75PICmOrb
   g/3E9xYilcDYeyBJuNOs1jMD+t7rmfwsdMPDsRVoTA+5sHYwnJnpDE8YF
   LofS6LauYbTS4A7J7WVPjhZtlQqQUYsomdshmZb4a5JHs9eXEs7/g0vnk
   LMm8wGCs6I/tcGGWF15EhMXyOxunlPMdbTY8FytnSZcqoA8NYSoAqMSqr
   1LP+TpuErFHRUveP8hsU+0kDt+H4jH0QU+oUZal0SsXM9vVguYiXamD/F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235118138"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="235118138"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507768902"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 15:10:44 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMHpM-00023G-2I; Mon, 21 Feb 2022 23:10:44 +0000
Date:   Tue, 22 Feb 2022 07:10:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.02.17a 73/73] make[3]: *** No rule to make
 target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/typesafe.mod'.
Message-ID: <202202220748.auwiODXc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
head:   f5b2eaf791ebbd6af881947ab7c40ed70681e534
commit: f5b2eaf791ebbd6af881947ab7c40ed70681e534 [73/73] EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202220748.auwiODXc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f5b2eaf791ebbd6af881947ab7c40ed70681e534
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.02.17a
        git checkout f5b2eaf791ebbd6af881947ab7c40ed70681e534
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/typesafe.mod'.
   make[3]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
