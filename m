Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F134E503F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiCWK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiCWK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:26:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCAA5D5F2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648031127; x=1679567127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3VQoP/rWxzNQ/rqO18eRec8pDPClTXW40qi1LEUyVUY=;
  b=LBo7Uc5BhB0XhlQ4h16MlS4plVJVo+o9uyGnWQGLv8QQVT9aeQRQjilf
   1XjqcErbUv8/2lZaG7tQwn1spTl25VBU45MVItMLdP8PSIenrqUHtJqCw
   tOdxs5x21wmaAx93uDrh0XPT6LJOQCefSmndP32f48ns2nhORXoCj/SVZ
   bgkS3p0Xd50WHnilmgHvEg6pq+WS02Ud1URAMjjeezbwDWAE5tnSb6z8s
   BJNZKilxmAVaOwK/pxWXdLxWlm4oCyAqBsVZp5TocMYitv1EKg6KUmxJS
   DsPzBsZdZmHOIo3rP0OJphdtSf2AqEa+PaB54IlYWjUV7kD5Nah9KQgZd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="321273154"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="321273154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 03:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="649380276"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 03:25:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWyBB-000JxX-C0; Wed, 23 Mar 2022 10:25:25 +0000
Date:   Wed, 23 Mar 2022 18:24:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 27/27]
 drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202203231801.VgCJzhRC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git master
head:   a536629ef32d127d26f3886f1fd480708fd5ac20
commit: a536629ef32d127d26f3886f1fd480708fd5ac20 [27/27] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
config: sh-randconfig-s031-20220323 (https://download.01.org/0day-ci/archive/20220323/202203231801.VgCJzhRC-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     expected unsigned char [usertype]
   drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     expected unsigned char [usertype]
   drivers/char/tpm/tpm_tis_synquacer.c:90:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     expected unsigned char [usertype]
   drivers/char/tpm/tpm_tis_synquacer.c:91:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned char [usertype] @@     got unsigned char const [usertype] * @@
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     expected unsigned char [usertype]
   drivers/char/tpm/tpm_tis_synquacer.c:92:32: sparse:     got unsigned char const [usertype] *
   drivers/char/tpm/tpm_tis_synquacer.c:89:33: sparse: sparse: non size-preserving pointer to integer cast
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
