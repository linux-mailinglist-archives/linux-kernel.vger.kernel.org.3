Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D34E391F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiCVGni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiCVGnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:43:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1093F43AD8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647931328; x=1679467328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zqqlBg0UM4PhjlVqK27IfbCxbLUaYPlmzjHVzpyvUCc=;
  b=T1z2Ucjuqcxc+gLcJSlRTMzj0G3lB15zLtIruQpVfgnBAdhX/FNhkoTr
   //LA0fR7XO5X2kwvmmlFGMU90LnQ1CrdRzF6zpx86MFeKRiVZPA68bQUj
   mQJ+3EPlEAkUq8Dv5Cfsxk65DjpB5qswpiVPx2eMCOIGB93nHUTwsfsTc
   2yvhtwCbB9rgz2jP0GYREgVAWU+1xF2efxrelIOjPu7jg8QAah4luaK1b
   gpfqblgwnJk+J8Q9GvDcQpAKzklnUmgMfLqQfLqSHdjYHYLSDLKIu8zPP
   cbbfVx9m/5zWdtHSIFCjoR9B+PtMuJijQ+vWsQIS4l4cWkTL/irvFNib/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="245212230"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="245212230"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="515224841"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 23:42:05 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWYDV-000IYv-32; Tue, 22 Mar 2022 06:42:05 +0000
Date:   Tue, 22 Mar 2022 14:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 27/27]
 drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202203221451.saNVXUZx-lkp@intel.com>
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
config: csky-randconfig-s032-20220321 (https://download.01.org/0day-ci/archive/20220322/202203221451.saNVXUZx-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a536629ef32d127d26f3886f1fd480708fd5ac20
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd master
        git checkout a536629ef32d127d26f3886f1fd480708fd5ac20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     expected unsigned char [usertype] value
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     expected unsigned char [usertype] value
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     expected unsigned char [usertype] value
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] value @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     expected unsigned char [usertype] value
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     got unsigned char const [usertype] *
>> drivers/char/tpm/tpm_tis_synquacer.c:89:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/char/tpm/tpm_tis_synquacer.c:90:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/char/tpm/tpm_tis_synquacer.c:91:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/char/tpm/tpm_tis_synquacer.c:92:33: sparse: sparse: non size-preserving pointer to integer cast

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
