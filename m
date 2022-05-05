Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCF51B4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiEEBHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEEBHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:07:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C2746B3D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651712617; x=1683248617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qOSz0AKPSbFvIvpie91xKPn7qKoU9FAQzv9HLB3JR6U=;
  b=DbjFbCbSDBJAij6Pf5HwIAJTM3dU4gaWofsDm56aoHSn8C4wcSx0uVi/
   0/dGKmubbZE4tKvhikm8JnL74kjEFMAjqAiOya/kc+41DIKnkacN5L/Gy
   t+L3tTH0wb8JUTuWNn/jOxrao7ktbRVz08yhsNOoOSYfr3kBSzKeFq3xk
   o0ZUea2h/lGbn2UQrjgS2X3ObWByK5JvPxikD3ZtdGzpF6EuD5Yr3FhQW
   K+ThPHBFgtZIDOakA72nKVTesSpTpBzzJOVwhzyxbxSK57FwqcVEfCT2V
   uBr/ojpJLSrf0vglbSQBFpaavkMR3pmxAPFc+Fx80xWI6c0mOQU7OtkPq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268100423"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268100423"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="517277550"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2022 18:03:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmPu3-000Bwp-5w;
        Thu, 05 May 2022 01:03:35 +0000
Date:   Thu, 5 May 2022 09:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 5/39] ERROR: modpost:
 "comedi_8254_subdevice_init" [drivers/comedi/drivers/amplc_dio200_common.ko]
 undefined!
Message-ID: <202205050846.zTVarmg5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   2d239b86b347751644338b1dc5b64d25beb640ce
commit: b3a6a085f28524130749e016e1cbc17f811b6ea4 [5/39] comedi: add HAS_IOPORT dependencies
config: riscv-randconfig-r042-20220501 (https://download.01.org/0day-ci/archive/20220505/202205050846.zTVarmg5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=b3a6a085f28524130749e016e1cbc17f811b6ea4
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout b3a6a085f28524130749e016e1cbc17f811b6ea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "comedi_8254_subdevice_init" [drivers/comedi/drivers/amplc_dio200_common.ko] undefined!
>> ERROR: modpost: "comedi_8254_init" [drivers/comedi/drivers/amplc_dio200_common.ko] undefined!
>> ERROR: modpost: "comedi_8254_mm_init" [drivers/comedi/drivers/amplc_dio200_common.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMEDI_AMPLC_DIO200
   Depends on COMEDI && COMEDI_8254
   Selected by
   - COMEDI_AMPLC_DIO200_PCI && COMEDI && COMEDI_PCI_DRIVERS

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
