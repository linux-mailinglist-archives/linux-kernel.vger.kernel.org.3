Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A494FBCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbiDKNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiDKNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:18:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AAF39830
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649682974; x=1681218974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YsDBQb12p8x0H2DcxenAH/X0JU8x4I9TcXUcV/eKY8E=;
  b=oFlfnWUzonNnejrlOyEjnpD8NuOa64+ZxifFDv4/Rj8cDoEuIYPUAtvC
   Imdxdq3P1NIOQKw8cwHMpWvVEAEOMwANARaQqCTDDqslZ3Yz6AM/A7e9p
   F/tMg1gRJGQVWIwsqu2Xe1waXzrjnDmKxDVS25OShkpEKaaoc8uUbAfXu
   DCZOFe8V2SJnHgN0Nf6IjQvfTOmmu8+ukSNzNmz410P1PF0hdF1sq4DKf
   sdxfNQaHJvKlPdUIqyArAUni5Np7N7xZFc/GgBSHX5zegNDlI4C8S9tPp
   C6m3YlpWcVODsKJRCrlAhV0S1wQLSjahAp4wQEiC9cSAvOdUWosMxSemZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261856650"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261856650"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525973899"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 06:16:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndttq-0001s3-O4;
        Mon, 11 Apr 2022 13:16:10 +0000
Date:   Mon, 11 Apr 2022 21:15:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>
Subject: drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:59:6: error: no
 previous prototype for 'intel_pxp_debugfs_register'
Message-ID: <202204112116.5k0b9bqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
head:   ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
commit: 390cf1b28b11190121cb05d4cec1f86787b47668 drm/i915/pxp: add pxp debugfs
date:   6 months ago
config: i386-randconfig-c001-20220411 (https://download.01.org/0day-ci/archive/20220411/202204112116.5k0b9bqR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=390cf1b28b11190121cb05d4cec1f86787b47668
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 390cf1b28b11190121cb05d4cec1f86787b47668
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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
