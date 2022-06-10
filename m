Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F0545907
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiFJANC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiFJAM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:12:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A6280F02
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654819975; x=1686355975;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=muShz80N5WXbIaJ1H26l8GvCgTypGQ83+6ajKlOUXWg=;
  b=iYG+Ew5q3nFq19memfPWwb8JqJeuxUgckhZUxUvG6Hh1gxJ9yNACagvk
   M0pG98WZ9iSFa2dF2I4voivuTiac+8VWeLbLjD1Ro4ojhmUeRerS3Xk9G
   GvFh0DIYt52jBy5yl6+W9bLHIXHq2hYStBxRNnzWZRlIID77K9mDyBl10
   UegfmfDH4BhCzim4HTZd61CeK7HnThqfKwJGNwnl9z+upaEIMGvvbHYKq
   zUrjtLg+RPbB3k9SZocnkJCegeDeQbq2DakwA67Tl5hKs01ojMWOdpzqr
   JY5nCwsFikdcBQEU5f7PzsFMq0e5a0nhL6WgJlgeQzoY5FTqVJmx/oe21
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363789594"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363789594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="684247958"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2022 17:12:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzSGj-000GW6-7U;
        Fri, 10 Jun 2022 00:12:53 +0000
Date:   Fri, 10 Jun 2022 08:11:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [agd5f:drm-next 156/174]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11: warning:
 variable 'i' set but not used
Message-ID: <202206100824.0OO7jTU5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   64f6516e60b0bbe6abfc9f1d9f1999012e0f11a6
commit: 0f28cca87e9afc22280c44d378d2a6e249933977 [156/174] drm/amdkfd: Extend KFD device topology to surface peer-to-peer links
config: arm64-randconfig-r023-20220609 (https://download.01.org/0day-ci/archive/20220610/202206100824.0OO7jTU5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 0f28cca87e9afc22280c44d378d2a6e249933977
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11: warning: variable 'i' set but not used [-Wunused-but-set-variable]
           uint32_t i, k;
                    ^
   1 warning generated.


vim +/i +1542 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c

  1537	
  1538	static int kfd_dev_create_p2p_links(void)
  1539	{
  1540		struct kfd_topology_device *dev;
  1541		struct kfd_topology_device *new_dev;
> 1542		uint32_t i, k;
  1543		int ret = 0;
  1544	
  1545		k = 0;
  1546		list_for_each_entry(dev, &topology_device_list, list)
  1547			k++;
  1548		if (k < 2)
  1549			return 0;
  1550	
  1551		new_dev = list_last_entry(&topology_device_list, struct kfd_topology_device, list);
  1552		if (WARN_ON(!new_dev->gpu))
  1553			return 0;
  1554	
  1555		k--;
  1556		i = 0;
  1557	
  1558		/* create in-direct links */
  1559		ret = kfd_create_indirect_link_prop(new_dev, k);
  1560		if (ret < 0)
  1561			goto out;
  1562	
  1563		/* create p2p links */
  1564	#if defined(CONFIG_HSA_AMD_P2P)
  1565		list_for_each_entry(dev, &topology_device_list, list) {
  1566			if (dev == new_dev)
  1567				break;
  1568			if (!dev->gpu || !dev->gpu->adev ||
  1569			    (dev->gpu->hive_id &&
  1570			     dev->gpu->hive_id == new_dev->gpu->hive_id))
  1571				goto next;
  1572	
  1573			/* check if node(s) is/are peer accessible in one direction or bi-direction */
  1574			ret = kfd_add_peer_prop(new_dev, dev, i, k);
  1575			if (ret < 0)
  1576				goto out;
  1577	
  1578			ret = kfd_add_peer_prop(dev, new_dev, k, i);
  1579			if (ret < 0)
  1580				goto out;
  1581	next:
  1582			i++;
  1583		}
  1584	#endif
  1585	
  1586	out:
  1587		return ret;
  1588	}
  1589	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
