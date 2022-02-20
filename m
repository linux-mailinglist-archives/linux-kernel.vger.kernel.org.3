Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705A4BD161
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiBTUUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiBTUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8264C783
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645388392; x=1676924392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3PqThoQs7A3jRhv9b5IrLNFPWKtT2W4Mm8oW2k1KaJA=;
  b=AtQ1+D9TVCl49EANde+SqHxUcw+kFjbJdsibHZGAS8XlFtbJ0nRoO/3A
   Wo5owehucH9x4bo6ktgq5ZJJ93MbT1Ps/FyrYwNdAvoGXvaiLHbANTcNk
   ahB78zZ7TaobpcTGaAUCtEnxu+uJe2IJLO40sk+mA7Bqo+swhG6i+2J24
   aDdQoQLyYmcG/NPbvl4VRzTGafqZlN4Z3V7m9JEdKrIVlSZkhltSINkMr
   k798sU0YvS8ixJFCLDnLmm9J0lp3RbWFKN9co5CWzUwYByEICUPBlioUU
   O12YzyGzrjQMo/HW/fQjlVvK+RKMdhOGQ5w3W65SKNBAJeUN2wk367/CG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="275989826"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="275989826"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 12:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504624690"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 12:19:50 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLsgP-0000iA-QZ; Sun, 20 Feb 2022 20:19:49 +0000
Date:   Mon, 21 Feb 2022 04:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:modules-next 6/10] kernel/module/strict_rwx.c:16:10: error:
 implicit declaration of function 'PAGE_ALIGNED'
Message-ID: <202202210447.UvDGgsQA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   c55dc78176e6fe97a9e92d24a7ff3015b14ac858
commit: e5973a14d18785b893d383fbd9dc2f98edc16f1b [6/10] module: Move strict rwx support to a separate file
config: arm64-randconfig-r005-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210447.UvDGgsQA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=e5973a14d18785b893d383fbd9dc2f98edc16f1b
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout e5973a14d18785b893d383fbd9dc2f98edc16f1b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/module/strict_rwx.c:16:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->base));
                   ^
   kernel/module/strict_rwx.c:17:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->text_size));
                   ^
   kernel/module/strict_rwx.c:18:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->ro_size));
                   ^
   kernel/module/strict_rwx.c:26:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->base));
                   ^
   kernel/module/strict_rwx.c:27:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->ro_size));
                   ^
   kernel/module/strict_rwx.c:28:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
                   ^
   kernel/module/strict_rwx.c:36:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->base));
                   ^
   kernel/module/strict_rwx.c:37:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
                   ^
   kernel/module/strict_rwx.c:38:10: error: implicit declaration of function 'PAGE_ALIGNED' [-Werror,-Wimplicit-function-declaration]
           BUG_ON(!PAGE_ALIGNED(layout->size));
                   ^
   9 errors generated.


vim +/PAGE_ALIGNED +16 kernel/module/strict_rwx.c

    12	
    13	void frob_rodata(const struct module_layout *layout,
    14			 int (*set_memory)(unsigned long start, int num_pages))
    15	{
  > 16		BUG_ON(!PAGE_ALIGNED(layout->base));
    17		BUG_ON(!PAGE_ALIGNED(layout->text_size));
    18		BUG_ON(!PAGE_ALIGNED(layout->ro_size));
    19		set_memory((unsigned long)layout->base + layout->text_size,
    20			   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
    21	}
    22	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
