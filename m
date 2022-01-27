Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1649DE86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiA0JzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:55:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:56181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238315AbiA0JzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643277306; x=1674813306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3Wy3cH9vFtRwrtEZFfkGv0hwIWiVrjPi5nNs51EmS4=;
  b=ntqvw29Ru9kFko1q+Z+EcJK9l40FlY2ueWysTbkwO994juuY9MaZo8/l
   msEGGUHHe4dT9HmSxruygCkg3Qe2RdL70LCZJB8hWJidFTjdG/2w3yXwm
   Pyo50KPrclbG3gXQnxv2fouh1oFn1SUs/Tn71eypMeESdtwviIkhxmhgv
   hFLBmN0bfpREcWSyAZbEwVD7Vt10W1u9l0abQQvC/jstLdftWXg0DHUEW
   hpbEACcfLBinBC3pEvRVnuZztZvRDk85xg2f5czIDQTpchApLZ8dFxCCG
   i590XC6Kp4B0anOfN8RmuFI6pAfSnjlwC/16VzBX0Xcbpby/EiHFjGI5M
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310117418"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="310117418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="618271166"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2022 01:54:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD1UR-000MRh-JN; Thu, 27 Jan 2022 09:54:51 +0000
Date:   Thu, 27 Jan 2022 17:54:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 48/60] drivers/cxl/core/region.c:120:6: warning: format
 specifies type 'unsigned long long' but the argument has type 'unsigned int'
Message-ID: <202201271745.RlAJUNU9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   41c2d219a2c8e14de644f4e953e0c57402c3e884
commit: 99fd0afb6e1b21f8de1179f39f491347b6f3f04d [48/60] cxl/region: Introduce concept of region configuration
config: i386-randconfig-a013-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271745.RlAJUNU9-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f400a6012c668dfaa73462caf067ceb074e66c47)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=99fd0afb6e1b21f8de1179f39f491347b6f3f04d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 99fd0afb6e1b21f8de1179f39f491347b6f3f04d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/region.c:120:6: warning: format specifies type 'unsigned long long' but the argument has type 'unsigned int' [-Wformat]
                             cxld->platform_res.start - cxlr->res->start);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +120 drivers/cxl/core/region.c

   109	
   110	static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
   111				   char *buf)
   112	{
   113		struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
   114		struct cxl_region *cxlr = to_cxl_region(dev);
   115	
   116		if (!cxlr->res)
   117			return sysfs_emit(buf, "\n");
   118	
   119		return sysfs_emit(buf, "%#llx\n",
 > 120				  cxld->platform_res.start - cxlr->res->start);
   121	}
   122	static DEVICE_ATTR_RO(offset);
   123	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
