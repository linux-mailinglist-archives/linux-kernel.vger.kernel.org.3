Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44C4751CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbhLOE5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:57:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:26546 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhLOE5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639544267; x=1671080267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VkaRvQLoXE620TW1XUKONqpVdjUb10SIg4knOwbVOGo=;
  b=U0w8MpLmyq3L6wfeNoj+Co3UKihZCxWLeJwnbxSzISj4t/6SY8qnhtbt
   qKbucyItyAuiTgB0xEztb+vCtRqzOefQOnBNilbpGY+QqU/hI7rO3Fu5r
   mpk/We1HnLYHn8NC3SloeJ7CEjzwiOuDMtiOyPeIIv4TB/nLKdWoSDgSy
   P4JiiJhPvxEcby7z+heWSKs7yzLs1LYdnPeXqq120sYgNSQou/+xaoPE6
   OyspDhhDB07BhXFGctuZdxYtX6oisD/Zfwv5KEIuDbHGoo00y+4v6WWi5
   /kdfPjSN/Mb1tSWr59y00FoSmhSaFbE6+7/Bq8EurbGRl1qBsjzu6hNDX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219831945"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219831945"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 20:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465389209"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 20:57:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxMMK-0001Hc-G5; Wed, 15 Dec 2021 04:57:44 +0000
Date:   Wed, 15 Dec 2021 12:57:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bm-new1 2/15] drivers/infiniband/sw/siw/siw_main.c:196:6:
 warning: variable 'num_cpus' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202112151203.qazbGUpx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bm-new1
head:   4c8fba87b160a8063bdd06928dbfc058e26a85db
commit: 80216b2d5ee90bb6dea0aaa7224948f6deb3ae83 [2/15] lib/cpumask: replace cpumask_weight with cpumask_empty where appropriate
config: x86_64-randconfig-a012-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151203.qazbGUpx-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/80216b2d5ee90bb6dea0aaa7224948f6deb3ae83
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bm-new1
        git checkout 80216b2d5ee90bb6dea0aaa7224948f6deb3ae83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_main.c:196:6: warning: variable 'num_cpus' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (cpumask_empty(tx_cpumask)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:201:7: note: uninitialized use occurs here
           if (!num_cpus)
                ^~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:196:2: note: remove the 'if' if its condition is always true
           if (cpumask_empty(tx_cpumask)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:189:17: note: initialize the variable 'num_cpus' to silence this warning
           int i, num_cpus, cpu, min_use, node = sdev->numa_node, tx_cpu = -1;
                          ^
                           = 0
   1 warning generated.


vim +196 drivers/infiniband/sw/siw/siw_main.c

   181	
   182	/*
   183	 * Choose CPU with least number of active QP's from NUMA node of
   184	 * TX interface.
   185	 */
   186	int siw_get_tx_cpu(struct siw_device *sdev)
   187	{
   188		const struct cpumask *tx_cpumask;
   189		int i, num_cpus, cpu, min_use, node = sdev->numa_node, tx_cpu = -1;
   190	
   191		if (node < 0)
   192			tx_cpumask = cpu_online_mask;
   193		else
   194			tx_cpumask = siw_cpu_info.tx_valid_cpus[node];
   195	
 > 196		if (cpumask_empty(tx_cpumask)) {
   197			/* no CPU on this NUMA node */
   198			tx_cpumask = cpu_online_mask;
   199			num_cpus = cpumask_weight(tx_cpumask);
   200		}
   201		if (!num_cpus)
   202			goto out;
   203	
   204		cpu = cpumask_first(tx_cpumask);
   205	
   206		for (i = 0, min_use = SIW_MAX_QP; i < num_cpus;
   207		     i++, cpu = cpumask_next(cpu, tx_cpumask)) {
   208			int usage;
   209	
   210			/* Skip any cores which have no TX thread */
   211			if (!siw_tx_thread[cpu])
   212				continue;
   213	
   214			usage = atomic_read(&per_cpu(siw_use_cnt, cpu));
   215			if (usage <= min_use) {
   216				tx_cpu = cpu;
   217				min_use = usage;
   218			}
   219		}
   220		siw_dbg(&sdev->base_dev,
   221			"tx cpu %d, node %d, %d qp's\n", tx_cpu, node, min_use);
   222	
   223	out:
   224		if (tx_cpu >= 0)
   225			atomic_inc(&per_cpu(siw_use_cnt, tx_cpu));
   226		else
   227			pr_warn("siw: no tx cpu found\n");
   228	
   229		return tx_cpu;
   230	}
   231	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
