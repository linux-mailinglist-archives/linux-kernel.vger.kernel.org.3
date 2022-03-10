Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C004D3DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiCJAGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCJAGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:06:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF9A66CB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646870744; x=1678406744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MpxXGf/FuVKUN6k7lUKiY8jdPAQXZ2nzMA7FbkpCiJg=;
  b=Qcw3m6MVWULEfmvlWrB/rgZ6fwx++p92yp17qCJmI5EWeLnX/KogS0UX
   5C2KySwxGivITh/fI/vUp0862V8Ih97pNYGcuQ5tmDavn9CBfY0CALhRD
   TeQUqWjdBK/KPYHEDJgaGQdt88adr23WUKMNaIMfw3bd2ZWGv2aW2SoWw
   ck7kL+FryaHFNr36d/hej5fN5rvU4X0fYgTVCf1gaLpjzekaLlTP6TZvj
   CfBImgZiD+dPzvdeXDHMj7Qja1kX+N/9/Futwi8Bbr1cJBh1TtGm/AakP
   lFYIZJGaHPwANQWyjC7OuvqvAjodn5u9PXix83LWX11A11TmhbLRZX4DY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237288040"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="237288040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="688472476"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2022 16:05:30 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS6J7-00040U-U9; Thu, 10 Mar 2022 00:05:29 +0000
Date:   Thu, 10 Mar 2022 08:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: powerpc64-linux-ld: warning: orphan section `.stubs' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
Message-ID: <202203100720.rVnlJeGC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 8581fd402a0cf80b5298e3b225e7a7bd8f110e69 treewide: Add missing includes masked by cgroup -> bpf dependency
date:   3 months ago
config: powerpc64-randconfig-r003-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100720.rVnlJeGC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8581fd402a0cf80b5298e3b225e7a7bd8f110e69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8581fd402a0cf80b5298e3b225e7a7bd8f110e69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.stubs'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
