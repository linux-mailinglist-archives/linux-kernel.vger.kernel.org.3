Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F025AA37D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiIAXEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiIAXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:04:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386D1DA67
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662072905; x=1693608905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xZecgiVtGDKAmT4vgslybwpy2wW/tgvX/mNGxe5JJpg=;
  b=HLxQaL6UZDlhC1SERi7z8KU9yxNcgkuT76Ek1KEf6vBXI1dXPWyXkf31
   xnidHrObSiXlulcUddlSrMDkvouDwBUrVpLwxlkdtFpEIyHbtRZpb136y
   G0XoSUnaSr2KbyOBML1ZQ6Y02GERDfw7KHM1uZHpkx+pG6C/s/z0VOnv0
   VbbBem2L+RwgH6V5RjMCKWCDWBHiGqJOBnHK44Tb7HhmfBpHNOrGxiTzB
   Jnfki1CPmkHepfkqRscrX567tHgj+ji0BhlruXFhutA3CyDzI3IrWgxPz
   3gJAYBFGpNM9uT5eUyMxuuiffYY0Zg1Ubj1to+UhM6tjdg9sZBZ3VyhTV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296627664"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296627664"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="738664959"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2022 15:55:03 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTt5S-0000sD-1E;
        Thu, 01 Sep 2022 22:55:02 +0000
Date:   Fri, 2 Sep 2022 06:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ben Chan <benchan@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 3732/9354]
 drivers/firmware/qcom_scm.c:469:47: error: passing argument 3 of
 'dma_alloc_coherent' from incompatible pointer type
Message-ID: <202209020615.uk7OtnTY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: 0a3be2a2dde39be93f49bbfb657edbaf29871648 [3732/9354] UPSTREAM: firmware: scm: Add new SCM call API for switching memory ownership
config: arm-randconfig-r021-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020615.uk7OtnTY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/0a3be2a2dde39be93f49bbfb657edbaf29871648
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout 0a3be2a2dde39be93f49bbfb657edbaf29871648
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash M=drivers/firmware

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/firmware/qcom_scm.c: In function 'qcom_scm_assign_mem':
>> drivers/firmware/qcom_scm.c:469:47: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
                                                  ^
   In file included from drivers/firmware/qcom_scm.c:21:0:
   include/linux/dma-mapping.h:542:21: note: expected 'dma_addr_t * {aka long long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned int *}'
    static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                        ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dma_alloc_coherent +469 drivers/firmware/qcom_scm.c

   430	
   431	/**
   432	 * qcom_scm_assign_mem() - Make a secure call to reassign memory ownership
   433	 * @mem_addr: mem region whose ownership need to be reassigned
   434	 * @mem_sz:   size of the region.
   435	 * @srcvm:    vmid for current set of owners, each set bit in
   436	 *            flag indicate a unique owner
   437	 * @newvm:    array having new owners and corrsponding permission
   438	 *            flags
   439	 * @dest_cnt: number of owners in next set.
   440	 *
   441	 * Return negative errno on failure, 0 on success, with @srcvm updated.
   442	 */
   443	int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
   444				unsigned int *srcvm,
   445				struct qcom_scm_vmperm *newvm, int dest_cnt)
   446	{
   447		struct qcom_scm_current_perm_info *destvm;
   448		struct qcom_scm_mem_map_info *mem_to_map;
   449		phys_addr_t mem_to_map_phys;
   450		phys_addr_t dest_phys;
   451		phys_addr_t ptr_phys;
   452		size_t mem_to_map_sz;
   453		size_t dest_sz;
   454		size_t src_sz;
   455		size_t ptr_sz;
   456		int next_vm;
   457		__le32 *src;
   458		void *ptr;
   459		int ret;
   460		int len;
   461		int i;
   462	
   463		src_sz = hweight_long(*srcvm) * sizeof(*src);
   464		mem_to_map_sz = sizeof(*mem_to_map);
   465		dest_sz = dest_cnt * sizeof(*destvm);
   466		ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
   467				ALIGN(dest_sz, SZ_64);
   468	
 > 469		ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
   470		if (!ptr)
   471			return -ENOMEM;
   472	
   473		/* Fill source vmid detail */
   474		src = ptr;
   475		len = hweight_long(*srcvm);
   476		for (i = 0; i < len; i++) {
   477			src[i] = cpu_to_le32(ffs(*srcvm) - 1);
   478			*srcvm ^= 1 << (ffs(*srcvm) - 1);
   479		}
   480	
   481		/* Fill details of mem buff to map */
   482		mem_to_map = ptr + ALIGN(src_sz, SZ_64);
   483		mem_to_map_phys = ptr_phys + ALIGN(src_sz, SZ_64);
   484		mem_to_map[0].mem_addr = cpu_to_le64(mem_addr);
   485		mem_to_map[0].mem_size = cpu_to_le64(mem_sz);
   486	
   487		next_vm = 0;
   488		/* Fill details of next vmid detail */
   489		destvm = ptr + ALIGN(mem_to_map_sz, SZ_64) + ALIGN(src_sz, SZ_64);
   490		dest_phys = ptr_phys + ALIGN(mem_to_map_sz, SZ_64) + ALIGN(src_sz, SZ_64);
   491		for (i = 0; i < dest_cnt; i++) {
   492			destvm[i].vmid = cpu_to_le32(newvm[i].vmid);
   493			destvm[i].perm = cpu_to_le32(newvm[i].perm);
   494			destvm[i].ctx = 0;
   495			destvm[i].ctx_size = 0;
   496			next_vm |= BIT(newvm[i].vmid);
   497		}
   498	
   499		ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
   500					    ptr_phys, src_sz, dest_phys, dest_sz);
   501		dma_free_coherent(__scm->dev, ALIGN(ptr_sz, SZ_64), ptr, ptr_phys);
   502		if (ret) {
   503			dev_err(__scm->dev,
   504				"Assign memory protection call failed %d.\n", ret);
   505			return -EINVAL;
   506		}
   507	
   508		*srcvm = next_vm;
   509		return 0;
   510	}
   511	EXPORT_SYMBOL(qcom_scm_assign_mem);
   512	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
