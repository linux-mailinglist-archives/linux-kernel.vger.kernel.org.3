Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1F59121B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiHLOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiHLOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:19:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BB89CFA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660313984; x=1691849984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KXN+Gs8gDE/y+asR3/oT8SUhOJatnbLYaxzZBiRp2no=;
  b=Ser0TpLM1bK/DCFh9wcpxkVRly48kk1Eo/bydbd9kG3g7TDINAT3II8w
   bOiFHoEH6jylgVs/nXsP4dNhI66R6i8KVbIj1kH4JPKEUomNSb/fO8N3Z
   zvOJBuYRIvk+65rU01VJPgkoOFlEpqUQzH24ErK4mlQ3Gb4NJ/PJ/uqMF
   9tGeL+qtJeHwARvd1wghw6+ddyA60VLLeFpfWl8lAGlZowDtZudGFVAR/
   FwbusW8fun32vIQd3Bu53DPH48+uSsmALmq8YSNu8Gvo+fBrAOVcZuD5A
   Z/9xuVwNfL/V2uOrIf6NPXGmy3uqavlr0OWWwPtGE8ZvIhSfW4xzkIk2p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292396799"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292396799"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:19:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634655752"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:19:41 -0700
Message-ID: <01c068ec-1cd4-f91a-53d6-9bcba6ae6873@linux.intel.com>
Date:   Fri, 12 Aug 2022 16:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/13] ASoC: amd: add Pink Sardine ACP PCI driver
Content-Language: en-US
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-3-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220812120731.788052-3-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
> ACP is a PCI audio device.
> This patch adds PCI driver to bind to this device and get
> PCI resources for Pink Sardine Platform.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/ps/acp62.h  | 21 +++++++++
>   sound/soc/amd/ps/pci-ps.c | 94 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 115 insertions(+)
>   create mode 100644 sound/soc/amd/ps/acp62.h
>   create mode 100644 sound/soc/amd/ps/pci-ps.c
> 
> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
> new file mode 100644
> index 000000000000..e91762240c93
> --- /dev/null
> +++ b/sound/soc/amd/ps/acp62.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * AMD ALSA SoC PDM Driver
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#include <sound/acp62_chip_offset_byte.h>
> +
> +#define ACP_DEVICE_ID 0x15E2
> +#define ACP62_PHY_BASE_ADDRESS 0x1240000
> +
> +static inline u32 acp62_readl(void __iomem *base_addr)
> +{
> +	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);

Can't you just define offsets in header, without ACP62_PHY_BASE_ADDRESS? 
Then you won't need to subtract the value here?
I mean like:
#define ACP_DMA_CNTL_0                                0x0000
#define ACP_DMA_CNTL_1                                0x0004
...
instead of
#define ACP_DMA_CNTL_0                                0x1240000
#define ACP_DMA_CNTL_1                                0x1240004
...
Seems a bit weird to me, to just define values with offset if it is not 
needed...

> +}
> +
> +static inline void acp62_writel(u32 val, void __iomem *base_addr)
> +{
> +	writel(val, base_addr - ACP62_PHY_BASE_ADDRESS);
> +}

Same here

> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> new file mode 100644
> index 000000000000..25169797275c
> --- /dev/null
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AMD Pink Sardine ACP PCI Driver
> + *
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +
> +#include "acp62.h"
> +
> +struct acp62_dev_data {
> +	void __iomem *acp62_base;
> +};
> +
> +static int snd_acp62_probe(struct pci_dev *pci,
> +			   const struct pci_device_id *pci_id)
> +{
> +	struct acp62_dev_data *adata;
> +	u32 addr;
> +	int ret;
> +
> +	/* Pink Sardine device check */
> +	switch (pci->revision) {
> +	case 0x63:
> +		break;
> +	default:
> +		dev_dbg(&pci->dev, "acp62 pci device not found\n");
> +		return -ENODEV;
> +	}
> +	if (pci_enable_device(pci)) {
> +		dev_err(&pci->dev, "pci_enable_device failed\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = pci_request_regions(pci, "AMD ACP6.2 audio");
> +	if (ret < 0) {
> +		dev_err(&pci->dev, "pci_request_regions failed\n");
> +		goto disable_pci;
> +	}
> +		adata = devm_kzalloc(&pci->dev, sizeof(struct acp62_dev_data),
> +				     GFP_KERNEL);

Wrong indentation in assignment above?

> +	if (!adata) {
> +		ret = -ENOMEM;
> +		goto release_regions;
> +	}
> +
> +	addr = pci_resource_start(pci, 0);
> +	adata->acp62_base = devm_ioremap(&pci->dev, addr,
> +					 pci_resource_len(pci, 0));
> +	if (!adata->acp62_base) {
> +		ret = -ENOMEM;
> +		goto release_regions;
> +	}
> +	pci_set_master(pci);
> +	pci_set_drvdata(pci, adata);
> +	return 0;
> +release_regions:
> +	pci_release_regions(pci);
> +disable_pci:
> +	pci_disable_device(pci);
> +
> +	return ret;
> +}
> +
> +static void snd_acp62_remove(struct pci_dev *pci)
> +{
> +	pci_release_regions(pci);
> +	pci_disable_device(pci);
> +}
> +
> +static const struct pci_device_id snd_acp62_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),

This one is optional, but you could also use:
PCI_VDEVICE(AMD, ACP_DEVICE_ID)
which is bit shorter and at least to me seems a bit more readable.

> +	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
> +	.class_mask = 0xffffff },
> +	{ 0, },
> +};
> +MODULE_DEVICE_TABLE(pci, snd_acp62_ids);
> +
> +static struct pci_driver ps_acp62_driver  = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = snd_acp62_ids,
> +	.probe = snd_acp62_probe,
> +	.remove = snd_acp62_remove,
> +};
> +
> +module_pci_driver(ps_acp62_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_AUTHOR("Syed.SabaKareem@amd.com");
> +MODULE_DESCRIPTION("AMD ACP Pink Sardine PCI driver");
> +MODULE_LICENSE("GPL v2");

