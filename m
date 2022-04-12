Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51C4FE79D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358601AbiDLSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358593AbiDLSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:08:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC52E081
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649786764; x=1681322764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z35X25eVpVtyKeSD2yf5lglI8oGresHmsF/zKzRONXQ=;
  b=fpO9o/LABbUDHzSgWORoOL3UCPJ9ValPVJKuERL37+KXPGi6mMzaknyw
   Ah28wIlBU4EdxVWlqv0gnCer5CNO2sCjljD2X2skBQ4NxGB7HwseHebCa
   Gt5JAiFcrPs8IEnHkrjZFFPyBVmXktchLOX+Q9h9prorIOF5N/f8Hx4sO
   utzX0cKp4s87YuYixUmomq1TyDW+qe4JnODBZ+yxE6m863FS0ptPEwWji
   7HGzerQ97ASP/cba0JZ3oqDdj6mv2P5Hr99pjrO3VYWRe+cQPR/0UtENS
   3edxKNAwjQKdoA3JChoObjMAJ7h6bolmYRc/8yLSw/y+DYeukKeSFN+QC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242403441"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="242403441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 11:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="526155168"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 11:01:08 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neKp9-00032B-AC;
        Tue, 12 Apr 2022 18:01:07 +0000
Date:   Wed, 13 Apr 2022 02:00:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 29/29]
 drivers/ufs/host/tc-dwc-g210-pltfrm.c:36:34: warning: unused variable
 'tc_dwc_g210_pltfm_match'
Message-ID: <202204130103.bxPsWXGw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   e1c32435245394413b0308d1329938ce4db52877
commit: e1c32435245394413b0308d1329938ce4db52877 [29/29] scsi: ufs: Split the drivers/scsi/ufs directory
config: x86_64-randconfig-a002-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130103.bxPsWXGw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/e1c32435245394413b0308d1329938ce4db52877
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout e1c32435245394413b0308d1329938ce4db52877
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/tc-dwc-g210-pltfrm.c:36:34: warning: unused variable 'tc_dwc_g210_pltfm_match' [-Wunused-const-variable]
   static const struct of_device_id tc_dwc_g210_pltfm_match[] = {
                                    ^
   1 warning generated.


vim +/tc_dwc_g210_pltfm_match +36 drivers/ufs/host/tc-dwc-g210-pltfrm.c

fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  35  
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11 @36  static const struct of_device_id tc_dwc_g210_pltfm_match[] = {
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  37  	{
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  38  		.compatible = "snps,g210-tc-6.00-20bit",
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  39  		.data = &tc_dwc_g210_20bit_pltfm_hba_vops,
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  40  	},
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  41  	{
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  42  		.compatible = "snps,g210-tc-6.00-40bit",
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  43  		.data = &tc_dwc_g210_40bit_pltfm_hba_vops,
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  44  	},
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  45  	{ },
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  46  };
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  47  MODULE_DEVICE_TABLE(of, tc_dwc_g210_pltfm_match);
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  48  

:::::: The code at line 36 was first introduced by commit
:::::: fc040a3fc47cad038f774275ea61fe6d5b57d7cc ufs: add TC G210 platform driver

:::::: TO: Joao Pinto <Joao.Pinto@synopsys.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
