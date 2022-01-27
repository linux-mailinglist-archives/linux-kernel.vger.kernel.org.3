Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF89F49D9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiA0Esp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:48:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:6615 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbiA0Eso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643258924; x=1674794924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=337t0sMfH0pJIeu0mNSWUh3fgi4+4AM2n0eZ/Yp6oKE=;
  b=clu19s3d7JoizWxaTLSE0F52f2hQ9lZbRpEkhpe/zio+/x728tCHy4UF
   gr77EW1mc9Qr4P4+Lm41VQSaMMtGS/x3JtNflcVzZ5Nwxdby8k5Uw9Cv4
   hWWrk3B+CzeQaKlS2NJ6zszXGNZc6RM3GtYRnjykTha3IIcjfppuPvjel
   as+rRRZqg58S3K+11pTzounwbWkHGyL8XrFyfoVl5rVjEj2HX6rKs/FSg
   BsiijjUbCFAKL053Gt1qB/VqZE5prnNuid3PazgfI2dJG3h1/61RhwS84
   CPdwVUhQSAoOGdDo7liVxjf5+GGFMDcvNrodUN4MT76SSI7VhCL5b70fb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245586474"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="245586474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="535477233"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2022 20:48:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCwi9-000M8y-0H; Thu, 27 Jan 2022 04:48:41 +0000
Date:   Thu, 27 Jan 2022 12:48:09 +0800
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
Message-ID: <202201271240.IB5pvRUs-lkp@intel.com>
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
config: csky-randconfig-s031-20220124 (https://download.01.org/0day-ci/archive/20220127/202201271240.IB5pvRUs-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/b1c0b7969aa491881596e862a90a07afae4bdfd7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
        git checkout b1c0b7969aa491881596e862a90a07afae4bdfd7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/fastrpc.c:1544:30: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1599:30: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1605:30: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1608:30: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1611:30: sparse: sparse: non size-preserving pointer to integer cast

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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
