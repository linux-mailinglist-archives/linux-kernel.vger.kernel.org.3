Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14455A640
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiFYCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFYCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:44:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD84756B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656125085; x=1687661085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lhf2cpaLyrgMFW/oM/kAcIqZ1W3FB8AGWbSkn2LzutQ=;
  b=UN0DEn11SOWVW7ULZy6XyNhHmzuEDojxiEqcjWGllk9ST1Ts7A51FCYu
   iHnKjJr+lJdm3Iq06m9/ycLI028eCT2YTHAgl4oqieAnt/3jYS+L6qMnm
   hpkdoLJYb9FrTkgHHXbfMv66qL+t2IpkFsb1T3XBY+0cJNWaBUntUObtl
   wE7TwrSjPYT1O9pkJZ+TXHDUr9nsaH/u8V6vauY1dSzeaflXFpIhKUqtD
   6BLGyQuuf9D0uK0jLEgkGW0+7d3yjEYNaimLcTbpRwyoEalzQq9fd2PH4
   E2Poa0CGVg2BNrsisRZI3OP6G8lCaFbOKksVc6z04u8S3dRJxb3le4ITb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="367454888"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="367454888"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 19:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="731553152"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2022 19:44:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4vmu-0005Bx-4r;
        Sat, 25 Jun 2022 02:44:44 +0000
Date:   Sat, 25 Jun 2022 10:43:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/smc/smc_llc.c:26:2: warning: field  within 'struct smc_llc_hdr'
 is less aligned than 'union smc_llc_hdr::(anonymous at
 net/smc/smc_llc.c:26:2)' and is usually due to 'struct smc_llc_hdr' being
 packed, which can lead to unaligned accesses
Message-ID: <202206240723.OOu0nUgA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karsten,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f20ff72066d8d7e2ffb655c2236259ac9d1c5d
commit: b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196 net/smc: extend LLC layer for SMC-Rv2
date:   8 months ago
config: arm-randconfig-c002-20220622 (https://download.01.org/0day-ci/archive/20220624/202206240723.OOu0nUgA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/smc/smc_llc.c:26:2: warning: field  within 'struct smc_llc_hdr' is less aligned than 'union smc_llc_hdr::(anonymous at net/smc/smc_llc.c:26:2)' and is usually due to 'struct smc_llc_hdr' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   1 warning generated.


vim +26 net/smc/smc_llc.c

    23	
    24	struct smc_llc_hdr {
    25		struct smc_wr_rx_hdr common;
  > 26		union {
    27			struct {
    28				u8 length;	/* 44 */
    29		#if defined(__BIG_ENDIAN_BITFIELD)
    30				u8 reserved:4,
    31				   add_link_rej_rsn:4;
    32	#elif defined(__LITTLE_ENDIAN_BITFIELD)
    33				u8 add_link_rej_rsn:4,
    34				   reserved:4;
    35	#endif
    36			};
    37			u16 length_v2;	/* 44 - 8192*/
    38		};
    39		u8 flags;
    40	} __packed;		/* format defined in
    41				 * IBM Shared Memory Communications Version 2
    42				 * (https://www.ibm.com/support/pages/node/6326337)
    43				 */
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
