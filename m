Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150CE591219
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiHLOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbiHLOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:20:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049F9AFC3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660314007; x=1691850007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=elrodQBYvoyAiCUHaz/zd2XJmNYPAM6SM/vqf4Qaa1o=;
  b=jL9pNKrkqTkBs+QEEwUPQpHlLVRgeuRQp++r1t5WPlo/hRZMBB85s3fG
   PG5cS2RhDy2TQB9TCZvOQHccYg9m9fOMjcDkDF+1sYMLM3AJguqWU2Vi+
   nWBO1YrAFEm9G/ICBbj7apWJXwpRNAmPR4wkcPl38Z8m0l5AYLURgWRee
   Oi20Qgw/+5mtzAFATzMEXnYvGY3DhkUVoDsD3PDaQOmodOBbGXcT3AN2S
   9H8gV2SKMRDM9qyrVnKBypfcmUDOSIL/9GXBxrTGeE3fUdk20E9l/PHG+
   /GDAuCDd3yxYU2tujaaBljH7PaYDbhKdGoulExeDHJ1RyoQfgsS3oiA2s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355606890"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355606890"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634655841"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:20:03 -0700
Message-ID: <f55c444b-d1c7-9d61-1f0c-c6bfe32ca2db@linux.intel.com>
Date:   Fri, 12 Aug 2022 16:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] ASoC: amd: add platform devices for acp6.2 pdm
 driver and dmic driver
Content-Language: en-US
To:     Syed Saba kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-5-Syed.SabaKareem@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220812120731.788052-5-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
> ACP6.2 IP has PDM decoder block.
> Create a platform device for it, so that the PDM platform driver
> can be bound to this device.
> Pass PCI resources like MMIO to this platform device.
> 
> Create a platform device for generic dmic codec driver.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/ps/acp62.h  | 23 +++++++++++
>   sound/soc/amd/ps/pci-ps.c | 83 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 104 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
> index 8e734f190b11..ab56e1f8c31b 100644
> --- a/sound/soc/amd/ps/acp62.h
> +++ b/sound/soc/amd/ps/acp62.h
> @@ -9,6 +9,10 @@
>   
>   #define ACP_DEVICE_ID 0x15E2
>   #define ACP62_PHY_BASE_ADDRESS 0x1240000
> +#define ACP6x_REG_START		0x1240000
> +#define ACP6x_REG_END		0x1250200
> +#define ACP6x_DEVS		2
> +#define ACP6x_PDM_MODE		1
>   
>   #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
>   #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
> @@ -22,6 +26,25 @@
>   #define ACP_ERROR_MASK 0x20000000
>   #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
>   
> +enum acp_config {
> +	ACP_CONFIG_0 = 0,
> +	ACP_CONFIG_1,
> +	ACP_CONFIG_2,
> +	ACP_CONFIG_3,
> +	ACP_CONFIG_4,
> +	ACP_CONFIG_5,
> +	ACP_CONFIG_6,
> +	ACP_CONFIG_7,
> +	ACP_CONFIG_8,
> +	ACP_CONFIG_9,
> +	ACP_CONFIG_10,
> +	ACP_CONFIG_11,
> +	ACP_CONFIG_12,
> +	ACP_CONFIG_13,
> +	ACP_CONFIG_14,
> +	ACP_CONFIG_15,
> +};
> +
>   static inline u32 acp62_readl(void __iomem *base_addr)
>   {
>   	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 2014f415af15..94201f75427a 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -9,11 +9,16 @@
>   #include <linux/module.h>
>   #include <linux/io.h>
>   #include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>   
>   #include "acp62.h"
>   
>   struct acp62_dev_data {
>   	void __iomem *acp62_base;
> +	struct resource *res;
> +	bool acp62_audio_mode;
> +	struct platform_device *pdev[ACP6x_DEVS];
>   };
>   
>   static int acp62_power_on(void __iomem *acp_base)
> @@ -117,8 +122,11 @@ static int snd_acp62_probe(struct pci_dev *pci,
>   			   const struct pci_device_id *pci_id)
>   {
>   	struct acp62_dev_data *adata;
> +	struct platform_device_info pdevinfo[ACP6x_DEVS];
> +	int index, ret;
> +	int val = 0x00;
> +	struct acpi_device *adev;
>   	u32 addr;
> -	int ret;
>   
>   	/* Pink Sardine device check */
>   	switch (pci->revision) {
> @@ -157,8 +165,75 @@ static int snd_acp62_probe(struct pci_dev *pci,
>   	ret = acp62_init(adata->acp62_base);
>   	if (ret)
>   		goto release_regions;
> +	val = acp62_readl(adata->acp62_base + ACP_PIN_CONFIG);
> +	switch (val) {
> +	case ACP_CONFIG_0:
> +	case ACP_CONFIG_1:
> +	case ACP_CONFIG_2:
> +	case ACP_CONFIG_3:
> +	case ACP_CONFIG_9:
> +	case ACP_CONFIG_15:
> +		dev_info(&pci->dev, "Audio Mode %d\n", val);
> +		break;
> +	default:
> +
> +		/* Checking DMIC hardware*/
> +		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
> +

You can probably remove one level of indentation in following code if 
you do:
		if (!adev)
			break;

> +		if (adev) {
> +			const union acpi_object *obj;
> +
> +			if (!acpi_dev_get_property(adev, "acp-audio-device-type",
> +						   ACPI_TYPE_INTEGER, &obj) &&
> +						   obj->integer.value == 2) {
> +				adata->res = devm_kzalloc(&pci->dev,
> +							  sizeof(struct resource), GFP_KERNEL);
> +
> +				if (!adata->res) {
> +					ret = -ENOMEM;
> +					goto de_init;
> +				}
> +
> +				adata->res->name = "acp_iomem";
> +				adata->res->flags = IORESOURCE_MEM;
> +				adata->res->start = addr;
> +				adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
> +				adata->acp62_audio_mode = ACP6x_PDM_MODE;
>   
> +				memset(&pdevinfo, 0, sizeof(pdevinfo));
> +				pdevinfo[0].name = "acp_ps_pdm_dma";
> +				pdevinfo[0].id = 0;
> +				pdevinfo[0].parent = &pci->dev;
> +				pdevinfo[0].num_res = 1;
> +				pdevinfo[0].res = adata->res;
> +
> +				pdevinfo[1].name = "dmic-codec";
> +				pdevinfo[1].id = 0;
> +				pdevinfo[1].parent = &pci->dev;
> +
> +				for (index = 0; index < ACP6x_DEVS; index++) {
> +					adata->pdev[index] =
> +						platform_device_register_full(&pdevinfo[index]);
> +
> +					if (IS_ERR(adata->pdev[index])) {
> +						dev_err(&pci->dev,
> +							"cannot register %s device\n",
> +							 pdevinfo[index].name);
> +						ret = PTR_ERR(adata->pdev[index]);
> +						goto unregister_devs;
> +					}
> +				}
> +			}
> +		}
> +		break;
> +	}
>   	return 0;
> +unregister_devs:
> +	for (--index; index >= 0; index--)
> +		platform_device_unregister(adata->pdev[index]);
> +de_init:
> +	if (acp62_deinit(adata->acp62_base))
> +		dev_err(&pci->dev, "ACP de-init failed\n");
>   release_regions:
>   	pci_release_regions(pci);
>   disable_pci:
> @@ -170,9 +245,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
>   static void snd_acp62_remove(struct pci_dev *pci)
>   {
>   	struct acp62_dev_data *adata;
> -	int ret;
> +	int ret, index;
>   
>   	adata = pci_get_drvdata(pci);
> +	if (adata->acp62_audio_mode == ACP6x_PDM_MODE) {
> +		for (index = 0; index < ACP6x_DEVS; index++)
> +			platform_device_unregister(adata->pdev[index]);
> +	}
>   	ret = acp62_deinit(adata->acp62_base);
>   	if (ret)
>   		dev_err(&pci->dev, "ACP de-init failed\n");

