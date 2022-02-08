Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4A4ACF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbiBHDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbiBHCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:40:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11728C03FEC0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644288056; x=1675824056;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G6VbzIs2C4kvJ9oS0aTPvUArRslNHPTgVY+IiGxNTGQ=;
  b=GNkVBGIZN/I+JSKTW8AK8nHLOyTV6uxbDOe1egPAuZgu5yUoXhKJSMbG
   /Z7UsSbB2R8MkCl2dDgsQnZTarPB2GccKrrrlC/6cjv7u390xQoDdVL5o
   ZvNlnvm0n+eJAhoOP/33Q11v2kn1wE/jBeiEnmb3QarbmIJwdxhNCUgu6
   tY/kRf7HdoLlI9+1m+yJfSZWwDkB6EZXFxrngNFxl/YCQGHIdT0EKHY3d
   3SU7Y1R4ldgpXI6m3f+zLgeBOlpBLVOsxDFLkwBcd/YBpPTV8h+T6FjYZ
   j+kCbyzCjMQy7yzEhRUBeEZoRrjBf3rxMUXlmFEjHazRbyX7YlX6l6dNZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273384102"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="273384102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677965696"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 18:40:52 -0800
Message-ID: <3ab8d345-da63-4193-ae38-b3fdc56fddff@linux.intel.com>
Date:   Tue, 8 Feb 2022 10:39:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to
 CONFIG_IOMMU_SVA
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-2-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207230254.3342514-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 7:02 AM, Fenghua Yu wrote:
> This CONFIG option originally only referred to the Shared
> Virtual Address (SVA) library. But it is now also used for
> non-library portions of code.
> 
> Drop the "_LIB" suffix so that there is just one configuration
> options for all code relating to SVA.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v4:
> - Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).
> 
> v2:
> - Add this patch for more meaningful name CONFIG_IOMMU_SVA
> 
>   drivers/iommu/Kconfig         | 6 +++---
>   drivers/iommu/Makefile        | 2 +-
>   drivers/iommu/intel/Kconfig   | 2 +-
>   drivers/iommu/iommu-sva-lib.h | 6 +++---
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 3eb68fa1b8cc..c79a0df090c0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -144,8 +144,8 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> -# Shared Virtual Addressing library
> -config IOMMU_SVA_LIB
> +# Shared Virtual Addressing
> +config IOMMU_SVA
>   	bool
>   	select IOASID
>   
> @@ -379,7 +379,7 @@ config ARM_SMMU_V3
>   config ARM_SMMU_V3_SVA
>   	bool "Shared Virtual Addressing support for the ARM SMMUv3"
>   	depends on ARM_SMMU_V3
> -	select IOMMU_SVA_LIB
> +	select IOMMU_SVA
>   	select MMU_NOTIFIER
>   	help
>   	  Support for sharing process address spaces with devices using the
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index bc7f730edbb0..44475a9b3eea 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>   obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> -obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
> +obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
>   obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>   obj-$(CONFIG_APPLE_DART) += apple-dart.o
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 247d0f2d5fdf..39a06d245f12 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -52,7 +52,7 @@ config INTEL_IOMMU_SVM
>   	select PCI_PRI
>   	select MMU_NOTIFIER
>   	select IOASID
> -	select IOMMU_SVA_LIB
> +	select IOMMU_SVA
>   	help
>   	  Shared Virtual Memory (SVM) provides a facility for devices
>   	  to access DMA resources through process address space by
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 031155010ca8..95dc3ebc1928 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -17,7 +17,7 @@ struct device;
>   struct iommu_fault;
>   struct iopf_queue;
>   
> -#ifdef CONFIG_IOMMU_SVA_LIB
> +#ifdef CONFIG_IOMMU_SVA
>   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
>   
>   int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
> @@ -28,7 +28,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
>   void iopf_queue_free(struct iopf_queue *queue);
>   int iopf_queue_discard_partial(struct iopf_queue *queue);
>   
> -#else /* CONFIG_IOMMU_SVA_LIB */
> +#else /* CONFIG_IOMMU_SVA */
>   static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
>   {
>   	return -ENODEV;
> @@ -64,5 +64,5 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
>   {
>   	return -ENODEV;
>   }
> -#endif /* CONFIG_IOMMU_SVA_LIB */
> +#endif /* CONFIG_IOMMU_SVA */
>   #endif /* _IOMMU_SVA_LIB_H */

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
