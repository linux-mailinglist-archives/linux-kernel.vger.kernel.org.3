Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04758A423
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiHEAWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbiHEAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:21:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0DC72EEB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659658913; x=1691194913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kmocP3pQlHDoCikAfL+rSE6N9vOwDpKEdF2hdHk9vw0=;
  b=dMubeN0VwRBkbgngp3AXs0L3mdCw6SNXqz5igRt97efRAFv8BKXO90c1
   bKm2bjlO1BlmX1lkQVpgeWwXcRlDTqfqgv8vhj5MiLq+AVaic+rjm70CZ
   MxZNJos+UhvfSW8wV5NGelTvvBX8f/Lgmo/WwjecBZq+aJvImprNpeQ0N
   a2Ati6feBDqL1s2QG2bMiGyQ4ZQGNC/6xUz5N77W3TN3SihwRVdyEo2rG
   DeqOd/uFpylyhIsl/i0F+O4gcSZ/uFKVlaVtLjtA89aimoS3loSlcNCZG
   DgK8ux9gzAEU2+52Zu3Ls79dK7zYpJVA/E3Vmxoa/bdXH0O+4HlTg3Egz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="269858098"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="269858098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553923538"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 17:21:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJl66-000Iyx-2R;
        Fri, 05 Aug 2022 00:21:50 +0000
Date:   Fri, 5 Aug 2022 08:21:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted
 __le32
Message-ID: <202208050850.XNdMMV1C-lkp@intel.com>
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
head:   c040862bfbd9c5f3cb64e1df1c623e20e38fe656
commit: f1383348ad0fe0d568dfd37f2552b0b4f044dbe5 soc: qcom: smem: validate fields of shared structures
date:   4 months ago
config: sh-randconfig-s041-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050850.XNdMMV1C-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1383348ad0fe0d568dfd37f2552b0b4f044dbe5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f1383348ad0fe0d568dfd37f2552b0b4f044dbe5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/smem.c:430:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:430:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:430:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:517:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:517:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:517:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:537:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:537:50: sparse:     expected void *
   drivers/soc/qcom/smem.c:537:50: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:698:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:698:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:698:22: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
>> drivers/soc/qcom/smem.c:702:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:706:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:706:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:706:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:710:27: sparse: sparse: cast to restricted __le32
   drivers/soc/qcom/smem.c:713:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:713:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:713:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:726:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:726:30: sparse:    void *
   drivers/soc/qcom/smem.c:726:30: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:747:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:756:28: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:765:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:780:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:780:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:780:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:813:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/soc/qcom/smem.c:834:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:834:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:834:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:985:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:985:22: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:985:22: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:1094:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:1094:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:1094:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:1115:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1115:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1115:16: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c:1115:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1115:52: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smem.c:1115:52: sparse:     got restricted __le32 *

vim +702 drivers/soc/qcom/smem.c

   504	
   505	static void *qcom_smem_get_global(struct qcom_smem *smem,
   506					  unsigned item,
   507					  size_t *size)
   508	{
   509		struct smem_header *header;
   510		struct smem_region *region;
   511		struct smem_global_entry *entry;
   512		u64 entry_offset;
   513		u32 e_size;
   514		u32 aux_base;
   515		unsigned i;
   516	
 > 517		header = smem->regions[0].virt_base;
   518		entry = &header->toc[item];
   519		if (!entry->allocated)
   520			return ERR_PTR(-ENXIO);
   521	
   522		aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
   523	
   524		for (i = 0; i < smem->num_regions; i++) {
   525			region = &smem->regions[i];
   526	
   527			if ((u32)region->aux_base == aux_base || !aux_base) {
   528				e_size = le32_to_cpu(entry->size);
   529				entry_offset = le32_to_cpu(entry->offset);
   530	
   531				if (WARN_ON(e_size + entry_offset > region->size))
   532					return ERR_PTR(-EINVAL);
   533	
   534				if (size != NULL)
   535					*size = e_size;
   536	
   537				return region->virt_base + entry_offset;
   538			}
   539		}
   540	
   541		return ERR_PTR(-ENOENT);
   542	}
   543	
   544	static void *qcom_smem_get_private(struct qcom_smem *smem,
   545					   struct smem_partition *part,
   546					   unsigned item,
   547					   size_t *size)
   548	{
   549		struct smem_private_entry *e, *end;
   550		struct smem_partition_header *phdr;
   551		void *item_ptr, *p_end;
   552		u32 padding_data;
   553		u32 e_size;
   554	
   555		phdr = (struct smem_partition_header __force *)part->virt_base;
   556		p_end = (void *)phdr + part->size;
   557	
   558		e = phdr_to_first_uncached_entry(phdr);
   559		end = phdr_to_last_uncached_entry(phdr);
   560	
   561		while (e < end) {
   562			if (e->canary != SMEM_PRIVATE_CANARY)
   563				goto invalid_canary;
   564	
   565			if (le16_to_cpu(e->item) == item) {
   566				if (size != NULL) {
   567					e_size = le32_to_cpu(e->size);
   568					padding_data = le16_to_cpu(e->padding_data);
   569	
   570					if (WARN_ON(e_size > part->size || padding_data > e_size))
   571						return ERR_PTR(-EINVAL);
   572	
   573					*size = e_size - padding_data;
   574				}
   575	
   576				item_ptr = uncached_entry_to_item(e);
   577				if (WARN_ON(item_ptr > p_end))
   578					return ERR_PTR(-EINVAL);
   579	
   580				return item_ptr;
   581			}
   582	
   583			e = uncached_entry_next(e);
   584		}
   585	
   586		if (WARN_ON((void *)e > p_end))
   587			return ERR_PTR(-EINVAL);
   588	
   589		/* Item was not found in the uncached list, search the cached list */
   590	
   591		e = phdr_to_first_cached_entry(phdr, part->cacheline);
   592		end = phdr_to_last_cached_entry(phdr);
   593	
   594		if (WARN_ON((void *)e < (void *)phdr || (void *)end > p_end))
   595			return ERR_PTR(-EINVAL);
   596	
   597		while (e > end) {
   598			if (e->canary != SMEM_PRIVATE_CANARY)
   599				goto invalid_canary;
   600	
   601			if (le16_to_cpu(e->item) == item) {
   602				if (size != NULL) {
   603					e_size = le32_to_cpu(e->size);
   604					padding_data = le16_to_cpu(e->padding_data);
   605	
   606					if (WARN_ON(e_size > part->size || padding_data > e_size))
   607						return ERR_PTR(-EINVAL);
   608	
   609					*size = e_size - padding_data;
   610				}
   611	
   612				item_ptr = cached_entry_to_item(e);
   613				if (WARN_ON(item_ptr < (void *)phdr))
   614					return ERR_PTR(-EINVAL);
   615	
   616				return item_ptr;
   617			}
   618	
   619			e = cached_entry_next(e, part->cacheline);
   620		}
   621	
   622		if (WARN_ON((void *)e < (void *)phdr))
   623			return ERR_PTR(-EINVAL);
   624	
   625		return ERR_PTR(-ENOENT);
   626	
   627	invalid_canary:
   628		dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
   629				le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
   630	
   631		return ERR_PTR(-EINVAL);
   632	}
   633	
   634	/**
   635	 * qcom_smem_get() - resolve ptr of size of a smem item
   636	 * @host:	the remote processor, or -1
   637	 * @item:	smem item handle
   638	 * @size:	pointer to be filled out with size of the item
   639	 *
   640	 * Looks up smem item and returns pointer to it. Size of smem
   641	 * item is returned in @size.
   642	 */
   643	void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
   644	{
   645		struct smem_partition *part;
   646		unsigned long flags;
   647		int ret;
   648		void *ptr = ERR_PTR(-EPROBE_DEFER);
   649	
   650		if (!__smem)
   651			return ptr;
   652	
   653		if (WARN_ON(item >= __smem->item_count))
   654			return ERR_PTR(-EINVAL);
   655	
   656		ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
   657						  HWSPINLOCK_TIMEOUT,
   658						  &flags);
   659		if (ret)
   660			return ERR_PTR(ret);
   661	
   662		if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
   663			part = &__smem->partitions[host];
   664			ptr = qcom_smem_get_private(__smem, part, item, size);
   665		} else if (__smem->global_partition.virt_base) {
   666			part = &__smem->global_partition;
   667			ptr = qcom_smem_get_private(__smem, part, item, size);
   668		} else {
   669			ptr = qcom_smem_get_global(__smem, item, size);
   670		}
   671	
   672		hwspin_unlock_irqrestore(__smem->hwlock, &flags);
   673	
   674		return ptr;
   675	
   676	}
   677	EXPORT_SYMBOL(qcom_smem_get);
   678	
   679	/**
   680	 * qcom_smem_get_free_space() - retrieve amount of free space in a partition
   681	 * @host:	the remote processor identifying a partition, or -1
   682	 *
   683	 * To be used by smem clients as a quick way to determine if any new
   684	 * allocations has been made.
   685	 */
   686	int qcom_smem_get_free_space(unsigned host)
   687	{
   688		struct smem_partition *part;
   689		struct smem_partition_header *phdr;
   690		struct smem_header *header;
   691		unsigned ret;
   692	
   693		if (!__smem)
   694			return -EPROBE_DEFER;
   695	
   696		if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
   697			part = &__smem->partitions[host];
   698			phdr = part->virt_base;
   699			ret = le32_to_cpu(phdr->offset_free_cached) -
   700			      le32_to_cpu(phdr->offset_free_uncached);
   701	
 > 702			if (ret > le32_to_cpu(part->size))
   703				return -EINVAL;
   704		} else if (__smem->global_partition.virt_base) {
   705			part = &__smem->global_partition;
   706			phdr = part->virt_base;
   707			ret = le32_to_cpu(phdr->offset_free_cached) -
   708			      le32_to_cpu(phdr->offset_free_uncached);
   709	
   710			if (ret > le32_to_cpu(part->size))
   711				return -EINVAL;
   712		} else {
   713			header = __smem->regions[0].virt_base;
   714			ret = le32_to_cpu(header->available);
   715	
   716			if (ret > __smem->regions[0].size)
   717				return -EINVAL;
   718		}
   719	
   720		return ret;
   721	}
   722	EXPORT_SYMBOL(qcom_smem_get_free_space);
   723	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
