Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0B472D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhLMNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:23:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:55153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhLMNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639401828; x=1670937828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q2zU3aX/eix51Jdmdc9c0LXwqMOILQykOpVNNbSowZE=;
  b=Q5lb5RrO4qLHn8od6UI9dacT31Oz3FUimwuuAptGTOL/ubJ4+/m+tsNs
   coKiaj7Z1M4k97ooJoJ9SCgRduXV+8B1jjAL9J9C5OH95gnDbgQXJ8rtC
   7o3qVtrxzrDKdJ2vH6cz6sbIiHhMO1KcvJzZLynocv5D5GukEMVwgPl13
   5Bp0DQ+4L6Yd/TG+afo6jAH5R8AvTRmgTBqeKTR0wsIco2a+0KjIt8upv
   tx132gWW4RAucgBqfFzrYbsvSyctkye8Zuhv+CIryI2duKJir2Gokllpv
   BHAP/6CJ2jF36cgkJwpUyIWmZbFRIQzUF/X1BoDtuWqeCGHhGg4Fkzs6w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="219412293"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="219412293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="504902747"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 05:23:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwlIw-0006hV-BT; Mon, 13 Dec 2021 13:23:46 +0000
Date:   Mon, 13 Dec 2021 21:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com, linux-kernel@vger.kernel.org
Subject: [kevin78:percpu-cleanup 2/4] arch/sparc/kernel/smp_64.c:1644:45:
 error: 'cpu_to_node' undeclared; did you mean 'dev_to_node'?
Message-ID: <202112132105.zCgSs9Zg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kevin78/linux.git percpu-cleanup
head:   ec8bef0e65982bb71c931efddde0fca6418e02ba
commit: 802124ef348edb29320cfba0dc15edb1c1f7f0c1 [2/4] mm: percpu: Add pcpu_fc_cpu_to_node_fn_t typedef
config: sparc64-randconfig-p001-20211212 (https://download.01.org/0day-ci/archive/20211213/202112132105.zCgSs9Zg-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kevin78/linux/commit/802124ef348edb29320cfba0dc15edb1c1f7f0c1
        git remote add kevin78 https://github.com/kevin78/linux.git
        git fetch --no-tags kevin78 percpu-cleanup
        git checkout 802124ef348edb29320cfba0dc15edb1c1f7f0c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/kernel/smp_64.c: In function 'setup_per_cpu_areas':
>> arch/sparc/kernel/smp_64.c:1644:45: error: 'cpu_to_node' undeclared (first use in this function); did you mean 'dev_to_node'?
    1644 |                                             cpu_to_node,
         |                                             ^~~~~~~~~~~
         |                                             dev_to_node
   arch/sparc/kernel/smp_64.c:1644:45: note: each undeclared identifier is reported only once for each function it appears in


vim +1644 arch/sparc/kernel/smp_64.c

  1633	
  1634	void __init setup_per_cpu_areas(void)
  1635	{
  1636		unsigned long delta;
  1637		unsigned int cpu;
  1638		int rc = -EINVAL;
  1639	
  1640		if (pcpu_chosen_fc != PCPU_FC_PAGE) {
  1641			rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
  1642						    PERCPU_DYNAMIC_RESERVE, 4 << 20,
  1643						    pcpu_cpu_distance,
> 1644						    cpu_to_node,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
