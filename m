Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766FB4820AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbhL3Wkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:40:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:42081 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbhL3Wkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640904036; x=1672440036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6XReL5s7m6DoDfEpmkpF+Vd/MjJQMXM90tY+u0icvg4=;
  b=nQ1y3dvuaGfZiTl9GWKo/lJ2slEK5ll6pL13cg/nDNVgYEtpZL6e5AuK
   l9KTRqyp3a5yTZ/TV9rrU131d0iu4KBvZseEibtr5wkvy+ms72Wufr+i8
   Ez8FNGPAiv+0h9z8parH66qXZ4Qiskayd2ZC0ln6ShWjW8Ooo5QBM9V09
   e9deLhNNIPXOuareLPSzg/LECNg46VO8PfbyxbObigkMZs/KYGsU7tqbR
   Fov82NpMFhBza1eAdmsjZigpoj07k80NCF8yH5VuDLFw9U/q/0Xh44934
   5TbKq1bWxHGRU/xHk2wOkItZ+ay9895qWfYo7+2OULjUATmfG93GoB11e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241696928"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241696928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 14:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="470787998"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Dec 2021 14:40:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3465-000Afj-3X; Thu, 30 Dec 2021 22:40:33 +0000
Date:   Fri, 31 Dec 2021 06:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse: sparse:
 incorrect type in argument 4 (different base types)
Message-ID: <202112310618.mBoYcfPO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bad743e8d221c1be8fa80f0e76102234e472ac3
commit: cd96fe600cc4924d8d0cc6e3161870219c0d2c12 scsi: hisi_sas: Add trace FIFO debugfs support
date:   11 months ago
config: ia64-randconfig-s031-20211123 (https://download.01.org/0day-ci/archive/20211231/202112310618.mBoYcfPO-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd96fe600cc4924d8d0cc6e3161870219c0d2c12
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cd96fe600cc4924d8d0cc6e3161870219c0d2c12
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/scsi/hisi_sas/ fs/dlm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __le32 [usertype] *[assigned] ptr @@     got unsigned int * @@
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse:     expected restricted __le32 [usertype] *[assigned] ptr
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse:     got unsigned int *

vim +4327 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

  4319	
  4320	static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
  4321	{
  4322		struct hisi_sas_phy *phy = s->private;
  4323	
  4324		debugfs_read_fifo_data_v3_hw(phy);
  4325	
  4326		debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
> 4327					  phy->fifo.rd_data);
  4328	
  4329		return 0;
  4330	}
  4331	DEFINE_SHOW_ATTRIBUTE(debugfs_fifo_data_v3_hw);
  4332	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
