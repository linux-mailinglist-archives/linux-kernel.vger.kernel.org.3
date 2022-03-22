Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C84E388C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiCVFme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiCVFmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:42:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8A527DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647927661; x=1679463661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zl8H2A6tTvM9L+rlMapP/4UYy5yoyPseoRTfvXBWQVE=;
  b=Z+9Uzo/JpuVPdhuRxVuqS+8nR0idUPP+5NfsnRLdizG6OXW3EHDiblaz
   h/L12iwsP5Jcd72uXd7t4yAVMgTk/YJH6bULt4I/Z44q5lqbiMqRizLsM
   Vh7fTd4fKRzgg7iTuuxtYtp5KhDi7i+w/6Kju0OQY45iRczqSQ4EsiRsc
   HrIriyVpYlTXIRLYxsBlb7p6Vidu98e4oki5VwkZpE75bREL0G3G/5VzE
   p4iutRGVaSrE8dPsekS4K1AR0R3goCy9MaUzQrBd3YAuA0iVLnxPZgxNF
   biGgQtKfYsz5PV/BFKTPz+C4LvC+QNumsW1lMjaIexpCM+MANdGlOhbgq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257446317"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257446317"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="500437384"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2022 22:41:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWXGN-000IWQ-AQ; Tue, 22 Mar 2022 05:40:59 +0000
Date:   Tue, 22 Mar 2022 13:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 27/27]
 drivers/char/tpm/tpm_tis_synquacer.c:89:12: warning: passing argument 1 of
 'iowrite8' makes integer from pointer without a cast
Message-ID: <202203221316.iy9h9BnW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git master
head:   a536629ef32d127d26f3886f1fd480708fd5ac20
commit: a536629ef32d127d26f3886f1fd480708fd5ac20 [27/27] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220322/202203221316.iy9h9BnW-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a536629ef32d127d26f3886f1fd480708fd5ac20
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd master
        git checkout a536629ef32d127d26f3886f1fd480708fd5ac20
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/tpm/tpm_tis_synquacer.c: In function 'tpm_tis_synquacer_read_bytes':
   drivers/char/tpm/tpm_tis_synquacer.c:45:6: warning: unused variable 'result32' [-Wunused-variable]
      45 |  u32 result32;
         |      ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:44:6: warning: unused variable 'result16' [-Wunused-variable]
      44 |  u16 result16;
         |      ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:43:9: warning: unused variable 'result_le32' [-Wunused-variable]
      43 |  __le32 result_le32;
         |         ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:42:9: warning: unused variable 'result_le16' [-Wunused-variable]
      42 |  __le16 result_le16;
         |         ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c: In function 'tpm_tis_synquacer_write_bytes':
>> drivers/char/tpm/tpm_tis_synquacer.c:89:12: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      89 |   iowrite8(&value[3], phy->iobase + addr + 3);
         |            ^~~~~~~~~
         |            |
         |            const u8 * {aka const unsigned char *}
   In file included from include/asm-generic/io.h:15,
                    from arch/um/include/asm/io.h:24,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:90:12: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      90 |   iowrite8(&value[2], phy->iobase + addr + 2);
         |            ^~~~~~~~~
         |            |
         |            const u8 * {aka const unsigned char *}
   In file included from include/asm-generic/io.h:15,
                    from arch/um/include/asm/io.h:24,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:91:12: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      91 |   iowrite8(&value[1], phy->iobase + addr + 1);
         |            ^~~~~~~~~
         |            |
         |            const u8 * {aka const unsigned char *}
   In file included from include/asm-generic/io.h:15,
                    from arch/um/include/asm/io.h:24,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:92:12: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      92 |   iowrite8(&value[0], phy->iobase + addr);
         |            ^~~~~~~~~
         |            |
         |            const u8 * {aka const unsigned char *}
   In file included from include/asm-generic/io.h:15,
                    from arch/um/include/asm/io.h:24,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:75:6: warning: unused variable 'result32' [-Wunused-variable]
      75 |  u32 result32;
         |      ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:74:6: warning: unused variable 'result16' [-Wunused-variable]
      74 |  u16 result16;
         |      ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:73:9: warning: unused variable 'result_le32' [-Wunused-variable]
      73 |  __le32 result_le32;
         |         ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:72:9: warning: unused variable 'result_le16' [-Wunused-variable]
      72 |  __le16 result_le16;
         |         ^~~~~~~~~~~


vim +/iowrite8 +89 drivers/char/tpm/tpm_tis_synquacer.c

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
