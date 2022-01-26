Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05E49D417
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiAZVFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:05:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:27638 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbiAZVFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643231130; x=1674767130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=10s7JCzkmDr5frcmvWxL9SK3VMQGPrm/FbqaqhQ5Y8E=;
  b=FjivUBlNMk9lfXbOeCGLTLc8xCgY3QUQkMoPTi+HV0w+OZIiaeS1OS03
   FPchhy/vGOpiBZohfW9DbC1u0ov+06Fj2BqmfdJ8LDSsK7oN5I4a3jNZy
   zo+xZ9L5swhPYZJfMDI2LHIx3a6IJbumGixNMEZNTMn/Jbo8eaZ8zNhFg
   ov7wBLkZwBbAkQ920NwldrzN+T6HDOnWWMECCoUT7hM/qc4lJIBNKBNa3
   /oIx9FO75IqNv9vrxwwtJGUxX0gKRwWIRJM9IfvKWf+fKUxj90yD4Uq0F
   IxUF2aaQIZCeHJtdIotA3JYEYNhYe9hQhtpjnTCirlauEcLoRthJC4JG2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246870366"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246870366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696371048"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 13:05:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCpTg-000Lf3-Uc; Wed, 26 Jan 2022 21:05:16 +0000
Date:   Thu, 27 Jan 2022 05:04:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Jeya R <jeyr@codeaurora.org>
Subject: Re: [PATCH v3 03/12] misc: fastrpc: Add support to get DSP
 capabilities
Message-ID: <202201270435.PxFnOyYn-lkp@intel.com>
References: <20220126135304.16340-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-4-srinivas.kandagatla@linaro.org>
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
config: nds32-randconfig-r014-20220126 (https://download.01.org/0day-ci/archive/20220127/202201270435.PxFnOyYn-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a22465bb4904facca8fe21d23f74410cf6cb1fd0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
        git checkout a22465bb4904facca8fe21d23f74410cf6cb1fd0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
   drivers/misc/fastrpc.c:1646:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1646 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
   drivers/misc/fastrpc.c:1696:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    1696 |         map->va = (void *) req.vaddrin;
         |                   ^
   drivers/misc/fastrpc.c:1701:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1701 |         args[0].ptr = (u64) &req_msg;
         |                       ^
   drivers/misc/fastrpc.c:1707:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1707 |         args[1].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1710:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1710 |         args[2].ptr = (u64) &pages;
         |                       ^
   drivers/misc/fastrpc.c:1713:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1713 |         args[3].ptr = (u64) &rsp_msg;
         |                       ^
   drivers/misc/fastrpc.c: In function 'fastrpc_get_info_from_kernel.constprop':
>> drivers/misc/fastrpc.c:1437:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1437 | }
         | ^


vim +1437 drivers/misc/fastrpc.c

  1400	
  1401	static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
  1402						struct fastrpc_user *fl)
  1403	{
  1404		struct fastrpc_channel_ctx *cctx = fl->cctx;
  1405		uint32_t attribute_id = cap->attribute_id;
  1406		uint32_t dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
  1407		unsigned long flags;
  1408		uint32_t domain = cap->domain;
  1409		int err;
  1410	
  1411		spin_lock_irqsave(&cctx->lock, flags);
  1412		/* check if we already have queried dsp for attributes */
  1413		if (cctx->valid_attributes) {
  1414			spin_unlock_irqrestore(&cctx->lock, flags);
  1415			goto done;
  1416		}
  1417		spin_unlock_irqrestore(&cctx->lock, flags);
  1418	
  1419		err = fastrpc_get_info_from_dsp(fl, &dsp_attributes[0], FASTRPC_MAX_DSP_ATTRIBUTES);
  1420		if (err == DSP_UNSUPPORTED_API) {
  1421			dev_info(&cctx->rpdev->dev,
  1422				 "Warning: DSP capabilities not supported on domain: %d\n", domain);
  1423			return -EOPNOTSUPP;
  1424		} else if (err) {
  1425			dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
  1426			return err;
  1427		}
  1428	
  1429		spin_lock_irqsave(&cctx->lock, flags);
  1430		memcpy(cctx->dsp_attributes, dsp_attributes, sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES);
  1431		cctx->valid_attributes = true;
  1432		spin_unlock_irqrestore(&cctx->lock, flags);
  1433	done:
  1434		cap->capability = cctx->dsp_attributes[attribute_id];
  1435	
  1436		return 0;
> 1437	}
  1438	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
