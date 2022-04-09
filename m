Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AF4FA9F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiDIRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbiDIRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:35:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74B885678
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649525598; x=1681061598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0f12sF3I01k6F9iycQ7tfuSJDXh/O5H0yyHRcG7myMU=;
  b=WSMphNZLmKlMBd3q4Ll+dH2CTF5O7PUwaNc3sghG2cXt7MAe4rzj005h
   REJceoeBqQSTyMkXnZh5jLOeocTZCAataQIzFF0V0VAB5qu8599Dtdv/L
   /ErfaDkh6O/b7Acs28DLqT8MoPf7NO33VjNonPygM8oiNP2v+Bf1lRfwG
   mgQrDG7c67s1Rj+pPkOxcx5lbb9L7/WUknlurd6ep/ZX176/VBojxyO7P
   AEuRg7c0Xn5vVHVOZmpNubnwA+nh8BGAE1K1cnTfyrdOmUNVp8sfzO94Y
   CsOvISC/8/f096wGYA42Xc8v+lVmMJrinORquM2mVOLEbK1xe/SIngylO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="348272179"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="348272179"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 10:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="698730984"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 10:33:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndExY-0000Fn-DZ;
        Sat, 09 Apr 2022 17:33:16 +0000
Date:   Sun, 10 Apr 2022 01:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 3/3]
 drivers/char/tpm/tpm_tis_synquacer.c:89:12: warning: incompatible pointer to
 integer conversion passing 'const u8 *' (aka 'const unsigned char *') to
 parameter of type 'u8' (aka 'unsigned char')
Message-ID: <202204100151.9v5nSRu6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git master
head:   b6e0cdb87bf37357489de1069d55bd59f008daeb
commit: b6e0cdb87bf37357489de1069d55bd59f008daeb [3/3] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
config: riscv-randconfig-r042-20220409 (https://download.01.org/0day-ci/archive/20220410/202204100151.9v5nSRu6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 256c6b0ba14e8a7ab6373b61b7193ea8c0a3651c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=b6e0cdb87bf37357489de1069d55bd59f008daeb
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd master
        git checkout b6e0cdb87bf37357489de1069d55bd59f008daeb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/char/tpm/tpm_tis_synquacer.c:14:
   In file included from drivers/char/tpm/tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   drivers/char/tpm/tpm_tis_synquacer.c:43:9: warning: unused variable 'result_le32' [-Wunused-variable]
           __le32 result_le32;
                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:45:6: warning: unused variable 'result32' [-Wunused-variable]
           u32 result32;
               ^
   drivers/char/tpm/tpm_tis_synquacer.c:42:9: warning: unused variable 'result_le16' [-Wunused-variable]
           __le16 result_le16;
                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:44:6: warning: unused variable 'result16' [-Wunused-variable]
           u16 result16;
               ^
>> drivers/char/tpm/tpm_tis_synquacer.c:89:12: warning: incompatible pointer to integer conversion passing 'const u8 *' (aka 'const unsigned char *') to parameter of type 'u8' (aka 'unsigned char') [-Wint-conversion]
                   iowrite8(&value[3], phy->iobase + addr + 3);
                            ^~~~~~~~~
   include/asm-generic/io.h:744:32: note: passing argument to parameter 'value' here
   static inline void iowrite8(u8 value, volatile void __iomem *addr)
                                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:90:12: warning: incompatible pointer to integer conversion passing 'const u8 *' (aka 'const unsigned char *') to parameter of type 'u8' (aka 'unsigned char') [-Wint-conversion]
                   iowrite8(&value[2], phy->iobase + addr + 2);
                            ^~~~~~~~~
   include/asm-generic/io.h:744:32: note: passing argument to parameter 'value' here
   static inline void iowrite8(u8 value, volatile void __iomem *addr)
                                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:91:12: warning: incompatible pointer to integer conversion passing 'const u8 *' (aka 'const unsigned char *') to parameter of type 'u8' (aka 'unsigned char') [-Wint-conversion]
                   iowrite8(&value[1], phy->iobase + addr + 1);
                            ^~~~~~~~~
   include/asm-generic/io.h:744:32: note: passing argument to parameter 'value' here
   static inline void iowrite8(u8 value, volatile void __iomem *addr)
                                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:92:12: warning: incompatible pointer to integer conversion passing 'const u8 *' (aka 'const unsigned char *') to parameter of type 'u8' (aka 'unsigned char') [-Wint-conversion]
                   iowrite8(&value[0], phy->iobase + addr);
                            ^~~~~~~~~
   include/asm-generic/io.h:744:32: note: passing argument to parameter 'value' here
   static inline void iowrite8(u8 value, volatile void __iomem *addr)
                                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:73:9: warning: unused variable 'result_le32' [-Wunused-variable]
           __le32 result_le32;
                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:74:6: warning: unused variable 'result16' [-Wunused-variable]
           u16 result16;
               ^
   drivers/char/tpm/tpm_tis_synquacer.c:72:9: warning: unused variable 'result_le16' [-Wunused-variable]
           __le16 result_le16;
                  ^
   drivers/char/tpm/tpm_tis_synquacer.c:75:6: warning: unused variable 'result32' [-Wunused-variable]
           u32 result32;
               ^
   13 warnings generated.


vim +89 drivers/char/tpm/tpm_tis_synquacer.c

    66	
    67	static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
    68						 u16 len, const u8 *value,
    69						 enum tpm_tis_io_mode io_mode)
    70	{
    71		struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
    72		__le16 result_le16;
    73		__le32 result_le32;
    74		u16 result16;
    75		u32 result32;
    76	
    77		switch (io_mode) {
    78		case TPM_TIS_PHYS_8:
    79			while (len--)
    80				iowrite8(*value++, phy->iobase + addr);
    81			break;
    82		case TPM_TIS_PHYS_16:
    83			return -EINVAL;
    84		case TPM_TIS_PHYS_32:
    85			/*
    86			 * Due to the limitation of SPI controller on SynQuacer,
    87			 * 16/32 bits access must be done in byte-wise and descending order.
    88			 */
  > 89			iowrite8(&value[3], phy->iobase + addr + 3);
    90			iowrite8(&value[2], phy->iobase + addr + 2);
    91			iowrite8(&value[1], phy->iobase + addr + 1);
    92			iowrite8(&value[0], phy->iobase + addr);
    93			break;
    94		}
    95	
    96		return 0;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
