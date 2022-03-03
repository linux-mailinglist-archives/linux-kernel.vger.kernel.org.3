Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3E4CBC75
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiCCLWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCCLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:22:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162681795D1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646306513; x=1677842513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/iuZEozBJt22c60CC91WkPJgESWawyjpyId2kx6JMq8=;
  b=nKQkMPaxZSVeaaeiBoXFtBoojJQh8AyObz/mjqCUcDOjlD7CIzlKEd6W
   dshnx7LC6RTzjC27KS6CXMlKNUFEqu4hJFG1XZqAinvMM0pkgRTgiFjRw
   kzFJAIsmP51t8Am2lU3ZlieVZaS34gwP8QTJLG8CuHrjZTSviId/fF4ti
   ZMKDyGAKtP8qhvF0NRKTdnPjbNNv0ozRc0XtaaAY7DT4bVOHzNfsh94GM
   8MuH2y42UtrPteetPACOEBb2NGXnP7p6tDDnTvB7Ky7VSaHkedVISb0j7
   BtgbdVH4sfQXSAs/XCHjGmGv5KDtCQx3D0rZhHeTYRkp+20NhRk+X0hQn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316866180"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316866180"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511394365"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 03:21:51 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjWo-0000Qm-Po; Thu, 03 Mar 2022 11:21:50 +0000
Date:   Thu, 3 Mar 2022 19:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 24/27]
 microblaze-linux-ld: fs/cifs/file.o:undefined reference to
 `netfs_invalidatepage'
Message-ID: <202203031912.4ZBI2sVg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   b295237bb1a924ca0723d728bb5ff30e6461ad2b
commit: a606c4415f43f7122d98648f7e62c669986e6665 [24/27] netfs: Provide invalidatepage and releasepage calls
config: microblaze-defconfig (https://download.01.org/0day-ci/archive/20220303/202203031912.4ZBI2sVg-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a606c4415f43f7122d98648f7e62c669986e6665
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout a606c4415f43f7122d98648f7e62c669986e6665
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x470): undefined reference to `netfs_invalidatepage'
>> microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x474): undefined reference to `netfs_releasepage'
   microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x4c8): undefined reference to `netfs_invalidatepage'
   microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x4cc): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
