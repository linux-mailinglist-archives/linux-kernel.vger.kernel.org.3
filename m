Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6C5707B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGKPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGKPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:55:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548527FCA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657554935; x=1689090935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pr1rtMouHTlc0gc8hvqSAtyTe8IXxsnri8zSjUL00uQ=;
  b=XOZOlNr1XRtiqgU33UWim2r5CKXn9xItnQaQY/38Q4f4OPTVke1x5ZgK
   XpqFGl/xnQ1yIkPWCxBEWKU2XCRCt7Et6+3BLIobndThGFIlyUx5VCUmf
   2sp0ilmpj2Rowre6a8ALWim6GwVqQwM26fNMnVs00MZ4vjLOiJRB4655E
   XW1td2OCygus/TlpO/oQeDiM3/IEZFuP+5SZc3N1Qjgtkr97mXVK9GPxj
   ujleFwQ4ePRFnrvRR/96GCrmG33mg/8TnMEujO0L7DCA+YS03EXva1cix
   lBTSCAu2igaMCS6mnmIdpKBp60D7A059XhxOM1VAhhBrGGDyGbE3lM/vv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348675819"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348675819"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 08:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921833030"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 08:55:33 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAvky-0000wd-Np;
        Mon, 11 Jul 2022 15:55:32 +0000
Date:   Mon, 11 Jul 2022 23:54:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>
Subject: drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:59:6: error: no
 previous prototype for 'intel_pxp_debugfs_register'
Message-ID: <202207112334.aT2Wz3dC-lkp@intel.com>
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

Hi Daniele,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32346491ddf24599decca06190ebca03ff9de7f8
commit: 390cf1b28b11190121cb05d4cec1f86787b47668 drm/i915/pxp: add pxp debugfs
date:   9 months ago
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220711/202207112334.aT2Wz3dC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=390cf1b28b11190121cb05d4cec1f86787b47668
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 390cf1b28b11190121cb05d4cec1f86787b47668
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:59:6: error: no previous prototype for 'intel_pxp_debugfs_register' [-Werror=missing-prototypes]
      59 | void intel_pxp_debugfs_register(struct intel_pxp *pxp, struct dentry *gt_root)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/intel_pxp_debugfs_register +59 drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c

    57	
    58	DEFINE_SIMPLE_ATTRIBUTE(pxp_terminate_fops, pxp_terminate_get, pxp_terminate_set, "%llx\n");
  > 59	void intel_pxp_debugfs_register(struct intel_pxp *pxp, struct dentry *gt_root)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
