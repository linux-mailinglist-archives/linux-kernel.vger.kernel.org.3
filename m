Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9252458A3BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiHDXBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiHDXAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:00:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B1F1147
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659654052; x=1691190052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dvz4xAWKdHiICs7Gd7M1iUpnLLFxnNSL1jEvSRL/Lck=;
  b=d38DyhsDQ4y9PZbI3nfFRkYdNg8BLlqcPFIZSE0pDrWhXncpQETWolCi
   n/P0uer76sgCeVg8g6VLa+qW8XTzIzlQOArhEPIklE9blR09fCgH/e9YL
   XQ32X61GySxTLcSXriXsqhDntkQlXRmnPgsgNIs7+kvq+GQhQZmFJEXto
   JKHLQnf6ug46737GADX5owuMNB+4lLolyxYhEYm92LF/lsMFeF42RqIf1
   x/AL0Rd/kf0RjGkDisMUUV2sv2AWQ4s/kg5cuzIjFSHjdqOb852mmneqz
   9JVlNJhL6rYD5jf+iw3xyNj2HSw/NOVluHOAOHZCAmhM0rN4ZsZy0eJXn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="269847187"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="269847187"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 16:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636283360"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 16:00:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJjpV-000Ivv-1y;
        Thu, 04 Aug 2022 23:00:37 +0000
Date:   Fri, 5 Aug 2022 06:59:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/soc/qcom/smem.c:648:22: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202208050606.obCObB8T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1c76700a0d6e6090ccfe1209527f14c21b6681b
commit: 20bb6c9de1b7e13f11d2ffe73686f4449c426807 soc: qcom: smem: map only partitions used by local HOST
date:   4 months ago
config: sh-randconfig-s041-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050606.obCObB8T-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20bb6c9de1b7e13f11d2ffe73686f4449c426807
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20bb6c9de1b7e13f11d2ffe73686f4449c426807
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/smem.c:422:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:422:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:422:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:507:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:507:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:507:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:520:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:520:50: sparse:     expected void *
   drivers/soc/qcom/smem.c:520:50: sparse:     got void [noderef] __iomem *
>> drivers/soc/qcom/smem.c:648:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:648:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:648:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:653:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:653:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:653:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:657:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:657:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:657:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:667:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:667:30: sparse:    void *
   drivers/soc/qcom/smem.c:667:30: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:688:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:697:28: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:706:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:721:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:721:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:721:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:754:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/soc/qcom/smem.c:775:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:775:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:775:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:926:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:926:22: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:926:22: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:1035:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:1035:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:1035:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:1056:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1056:16: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c:1056:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:52: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1056:52: sparse:     got restricted __le32 *

vim +648 drivers/soc/qcom/smem.c

   628	
   629	/**
   630	 * qcom_smem_get_free_space() - retrieve amount of free space in a partition
   631	 * @host:	the remote processor identifying a partition, or -1
   632	 *
   633	 * To be used by smem clients as a quick way to determine if any new
   634	 * allocations has been made.
   635	 */
   636	int qcom_smem_get_free_space(unsigned host)
   637	{
   638		struct smem_partition *part;
   639		struct smem_partition_header *phdr;
   640		struct smem_header *header;
   641		unsigned ret;
   642	
   643		if (!__smem)
   644			return -EPROBE_DEFER;
   645	
   646		if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
   647			part = &__smem->partitions[host];
 > 648			phdr = part->virt_base;
   649			ret = le32_to_cpu(phdr->offset_free_cached) -
   650			      le32_to_cpu(phdr->offset_free_uncached);
   651		} else if (__smem->global_partition.virt_base) {
   652			part = &__smem->global_partition;
   653			phdr = part->virt_base;
   654			ret = le32_to_cpu(phdr->offset_free_cached) -
   655			      le32_to_cpu(phdr->offset_free_uncached);
   656		} else {
   657			header = __smem->regions[0].virt_base;
   658			ret = le32_to_cpu(header->available);
   659		}
   660	
   661		return ret;
   662	}
   663	EXPORT_SYMBOL(qcom_smem_get_free_space);
   664	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
