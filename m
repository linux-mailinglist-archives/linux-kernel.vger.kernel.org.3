Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606655577B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiFWKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiFWKRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:17:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2449F9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655979453; x=1687515453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ak11eR48f9H7H/jSjvfWWMRPufiXKUYnNMjSuA4aRt0=;
  b=DQrp1znLZKWZ4yZh4CeTVyEhlpdpJBqbUZU864tdV410G4UtlqpXKVc1
   VeS5b/8yKlEqMIlwA6pevkrRBsWlAJZv1RvxBngCEo+qv5Qgesv26ACbp
   AOnIVdC8HprhFkp+aqWlAsXTtc/TpFFoaABYeg3O+livmGSqH+uBUGcyS
   qxCS3DtrVXcwrWAaGVP5z5p70T1nA3UpZ7mOSt2d6AVyyEkymjb0kQIKL
   1OS9vsWTWO35R2CoG2hYeMp+ItUapzwF2oHwlN1q+g1QZbPfU5QKK8YTp
   VSRg8xpP+q3IuS5G8RQrTOrRqaJ2XklyXMU45oys/Gcjc0davgqlBAzl6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281758472"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281758472"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="592642624"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2022 03:17:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Jty-00016b-N9;
        Thu, 23 Jun 2022 10:17:30 +0000
Date:   Thu, 23 Jun 2022 18:17:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Ben Widawsky <bwidawsk@kernel.org>
Subject: [cxl:preview 42/49] powerpc-linux-ld: port.c:undefined reference to
 `cxl_region_rwsem'
Message-ID: <202206231854.MotF9Vjs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: 26b65f41272efb6f9c691f56f02fe4159985d187 [42/49] cxl/region: Enable the assignment of endpoint decoders to regions
config: powerpc-randconfig-r031-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231854.MotF9Vjs-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=26b65f41272efb6f9c691f56f02fe4159985d187
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 26b65f41272efb6f9c691f56f02fe4159985d187
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_root_decoder_visible':
   port.c:(.text+0xe2): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0xe6): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: port.c:(.text+0xf6): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: port.c:(.text+0xfa): undefined reference to `dev_attr_delete_region'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxld_unregister':
   port.c:(.text+0x8ea): undefined reference to `cxl_region_rwsem'
>> powerpc-linux-ld: port.c:(.text+0x8f2): undefined reference to `cxl_region_rwsem'
>> powerpc-linux-ld: port.c:(.text+0x90c): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `region_show':
   port.c:(.text+0x1c46): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x1c4a): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: drivers/cxl/core/port.o: in function `cxl_decoder_autoremove':
   port.c:(.text+0x388e): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x3892): undefined reference to `cxl_region_rwsem'
   powerpc-linux-ld: port.c:(.text+0x38a8): undefined reference to `cxl_region_detach'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x130): undefined reference to `dev_attr_create_pmem_region'
   powerpc-linux-ld: drivers/cxl/core/port.o:(.data+0x134): undefined reference to `dev_attr_delete_region'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
