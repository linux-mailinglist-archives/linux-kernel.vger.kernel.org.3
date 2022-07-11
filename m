Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0665706F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiGKPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiGKPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:24:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74D13E0B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657553074; x=1689089074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EqdGS3pAl/ZUqCpsxvHzAOGkz0m4s59TctPgjYr1N6g=;
  b=iIunCF2xrM/K9T4eCNbNljUfigmc4vzwZWHxv4jzE34JzmrPbX7I/BZj
   z/3DelJNelTaEpFtJNElzzLMVToGjjhk0enLIsWDTiX1H1zbsSoQgZAgV
   V51QMIWId29DVM0RmToeWydlFQ6cKMKshkbnkMkz5InVW/hn4JzF2NaHu
   HXsiDAlqWlRyax3SG/FMsWLQ2zWz8MasUeykrG8zb/W1bBykb20Gi/1ow
   6mMmcMgFIo+Cdyp5iWcTbmxkQ7Yhl1Ju5f7pCLWzK6El3PSBtzbbj8Igu
   sSyqaYrelSLEf3G8kz5/zEtR4b76hcfr4GvZhdJ7NsIaHaZnzh73stf4h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="282239584"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="282239584"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 08:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="662585411"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 08:24:32 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAvGy-0000vH-2q;
        Mon, 11 Jul 2022 15:24:32 +0000
Date:   Mon, 11 Jul 2022 23:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: [leon-rdma:rdma-next 19/27] drivers/vfio/vfio_main.c:1658: undefined
 reference to `interval_tree_iter_first'
Message-ID: <202207112304.RBht9L6V-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git rdma-next
head:   325f0cb55fe7505ffc12020edf66e91f1bdbe021
commit: de08f6b555c0b4687890265b2f2358f69f28512a [19/27] vfio: Introduce the DMA logging feature support
config: arm-randconfig-r035-20220710 (https://download.01.org/0day-ci/archive/20220711/202207112304.RBht9L6V-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=de08f6b555c0b4687890265b2f2358f69f28512a
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout de08f6b555c0b4687890265b2f2358f69f28512a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/vfio/vfio_main.o: in function `vfio_ioctl_device_feature_logging_start':
>> drivers/vfio/vfio_main.c:1658: undefined reference to `interval_tree_iter_first'
>> arm-linux-gnueabi-ld: drivers/vfio/vfio_main.c:1664: undefined reference to `interval_tree_insert'


vim +1658 drivers/vfio/vfio_main.c

  1607	
  1608	static int
  1609	vfio_ioctl_device_feature_logging_start(struct vfio_device *device,
  1610						u32 flags, void __user *arg,
  1611						size_t argsz)
  1612	{
  1613		size_t minsz =
  1614			offsetofend(struct vfio_device_feature_dma_logging_control,
  1615				    ranges);
  1616		struct vfio_device_feature_dma_logging_range __user *ranges;
  1617		struct vfio_device_feature_dma_logging_control control;
  1618		struct vfio_device_feature_dma_logging_range range;
  1619		struct rb_root_cached root = RB_ROOT_CACHED;
  1620		struct interval_tree_node *nodes;
  1621		u32 nnodes;
  1622		int i, ret;
  1623	
  1624		if (!device->log_ops)
  1625			return -ENOTTY;
  1626	
  1627		ret = vfio_check_feature(flags, argsz,
  1628					 VFIO_DEVICE_FEATURE_SET,
  1629					 sizeof(control));
  1630		if (ret != 1)
  1631			return ret;
  1632	
  1633		if (copy_from_user(&control, arg, minsz))
  1634			return -EFAULT;
  1635	
  1636		nnodes = control.num_ranges;
  1637		if (!nnodes || nnodes > LOG_MAX_RANGES)
  1638			return -EINVAL;
  1639	
  1640		ranges = u64_to_user_ptr(control.ranges);
  1641		nodes = kmalloc_array(nnodes, sizeof(struct interval_tree_node),
  1642				      GFP_KERNEL);
  1643		if (!nodes)
  1644			return -ENOMEM;
  1645	
  1646		for (i = 0; i < nnodes; i++) {
  1647			if (copy_from_user(&range, &ranges[i], sizeof(range))) {
  1648				ret = -EFAULT;
  1649				goto end;
  1650			}
  1651			if (!IS_ALIGNED(range.iova, control.page_size) ||
  1652			    !IS_ALIGNED(range.length, control.page_size)) {
  1653				ret = -EINVAL;
  1654				goto end;
  1655			}
  1656			nodes[i].start = range.iova;
  1657			nodes[i].last = range.iova + range.length - 1;
> 1658			if (interval_tree_iter_first(&root, nodes[i].start,
  1659						     nodes[i].last)) {
  1660				/* Range overlapping */
  1661				ret = -EINVAL;
  1662				goto end;
  1663			}
> 1664			interval_tree_insert(nodes + i, &root);
  1665		}
  1666	
  1667		ret = device->log_ops->log_start(device, &root, nnodes,
  1668						 &control.page_size);
  1669		if (ret)
  1670			goto end;
  1671	
  1672		if (copy_to_user(arg, &control, sizeof(control))) {
  1673			ret = -EFAULT;
  1674			device->log_ops->log_stop(device);
  1675		}
  1676	
  1677	end:
  1678		kfree(nodes);
  1679		return ret;
  1680	}
  1681	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
