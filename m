Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D95832B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiG0TDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiG0TCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC12B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658945992; x=1690481992;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hupLy233Vh2ytjJp20T0HA0yTrxvG+fp06C6IGbYG2M=;
  b=kYpsOArFdhpohwHENWkkKkQJgHuUOGx7Iq7m80UH0syxjrIsOIh+lnEM
   vTn36QLJwsC6gLhCOkSAe3WIqYR+pJphe/8RmUp2Snaf9P5nrGF4THy4z
   xxitZ5ZWJP7ANCKHMWonqMyiBPuRKT6zo6KxQEKUMrloZ7r0bvm8BIkOy
   B4sqbROxpHaAI2/91SJJfrePcGwive5gQxy7RMGDRw9c7vCp/GboblCfe
   NuP/B4Tfu2ezs/t4RxouSBNYPa2amnyzH9xq6mVBfGT8IPyV72XV1y5ux
   EHUkBUwfyxgGRcewMgl6jIfP6AAya+9+zhjADx+8o5frWbVSVrrGGSdAB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="271351609"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="271351609"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 11:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="576098779"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2022 11:19:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGldN-000922-1F;
        Wed, 27 Jul 2022 18:19:49 +0000
Date:   Thu, 28 Jul 2022 02:19:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 154/166]
 arch/powerpc/kernel/pci-common.c:78:13: error: unused variable 'prop_32'
Message-ID: <202207280244.H0wBbS7A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   50be92bd65cb6a6a017f71c49bb2d5a05196c063
commit: 8ae2f1055cccee6fa4c646e2b0feb97e74a93cf8 [154/166] powerpc/pci: Prefer PCI domain assignment via DT 'linux,pci-domain' and alias
config: powerpc-randconfig-r035-20220727 (https://download.01.org/0day-ci/archive/20220728/202207280244.H0wBbS7A-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/8ae2f1055cccee6fa4c646e2b0feb97e74a93cf8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 8ae2f1055cccee6fa4c646e2b0feb97e74a93cf8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/pci-common.c: In function 'get_phb_number':
>> arch/powerpc/kernel/pci-common.c:78:13: error: unused variable 'prop_32' [-Werror=unused-variable]
      78 |         u32 prop_32;
         |             ^~~~~~~
   cc1: all warnings being treated as errors


vim +/prop_32 +78 arch/powerpc/kernel/pci-common.c

4fc665b88a79a45 Becky Bruce          2008-09-12   70  
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   71  /*
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   72   * This function should run under locking protection, specifically
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   73   * hose_spinlock.
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   74   */
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   75  static int get_phb_number(struct device_node *dn)
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   76  {
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   77  	int ret, phb_id = -1;
61e8a0d5a0270b9 Michael Ellerman     2016-08-05  @78  	u32 prop_32;
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   79  	u64 prop;
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   80  
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   81  	/*
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   82  	 * Try fixed PHB numbering first, by checking archs and reading
8ae2f1055cccee6 Pali Rohár           2022-07-06   83  	 * the respective device-tree properties. Firstly, try reading
8ae2f1055cccee6 Pali Rohár           2022-07-06   84  	 * standard "linux,pci-domain", then try reading "ibm,opal-phbid"
8ae2f1055cccee6 Pali Rohár           2022-07-06   85  	 * (only present in powernv OPAL environment), then try device-tree
8ae2f1055cccee6 Pali Rohár           2022-07-06   86  	 * alias and as the last try to use lower bits of "reg" property.
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   87  	 */
8ae2f1055cccee6 Pali Rohár           2022-07-06   88  	ret = of_get_pci_domain_nr(dn);
8ae2f1055cccee6 Pali Rohár           2022-07-06   89  	if (ret >= 0) {
8ae2f1055cccee6 Pali Rohár           2022-07-06   90  		prop = ret;
8ae2f1055cccee6 Pali Rohár           2022-07-06   91  		ret = 0;
8ae2f1055cccee6 Pali Rohár           2022-07-06   92  	}
8ae2f1055cccee6 Pali Rohár           2022-07-06   93  	if (ret)
63a72284b159c56 Guilherme G. Piccoli 2016-06-29   94  		ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
8ae2f1055cccee6 Pali Rohár           2022-07-06   95  	if (ret)
8ae2f1055cccee6 Pali Rohár           2022-07-06   96  		ret = of_alias_get_id(dn, "pci");
8ae2f1055cccee6 Pali Rohár           2022-07-06   97  	if (ret >= 0) {
8ae2f1055cccee6 Pali Rohár           2022-07-06   98  		prop = ret;
8ae2f1055cccee6 Pali Rohár           2022-07-06   99  		ret = 0;
8ae2f1055cccee6 Pali Rohár           2022-07-06  100  	}
61e8a0d5a0270b9 Michael Ellerman     2016-08-05  101  	if (ret) {
8ae2f1055cccee6 Pali Rohár           2022-07-06  102  		u32 prop_32;
61e8a0d5a0270b9 Michael Ellerman     2016-08-05  103  		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
61e8a0d5a0270b9 Michael Ellerman     2016-08-05  104  		prop = prop_32;
61e8a0d5a0270b9 Michael Ellerman     2016-08-05  105  	}
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  106  
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  107  	if (!ret)
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  108  		phb_id = (int)(prop & (MAX_PHBS - 1));
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  109  
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  110  	/* We need to be sure to not use the same PHB number twice. */
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  111  	if ((phb_id >= 0) && !test_and_set_bit(phb_id, phb_bitmap))
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  112  		return phb_id;
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  113  
8ae2f1055cccee6 Pali Rohár           2022-07-06  114  	/* If everything fails then fallback to dynamic PHB numbering. */
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  115  	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  116  	BUG_ON(phb_id >= MAX_PHBS);
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  117  	set_bit(phb_id, phb_bitmap);
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  118  
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  119  	return phb_id;
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  120  }
63a72284b159c56 Guilherme G. Piccoli 2016-06-29  121  

:::::: The code at line 78 was first introduced by commit
:::::: 61e8a0d5a0270b91581f6c715036844b2ea98da1 powerpc/pci: Fix endian bug in fixed PHB numbering

:::::: TO: Michael Ellerman <mpe@ellerman.id.au>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
