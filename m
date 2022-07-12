Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58CE571FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiGLPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:47:51 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1052C54B6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:47:49 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712154748euoutp025fb5ff2680be2effd82320811983cc6a~BH5ZWVO3a0892108921euoutp02r
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:47:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712154748euoutp025fb5ff2680be2effd82320811983cc6a~BH5ZWVO3a0892108921euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657640868;
        bh=Bq0HrvFcirkJtFvhiABh8FTq7qDKt4qBK9IqAz2ogT0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=mBUYVONBxXYN0afIqlXoGS0Hbkh6ru7CL7TpmzO6g417FmHxZAF1dgPOfynwc+QLK
         I57M4LNtM+/gmQm5xTce7R0l8tAQex6+CB0sJWjCQ4CwPHuhVePipVfDmAwRhS/i0x
         +2BJi38YArRwI54Ph2KjR6PL+CEJ6wpjelSJX9X8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712154747eucas1p26e0ad59c051d72e1a7481edc38a7164c~BH5Y5WuWn0111101111eucas1p2T;
        Tue, 12 Jul 2022 15:47:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.09.09664.3A79DC26; Tue, 12
        Jul 2022 16:47:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712154747eucas1p26294c0df195bede588104a4e6e68b26a~BH5YZFnKa2465224652eucas1p2i;
        Tue, 12 Jul 2022 15:47:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712154747eusmtrp2917487d060779814e41abd551a71e265~BH5YYMmq11110011100eusmtrp2D;
        Tue, 12 Jul 2022 15:47:47 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-cf-62cd97a30b3c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.3F.09038.3A79DC26; Tue, 12
        Jul 2022 16:47:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220712154746eusmtip2cad547991ed88c013218b95062d1ef8e~BH5Xl1g2_1886418864eusmtip2h;
        Tue, 12 Jul 2022 15:47:46 +0000 (GMT)
Message-ID: <00191759-df90-c020-92e8-37454edba6e1@samsung.com>
Date:   Tue, 12 Jul 2022 17:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/7] iommu/exynos: Check if SysMMU v7 has VM
 registers
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
In-Reply-To: <20220710230603.13526-6-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87qLp59NMnj2Q99iQkcrk8WvLxYW
        m+cUW3TO3sBusff1VnaLTY+vsVpc3jWHzWLG+X1MFv96DzJaHPzwhNXieR+Qe+ruZ3aL4+8f
        M1q03DF14PN4cnAek8eaeWsYPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uPF5pmMHn1bVjF6
        fN4kF8AVxWWTkpqTWZZapG+XwJWx7MZktoIdYhWdvUeYGxi/C3YxcnJICJhItHb9Zupi5OIQ
        EljBKLH3xzNGkISQwBdGiQMbBSESnxklru8+zgbT8bTjEStEYjmjxMydZ1ggOj4ySvS8sgCx
        eQXsJLqOXGUCsVkEVCUW/5nLBBEXlDg58wlYvahAssS5s1fBhgoL+Et8Oj0PLM4sIC5x68l8
        sHoRgTSJq//ugy1jFtjBLPF1zk2wIjYBQ4mut11AzRwcnAIOEi3LJCB65SW2v53DDFIvIbCa
        U+LI1cvMEFe7SCxYd4MdwhaWeHV8C5QtI/F/J8gyDiA7X+LvDGOIcIXEtddroFqtJe6c+wW2
        illAU2L9Ln2IsKPE6ROb2CA6+SRuvBWEuIBPYtK26cwQYV6JjjYhiGo1iVnH18HtPHjhEvME
        RqVZSGEyC8nvs5D8Mgth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBqe70v+Of
        djDOffVR7xAjEwfjIUYJDmYlEd4/Z08lCfGmJFZWpRblxxeV5qQWH2KU5mBREudNztyQKCSQ
        nliSmp2aWpBaBJNl4uCUamDis6ir5uPJX2wfK1Zxb87Evi9NHFUCholz3KRWXeI4eMXmpxe3
        r9Dcp3KqSUcM8s7VFQd+1nls9yVpWkPXtsOBRvPZdVTUz75Y5JiXzrQt1mH2hSt31v9iW9O6
        rXeLwETlz0Gev+wk8x8sUlIpZlgbOuPmr1j5/LaX5x4+/M1pJmo5Ndwnce+Jw7o18aLn426s
        T709+XKh7fWeJI2Hvh9knX6w2UjphLc90FryX7Qmzfol9+fLs72CbR105T1Wx76XT794bHaa
        w9bT1sL1PleFMlsLVB6HbeI25bOrCza/7b7wclvckoSuXRkOX01Pm++yeJTsLz4vQfeQwgQ2
        3vivggcXRyuo/8yMj97hr8RSnJFoqMVcVJwIALwNZFTkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7qLp59NMrj6m9diQkcrk8WvLxYW
        m+cUW3TO3sBusff1VnaLTY+vsVpc3jWHzWLG+X1MFv96DzJaHPzwhNXieR+Qe+ruZ3aL4+8f
        M1q03DF14PN4cnAek8eaeWsYPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uPF5pmMHn1bVjF6
        fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJex7MZktoIdYhWdvUeYGxi/C3YxcnJICJhIPO14xNrFyMUhJLCUUWLqvI3MEAkZiZPTGlgh
        bGGJP9e62CCK3jNKTLnYyAKS4BWwk+g6cpUJxGYRUJVY/GcuE0RcUOLkzCdgNaICyRLNWw6B
        xYUFfCW27/8CZjMLiEvcejIfzBYRSJPYN+k1I8gCZoFdzBI9ba9YILadZJR4MruHEaSKTcBQ
        oustyBkcHJwCDhItyyQgBplJdG3tYoSw5SW2v53DPIFRaBaSO2Yh2TcLScssJC0LGFlWMYqk
        lhbnpucWG+kVJ+YWl+al6yXn525iBEb5tmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8f86eShLi
        TUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ+cA0k1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCe
        WJKanZpakFoE08fEwSnVwLRnzZIXdgbePw/PeGQpXy9q5rDrltWMW6U5nlvbv5WdsOdm+cl0
        T+DpTIeDXZYbgxi/T6r9+u3j295zbCbhrXMzimdffOtol1R5+ujBR44+6kxfPvREJGmfOMzC
        XD23QDQorbhEfGHSmaWtfN8P+f49aH7e8sLnFX5TjxX/cGmVdrbWCZDtu9ulrNv/6uiRxyIT
        TicWc56o+lKWrOUWVa7yMsHHzC3g//zgtMd9K881ccgsyFi2YuMDpm3qtj+VFY5rsRde3bMn
        TOS6jeFWvwlJFh42kybeanpff1bw2vZpOcYCDyO8pZOkV4rrLWKKm8qrlhi1Oez/ZMO9tfzT
        Wcs3fjum77iFze21qKDpUSWW4oxEQy3mouJEAHLyQgh7AwAA
X-CMS-MailID: 20220712154747eucas1p26294c0df195bede588104a4e6e68b26a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220710230617eucas1p2a9ba640ab97b608c6fe94007641012a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220710230617eucas1p2a9ba640ab97b608c6fe94007641012a4
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
        <CGME20220710230617eucas1p2a9ba640ab97b608c6fe94007641012a4@eucas1p2.samsung.com>
        <20220710230603.13526-6-semen.protsenko@linaro.org>
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


On 11.07.2022 01:06, Sam Protsenko wrote:
> SysMMU v7 can have Virtual Machine registers, which implement multiple
> translation domains. The driver should know if it's true or not, as VM
> registers shouldn't be accessed if not present. Read corresponding
> capabilities register to obtain that info, and store it in driver data.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

I would merge this with the next one. Imho this change doesn't make much 
sense on it's own.

> ---
> Changes in v2:
>    - Removed the 'const' qualifier for local non-pointer variables
>
>   drivers/iommu/exynos-iommu.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 0cb1ce10db51..48681189ccf8 100644
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
>   #define REG_MMU_VERSION		0x034
>   
> @@ -154,6 +157,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   #define REG_V5_FAULT_AR_VA	0x070
>   #define REG_V5_FAULT_AW_VA	0x080
>   
> +/* v7.x registers */
> +#define REG_V7_CAPA0		0x870
> +#define REG_V7_CAPA1		0x874
> +
>   #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>   
>   enum {
> @@ -298,6 +305,9 @@ struct sysmmu_drvdata {
>   
>   	struct iommu_device iommu;	/* IOMMU core handle */
>   	const unsigned int *regs;	/* register set */
> +
> +	/* v7 fields */
> +	bool has_vcr;			/* virtual machine control register */
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -411,11 +421,27 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
>   		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
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
>   static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
>   {
>   	__sysmmu_enable_clocks(data);
>   
>   	__sysmmu_get_version(data);
> +	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
> +		__sysmmu_get_vcr(data);
>   	if (MMU_MAJ_VER(data->version) < 5)
>   		data->regs = sysmmu_regs[REG_SET_V1];
>   	else

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

