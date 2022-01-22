Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8511C496C53
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiAVMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:22:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:33890 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234479AbiAVMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642854158; x=1674390158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=07Dw7OH6jrDKST0UyRRL7x6OugU1Ewa6plPn2z6juj8=;
  b=i8aRZk2cgbw9TP2zEOUEj7ALe95WYR0Y53bez8XoWiyRqh+nl8Fgd00w
   8Fy41F+fDwvsyex/7aJGXG0te6KW1z2jAZcqLzgrDMIS1KY1RSuVVeQJK
   z9ynCHSHBa1urvzcsFPNkoOvYF9zOYE4txgcpV+WDboeDsbs64ruLEI8B
   lwyyTqWv1/jfO25QATr6gvulaceSetdQwABsYdFfPheZSBaO64V8inhz9
   Faiy/XOauDuI6DEl8dChzsKsZkJ1dgWF5A9SLzWlGp/bTnCGnB49OmTiP
   WwoRuFCIRTjr0RUapdWC4m2//PjELWFTMDpcTBEaYjMlq2WOAN8a0H5Mz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="270249714"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="270249714"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 04:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="765964666"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2022 04:22:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBFPg-000GNR-38; Sat, 22 Jan 2022 12:22:36 +0000
Date:   Sat, 22 Jan 2022 20:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 46/53] drivers/cxl/core/memdev.c:222:6: warning: no
 previous prototype for 'detach_memdev'
Message-ID: <202201222059.SHcoDfgc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   e675fabdbbcdb6e32dba688a20fb0bd42e0e2d5d
commit: 2b2d6579d0ee25b92d9af10c407c11cb4e3e0afe [46/53] cxl/mem: Add the cxl_mem driver
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220122/202201222059.SHcoDfgc-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=2b2d6579d0ee25b92d9af10c407c11cb4e3e0afe
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 2b2d6579d0ee25b92d9af10c407c11cb4e3e0afe
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/memdev.c:222:6: warning: no previous prototype for 'detach_memdev' [-Wmissing-prototypes]
     222 | void detach_memdev(struct work_struct *work)
         |      ^~~~~~~~~~~~~


vim +/detach_memdev +222 drivers/cxl/core/memdev.c

   221	
 > 222	void detach_memdev(struct work_struct *work)
   223	{
   224		struct cxl_memdev *cxlmd;
   225	
   226		cxlmd = container_of(work, typeof(*cxlmd), detach_work);
   227		device_release_driver(&cxlmd->dev);
   228		put_device(&cxlmd->dev);
   229	}
   230	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
