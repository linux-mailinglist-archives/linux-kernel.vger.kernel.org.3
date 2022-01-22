Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090AA496C54
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiAVMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:22:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:48709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234509AbiAVMWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642854159; x=1674390159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2X8LfXbCfbCN29tZVrnGHoOSZg5965pWNIaKNj9gCSA=;
  b=Z/fHoqNhQK+3x/Wdx//3AI1UnLJvYxI3+L7o64jwJyOoMA2eT4EYK1sI
   4eyKJja9+1oLQ6IKknguKPpAhqbHSdosihF+g3G8k7je2Ylt1Nn8DmU7g
   pullog1P2g/oZ8d0END4GAo3fNVGTaFR695hP8tngz0IE6+JZY/1oZt98
   r7bMRnyW5ibSAgEzDD4dvJGd4UsPtVy0xYJayGe0rQuvGUcXUtu3EBi/j
   uWuN2/HJeqkkrzw7Ib6IAybw9YziSUzKhRNVts4Cf25rBGcj3Uw/qN0d4
   +FqLje3VzHFB69AS/c9tcDZqgAsf1+ETzgxl3lGI4ZxGMQ+YLv23QKWgN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245601198"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="245601198"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 04:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="768254206"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2022 04:22:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBFPf-000GNG-U6; Sat, 22 Jan 2022 12:22:35 +0000
Date:   Sat, 22 Jan 2022 20:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 42/53] drivers/cxl/pci.c:437:7: warning: variable
 'size' set but not used
Message-ID: <202201222041.iNxUcO0N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   e675fabdbbcdb6e32dba688a20fb0bd42e0e2d5d
commit: 9f7f5289523a8cd7746b8aeca9350c87ecdc5747 [42/53] cxl/pci: Implement wait for media active
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220122/202201222041.iNxUcO0N-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=9f7f5289523a8cd7746b8aeca9350c87ecdc5747
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 9f7f5289523a8cd7746b8aeca9350c87ecdc5747
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/pci.c:437:7: warning: variable 'size' set but not used [-Wunused-but-set-variable]
                   u64 size;
                       ^
   1 warning generated.


vim +/size +437 drivers/cxl/pci.c

   419	
   420	/*
   421	 * Wait up to @mbox_ready_timeout for the device to report memory
   422	 * active.
   423	 */
   424	static int wait_for_media_ready(struct cxl_dev_state *cxlds)
   425	{
   426		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
   427		int d = cxlds->cxl_dvsec;
   428		bool active = false;
   429		u64 md_status;
   430		int rc, i;
   431	
   432		rc = wait_for_valid(cxlds);
   433		if (rc)
   434			return rc;
   435	
   436		for (i = mbox_ready_timeout; i; i--) {
 > 437			u64 size;
   438			u32 temp;
   439			int rc;
   440	
   441			rc = pci_read_config_dword(
   442				pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(0), &temp);
   443			if (rc)
   444				return rc;
   445			size = (u64)temp << 32;
   446	
   447			rc = pci_read_config_dword(
   448				pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
   449			if (rc)
   450				return rc;
   451			size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
   452	
   453			active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
   454			if (active)
   455				break;
   456			msleep(1);
   457		}
   458	
   459		if (!active) {
   460			dev_err(&pdev->dev,
   461				"timeout awaiting memory active after %d seconds\n",
   462				mbox_ready_timeout);
   463			return -ETIMEDOUT;
   464		}
   465	
   466		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
   467		if (!CXLMDEV_READY(md_status))
   468			return -EIO;
   469	
   470		return 0;
   471	}
   472	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
