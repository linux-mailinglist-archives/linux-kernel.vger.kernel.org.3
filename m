Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D354AC79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbiFNIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355895AbiFNItj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:49:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DF13CF1;
        Tue, 14 Jun 2022 01:49:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25E8mpFE060385;
        Tue, 14 Jun 2022 03:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655196531;
        bh=CDf43wcE6wSh3PzlVgmbjR8Np/ai78l/H7vjoYFhOkU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lH+zrL9aZF6hMI1zQYVIj2+YAy4Re0EqZyoS7NsF2LqIU9ht70kczMRbjJSE8pthm
         DhgCLWbwKjpURMKaDAoU/ylwKjfHqil5RSj+wwKMHzI7dMxQN8gz3PX79kePwTFMBC
         HT7btcyrJ8HyjPgyLWxPQP8N9AS2B8O5Hew3Q7kw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25E8mpXD097757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jun 2022 03:48:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Jun 2022 03:48:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Jun 2022 03:48:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25E8mnC0016187;
        Tue, 14 Jun 2022 03:48:50 -0500
Date:   Tue, 14 Jun 2022 14:18:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Brad Larson <brad@pensando.io>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <broonie@kernel.org>, <yamada.masahiro@socionext.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <fancer.lancer@gmail.com>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <ulf.hansson@linaro.org>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD
 Pensando Elba SoC
Message-ID: <20220614084849.oodxh6cthysga5iq@ti.com>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-12-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-12-brad@pensando.io>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On 13/06/22 12:56PM, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.
> 
> The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
> a dummy readback from the controller is performed to ensure
> synchronization.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 72b1a5a2298c..ebb77ea8e6ba 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -39,6 +39,7 @@
>  #define CQSPI_DISABLE_DAC_MODE		BIT(1)
>  #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
>  #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
> +#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(4)
>  
>  /* Capabilities */
>  #define CQSPI_SUPPORTS_OCTAL		BIT(0)
> @@ -87,6 +88,7 @@ struct cqspi_st {
>  	bool			use_dma_read;
>  	u32			pd_dev_id;
>  	bool			wr_completion;
> +	bool			apb_ahb_hazard;
>  };
>  
>  struct cqspi_driver_platdata {
> @@ -952,6 +954,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>  	if (cqspi->wr_delay)
>  		ndelay(cqspi->wr_delay);
>  
> +	/*
> +	 * If a hazard exists between the APB and AHB interfaces, perform a
> +	 * dummy readback from the controller to ensure synchronization.
> +	 */

This is needed for TI's SoCs as well. APB and AHB accesses are 
independent of each other on the interconnect and can be racy. I wrote a 
couple patches [0][1] to fix this on TI's fork. I never got around to 
sending them upstream. It would be great if you can pick those up. They 
fix the race in all paths, not just indirect write.

I would also prefer if we do this unconditionally. I don't think it has 
much downside even on platforms that do not strictly need this.

[0] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=027f03a8512086e5ef05dc4e4ff53b2628848f95
[1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=4c367e58bab7d3f9c470c3778441f73546f20398

> +	if (cqspi->apb_ahb_hazard)
> +		(void)readl(reg_base + CQSPI_REG_INDIRECTWR);
> +
>  	while (remaining > 0) {
>  		size_t write_words, mod_bytes;
>  
> @@ -1667,6 +1676,8 @@ static int cqspi_probe(struct platform_device *pdev)
>  			cqspi->use_dma_read = true;
>  		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
>  			cqspi->wr_completion = false;
> +		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
> +			cqspi->apb_ahb_hazard = true;
>  
>  		if (of_device_is_compatible(pdev->dev.of_node,
>  					    "xlnx,versal-ospi-1.0"))
> @@ -1789,6 +1800,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
>  	.get_dma_status = cqspi_get_versal_dma_status,
>  };
>  
> +static const struct cqspi_driver_platdata pen_cdns_qspi = {
> +	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
> +};
> +
>  static const struct of_device_id cqspi_dt_ids[] = {
>  	{
>  		.compatible = "cdns,qspi-nor",
> @@ -1814,6 +1829,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>  		.compatible = "intel,socfpga-qspi",
>  		.data = &socfpga_qspi,
>  	},
> +	{
> +		.compatible = "amd,pensando-elba-qspi",
> +		.data = &pen_cdns_qspi,
> +	},
>  	{ /* end of table */ }
>  };
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
