Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B3504ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiDRK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDRK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:27:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2F19C10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650277478; x=1681813478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aciEQzyL1MqhGQqKm7QoCGDt+R4s3XKB/DFtDwxqTgM=;
  b=HCwQDzVwTJCr4gMnrtulx3ih65BaewWRPkdoXXABd2YmHiEztBI7Lbl5
   6cMG3xC4QjttzdripFVOgPbyxqTuEXJLrl62DZYJ8O6lBU5onLCzz2WU+
   mitLlYli0jDk5CIP2ygK/f+FbPxENGwpaIy34EYTC2/04gZuWiqJ12/EC
   FbVfevO6HdZfaH+ryry65T6OwgekrYStbdNljfhPFXEmjs72aUQfeqvdb
   ENuZDe2ekB3uEDygek75puystsnaT9i5JbSTkBGvGWiJihFPG8tBuDayq
   xpl0dgmXYsdyL9MLdRjlIa5Idp0uZRDoJjFMh3l6Tlbs4hZA+HnVFDVkt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="244076722"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="244076722"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 03:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="529465431"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 03:24:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngOYO-0004Xh-Nv;
        Mon, 18 Apr 2022 10:24:20 +0000
Date:   Mon, 18 Apr 2022 18:23:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: include/linux/mtd/cfi.h:62:2: warning: No CONFIG_MTD_CFI_Ix
 selected. No NOR chip support can work.
Message-ID: <202204181831.mZ5R0kZ8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: e23e5a05d1fd9479586c40ffbcc056b3e34ef816 mtd: spi-nor: intel-spi: Convert to SPI MEM
date:   9 weeks ago
config: x86_64-randconfig-a014-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181831.mZ5R0kZ8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e23e5a05d1fd9479586c40ffbcc056b3e34ef816
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e23e5a05d1fd9479586c40ffbcc056b3e34ef816
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-intel.c:13:
   In file included from include/linux/mtd/spi-nor.h:10:
>> include/linux/mtd/cfi.h:62:2: warning: No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-W#warnings]
   #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
    ^
   1 warning generated.


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
