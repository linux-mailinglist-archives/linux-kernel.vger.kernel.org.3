Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752FB4B3DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiBMVMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:12:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiBMVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:12:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EB53715
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644786730; x=1676322730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N4tTXQ1WJWaPnI67ZRv6Bvf1GZNumPPtPdHNp1yIj8U=;
  b=GW4Tm11+W8R+dtFBJ9ylX9mSuck1bJ8EiwBr7SCR6pdPhUBFA8AKC5lh
   681Alu/AUByV1takbh++qwI5l+JX+AZinZOLSCMlL8BVyZvIG0OrV/y7h
   XEmM8ei2iCXBKdoS4IjEqRaCakxONOFXqptdLfE0tPivDSZQev5d93SoT
   hYSHaU9e2Ah531drL96fcudC+dxju89VLJxmCUcnbUNbpRjQWtWREmW+H
   IAJSqnhqrntxFVvrj4fiJtY90ZTrsLq5XtZ+6bjja68VcCYHAi1OCZdkq
   53S1lqx05cAe6NDh1SqgRQYuV7rrCSo7fg+xXyU7RGPoy4oY5keNbwmzV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249722783"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249722783"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 13:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="527697147"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2022 13:12:08 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJMAB-0007qy-VZ; Sun, 13 Feb 2022 21:12:07 +0000
Date:   Mon, 14 Feb 2022 05:11:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [boqun:dev/arm64 3/3] drivers/hv/hv_balloon.c:1750: undefined
 reference to `memory_block_size_bytes'
Message-ID: <202202140519.Djv5mqzC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git dev/arm64
head:   715cdf131dd8fcb33591dc7143d193050368ecc1
commit: 715cdf131dd8fcb33591dc7143d193050368ecc1 [3/3] Drivers: hv: balloon: Support memory hot add for larger page sizes
config: i386-randconfig-a002-20220105 (https://download.01.org/0day-ci/archive/20220214/202202140519.Djv5mqzC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?id=715cdf131dd8fcb33591dc7143d193050368ecc1
        git remote add boqun https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git
        git fetch --no-tags boqun dev/arm64
        git checkout 715cdf131dd8fcb33591dc7143d193050368ecc1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/hv/hv_balloon.o: in function `balloon_connect_vsp':
>> drivers/hv/hv_balloon.c:1750: undefined reference to `memory_block_size_bytes'


vim +1750 drivers/hv/hv_balloon.c

  1664	
  1665	static int balloon_connect_vsp(struct hv_device *dev)
  1666	{
  1667		struct dm_version_request version_req;
  1668		struct dm_capabilities cap_msg;
  1669		unsigned long t;
  1670		int ret;
  1671	
  1672		/*
  1673		 * max_pkt_size should be large enough for one vmbus packet header plus
  1674		 * our receive buffer size. Hyper-V sends messages up to
  1675		 * HV_HYP_PAGE_SIZE bytes long on balloon channel.
  1676		 */
  1677		dev->channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
  1678	
  1679		ret = vmbus_open(dev->channel, dm_ring_size, dm_ring_size, NULL, 0,
  1680				 balloon_onchannelcallback, dev);
  1681		if (ret)
  1682			return ret;
  1683	
  1684		/*
  1685		 * Initiate the hand shake with the host and negotiate
  1686		 * a version that the host can support. We start with the
  1687		 * highest version number and go down if the host cannot
  1688		 * support it.
  1689		 */
  1690		memset(&version_req, 0, sizeof(struct dm_version_request));
  1691		version_req.hdr.type = DM_VERSION_REQUEST;
  1692		version_req.hdr.size = sizeof(struct dm_version_request);
  1693		version_req.hdr.trans_id = atomic_inc_return(&trans_id);
  1694		version_req.version.version = DYNMEM_PROTOCOL_VERSION_WIN10;
  1695		version_req.is_last_attempt = 0;
  1696		dm_device.version = version_req.version.version;
  1697	
  1698		ret = vmbus_sendpacket(dev->channel, &version_req,
  1699				       sizeof(struct dm_version_request),
  1700				       (unsigned long)NULL, VM_PKT_DATA_INBAND, 0);
  1701		if (ret)
  1702			goto out;
  1703	
  1704		t = wait_for_completion_timeout(&dm_device.host_event, 5*HZ);
  1705		if (t == 0) {
  1706			ret = -ETIMEDOUT;
  1707			goto out;
  1708		}
  1709	
  1710		/*
  1711		 * If we could not negotiate a compatible version with the host
  1712		 * fail the probe function.
  1713		 */
  1714		if (dm_device.state == DM_INIT_ERROR) {
  1715			ret = -EPROTO;
  1716			goto out;
  1717		}
  1718	
  1719		pr_info("Using Dynamic Memory protocol version %u.%u\n",
  1720			DYNMEM_MAJOR_VERSION(dm_device.version),
  1721			DYNMEM_MINOR_VERSION(dm_device.version));
  1722	
  1723		/*
  1724		 * Now submit our capabilities to the host.
  1725		 */
  1726		memset(&cap_msg, 0, sizeof(struct dm_capabilities));
  1727		cap_msg.hdr.type = DM_CAPABILITIES_REPORT;
  1728		cap_msg.hdr.size = sizeof(struct dm_capabilities);
  1729		cap_msg.hdr.trans_id = atomic_inc_return(&trans_id);
  1730	
  1731		/*
  1732		 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
  1733		 * currently still requires the bits to be set, so we have to add code
  1734		 * to fail the host's hot-add and balloon up/down requests, if any.
  1735		 */
  1736		cap_msg.caps.cap_bits.balloon = 1;
  1737		cap_msg.caps.cap_bits.hot_add = 1;
  1738	
  1739		/*
  1740		 * Specify our alignment requirements as it relates
  1741		 * memory hot-add. The alignment should be the same as the memory block
  1742		 * size, and Hyper-V expects 2 ^ hot_add_alignment * 1MB is the
  1743		 * alignment in bytes.
  1744		 */
  1745		/*
  1746		 * XXX: memory_block_size_bytes() for ARM64 only is only implemented
  1747		 * when CONFIG_MEMORY_HOTPLUG=y, and for x86, it doesn't get exported
  1748		 */
  1749		cap_msg.caps.cap_bits.hot_add_alignment =
> 1750			count_trailing_zeros(memory_block_size_bytes() / 0x100000);
  1751	
  1752		/*
  1753		 * Currently the host does not use these
  1754		 * values and we set them to what is done in the
  1755		 * Windows driver.
  1756		 */
  1757		cap_msg.min_page_cnt = 0;
  1758		cap_msg.max_page_number = -1;
  1759	
  1760		ret = vmbus_sendpacket(dev->channel, &cap_msg,
  1761				       sizeof(struct dm_capabilities),
  1762				       (unsigned long)NULL, VM_PKT_DATA_INBAND, 0);
  1763		if (ret)
  1764			goto out;
  1765	
  1766		t = wait_for_completion_timeout(&dm_device.host_event, 5*HZ);
  1767		if (t == 0) {
  1768			ret = -ETIMEDOUT;
  1769			goto out;
  1770		}
  1771	
  1772		/*
  1773		 * If the host does not like our capabilities,
  1774		 * fail the probe function.
  1775		 */
  1776		if (dm_device.state == DM_INIT_ERROR) {
  1777			ret = -EPROTO;
  1778			goto out;
  1779		}
  1780	
  1781		return 0;
  1782	out:
  1783		vmbus_close(dev->channel);
  1784		return ret;
  1785	}
  1786	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
