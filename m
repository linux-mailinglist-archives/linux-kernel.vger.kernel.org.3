Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5937D51E436
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445535AbiEGFGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356601AbiEGFFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:05:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A49443DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651899728; x=1683435728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QLTFHdnUBTzWWU34AO9SvqAcGSLS+UOF20d6uL8pj0I=;
  b=BY5fuDR7tZGWpkjGMhmhMbLpN9tfHZwdsfp35jy3hzUFJFQWK2+i4F1t
   rt0CAG3Rln/9UjCVehsDlaKn4TAHdcGXkr+ixsOl/EKFZxYojo8a3LC/b
   SR4FCu3rbBeV/j38L7N0PCNmUw8PmdDmfS826sGINcWfnBHMo8wufdPJr
   zq81xD7BdxskpnKPLH+L6uQ4qHpVw5xcFz2G9ANbXb+uNXX2G0TUxFtd7
   2Wra4DI8Wwi9ph4r1L0MH0zoj6VVzyNDKfcVszLYhf6/pw5xUcvwUppEg
   lJYFWOBVUaTPNYWGZrREEx5IeTVUEoD0l0QHftbBrMGKvVR3mTgB9KvDq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="355086824"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="355086824"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 22:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="569372881"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2022 22:02:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnCZx-000EES-7s;
        Sat, 07 May 2022 05:02:05 +0000
Date:   Sat, 7 May 2022 13:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Likun Gao <Likun.Gao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 585/599]
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3459:17: error: implicit declaration
 of function 'vfree'; did you mean 'kfree'?
Message-ID: <202205071258.p2FKbi8O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   3170f5f234272247989fafee4cba4cbbc822631c
commit: 31aad22e2b3cfe89aef45015a9c7e4f7c0646daa [585/599] drm/amdgpu/psp: Add vbflash sysfs interface support
config: alpha-randconfig-r026-20220506 (https://download.01.org/0day-ci/archive/20220507/202205071258.p2FKbi8O-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 31aad22e2b3cfe89aef45015a9c7e4f7c0646daa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c: In function 'amdgpu_psp_vbflash_write':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3459:17: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
    3459 |                 vfree(adev->psp.vbflash_tmp_buf);
         |                 ^~~~~
         |                 kfree
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3467:45: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
    3467 |                 adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
         |                                             ^~~~~~~
         |                                             kvmalloc
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:3467:43: warning: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3467 |                 adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
         |                                           ^
   cc1: some warnings being treated as errors


vim +3459 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

  3447	
  3448	static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
  3449						struct bin_attribute *bin_attr,
  3450						char *buffer, loff_t pos, size_t count)
  3451	{
  3452		struct device *dev = kobj_to_dev(kobj);
  3453		struct drm_device *ddev = dev_get_drvdata(dev);
  3454		struct amdgpu_device *adev = drm_to_adev(ddev);
  3455	
  3456		/* Safeguard against memory drain */
  3457		if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
  3458			dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
> 3459			vfree(adev->psp.vbflash_tmp_buf);
  3460			adev->psp.vbflash_tmp_buf = NULL;
  3461			adev->psp.vbflash_image_size = 0;
  3462			return -ENOMEM;
  3463		}
  3464	
  3465		/* TODO Just allocate max for now and optimize to realloc later if needed */
  3466		if (!adev->psp.vbflash_tmp_buf) {
> 3467			adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
  3468			if (!adev->psp.vbflash_tmp_buf)
  3469				return -ENOMEM;
  3470		}
  3471	
  3472		mutex_lock(&adev->psp.mutex);
  3473		memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
  3474		adev->psp.vbflash_image_size += count;
  3475		mutex_unlock(&adev->psp.mutex);
  3476	
  3477		dev_info(adev->dev, "VBIOS flash write PSP done");
  3478	
  3479		return count;
  3480	}
  3481	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
