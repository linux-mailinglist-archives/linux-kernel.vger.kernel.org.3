Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708E746F8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhLJCG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:06:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:21314 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhLJCGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639101771; x=1670637771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LWTzaKVTDEyUajDNfO4qr0nvBRT+Sx+OnoSC5b7SdIY=;
  b=Cvp/Qjyn0elXvSLgVJ3zIYZ+3jcB071R/a6c25W7zUqCkBSZMChFAAhI
   +8sc5lBu5YpaQCmAK+dXNEU/cxjCB9Z8JQ1fEENTB0N4G4NUfAGv2Estw
   BH5Aol4zUWixK3UX1w6OZiLKTIK9PrKFkDaaNSN9INi+HY2UF/tTgp5/l
   EYeufDF6bzL62F6fpoy/m3vUEJPoEVHnYPaS3iS/zOsV2CKjRnMUs8Z+p
   eTsPAQG1N1yZvaibsQ6PEmgeIP7lw0T0xghZtxIiECmbmRe+dw7gInyvX
   wPOV1dRwbRl4xoes9SfwXDEsTNICrGZr7/rdk/GlLBshZ8+MOqf/EE0W0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225524245"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="225524245"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 18:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="680573396"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 18:02:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvVFJ-0002dJ-JN; Fri, 10 Dec 2021 02:02:49 +0000
Date:   Fri, 10 Dec 2021 10:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme/dev 18/18] drivers/nvme/host/apple.c:462:14: error:
 implicit declaration of function 'DO_ONCE'
Message-ID: <202112101027.eInODw2M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme/dev
head:   d25eee8aced31cf92944992bec41022e6f837daf
commit: d25eee8aced31cf92944992bec41022e6f837daf [18/18] HACK/DO-NOT-MERGE: nvme-apple: add initial Apple SoC NVMe driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20211210/202112101027.eInODw2M-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/d25eee8aced31cf92944992bec41022e6f837daf
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme/dev
        git checkout d25eee8aced31cf92944992bec41022e6f837daf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/nvme/host/apple.c:12:
   drivers/nvme/host/apple.c: In function 'apple_nvme_setup_prps':
>> drivers/nvme/host/apple.c:462:14: error: implicit declaration of function 'DO_ONCE' [-Werror=implicit-function-declaration]
     462 |         WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
         |              ^~~~~~~
   include/asm-generic/bug.h:130:32: note: in definition of macro 'WARN'
     130 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DO_ONCE +462 drivers/nvme/host/apple.c

   374	
   375	static blk_status_t apple_nvme_setup_prps(struct apple_nvme *anv,
   376						  struct request *req,
   377						  struct nvme_rw_command *cmnd)
   378	{
   379		struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
   380		struct dma_pool *pool;
   381		int length = blk_rq_payload_bytes(req);
   382		struct scatterlist *sg = iod->sg;
   383		int dma_len = sg_dma_len(sg);
   384		u64 dma_addr = sg_dma_address(sg);
   385		int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
   386		__le64 *prp_list;
   387		void **list = apple_nvme_iod_list(req);
   388		dma_addr_t prp_dma;
   389		int nprps, i;
   390	
   391		length -= (NVME_CTRL_PAGE_SIZE - offset);
   392		if (length <= 0) {
   393			iod->first_dma = 0;
   394			goto done;
   395		}
   396	
   397		dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
   398		if (dma_len) {
   399			dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
   400		} else {
   401			sg = sg_next(sg);
   402			dma_addr = sg_dma_address(sg);
   403			dma_len = sg_dma_len(sg);
   404		}
   405	
   406		if (length <= NVME_CTRL_PAGE_SIZE) {
   407			iod->first_dma = dma_addr;
   408			goto done;
   409		}
   410	
   411		nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
   412		if (nprps <= (256 / 8)) {
   413			pool = anv->prp_small_pool;
   414			iod->npages = 0;
   415		} else {
   416			pool = anv->prp_page_pool;
   417			iod->npages = 1;
   418		}
   419	
   420		prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
   421		if (!prp_list) {
   422			iod->first_dma = dma_addr;
   423			iod->npages = -1;
   424			return BLK_STS_RESOURCE;
   425		}
   426		list[0] = prp_list;
   427		iod->first_dma = prp_dma;
   428		i = 0;
   429		for (;;) {
   430			if (i == NVME_CTRL_PAGE_SIZE >> 3) {
   431				__le64 *old_prp_list = prp_list;
   432				prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
   433				if (!prp_list)
   434					goto free_prps;
   435				list[iod->npages++] = prp_list;
   436				prp_list[0] = old_prp_list[i - 1];
   437				old_prp_list[i - 1] = cpu_to_le64(prp_dma);
   438				i = 1;
   439			}
   440			prp_list[i++] = cpu_to_le64(dma_addr);
   441			dma_len -= NVME_CTRL_PAGE_SIZE;
   442			dma_addr += NVME_CTRL_PAGE_SIZE;
   443			length -= NVME_CTRL_PAGE_SIZE;
   444			if (length <= 0)
   445				break;
   446			if (dma_len > 0)
   447				continue;
   448			if (unlikely(dma_len < 0))
   449				goto bad_sgl;
   450			sg = sg_next(sg);
   451			dma_addr = sg_dma_address(sg);
   452			dma_len = sg_dma_len(sg);
   453		}
   454	done:
   455		cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
   456		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
   457		return BLK_STS_OK;
   458	free_prps:
   459		apple_nvme_free_prps(anv, req);
   460		return BLK_STS_RESOURCE;
   461	bad_sgl:
 > 462		WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
   463		     "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
   464		     iod->nents);
   465		return BLK_STS_IOERR;
   466	}
   467	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
