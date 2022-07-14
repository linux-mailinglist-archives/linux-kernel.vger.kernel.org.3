Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41E574400
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiGNE6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiGNE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:57:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADE29C87
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657773961; x=1689309961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GKrkqORkkA4/uiGhuEYqezDKq5gdwgZLfiwXLp1Z++Q=;
  b=LhKPfpcBEKxIBUcNLDI9Hwr1bLxC0PZiD3B0uH6kS3PAHnVUv4NmsIGM
   4EvJadNen5dAguHXNzvgR2fJc03lj0Mr8MY9by2JWTxhrWYIpklDb2OU1
   99KKyaXhNV8vodf/MJEQdq88t+d0jj9C0cWyXa1a6F1G/ox1zF7RUrSV4
   MGdnxQvRrIsNcXL24nSDErX4ulWuDT0D6+wxqNEZyJdL2dNO5TueeiiIh
   cKkENZ3YVpmXtnEFcFxrlFl8R8z6KwSdfHxCNOwsKILYXiiU62NnAwsoO
   HA8eXMRQQnEBK01BG4+JV6IT53sMli6Wvj97sCTvwrxSux+5lMXQBxrtG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286157417"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="286157417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 21:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="546126327"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 21:45:59 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBqje-0000E6-TF;
        Thu, 14 Jul 2022 04:45:58 +0000
Date:   Thu, 14 Jul 2022 12:45:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast
 truncates bits from constant value (369 becomes 69)
Message-ID: <202207141231.RoL3iyJf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a57a8400075bc5287c5c877702c68aeae2a033d
commit: 17b27ac5922454ff7de91cbed458643608c36abc scsi: lpfc: Add rx monitoring statistics
date:   11 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220714/202207141231.RoL3iyJf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17b27ac5922454ff7de91cbed458643608c36abc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 17b27ac5922454ff7de91cbed458643608c36abc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/ drivers/irqchip/ drivers/scsi/hisi_sas/ drivers/scsi/lpfc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/lpfc/lpfc_init.c: note: in included file:
   drivers/scsi/lpfc/lpfc_ids.h:26:28: sparse: sparse: symbol 'lpfc_id_table' was not declared. Should it be static?
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse:     expected unsigned int [usertype]
   drivers/scsi/lpfc/lpfc_init.c:145:40: sparse:     got restricted __be32 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:385:27: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_init.c:390:34: sparse: sparse: restricted __be32 degrades to integer
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:4442:24: sparse: sparse: cast to restricted __be64
   drivers/scsi/lpfc/lpfc_init.c:6111:32: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [usertype] wwn @@     got restricted __be64 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse:     expected unsigned long long [addressable] [usertype] wwn
   drivers/scsi/lpfc/lpfc_init.c:7518:21: sparse:     got restricted __be64 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [addressable] [usertype] wwn @@     got restricted __be64 [usertype] @@
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse:     expected unsigned long long [addressable] [usertype] wwn
   drivers/scsi/lpfc/lpfc_init.c:7523:21: sparse:     got restricted __be64 [usertype]
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13866:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13867:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13868:15: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c:13869:17: sparse: sparse: cast to restricted __be32
   drivers/scsi/lpfc/lpfc_init.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:88:1: sparse: sparse: cast truncates bits from constant value (369 becomes 69)

vim +88 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  84  
305d454aaa292b Will Deacon     2015-10-08  85  __XCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  86  __XCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08  87  __XCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08 @88  __XCHG_GEN(_mb)
305d454aaa292b Will Deacon     2015-10-08  89  

:::::: The code at line 88 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
