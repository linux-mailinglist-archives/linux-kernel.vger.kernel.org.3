Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2EC5897B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiHDGSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHDGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:18:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C11EAD1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659593925; x=1691129925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1nffTVDO9FPxIws+eJNCDJGuDzOPcxGBgg2SBFQX7zc=;
  b=kyshl2LkOMOZjX4OcT9k+hUeZnC9dZJ1oxCKcSXAWLDovMGb3r+De/HC
   HT3z1dV/y+3rtA9MTIBl6hx5QCUtVeP7XVEU0eXs5MRZVpqoB/jlslGMN
   rqzMG3eGidGHaiI/zjc2aXTrfb9G+EXT5/gQ1+kCzAuBmklKRQ2NxPBaW
   SlNh01fNkrqeF2T3f8MppWndyhs3/0Omew8O29t3yPyVKpqcnxdZE2s/z
   y07ET6yB80ob/64jobRuInaUsywKbMo0YX4byIwIZIx34iHcZQGFZFgDA
   ZYZ+1NyiydJwfs7DwSeqxra+inFrQPM41RbftleunFL1EOiKbXWe4hS9Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="290624926"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="290624926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 23:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="578942620"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 23:18:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJUBt-000I5f-0L;
        Thu, 04 Aug 2022 06:18:41 +0000
Date:   Thu, 4 Aug 2022 14:17:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Fedorenko <vadfed@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kuba:dpll-changes 3/9] drivers/ptp/ptp_ocp.c:3721:30: warning: cast
 to pointer from integer of different size
Message-ID: <202208041420.ATdjkatl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dpll-changes
head:   9fe25d755c104116a844f268fb6bae41569e28fb
commit: 48c4cd1d7a94aeb6ab460989f1561117291092a5 [3/9] ptp_ocp: implement DPLL ops
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220804/202208041420.ATdjkatl-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git/commit/?id=48c4cd1d7a94aeb6ab460989f1561117291092a5
        git remote add kuba https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
        git fetch --no-tags kuba dpll-changes
        git checkout 48c4cd1d7a94aeb6ab460989f1561117291092a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/ptp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_get_status':
   drivers/ptp/ptp_ocp.c:3721:48: error: implicit declaration of function 'dpll_priv' [-Werror=implicit-function-declaration]
    3721 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                                                ^~~~~~~~~
>> drivers/ptp/ptp_ocp.c:3721:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3721 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                              ^
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_get_lock_status':
   drivers/ptp/ptp_ocp.c:3730:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3730 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                              ^
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_sma_get_dpll_type':
   drivers/ptp/ptp_ocp.c:3743:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3743 |                 tbl = bp->sma_op->tbl[0];
         |                     ^
   drivers/ptp/ptp_ocp.c:3745:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3745 |                 tbl = bp->sma_op->tbl[1];
         |                     ^
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_type_supported':
   drivers/ptp/ptp_ocp.c:3753:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3753 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                              ^
   drivers/ptp/ptp_ocp.c:3754:36: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    3754 |         struct ocp_selector *tbl = bp->sma_op->tbl[dir];
         |                                    ^~
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_get_source_type':
   drivers/ptp/ptp_ocp.c:3766:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3766 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                              ^
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_dpll_get_output_type':
   drivers/ptp/ptp_ocp.c:3781:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3781 |         struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
         |                              ^
   drivers/ptp/ptp_ocp.c: At top level:
   drivers/ptp/ptp_ocp.c:3794:15: error: variable 'dpll_ops' has initializer but incomplete type
    3794 | static struct dpll_device_ops dpll_ops = {
         |               ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3795:10: error: 'struct dpll_device_ops' has no member named 'get_status'
    3795 |         .get_status             = ptp_ocp_dpll_get_status,
         |          ^~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3795:35: warning: excess elements in struct initializer
    3795 |         .get_status             = ptp_ocp_dpll_get_status,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3795:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c:3796:10: error: 'struct dpll_device_ops' has no member named 'get_lock_status'
    3796 |         .get_lock_status        = ptp_ocp_dpll_get_lock_status,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3796:35: warning: excess elements in struct initializer
    3796 |         .get_lock_status        = ptp_ocp_dpll_get_lock_status,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3796:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c:3797:10: error: 'struct dpll_device_ops' has no member named 'get_source_type'
    3797 |         .get_source_type        = ptp_ocp_dpll_get_source_type,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3797:35: warning: excess elements in struct initializer
    3797 |         .get_source_type        = ptp_ocp_dpll_get_source_type,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3797:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c:3798:10: error: 'struct dpll_device_ops' has no member named 'get_source_supported'
    3798 |         .get_source_supported   = ptp_ocp_dpll_get_source_supported,
         |          ^~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3798:35: warning: excess elements in struct initializer
    3798 |         .get_source_supported   = ptp_ocp_dpll_get_source_supported,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3798:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c:3799:10: error: 'struct dpll_device_ops' has no member named 'get_output_type'
    3799 |         .get_output_type        = ptp_ocp_dpll_get_output_type,
         |          ^~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3799:35: warning: excess elements in struct initializer
    3799 |         .get_output_type        = ptp_ocp_dpll_get_output_type,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3799:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c:3800:10: error: 'struct dpll_device_ops' has no member named 'get_output_supported'
    3800 |         .get_output_supported   = ptp_ocp_dpll_get_output_supported,
         |          ^~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3800:35: warning: excess elements in struct initializer
    3800 |         .get_output_supported   = ptp_ocp_dpll_get_output_supported,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c:3800:35: note: (near initialization for 'dpll_ops')
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_probe':
   drivers/ptp/ptp_ocp.c:3859:20: error: implicit declaration of function 'dpll_device_alloc'; did you mean 'platform_device_alloc'? [-Werror=implicit-function-declaration]
    3859 |         bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
         |                    ^~~~~~~~~~~~~~~~~
         |                    platform_device_alloc
   drivers/ptp/ptp_ocp.c:3859:18: warning: assignment to 'struct dpll_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3859 |         bp->dpll = dpll_device_alloc(&dpll_ops, ARRAY_SIZE(bp->sma), ARRAY_SIZE(bp->sma), bp);
         |                  ^
   drivers/ptp/ptp_ocp.c:3864:9: error: implicit declaration of function 'dpll_device_register'; did you mean 'mtd_device_register'? [-Werror=implicit-function-declaration]
    3864 |         dpll_device_register(bp->dpll);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         mtd_device_register
   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_remove':
   drivers/ptp/ptp_ocp.c:3883:9: error: implicit declaration of function 'dpll_device_unregister'; did you mean 'mtd_device_unregister'? [-Werror=implicit-function-declaration]
    3883 |         dpll_device_unregister(bp->dpll);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         mtd_device_unregister
   drivers/ptp/ptp_ocp.c:3884:9: error: implicit declaration of function 'dpll_device_free' [-Werror=implicit-function-declaration]
    3884 |         dpll_device_free(bp->dpll);
         |         ^~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ocp.c: At top level:
   drivers/ptp/ptp_ocp.c:3794:31: error: storage size of 'dpll_ops' isn't known
    3794 | static struct dpll_device_ops dpll_ops = {
         |                               ^~~~~~~~
   cc1: some warnings being treated as errors


vim +3721 drivers/ptp/ptp_ocp.c

  3718	
  3719	static int ptp_ocp_dpll_get_status(struct dpll_device *dpll)
  3720	{
> 3721		struct ptp_ocp *bp = (struct ptp_ocp *)dpll_priv(dpll);
  3722		int sync;
  3723	
  3724		sync = ioread32(&bp->reg->status) & OCP_STATUS_IN_SYNC;
  3725		return sync;
  3726	}
  3727	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
