Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28C575C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiGOH2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGOH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:28:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6E7AC15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:28:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220715072823euoutp01c2360eeff1b0804eab3271799f056398~B8BNI0m141452114521euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:28:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220715072823euoutp01c2360eeff1b0804eab3271799f056398~B8BNI0m141452114521euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657870103;
        bh=j7SILxF/B03LHYKsYnrPmO5EUlheo0smkknt2sa8myU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Oy1rfgnwqEqxsCT0RBwUhU3XdPGCNnDM2xCPnGF9HSV8UHqlljZLng986Xztc75Kp
         JS9lm810uVFHUzdNJsihuuyaT7uFb+X2WAq/KagmUS68ee/Yrrxh78LedeVRYMgntg
         yv9nGeT30L66YowcPilfq+25eoQq2ruOz8X/oTZI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220715072823eucas1p1e713995f513d7bf9d15ae0a462ff0df1~B8BM03plR2368723687eucas1p1T;
        Fri, 15 Jul 2022 07:28:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.2D.09664.71711D26; Fri, 15
        Jul 2022 08:28:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220715072822eucas1p2ccd801c29f10c3cdfcdab0a1b50f076e~B8BMJnGuo0366903669eucas1p2F;
        Fri, 15 Jul 2022 07:28:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220715072822eusmtrp169692d380693f10a3d63fd0582c7e751~B8BMIxkZn1029210292eusmtrp1g;
        Fri, 15 Jul 2022 07:28:22 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-af-62d11717ab42
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.28.09038.61711D26; Fri, 15
        Jul 2022 08:28:22 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220715072821eusmtip1e53e55dc83e1eac4095d1b1f65d73ca5~B8BK8mfMX0827508275eusmtip1E;
        Fri, 15 Jul 2022 07:28:21 +0000 (GMT)
Message-ID: <6cdbc7ec-0cf9-8854-d0e2-36aedda544e2@samsung.com>
Date:   Fri, 15 Jul 2022 09:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/6] iommu/exynos: Add SysMMU v7 register set
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220714165550.8884-6-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87ri4heTDO5eZ7aY0NHKZPHri4XF
        5jnFFp2zN7Bb7H29ld1i0+NrrBaXd81hs5hxfh+Txb/eg4wWBz88YbV43gfknrr7md3i+PvH
        jBYtd0wd+DyeHJzH5LFm3hpGj52z7rJ7LNhU6rFpVSebx51re9g8Ni+p93ixeSajR9+WVYwe
        nzfJBXBFcdmkpOZklqUW6dslcGV8OqdZsFelYv6fXuYGxl8yXYycHBICJhI3v39i72Lk4hAS
        WMEocaFlKzNIQkjgC6PE1LllEInPjBK7P3xgg+lYcGkSC0RiOaPEhAdHGSGcj4wS2092sYNU
        8QrYSfzbcw+sg0VAVaL59V02iLigxMmZT1hAbFGBZIlzZ6+CxYUFXCT+zVoDFmcWEJe49WQ+
        E4gtIpAmcfXffVaQBcwCO5glvs65CVbEJmAo0fW2C6iZg4NTwF7i4V0uiF55ie1v5zCD1EsI
        rOaUeNZ6BOpsF4nVf68xQdjCEq+Ob2GHsGUkTk/uYQGZIyGQL/F3hjFEuELi2us1zBC2tcSd
        c7/AVjELaEqs36UPEXaUWP5lLhNEJ5/EjbeCEBfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4nQcv
        XGKewKg0CylMZiH5fRaSX2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMNWd
        /nf80w7Gua8+6h1iZOJgPMQowcGsJMLbfehckhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwN
        iUIC6YklqdmpqQWpRTBZJg5OqQYmEZlnq5aKZm5hZ3K/JM3AVHi+RC/v7Zvwg/sqJyaln7fr
        7S2v/cY5b2bW2Q0MV713FFjJX5+6ePfxAOuvF6fbPe6LWDfFL/PUcrWsONeWqezbd6epr3rx
        vs1KWCpVJmu/031Rzsi9qifvHuJ0eT6/8MbKXR6z9t2KNXTrTt5Tod2WcuGK/Af5PXPZz/Fx
        y95ymrNzTcWezkkXC1bb/tV9HXdENXlt1EORHZxC9mr7n9naCdnPfDHj0NsXs3w559dcTkw4
        a6m4MqpJ/JWPQMrHX5mPu4uXLLeaeWT9tQ2Z39lmbwmSvz8tKOtj8n27jOrePzPnyU66Pdni
        HvevE1bb3pl2F0080++/RYNF6fc5YyWW4oxEQy3mouJEADrumEHkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7pi4heTDC7v5LeY0NHKZPHri4XF
        5jnFFp2zN7Bb7H29ld1i0+NrrBaXd81hs5hxfh+Txb/eg4wWBz88YbV43gfknrr7md3i+PvH
        jBYtd0wd+DyeHJzH5LFm3hpGj52z7rJ7LNhU6rFpVSebx51re9g8Ni+p93ixeSajR9+WVYwe
        nzfJBXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GV8OqdZsFelYv6fXuYGxl8yXYycHBICJhILLk1i6WLk4hASWMoocX7GP3aIhIzEyWkNrBC2
        sMSfa11sILaQwHtGibUruEFsXgE7iX977oHFWQRUJZpf32WDiAtKnJz5hAXEFhVIlmjecogJ
        xBYWcJH4N2sNWJxZQFzi1pP5YHERgTSJfZNeM4IcwSywi1mip+0V1EXHGSXWX3kIVsUmYCjR
        9RbkCg4OTgF7iYd3uSAGmUl0be1ihLDlJba/ncM8gVFoFpI7ZiHZNwtJyywkLQsYWVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIERvi2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzdh84lCfGm
        JFZWpRblxxeV5qQWH2I0BQbGRGYp0eR8YIrJK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8s
        Sc1OTS1ILYLpY+LglGpgEnMzKf2cpyR9hYlr4ZF1iRvXup63+ct+zzBKOlzOPVrd5bjH7fSQ
        9i8/2VbrxXwWPH9vWVg+96Tnyt18O5RDz9Sc5bx1TLJwX8i0K8cEbp5sWbphQeEm7vWFz6f8
        Xf/BTHqP0kTmHFcN77alfB5KLYy94ZMNmqbf3d1sMf3yLO5Ctqqwn4d+GYjVWAauMT4R/Yr3
        tP738tRL3f+2TN8fHrifacb25tOT1mhHuMjUZHpa7tu0RGz77+lly5yrz74zLzlhMeNat/U1
        35ftB7T4v6wxPePiq8KV8snt69tDN00X1s8QNRG99ytsIk+rV9qEp05vNf9s+D6p3U732l4r
        9yV/dolV7OCMUtT1eBSkrsRSnJFoqMVcVJwIABuMs/B5AwAA
X-CMS-MailID: 20220715072822eucas1p2ccd801c29f10c3cdfcdab0a1b50f076e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220714165604eucas1p28f7d938581361401c97135e2725f8c7e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220714165604eucas1p28f7d938581361401c97135e2725f8c7e
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
        <CGME20220714165604eucas1p28f7d938581361401c97135e2725f8c7e@eucas1p2.samsung.com>
        <20220714165550.8884-6-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 14.07.2022 18:55, Sam Protsenko wrote:
> SysMMU v7 might have different register layouts (VM capable or non-VM
> capable). Virtual Machine registers (if present) implement multiple
> translation domains. If VM registers are not present, the driver
> shouldn't try to access those.
>
> Check which layout is implemented in current SysMMU module (by reading
> the capability registers) and prepare the corresponding variant
> structure for further usage.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Looks fine.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

What about the fault related code in the exynos_sysmmu_irq()? Afair v7 
has a bit different layout of the status bits.

> ---
> Changes in v3:
>    - Merged "Check if SysMMU v7 has VM registers" patch into this patch
>    - Reworked for using variant struct (instead of array)
>
> Changes in v2:
>    - (none) This patch is new and added in v2
>
>   drivers/iommu/exynos-iommu.c | 50 +++++++++++++++++++++++++++++++++---
>   1 file changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 6a0299fe1722..fc9ef3ff0057 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
>   #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
>   
> +#define CAPA0_CAPA1_EXIST		BIT(11)
> +#define CAPA1_VCR_ENABLED		BIT(14)
> +
>   /* common registers */
>   #define REG_MMU_CTRL		0x000
>   #define REG_MMU_CFG		0x004
> @@ -157,6 +160,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   #define REG_V5_FAULT_AR_VA	0x070
>   #define REG_V5_FAULT_AW_VA	0x080
>   
> +/* v7.x registers */
> +#define REG_V7_CAPA0		0x870
> +#define REG_V7_CAPA1		0x874
> +
>   #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>   
>   static struct device *dma_dev;
> @@ -276,6 +283,9 @@ struct sysmmu_drvdata {
>   
>   	struct iommu_device iommu;	/* IOMMU core handle */
>   	const struct sysmmu_variant *variant; /* version specific data */
> +
> +	/* v7 fields */
> +	bool has_vcr;			/* virtual machine control register */
>   };
>   
>   #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
> @@ -289,7 +299,7 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
>   	.int_clear	= 0x1c,
>   };
>   
> -/* SysMMU v5 */
> +/* SysMMU v5 and v7 (non-VM capable) */
>   static const struct sysmmu_variant sysmmu_v5_variant = {
>   	.pt_base	= 0x0c,
>   	.flush_all	= 0x10,
> @@ -301,6 +311,18 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
>   	.int_clear	= 0x64,
>   };
>   
> +/* SysMMU v7: VM capable register set */
> +static const struct sysmmu_variant sysmmu_v7_vm_variant = {
> +	.pt_base	= 0x800c,
> +	.flush_all	= 0x8010,
> +	.flush_entry	= 0x8014,
> +	.flush_range	= 0x8018,
> +	.flush_start	= 0x8020,
> +	.flush_end	= 0x8024,
> +	.int_status	= 0x60,
> +	.int_clear	= 0x64,
> +};
> +
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
>   {
>   	return container_of(dom, struct exynos_iommu_domain, domain);
> @@ -380,6 +402,20 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
>   	clk_disable_unprepare(data->clk_master);
>   }
>   
> +static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
> +{
> +	u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
> +
> +	return capa0 & CAPA0_CAPA1_EXIST;
> +}
> +
> +static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
> +{
> +	u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
> +
> +	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
> +}
> +
>   static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>   {
>   	u32 ver;
> @@ -397,10 +433,18 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>   	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
>   		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
>   
> -	if (MMU_MAJ_VER(data->version) < 5)
> +	if (MMU_MAJ_VER(data->version) < 5) {
>   		data->variant = &sysmmu_v1_variant;
> -	else
> +	} else if (MMU_MAJ_VER(data->version) < 7) {
>   		data->variant = &sysmmu_v5_variant;
> +	} else {
> +		if (__sysmmu_has_capa1(data))
> +			__sysmmu_get_vcr(data);
> +		if (data->has_vcr)
> +			data->variant = &sysmmu_v7_vm_variant;
> +		else
> +			data->variant = &sysmmu_v5_variant;
> +	}
>   
>   	__sysmmu_disable_clocks(data);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

