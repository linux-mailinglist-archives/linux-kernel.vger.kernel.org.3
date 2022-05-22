Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53229530312
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbiEVMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiEVMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 08:30:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381F3CA6A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653222624; x=1684758624;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yl6oCepAkkyMdyLVyBENcfFzAAEHfF1+hGSnyy1z5Is=;
  b=eTF9rk4HUX0lxrHhSt6kZ/G7dMmDKQh+2EcDg8vwQjaPMAdMAztlq2e5
   XDI1uGBaMM/8EspXwgfYvFjLMDrmrQIf8NgUg5FeSEyGWvj8Ue3El09oz
   bEpwiSCRtCQhmUj4iuyuPbSfvBLIt7YZdndHhmjmB6VPxFYIs5JL+UoxS
   EcSJNg1S3/BKoDdnPkJPWX5nDBvXSaDHRrqyGIQydBdd23L6G+kxSzHXT
   dccRTt8rH2rJVzORK/746pNIuHz3Uks07jlYlT6ZNaRNRdQ3KR/5OcdaJ
   zhYxn2WLWAnw5NaibtofM2uLTxBAlUUf2B/BcBXZC7yuW2P94wKM73Gbj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="273113710"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="273113710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 05:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="702544936"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2022 05:30:22 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nskiz-0000M3-JI;
        Sun, 22 May 2022 12:30:21 +0000
Date:   Sun, 22 May 2022 20:30:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address
 space '__rcu' of expression
Message-ID: <202205222029.xpW3PM1y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu annotations to redirect map entries
date:   11 months ago
config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=782347b6bcad07ddb574422e01e22c92e05928c8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 782347b6bcad07ddb574422e01e22c92e05928c8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/bpf/devmap.c:561:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
   kernel/bpf/devmap.c:561:29: sparse:     expected struct bpf_dtab_netdev *dst
   kernel/bpf/devmap.c:561:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
   kernel/bpf/devmap.c:657:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
   kernel/bpf/devmap.c:657:29: sparse:     expected struct bpf_dtab_netdev *dst
   kernel/bpf/devmap.c:657:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression

vim +/__rcu +1030 kernel/bpf/devmap.c

   990	
   991	static int dev_map_notification(struct notifier_block *notifier,
   992					ulong event, void *ptr)
   993	{
   994		struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
   995		struct bpf_dtab *dtab;
   996		int i, cpu;
   997	
   998		switch (event) {
   999		case NETDEV_REGISTER:
  1000			if (!netdev->netdev_ops->ndo_xdp_xmit || netdev->xdp_bulkq)
  1001				break;
  1002	
  1003			/* will be freed in free_netdev() */
  1004			netdev->xdp_bulkq = alloc_percpu(struct xdp_dev_bulk_queue);
  1005			if (!netdev->xdp_bulkq)
  1006				return NOTIFY_BAD;
  1007	
  1008			for_each_possible_cpu(cpu)
  1009				per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;
  1010			break;
  1011		case NETDEV_UNREGISTER:
  1012			/* This rcu_read_lock/unlock pair is needed because
  1013			 * dev_map_list is an RCU list AND to ensure a delete
  1014			 * operation does not free a netdev_map entry while we
  1015			 * are comparing it against the netdev being unregistered.
  1016			 */
  1017			rcu_read_lock();
  1018			list_for_each_entry_rcu(dtab, &dev_map_list, list) {
  1019				if (dtab->map.map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
  1020					dev_map_hash_remove_netdev(dtab, netdev);
  1021					continue;
  1022				}
  1023	
  1024				for (i = 0; i < dtab->map.max_entries; i++) {
  1025					struct bpf_dtab_netdev *dev, *odev;
  1026	
  1027					dev = rcu_dereference(dtab->netdev_map[i]);
  1028					if (!dev || netdev != dev->dev)
  1029						continue;
> 1030					odev = unrcu_pointer(cmpxchg(&dtab->netdev_map[i], RCU_INITIALIZER(dev), NULL));
  1031					if (dev == odev)
  1032						call_rcu(&dev->rcu,
  1033							 __dev_map_entry_free);
  1034				}
  1035			}
  1036			rcu_read_unlock();
  1037			break;
  1038		default:
  1039			break;
  1040		}
  1041		return NOTIFY_OK;
  1042	}
  1043	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
