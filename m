Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ACB59ACAA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbiHTIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:36:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E73AB4EE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660984570; x=1692520570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Telg7VrPa0NvE2efj80Mx0R2/4T1hleBTQuvcuAT4fI=;
  b=h2MEteq5/1NnLGx7u4P2B/gWdahHeTMUsm53LM2hUhhV+mHVCf4RjMea
   jLAhWT43KaixWf7bWwMGlk4KOoF2MOkDovXA93+C3b7aSQLUtN42pl6Qm
   kSnEQBPJah61YEjNQnENi6TiHIgIqO1XfYKFTDx8NL143CVnRU9agHMHh
   iaUaBHt8Y058J733dJyhc7ERWpz0NbjHeXTEYsyPaLxkm5p1/0BbcHXpS
   FMJ3TFW0MGvumHlUiqHYMPUstfC6FkQd5TOwRrKIyZEuzbnxx3jgRfb+z
   ldqLE6+/v/QYXaALGXyM9PK2ahn9mnjZzsSkMPW6y7ZlVO6ofBweDHU/c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="273552545"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="273552545"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 01:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="559196968"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2022 01:36:07 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPJxf-0002NF-0V;
        Sat, 20 Aug 2022 08:36:07 +0000
Date:   Sat, 20 Aug 2022 16:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.4 285/287] drivers/tee/tee_shm.c:242:14:
 error: implicit declaration of function 'access_ok'
Message-ID: <202208201640.D1cUWPeR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
head:   7ef356c708cbb2e28b3adaaf8bb6011f50fe4ee5
commit: 51bcd4a8616806b5ecfaa54dfacf072cc920a3aa [285/287] tee: add overflow check in register_shm_helper()
config: powerpc-randconfig-s033-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201640.D1cUWPeR-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=51bcd4a8616806b5ecfaa54dfacf072cc920a3aa
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.4
        git checkout 51bcd4a8616806b5ecfaa54dfacf072cc920a3aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/tee/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tee/tee_shm.c: In function 'tee_shm_register':
>> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
     242 |         if (!access_ok((void __user *)addr, length))
         |              ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/access_ok +242 drivers/tee/tee_shm.c

   168	
   169	struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
   170					 size_t length, u32 flags)
   171	{
   172		struct tee_device *teedev = ctx->teedev;
   173		const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
   174		struct tee_shm *shm;
   175		void *ret;
   176		int rc;
   177		int num_pages;
   178		unsigned long start;
   179	
   180		if (flags != req_flags)
   181			return ERR_PTR(-ENOTSUPP);
   182	
   183		if (!tee_device_get(teedev))
   184			return ERR_PTR(-EINVAL);
   185	
   186		if (!teedev->desc->ops->shm_register ||
   187		    !teedev->desc->ops->shm_unregister) {
   188			tee_device_put(teedev);
   189			return ERR_PTR(-ENOTSUPP);
   190		}
   191	
   192		teedev_ctx_get(ctx);
   193	
   194		shm = kzalloc(sizeof(*shm), GFP_KERNEL);
   195		if (!shm) {
   196			ret = ERR_PTR(-ENOMEM);
   197			goto err;
   198		}
   199	
   200		refcount_set(&shm->refcount, 1);
   201		shm->flags = flags | TEE_SHM_REGISTER;
   202		shm->teedev = teedev;
   203		shm->ctx = ctx;
   204		shm->id = -1;
   205		addr = untagged_addr(addr);
   206		start = rounddown(addr, PAGE_SIZE);
   207		shm->offset = addr - start;
   208		shm->size = length;
   209		num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;
   210		shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
   211		if (!shm->pages) {
   212			ret = ERR_PTR(-ENOMEM);
   213			goto err;
   214		}
   215	
   216		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
   217		if (rc > 0)
   218			shm->num_pages = rc;
   219		if (rc != num_pages) {
   220			if (rc >= 0)
   221				rc = -ENOMEM;
   222			ret = ERR_PTR(rc);
   223			goto err;
   224		}
   225	
   226		mutex_lock(&teedev->mutex);
   227		shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
   228		mutex_unlock(&teedev->mutex);
   229	
   230		if (shm->id < 0) {
   231			ret = ERR_PTR(shm->id);
   232			goto err;
   233		}
   234	
   235		rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
   236						     shm->num_pages, start);
   237		if (rc) {
   238			ret = ERR_PTR(rc);
   239			goto err;
   240		}
   241	
 > 242		if (!access_ok((void __user *)addr, length))
   243			return ERR_PTR(-EFAULT);
   244	
   245		mutex_lock(&teedev->mutex);
   246		list_add_tail(&shm->link, &ctx->list_shm);
   247		mutex_unlock(&teedev->mutex);
   248	
   249		return shm;
   250	err:
   251		if (shm) {
   252			size_t n;
   253	
   254			if (shm->id >= 0) {
   255				mutex_lock(&teedev->mutex);
   256				idr_remove(&teedev->idr, shm->id);
   257				mutex_unlock(&teedev->mutex);
   258			}
   259			if (shm->pages) {
   260				for (n = 0; n < shm->num_pages; n++)
   261					put_page(shm->pages[n]);
   262				kfree(shm->pages);
   263			}
   264		}
   265		kfree(shm);
   266		teedev_ctx_put(ctx);
   267		tee_device_put(teedev);
   268		return ret;
   269	}
   270	EXPORT_SYMBOL_GPL(tee_shm_register);
   271	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
