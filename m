Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD8577648
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiGQNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGQNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:00:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D311558E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658062835; x=1689598835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zz4enS7UPLQLRAzwgapexy/+DDWB7gmTh//iegJeK5c=;
  b=MR90XqHrnXQo9gKxcJgzOoC/SBoNDnOGEXrw6UjtHWWRKVj9PkVpOPbb
   S6UFraRy51J1i8lE9I+vvLbCD9cDinvjwr1mzAWsQXd6b8hplnmD6JKSu
   f0w1QY37AUV4tLeBpDdFbL4CXtuYNAWlzlvefOvIw6thKLrT1Tcsxvwuf
   iDmXmwlJ94cuIz7xX5VPao4TmgwDXJLSIdAbOFgabg3bKBUM/mdJXETFi
   dURdpF8FiCztxpL3AtOuUrUHJlVFNtzUCK4prr4DdcAq+C3Ts3o4EC4Ka
   87U4RRpv07TEa4K3fHA/fgzFhyb9qaMaPODOE8N6AjXeLuNxfmwR37r50
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="372369167"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="372369167"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 06:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="699731782"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2022 06:00:32 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD3st-0003GP-Vd;
        Sun, 17 Jul 2022 13:00:31 +0000
Date:   Sun, 17 Jul 2022 20:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: include/linux/mtd/cfi.h:62:2: warning: #warning No CONFIG_MTD_CFI_Ix
 selected. No NOR chip support can work.
Message-ID: <202207172022.V9HOBKg9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   972a278fe60c361eb8f37619f562f092e8786d7c
commit: e23e5a05d1fd9479586c40ffbcc056b3e34ef816 mtd: spi-nor: intel-spi: Convert to SPI MEM
date:   5 months ago
config: alpha-randconfig-r021-20220717 (https://download.01.org/0day-ci/archive/20220717/202207172022.V9HOBKg9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e23e5a05d1fd9479586c40ffbcc056b3e34ef816
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e23e5a05d1fd9479586c40ffbcc056b3e34ef816
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/mtd/spi-nor.h:10,
                    from drivers/spi/spi-intel.c:13:
>> include/linux/mtd/cfi.h:62:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Wcpp]
      62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
         |  ^~~~~~~


vim +62 include/linux/mtd/cfi.h

^1da177e4c3f41 Linus Torvalds  2005-04-16  60  
241651d04d672f David Woodhouse 2007-09-06  61  #ifndef cfi_interleave
241651d04d672f David Woodhouse 2007-09-06 @62  #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
241651d04d672f David Woodhouse 2007-09-06  63  static inline int cfi_interleave(void *cfi)
241651d04d672f David Woodhouse 2007-09-06  64  {
241651d04d672f David Woodhouse 2007-09-06  65  	BUG();
241651d04d672f David Woodhouse 2007-09-06  66  	return 0;
241651d04d672f David Woodhouse 2007-09-06  67  }
241651d04d672f David Woodhouse 2007-09-06  68  #endif
241651d04d672f David Woodhouse 2007-09-06  69  

:::::: The code at line 62 was first introduced by commit
:::::: 241651d04d672fb685b2874707016cbbf95931e5 [MTD] Fix CFI build error when no map width or interleave supported

:::::: TO: David Woodhouse <dwmw2@infradead.org>
:::::: CC: David Woodhouse <dwmw2@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
