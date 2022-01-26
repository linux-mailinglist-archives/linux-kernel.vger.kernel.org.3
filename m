Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB349D156
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbiAZSBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:01:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:4562 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237434AbiAZSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643220079; x=1674756079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y2ECp8QYPtLiLX3H6Jc115vRr24WGWM/ZU6gklYRLGg=;
  b=A77+rES2AFrXhsjn6tmI4NNe7bee5Xq3kol7rVLOAx5p5EqbkAe6mban
   wXh/QfZt6BBUAbDqews2GI/T5Na/oklESGUC4RGFPzGLicc3eRNgKFK7P
   vuQuT2MGa5M1aXNGXGWW43R6Q/FNsqjOaU9bm/Qkl8gcBWtRlscFZ4TFF
   sFbCQwrjrbChBdCTCtsoMLE1Y+7PQzNKrmHKAHsGd+X32sB1edlsAJcxi
   u2BSs9KIP0H+YNRFovl/wfHsu4l/HZYEaJdPnpRJJH5XQ0Xyz3QN4uluR
   YR+RpIPnqbXSkMPvfljdOWfbrWYVd0rGfMc2JFHTmUpLEoAacq7vl6qUg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246387582"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246387582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="477555567"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 10:01:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCmbU-000LTo-Hi; Wed, 26 Jan 2022 18:01:08 +0000
Date:   Thu, 27 Jan 2022 02:00:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Jeya R <jeyr@codeaurora.org>
Subject: Re: [PATCH v3 02/12] misc: fastrpc: add support for
 FASTRPC_IOCTL_MEM_MAP/UNMAP
Message-ID: <202201270134.bsVprnF9-lkp@intel.com>
References: <20220126135304.16340-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linux/master linus/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 515a2f507491e7c3818e74ef4f4e088c1fecb190
config: nds32-randconfig-r014-20220126 (https://download.01.org/0day-ci/archive/20220127/202201270134.bsVprnF9-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b1c0b7969aa491881596e862a90a07afae4bdfd7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
        git checkout b1c0b7969aa491881596e862a90a07afae4bdfd7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
>> drivers/misc/fastrpc.c:1544:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1544 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
>> drivers/misc/fastrpc.c:1594:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1594 |         map->va = (void *) req.vaddrin;
         |                   ^
   drivers/misc/fastrpc.c:1599:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1599 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c:1605:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1605 |         args[1].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1608:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1608 |         args[2].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1611:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1611 |         args[3].ptr = (u64) &rsp_msg;
         |                       ^


vim +1544 drivers/misc/fastrpc.c

  1515	
  1516	static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
  1517	{
  1518		struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
  1519		struct fastrpc_map *map = NULL, *m;
  1520		struct fastrpc_mem_unmap_req_msg req_msg = { 0 };
  1521		int err = 0;
  1522		u32 sc;
  1523		struct device *dev = fl->sctx->dev;
  1524	
  1525		spin_lock(&fl->lock);
  1526		list_for_each_entry_safe(map, m, &fl->maps, node) {
  1527			if ((req->fd < 0 || map->fd == req->fd) && (map->raddr == req->vaddr))
  1528				break;
  1529			map = NULL;
  1530		}
  1531	
  1532		spin_unlock(&fl->lock);
  1533	
  1534		if (!map) {
  1535			dev_err(dev, "map not in list\n");
  1536			return -EINVAL;
  1537		}
  1538	
  1539		req_msg.pgid = fl->tgid;
  1540		req_msg.len = map->len;
  1541		req_msg.vaddrin = map->raddr;
  1542		req_msg.fd = map->fd;
  1543	
> 1544		args[0].ptr = (u64) &req_msg;
  1545		args[0].length = sizeof(req_msg);
  1546	
  1547		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
  1548		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
  1549					      &args[0]);
  1550		fastrpc_map_put(map);
  1551		if (err)
  1552			dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
  1553	
  1554		return err;
  1555	}
  1556	
  1557	static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
  1558	{
  1559		struct fastrpc_mem_unmap req;
  1560	
  1561		if (copy_from_user(&req, argp, sizeof(req)))
  1562			return -EFAULT;
  1563	
  1564		return fastrpc_req_mem_unmap_impl(fl, &req);
  1565	}
  1566	
  1567	static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
  1568	{
  1569		struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
  1570		struct fastrpc_mem_map_req_msg req_msg = { 0 };
  1571		struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
  1572		struct fastrpc_mem_unmap req_unmap = { 0 };
  1573		struct fastrpc_phy_page pages = { 0 };
  1574		struct fastrpc_mem_map req;
  1575		struct device *dev = fl->sctx->dev;
  1576		struct fastrpc_map *map = NULL;
  1577		int err;
  1578		u32 sc;
  1579	
  1580		if (copy_from_user(&req, argp, sizeof(req)))
  1581			return -EFAULT;
  1582	
  1583		/* create SMMU mapping */
  1584		err = fastrpc_map_create(fl, req.fd, req.length, &map);
  1585		if (err) {
  1586			dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
  1587			return err;
  1588		}
  1589	
  1590		req_msg.pgid = fl->tgid;
  1591		req_msg.fd = req.fd;
  1592		req_msg.offset = req.offset;
  1593		req_msg.vaddrin = req.vaddrin;
> 1594		map->va = (void *) req.vaddrin;
  1595		req_msg.flags = req.flags;
  1596		req_msg.num = sizeof(pages);
  1597		req_msg.data_len = 0;
  1598	
  1599		args[0].ptr = (u64) &req_msg;
  1600		args[0].length = sizeof(req_msg);
  1601	
  1602		pages.addr = map->phys;
  1603		pages.size = map->size;
  1604	
  1605		args[1].ptr = (u64) &pages;
  1606		args[1].length = sizeof(pages);
  1607	
  1608		args[2].ptr = (u64) &pages;
  1609		args[2].length = 0;
  1610	
  1611		args[3].ptr = (u64) &rsp_msg;
  1612		args[3].length = sizeof(rsp_msg);
  1613	
  1614		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
  1615		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
  1616		if (err) {
  1617			dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
  1618				req.fd, req.vaddrin, map->size);
  1619			goto err_invoke;
  1620		}
  1621	
  1622		/* update the buffer to be able to deallocate the memory on the DSP */
  1623		map->raddr = rsp_msg.vaddr;
  1624	
  1625		/* let the client know the address to use */
  1626		req.vaddrout = rsp_msg.vaddr;
  1627	
  1628		if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
  1629			/* unmap the memory and release the buffer */
  1630			req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
  1631			req_unmap.length = map->size;
  1632			fastrpc_req_mem_unmap_impl(fl, &req_unmap);
  1633			return -EFAULT;
  1634		}
  1635	
  1636		return 0;
  1637	
  1638	err_invoke:
  1639		if (map)
  1640			fastrpc_map_put(map);
  1641	
  1642		return err;
  1643	}
  1644	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
