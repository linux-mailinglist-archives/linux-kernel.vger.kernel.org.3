Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB62585A2E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiG3K6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiG3K6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 06:58:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A4018353
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659178684; x=1690714684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6sc65OuayrEvHWHlOAGxOWf46NykaMdlgMXHoyjtESw=;
  b=QmXETXo4l5GffQJu78jqm7o2lPrIFteRjG7kI2lCndIrCpnB5up5qgvy
   p6FkOQDOvRJkHsgnwfwHFEsO7QbxEXl7weprmobDBHWvCa7G+9FZY4d/W
   Lqevdr5qyDnOPz5Pa/kAsrDcV2K8sP+c5NkGIrboUgGUNeDy4bBukXTuF
   hvUTQsVVAtJTmB7gsAuauV8ju6aMpnrj1yhEL2w9WoPC4WNnWfC0QhkgN
   PcbxDDfj05/EQ8WSR6w+WHp9SWK6tlY68vPX8JCBpitkwubmWpO7D9y7z
   wTtskX3PXcS4FEbG5sIGxbYoUlTR+wEYhvpFAcz2zHDv10zNfwJRD2Tg0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289678451"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="289678451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 03:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669527743"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 03:58:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHkAT-000Ckq-32;
        Sat, 30 Jul 2022 10:58:01 +0000
Date:   Sat, 30 Jul 2022 18:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 148/175]
 drivers/edac/ppc4xx_edac.c:1103:19: error: implicit declaration of function
 'irq_of_parse_and_map'
Message-ID: <202207301830.sm7IsGvF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   514050eb0f04fbed131c864f7ff5c353089f5054
commit: 4d5c5bad51935482437528f7fa4dffdcb3330d8b [148/175] powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h
config: powerpc-randconfig-r031-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301830.sm7IsGvF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4d5c5bad51935482437528f7fa4dffdcb3330d8b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 4d5c5bad51935482437528f7fa4dffdcb3330d8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/edac/ppc4xx_edac.c: In function 'ppc4xx_edac_register_irq':
>> drivers/edac/ppc4xx_edac.c:1103:19: error: implicit declaration of function 'irq_of_parse_and_map' [-Werror=implicit-function-declaration]
    1103 |         ded_irq = irq_of_parse_and_map(np, INTMAP_ECCDED_INDEX);
         |                   ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/irq_of_parse_and_map +1103 drivers/edac/ppc4xx_edac.c

dba7a77c0e403f Grant Erickson     2009-04-02  1079  
dba7a77c0e403f Grant Erickson     2009-04-02  1080  /**
dba7a77c0e403f Grant Erickson     2009-04-02  1081   * ppc4xx_edac_register_irq - setup and register controller interrupts
dba7a77c0e403f Grant Erickson     2009-04-02  1082   * @op: A pointer to the OpenFirmware device tree node associated
dba7a77c0e403f Grant Erickson     2009-04-02  1083   *      with the controller this EDAC instance is bound to.
dba7a77c0e403f Grant Erickson     2009-04-02  1084   * @mci: A pointer to the EDAC memory controller instance
dba7a77c0e403f Grant Erickson     2009-04-02  1085   *       associated with the ibm,sdram-4xx-ddr2 controller for which
dba7a77c0e403f Grant Erickson     2009-04-02  1086   *       interrupts are being registered.
dba7a77c0e403f Grant Erickson     2009-04-02  1087   *
dba7a77c0e403f Grant Erickson     2009-04-02  1088   * This routine parses the correctable (CE) and uncorrectable error (UE)
dba7a77c0e403f Grant Erickson     2009-04-02  1089   * interrupts from the device tree node and maps and assigns them to
dba7a77c0e403f Grant Erickson     2009-04-02  1090   * the associated EDAC memory controller instance.
dba7a77c0e403f Grant Erickson     2009-04-02  1091   *
dba7a77c0e403f Grant Erickson     2009-04-02  1092   * Returns 0 if OK; otherwise, -ENODEV if the interrupts could not be
dba7a77c0e403f Grant Erickson     2009-04-02  1093   * mapped and assigned.
dba7a77c0e403f Grant Erickson     2009-04-02  1094   */
9b3c6e85c2cfa7 Greg Kroah-Hartman 2012-12-21  1095  static int ppc4xx_edac_register_irq(struct platform_device *op,
9b3c6e85c2cfa7 Greg Kroah-Hartman 2012-12-21  1096  				    struct mem_ctl_info *mci)
dba7a77c0e403f Grant Erickson     2009-04-02  1097  {
dba7a77c0e403f Grant Erickson     2009-04-02  1098  	int status = 0;
dba7a77c0e403f Grant Erickson     2009-04-02  1099  	int ded_irq, sec_irq;
dba7a77c0e403f Grant Erickson     2009-04-02  1100  	struct ppc4xx_edac_pdata *pdata = mci->pvt_info;
a26f95fed31d91 Anatolij Gustschin 2010-06-03  1101  	struct device_node *np = op->dev.of_node;
dba7a77c0e403f Grant Erickson     2009-04-02  1102  
dba7a77c0e403f Grant Erickson     2009-04-02 @1103  	ded_irq = irq_of_parse_and_map(np, INTMAP_ECCDED_INDEX);
dba7a77c0e403f Grant Erickson     2009-04-02  1104  	sec_irq = irq_of_parse_and_map(np, INTMAP_ECCSEC_INDEX);
dba7a77c0e403f Grant Erickson     2009-04-02  1105  
372095723a597f Michael Ellerman   2016-09-12  1106  	if (!ded_irq || !sec_irq) {
dba7a77c0e403f Grant Erickson     2009-04-02  1107  		ppc4xx_edac_mc_printk(KERN_ERR, mci,
dba7a77c0e403f Grant Erickson     2009-04-02  1108  				      "Unable to map interrupts.\n");
dba7a77c0e403f Grant Erickson     2009-04-02  1109  		status = -ENODEV;
dba7a77c0e403f Grant Erickson     2009-04-02  1110  		goto fail;
dba7a77c0e403f Grant Erickson     2009-04-02  1111  	}
dba7a77c0e403f Grant Erickson     2009-04-02  1112  
dba7a77c0e403f Grant Erickson     2009-04-02  1113  	status = request_irq(ded_irq,
dba7a77c0e403f Grant Erickson     2009-04-02  1114  			     ppc4xx_edac_isr,
5c43cbdf78b55f Michael Opdenacker 2014-10-01  1115  			     0,
dba7a77c0e403f Grant Erickson     2009-04-02  1116  			     "[EDAC] MC ECCDED",
dba7a77c0e403f Grant Erickson     2009-04-02  1117  			     mci);
dba7a77c0e403f Grant Erickson     2009-04-02  1118  
dba7a77c0e403f Grant Erickson     2009-04-02  1119  	if (status < 0) {
dba7a77c0e403f Grant Erickson     2009-04-02  1120  		ppc4xx_edac_mc_printk(KERN_ERR, mci,
dba7a77c0e403f Grant Erickson     2009-04-02  1121  				      "Unable to request irq %d for ECC DED",
dba7a77c0e403f Grant Erickson     2009-04-02  1122  				      ded_irq);
dba7a77c0e403f Grant Erickson     2009-04-02  1123  		status = -ENODEV;
dba7a77c0e403f Grant Erickson     2009-04-02  1124  		goto fail1;
dba7a77c0e403f Grant Erickson     2009-04-02  1125  	}
dba7a77c0e403f Grant Erickson     2009-04-02  1126  
dba7a77c0e403f Grant Erickson     2009-04-02  1127  	status = request_irq(sec_irq,
dba7a77c0e403f Grant Erickson     2009-04-02  1128  			     ppc4xx_edac_isr,
5c43cbdf78b55f Michael Opdenacker 2014-10-01  1129  			     0,
dba7a77c0e403f Grant Erickson     2009-04-02  1130  			     "[EDAC] MC ECCSEC",
dba7a77c0e403f Grant Erickson     2009-04-02  1131  			     mci);
dba7a77c0e403f Grant Erickson     2009-04-02  1132  
dba7a77c0e403f Grant Erickson     2009-04-02  1133  	if (status < 0) {
dba7a77c0e403f Grant Erickson     2009-04-02  1134  		ppc4xx_edac_mc_printk(KERN_ERR, mci,
dba7a77c0e403f Grant Erickson     2009-04-02  1135  				      "Unable to request irq %d for ECC SEC",
dba7a77c0e403f Grant Erickson     2009-04-02  1136  				      sec_irq);
dba7a77c0e403f Grant Erickson     2009-04-02  1137  		status = -ENODEV;
dba7a77c0e403f Grant Erickson     2009-04-02  1138  		goto fail2;
dba7a77c0e403f Grant Erickson     2009-04-02  1139  	}
dba7a77c0e403f Grant Erickson     2009-04-02  1140  
dba7a77c0e403f Grant Erickson     2009-04-02  1141  	ppc4xx_edac_mc_printk(KERN_INFO, mci, "ECCDED irq is %d\n", ded_irq);
dba7a77c0e403f Grant Erickson     2009-04-02  1142  	ppc4xx_edac_mc_printk(KERN_INFO, mci, "ECCSEC irq is %d\n", sec_irq);
dba7a77c0e403f Grant Erickson     2009-04-02  1143  
dba7a77c0e403f Grant Erickson     2009-04-02  1144  	pdata->irqs.ded = ded_irq;
dba7a77c0e403f Grant Erickson     2009-04-02  1145  	pdata->irqs.sec = sec_irq;
dba7a77c0e403f Grant Erickson     2009-04-02  1146  
dba7a77c0e403f Grant Erickson     2009-04-02  1147  	return 0;
dba7a77c0e403f Grant Erickson     2009-04-02  1148  
dba7a77c0e403f Grant Erickson     2009-04-02  1149   fail2:
dba7a77c0e403f Grant Erickson     2009-04-02  1150  	free_irq(sec_irq, mci);
dba7a77c0e403f Grant Erickson     2009-04-02  1151  
dba7a77c0e403f Grant Erickson     2009-04-02  1152   fail1:
dba7a77c0e403f Grant Erickson     2009-04-02  1153  	free_irq(ded_irq, mci);
dba7a77c0e403f Grant Erickson     2009-04-02  1154  
dba7a77c0e403f Grant Erickson     2009-04-02  1155   fail:
dba7a77c0e403f Grant Erickson     2009-04-02  1156  	return status;
dba7a77c0e403f Grant Erickson     2009-04-02  1157  }
dba7a77c0e403f Grant Erickson     2009-04-02  1158  

:::::: The code at line 1103 was first introduced by commit
:::::: dba7a77c0e403f859ff67ee39f833b6bffb4d49e edac: new ppc4xx driver module

:::::: TO: Grant Erickson <gerickson@nuovations.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
