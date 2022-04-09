Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE74FA9FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiDIRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiDIRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:46:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026C39BAE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649526259; x=1681062259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aF+969ocQRv8AJwS/Bi38IWPgssOl/8oGBVaJQx/FEM=;
  b=gFfto3CUx9xVH3z1Pf7+6lcMZis2B5dAqiiOYbPXrv/tNmDQANDplELq
   Qa/gwNLZvWaQZU8Xkww1mtDT6IwjBdU2HPco5crtAcVPi8fV3fefek+yr
   arpqQzGYNUIHRKCOW/ApnfLISXjR/ocjjYAp7VQ2wKNw8V3qKn5Xs5se4
   +DrzEoU8/Nn7Uub2/V7VquXsS4tm099hpb9lNbVkf38UBvDLu4XMZ7WNA
   l4L+CZ5kfqXlWT6fiFxuZ2DbDJebUpE7ko0uTkP/bY/Bt6+Z6WhVx4KoA
   pCq0pRcMXWMvPfJyChT4TV3+ymEEOx8D/Oi9GkqbnK256SQj/sVbmxJqW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="262018965"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="262018965"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 10:44:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622235131"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 10:44:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndF8C-0000GF-Lb;
        Sat, 09 Apr 2022 17:44:16 +0000
Date:   Sun, 10 Apr 2022 01:43:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 3/3]
 drivers/char/tpm/tpm_tis_synquacer.c:89:26: warning: passing argument 1 of
 'iowrite8' makes integer from pointer without a cast
Message-ID: <202204100146.Ej10FNcI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220410/202204100146.Ej10FNcI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=b6e0cdb87bf37357489de1069d55bd59f008daeb
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd master
        git checkout b6e0cdb87bf37357489de1069d55bd59f008daeb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/tpm/tpm_tis_synquacer.c: In function 'tpm_tis_synquacer_read_bytes':
   drivers/char/tpm/tpm_tis_synquacer.c:45:13: warning: unused variable 'result32' [-Wunused-variable]
      45 |         u32 result32;
         |             ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:44:13: warning: unused variable 'result16' [-Wunused-variable]
      44 |         u16 result16;
         |             ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:43:16: warning: unused variable 'result_le32' [-Wunused-variable]
      43 |         __le32 result_le32;
         |                ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:42:16: warning: unused variable 'result_le16' [-Wunused-variable]
      42 |         __le16 result_le16;
         |                ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c: In function 'tpm_tis_synquacer_write_bytes':
>> drivers/char/tpm/tpm_tis_synquacer.c:89:26: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      89 |                 iowrite8(&value[3], phy->iobase + addr + 3);
         |                          ^~~~~~~~~
         |                          |
         |                          const u8 * {aka const unsigned char *}
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:90:26: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      90 |                 iowrite8(&value[2], phy->iobase + addr + 2);
         |                          ^~~~~~~~~
         |                          |
         |                          const u8 * {aka const unsigned char *}
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:91:26: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      91 |                 iowrite8(&value[1], phy->iobase + addr + 1);
         |                          ^~~~~~~~~
         |                          |
         |                          const u8 * {aka const unsigned char *}
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:92:26: warning: passing argument 1 of 'iowrite8' makes integer from pointer without a cast [-Wint-conversion]
      92 |                 iowrite8(&value[0], phy->iobase + addr);
         |                          ^~~~~~~~~
         |                          |
         |                          const u8 * {aka const unsigned char *}
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from drivers/char/tpm/tpm.h:26,
                    from drivers/char/tpm/tpm_tis_synquacer.c:14:
   include/asm-generic/iomap.h:50:22: note: expected 'u8' {aka 'unsigned char'} but argument is of type 'const u8 *' {aka 'const unsigned char *'}
      50 | extern void iowrite8(u8, void __iomem *);
         |                      ^~
   drivers/char/tpm/tpm_tis_synquacer.c:75:13: warning: unused variable 'result32' [-Wunused-variable]
      75 |         u32 result32;
         |             ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:74:13: warning: unused variable 'result16' [-Wunused-variable]
      74 |         u16 result16;
         |             ^~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:73:16: warning: unused variable 'result_le32' [-Wunused-variable]
      73 |         __le32 result_le32;
         |                ^~~~~~~~~~~
   drivers/char/tpm/tpm_tis_synquacer.c:72:16: warning: unused variable 'result_le16' [-Wunused-variable]
      72 |         __le16 result_le16;
         |                ^~~~~~~~~~~


vim +/iowrite8 +89 drivers/char/tpm/tpm_tis_synquacer.c

    36	
    37	static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
    38						u16 len, u8 *result,
    39						enum tpm_tis_io_mode io_mode)
    40	{
    41		struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
    42		__le16 result_le16;
  > 43		__le32 result_le32;
    44		u16 result16;
    45		u32 result32;
    46	
    47		switch (io_mode) {
    48		case TPM_TIS_PHYS_8:
    49			while (len--)
    50				*result++ = ioread8(phy->iobase + addr);
    51			break;
    52		case TPM_TIS_PHYS_16:
    53			result[1] = ioread8(phy->iobase + addr + 1);
    54			result[0] = ioread8(phy->iobase + addr);
    55			break;
    56		case TPM_TIS_PHYS_32:
    57			result[3] = ioread8(phy->iobase + addr + 3);
    58			result[2] = ioread8(phy->iobase + addr + 2);
    59			result[1] = ioread8(phy->iobase + addr + 1);
    60			result[0] = ioread8(phy->iobase + addr);
    61			break;
    62		}
    63	
    64		return 0;
    65	}
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
