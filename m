Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3F502703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiDOIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiDOIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:47:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77715FC9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650012286; x=1681548286;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rjIJ8FShmY1Rzg/XCd+K40jz/utdD1XpxIhRT9Owwmk=;
  b=REO32IwiBkRbRFJr88XeNqxI0CYmQnxmNuKWtvdFFxy7tW5wojXX4sjg
   xX2cfEArBBNI6n4ITgdBPzdp9zgvqky0R2RTXhw1QJw0oNTM4Jxxr01Nn
   H+nw27L1NvxwfV1ij872Vt5kafGMJIbIBdkGtpa6PU6C27gL9OeaiSgQ4
   rA7J5/oqxf6V8oGxVQ2+N0xw4KKf9GoJLw8SqcR8bbtHjAzqjmBh80A5u
   JPO3wgr13PfSg8tFILpD9mXtYI/dqJtOz2ZJBdifI6zfqBiPfT2z83ZMb
   Z9t5H6ho5H5clj+DF8hFtoCo5bD+9ZkWJ7bmgF41qK6TboTCY0bhVTYhO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="288184504"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="288184504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 01:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="725699627"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 01:44:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfHZ2-0001mL-Ab;
        Fri, 15 Apr 2022 08:44:24 +0000
Date:   Fri, 15 Apr 2022 16:44:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [jarkko-tpmdd:master 3/3]
 drivers/char/tpm/tpm_tis_synquacer.c:89:32: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202204151656.q0kIOZbG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git master
head:   b6e0cdb87bf37357489de1069d55bd59f008daeb
commit: b6e0cdb87bf37357489de1069d55bd59f008daeb [3/3] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
config: arc-randconfig-s032-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151656.q0kIOZbG-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=b6e0cdb87bf37357489de1069d55bd59f008daeb
        git remote add jarkko-tpmdd git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
        git fetch --no-tags jarkko-tpmdd master
        git checkout b6e0cdb87bf37357489de1069d55bd59f008daeb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/tpm/

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
