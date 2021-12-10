Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4246FF52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbhLJLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:08:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:62438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240215AbhLJLIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639134304; x=1670670304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q8YNBy+MQy/3W727lrtFUB2B3lZ7RrqJI6Iwl+T8vcc=;
  b=Nq6syAwdVF4PH9efdLrbnF4Q3i9PRx6dryVTtusMGjPvHx3Ccht5rAkq
   rBPrxTRIVmR/h0I3eza2iptXA2ZI5VE1gdLFIBsf5HjPu8yRj50tv5maC
   mFER9q5aH/DlyZY5NYOykcmdtObki6r4LE0tAAILzpXbYzH3SOQeKH8hG
   Go7g/onI1dhFCoeTTSeAw1TGabJPRtl1lGo/1KcoyBAu6jFfJHBdEsCGX
   +c86Bixul8JlOs/MLL2+IVh/IMKJd7YNVnxYEo4G0TTpvhqWlQ8uXITH6
   R9cwy0as6g3+VMAyV/y4IWPlIX0xYMEINsLnJ7yvUwdxx+q+VvNHFNMhM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="237062651"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="237062651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="543941123"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2021 03:05:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvdi1-00036e-IJ; Fri, 10 Dec 2021 11:05:01 +0000
Date:   Fri, 10 Dec 2021 19:04:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 9/10]
 net/core/rtnetlink.c:5509:51: warning: format specifies type 'long' but the
 argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202112101827.NH71OPJw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw petrm_soft_counters
head:   38ca0aa04554a994a5ab769f0c07b37484b5f4c9
commit: 0839ffb5b56fb6f5e67545c77bf6151fe606835d [9/10] wip
config: i386-randconfig-r026-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101827.NH71OPJw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/0839ffb5b56fb6f5e67545c77bf6151fe606835d
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_soft_counters
        git checkout 0839ffb5b56fb6f5e67545c77bf6151fe606835d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/core/rtnetlink.c:5509:51: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
           printk(KERN_WARNING "if_nlmsg_stats_size %ld\n", size);
                                                    ~~~     ^~~~
                                                    %u
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +5509 net/core/rtnetlink.c

  5442	
  5443	static size_t if_nlmsg_stats_size(const struct net_device *dev,
  5444					  const struct rtnl_stats_dump_filters *filters)
  5445	{
  5446		size_t size = NLMSG_ALIGN(sizeof(struct if_stats_msg));
  5447		unsigned int filter_mask = filters->mask[0];
  5448	
  5449		if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_64, 0))
  5450			size += nla_total_size_64bit(sizeof(struct rtnl_link_stats64));
  5451	
  5452		if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_XSTATS, 0)) {
  5453			const struct rtnl_link_ops *ops = dev->rtnl_link_ops;
  5454			int attr = IFLA_STATS_LINK_XSTATS;
  5455	
  5456			if (ops && ops->get_linkxstats_size) {
  5457				size += nla_total_size(ops->get_linkxstats_size(dev,
  5458										attr));
  5459				/* for IFLA_STATS_LINK_XSTATS */
  5460				size += nla_total_size(0);
  5461			}
  5462		}
  5463	
  5464		if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_XSTATS_SLAVE, 0)) {
  5465			struct net_device *_dev = (struct net_device *)dev;
  5466			const struct rtnl_link_ops *ops = NULL;
  5467			const struct net_device *master;
  5468	
  5469			/* netdev_master_upper_dev_get can't take const */
  5470			master = netdev_master_upper_dev_get(_dev);
  5471			if (master)
  5472				ops = master->rtnl_link_ops;
  5473			if (ops && ops->get_linkxstats_size) {
  5474				int attr = IFLA_STATS_LINK_XSTATS_SLAVE;
  5475	
  5476				size += nla_total_size(ops->get_linkxstats_size(dev,
  5477										attr));
  5478				/* for IFLA_STATS_LINK_XSTATS_SLAVE */
  5479				size += nla_total_size(0);
  5480			}
  5481		}
  5482	
  5483		if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_OFFLOAD_XSTATS, 0)) {
  5484			u32 off_filter_mask;
  5485	
  5486			off_filter_mask = filters->mask[IFLA_STATS_LINK_OFFLOAD_XSTATS];
  5487			size += rtnl_get_offload_stats_size(dev, off_filter_mask);
  5488		}
  5489	
  5490		if (stats_attr_valid(filter_mask, IFLA_STATS_AF_SPEC, 0)) {
  5491			struct rtnl_af_ops *af_ops;
  5492	
  5493			/* for IFLA_STATS_AF_SPEC */
  5494			size += nla_total_size(0);
  5495	
  5496			rcu_read_lock();
  5497			list_for_each_entry_rcu(af_ops, &rtnl_af_ops, list) {
  5498				if (af_ops->get_stats_af_size) {
  5499					size += nla_total_size(
  5500						af_ops->get_stats_af_size(dev));
  5501	
  5502					/* for AF_* */
  5503					size += nla_total_size(0);
  5504				}
  5505			}
  5506			rcu_read_unlock();
  5507		}
  5508	
> 5509		printk(KERN_WARNING "if_nlmsg_stats_size %ld\n", size);
  5510		return size;
  5511	}
  5512	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
