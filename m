Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB44D76F0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiCMQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiCMQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:39:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1415A17;
        Sun, 13 Mar 2022 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647189482; x=1678725482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I6qN1Sg+iqsdbF/CTX0o5V6Hvh5AhvG9qew5bwtGzZI=;
  b=SnOxWxR7mNTk38MjTjcnHr7ZIfTlCpfTD8rLv9f049r7k0vevhD2ATUU
   2B9gh3swBl84sUb4/WObkFi0jX37YDOe81kOlqyixNjpe4ETnp312474G
   4m0TA7fg5hXTTo8BRPkUMiVr7i8Bt97NKljIrYQgXJDvjWpPYT2QO0r1r
   RB3bQCoaOz/5xGXgaK2iIW3e9e51P+xAUFHJ/JiWaLpncdOJosh3GC1g+
   YjddtVe03KHWsIovwYc2NKr6rtOHoqizXFBU8u0su3jJYPOa3Wv0+MLiZ
   k20kIdpqxS9orfEnmaRzWqH4PWSol4FQKOkeX9PmnGjLB4VbRUW9XHHaJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253442975"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="253442975"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 09:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="539643470"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2022 09:38:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTREG-00097E-2w; Sun, 13 Mar 2022 16:38:00 +0000
Date:   Mon, 14 Mar 2022 00:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [mchehab-media-next:master 314/316] scripts/Makefile.build:44:
 drivers/media/platform/nvidia/Makefile: No such file or directory
Message-ID: <202203140022.R4erbrkI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/mchehab/media-next.git master
head:   9d8c4cc1be6c37e66662141f1a3ebc8b54cb8dae
commit: 63533d0167e608fde8c40a7579e6ac22b1ffdfbc [314/316] media: platform: Create vendor/{Makefile,Kconfig} files
config: arc-randconfig-r043-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140022.R4erbrkI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add mchehab-media-next git://linuxtv.org/mchehab/media-next.git
        git fetch --no-tags mchehab-media-next master
        git checkout 63533d0167e608fde8c40a7579e6ac22b1ffdfbc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> scripts/Makefile.build:44: drivers/media/platform/nvidia/Makefile: No such file or directory
>> make[5]: *** No rule to make target 'drivers/media/platform/nvidia/Makefile'.
   make[5]: Failed to remake makefile 'drivers/media/platform/nvidia/Makefile'.


vim +44 scripts/Makefile.build

20a468b51325b3 Sam Ravnborg   2006-01-22  40  
2a691470345a00 Sam Ravnborg   2005-07-25  41  # The filename Kbuild has precedence over Makefile
db8c1a7b2ca25f Sam Ravnborg   2005-07-27  42  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
0c53c8e6eb456c Sam Ravnborg   2007-10-14  43  kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
0c53c8e6eb456c Sam Ravnborg   2007-10-14 @44  include $(kbuild-file)
^1da177e4c3f41 Linus Torvalds 2005-04-16  45  

:::::: The code at line 44 was first introduced by commit
:::::: 0c53c8e6eb456cde30f2305421c605713856abc8 kbuild: check for wrong use of CFLAGS

:::::: TO: Sam Ravnborg <sam@neptun.(none)>
:::::: CC: Sam Ravnborg <sam@neptun.(none)>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
