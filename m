Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9049DEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiA0KP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:15:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:18674 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbiA0KPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643278555; x=1674814555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rn29xNxOGuGdjqOOUB/Mgfh8OyV2+rxggSBLPh+z1pY=;
  b=ZkB7USK1tJQBupBC9EfwvQt8hHXDm2Cljx418imxsKy7G2t0BNilpl3p
   k3Tj1l/+BDh68mi//C22kP/66pE4bvg6//R6ZcPiuKJMJ1kECTb/NI2+E
   Ar0/UGPoeqgVwgGhfQmxEumY9Qash73a37PbZoKABI+jEMa6LZCs+uA78
   RLmuDV0eQhYUDKnM6N0lZtKQqQw5HaSLNyZLbkP9tycrEUpbZK4XF6Sjr
   aa0tVRMwdjzNgWFnvkgUHXOhOsn32yIR/CVUKWc+jMNqOxqkb9IyAYJyv
   udkqIdpKxSn4i+JtBfY3fmoix1qbSnaV5R94Wo5JNfQQ5VdklltYREqdk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227480823"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="227480823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521168632"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2022 02:15:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD1om-000MTC-6e; Thu, 27 Jan 2022 10:15:52 +0000
Date:   Thu, 27 Jan 2022 18:15:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 60/60] powerpc-linux-ld: region.c:undefined reference
 to `nvdimm_pmem_region_create'
Message-ID: <202201271800.XzjIrLit-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   41c2d219a2c8e14de644f4e953e0c57402c3e884
commit: 41c2d219a2c8e14de644f4e953e0c57402c3e884 [60/60] cxl/region: Create an nd_region
config: powerpc-randconfig-c004-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271800.XzjIrLit-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=41c2d219a2c8e14de644f4e953e0c57402c3e884
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 41c2d219a2c8e14de644f4e953e0c57402c3e884
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/cxl/region.o: in function `cxl_region_probe':
   region.c:(.text+0xe54): undefined reference to `__umoddi3'
>> powerpc-linux-ld: region.c:(.text+0x11dc): undefined reference to `nvdimm_pmem_region_create'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
