Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B509354C270
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353906AbiFOHJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351335AbiFOHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:09:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1462A73F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655276952; x=1686812952;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8fTgBvL6P0eUrU5S5+7FOJlRJGtlGcAyVk620KXCeWY=;
  b=hjt0++YQ1TX1mZnS5gqV5V+YufuvCUEnOkfus32cRmJjgx1eVatNYB4j
   ontqldoe8v34kJDHg0h85ZkpHDOZj2MCBcqsKfqKVfgIl1pume/ycPp7F
   249rB3vnUu7ZYyX4gYAJURGsZ4NuEktOxYuCqqEh5dpr6BE5+Fe9wKQSA
   oGWDJpEI73+m6p5C21PZ3v+pAWcR0DbgbcA2JomyZ9aZudf/6J489gTgp
   UIC905cH+Q+EwSWoon/8fK9j5R/stx3OlMVyTVavrisTFdwUVA9upWsrQ
   kpjZXQaZfq6/MPxKWxBySHrITTx8Z4ZhjG9Gbbo66GfZzJq6ug9KHeMW9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342825444"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342825444"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 00:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830884202"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2022 00:09:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1N9E-000Mef-BJ;
        Wed, 15 Jun 2022 07:09:04 +0000
Date:   Wed, 15 Jun 2022 15:08:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [stffrdhrn:or1k-virt 1/4] drivers/parport/parport_pc.c:68:10: fatal
 error: asm/parport.h: No such file or directory
Message-ID: <202206151530.3eDDbhQ1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/stffrdhrn/linux.git or1k-virt
head:   a0ea15d897c0baa5a4dc8f4ec3c8839527c43e89
commit: a65c4ddd8782b2255f4387fd1273b96dacc7c8a6 [1/4] openrisc: Add pci bus support
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20220615/202206151530.3eDDbhQ1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/stffrdhrn/linux/commit/a65c4ddd8782b2255f4387fd1273b96dacc7c8a6
        git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
        git fetch --no-tags stffrdhrn or1k-virt
        git checkout a65c4ddd8782b2255f4387fd1273b96dacc7c8a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/parport/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/parport/parport_pc.c:68:10: fatal error: asm/parport.h: No such file or directory
      68 | #include <asm/parport.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.


vim +68 drivers/parport/parport_pc.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  64  
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  #include <linux/parport.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  #include <linux/parport_pc.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  #include <linux/via.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16 @68  #include <asm/parport.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16  69  

:::::: The code at line 68 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
