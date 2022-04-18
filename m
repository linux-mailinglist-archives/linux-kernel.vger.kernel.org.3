Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94584505A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiDROnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbiDROmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:42:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD37026F2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650288449; x=1681824449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NPCmjA3Z2nYHOcj0RRTKEmm/t+LnZAxBuqaqadnU+TM=;
  b=g3HQh7zxmwoBoia9C0dfHGePJ6MxIjFzyjgGGP3JejfmkFJrimLZPHr+
   ykstlPTu/k/szk9LWiO3OIvDTEUeLB/2iHNPqINdSorQfBPcHa956V/E6
   PXFI0IW6k5OcWSTGRzQyOLQM20Klp2hCO6dCMIhIBs5G9252B2f2CfmNt
   DlMRzq+qEExysYUj39De47r4+d6vv/ibzqhFWGYXBzh9mU3FhUxqFQhGj
   WsCQM/FzJnX2YWoTySXPKe9Rn2bkWnquAzL3IvFu3dFSlzc9sjEpXI2oh
   L4FUx9S67QGtnwhe7lw80NuHMFtX8QFgxYXtIA+HrFpfxTd6mccJE5XNy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="243448541"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="243448541"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 06:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="665180974"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 06:27:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngRPb-0004fJ-N0;
        Mon, 18 Apr 2022 13:27:27 +0000
Date:   Mon, 18 Apr 2022 21:27:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .Level2InterruptVector.text VMA
 [0000000000000180,0000000000000193] overlaps section .data VMA
 [0000000000000000,000000000019233f]
Message-ID: <202204182128.PrSavz1o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: c20e1117d9aa22c558646a1060ddd1dd042fb107 xtensa: add kernel ABI selection to Kconfig
date:   6 weeks ago
config: xtensa-randconfig-r001-20220417 (https://download.01.org/0day-ci/archive/20220418/202204182128.PrSavz1o-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c20e1117d9aa22c558646a1060ddd1dd042fb107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c20e1117d9aa22c558646a1060ddd1dd042fb107
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .Level2InterruptVector.text VMA [0000000000000180,0000000000000193] overlaps section .data VMA [0000000000000000,000000000019233f]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
