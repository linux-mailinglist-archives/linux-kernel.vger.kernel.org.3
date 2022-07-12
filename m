Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A51571FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiGLPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGLPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:53:58 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5DFD31
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:53:46 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220712155344euoutp020b04f4b4072f02763dd8978925f705be~BH_lLcRDm1169411694euoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220712155344euoutp020b04f4b4072f02763dd8978925f705be~BH_lLcRDm1169411694euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657641224;
        bh=vNovVSQmMovh5C/1R25U4TKhhBZ9NJ7y2zolR6OqBy4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fX2POQmdPrYdCV7ZW9J5sNkvi8u8Abn7eud8SViy5gWTxhgJXCkRo8RmirNxYaJCl
         rA514WnCT5zVQ6FAEvbj9/DYqgsDT8Iodk4KwoDn5MpveE3ZHdKutCIZlMZYB3QinX
         7dcUgnDsQh+ki1gdMavWDZ8auyVwvzrft0ARcf7g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220712155343eucas1p1ef4caa69cd9915a214642348b777f74a~BH_khJPn80639006390eucas1p15;
        Tue, 12 Jul 2022 15:53:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.B9.09664.7099DC26; Tue, 12
        Jul 2022 16:53:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712155343eucas1p291ba9a443b820543ce3c443912701b80~BH_jwVlhy2176921769eucas1p2T;
        Tue, 12 Jul 2022 15:53:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220712155343eusmtrp2cc058c63b050760ff33c6e267570ec97~BH_jvh1Nr1436214362eusmtrp2t;
        Tue, 12 Jul 2022 15:53:43 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-1c-62cd99079e4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.CF.09038.6099DC26; Tue, 12
        Jul 2022 16:53:43 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220712155342eusmtip151ca99c84b8d6260f7e774f3cffd2119~BH_i7B6c-1082610826eusmtip19;
        Tue, 12 Jul 2022 15:53:42 +0000 (GMT)
Message-ID: <a545127d-1d9d-79c9-e38a-0e9edd98df36@samsung.com>
Date:   Tue, 12 Jul 2022 17:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 7/7] iommu/exynos: Enable default VM instance on
 SysMMU v7
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
In-Reply-To: <20220710230603.13526-8-semen.protsenko@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87rsM88mGbTsMbWY0NHKZPHri4XF
        5jnFFp2zN7Bb7H29ld1i0+NrrBaXd81hs5hxfh+Txb/eg4wWBz88YbV43gfknrr7md3i+PvH
        jBYtd0wd+DyeHJzH5LFm3hpGj52z7rJ7LNhU6rFpVSebx51re9g8Ni+p93ixeSajR9+WVYwe
        nzfJBXBFcdmkpOZklqUW6dslcGVse/WLreCmRMXE34cZGxiXCXcxcnJICJhIbP2wiLGLkYtD
        SGAFo8TGpc3MEM4XRolPO19CZT4zSix6uJIJpuXanN0sEInljBKXJ62Hcj4ySqz6ATKMk4NX
        wE7i99ebYB0sAqoSLW2fmCHighInZz5hAbFFBZIlzp29ygZiCwsES5w//wisl1lAXOLWk/lg
        vSICaRJX/91nBVnALLCDWeLrnJtgzWwChhJdb7vAmjkFHCReHtzMBtEsL7H97RywJyQEVnNK
        HH/dC3W3i8Tvv/1QtrDEq+Nb2CFsGYn/O0G2cQDZ+RJ/ZxhDhCskrr1ewwxhW0vcOfeLDaSE
        WUBTYv0ufYiwo8Sj16dYIDr5JG68FYS4gE9i0rbpzBBhXomONiGIajWJWcfXwe08eOES8wRG
        pVlIgTILyfOzkPwyC2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIEJ7/S/4592
        MM599VHvECMTB+MhRgkOZiUR3j9nTyUJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCe
        WJKanZpakFoEk2Xi4JRqYIoK+G3Yqff+v32OjYbbTQ1jhtNT9D9c/CYSkDkxa7KSIvNBhqhD
        wWwrZM44F1nvL9FYe0Nb9M5K9WMPN2rpHyq+FczkdOx3d/Silquc5pWXjohvdZ3lMWvPj+kp
        DtWhFpy1L45obJ3fodh6nvnmpL1TC/OkNJV310itbglaPfU+fzbTN47nsyt2VEdU+z6Z3rv8
        WfGG0sVnlp+3UW+vXO/EHFOzg9m9fH28QfFj+Z95QvU7Tuzdqds5f7X5Mh9Njuytfjb98mu7
        2DmDL0ieu8R0Trdj+nVLrRPFty7PYknreLjT9t2+tQ+UjvWZWs1g/fUhjr1T9au+3/WGh9qt
        332Ugot8fsWvZpoWypH3XYmlOCPRUIu5qDgRAKtKLLLnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7rsM88mGXyosJjQ0cpk8euLhcXm
        OcUWnbM3sFvsfb2V3WLT42usFpd3zWGzmHF+H5PFv96DjBYHPzxhtXjeB+SeuvuZ3eL4+8eM
        Fi13TB34PJ4cnMfksWbeGkaPnbPusnss2FTqsWlVJ5vHnWt72Dw2L6n3eLF5JqNH35ZVjB6f
        N8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZWx79Yut4KZExcTfhxkbGJcJdzFyckgImEhcm7ObpYuRi0NIYCmjxN7rN9ghEjISJ6c1sELY
        whJ/rnWxgdhCAu8ZJV5PtgaxeQXsJH5/vckEYrMIqEq0tH1ihogLSpyc+YQFxBYVSJZo3nII
        rEZYIFhi7+1ljCA2s4C4xK0n88HiIgJpEvsmvWYEOYJZYBezRE/bK6iLTjJKtPfOButgEzCU
        6HoLcQWngIPEy4Ob2SAmmUl0be2Cmiovsf3tHOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRJLW0
        ODc9t9hIrzgxt7g0L10vOT93EyMwxrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4f1z9lSSEG9K
        YmVValF+fFFpTmrxIUZTYGhMZJYSTc4HJpm8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS
        1OzU1ILUIpg+Jg5OqQamNZ5tdz4vNdmdV8UxZ27Kn3td6oE7Kptbgn7XbQrumLxqdt4TyTu7
        m4U0Uz47PnxvlOW8cWnbnc1TOh78nvLwg3q0eLCzvWDAhYo1+763KUh+yD0lwheRvNZ0fpn+
        /NPXFC6tiJGfOGNZbN290iM8zN0HvT/eNbHatiOgZ23q2liPyrf3PTp3bp9ULrNvQTfL4Yjf
        h11satp4ovMV7ZMZGoVDnlqmL16p77BpSWTmiaCsbEf/xcueuJwRcijLdL+Z6Cyct049692e
        aeeLt06bae0ew6zjemQnz59iwTmeOdZH7ltMnWzxo+P44uzF0X93O3o1TjcPm8abJR012VJ7
        9ZzEkPdWm2Uy+uX7+7uUWIozEg21mIuKEwHuKA6begMAAA==
X-CMS-MailID: 20220712155343eucas1p291ba9a443b820543ce3c443912701b80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220710230617eucas1p135fabb24acf8b5ce64cd1298582c4f2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220710230617eucas1p135fabb24acf8b5ce64cd1298582c4f2a
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
        <CGME20220710230617eucas1p135fabb24acf8b5ce64cd1298582c4f2a@eucas1p1.samsung.com>
        <20220710230603.13526-8-semen.protsenko@linaro.org>
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
> In order to enable SysMMU v7 with VM register layout, at least the
> default VM instance (n=0) must be enabled, in addition to enabling the
> SysMMU itself. To do so, add corresponding write to MMU_CTRL_VM[0]
> register, before writing to MMU_CTRL register.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changes in v2:
>    - Extracted VM enabling code to the separate function
>    - Used new SysMMU read/write functions to access the registers
>
>   drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 64bf3331064f..2b333e137f57 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -135,6 +135,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>   #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
>   #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
>   
> +#define CTRL_VM_ENABLE			BIT(0)
> +#define CTRL_VM_FAULT_MODE_STALL	BIT(3)
>   #define CAPA0_CAPA1_EXIST		BIT(11)
>   #define CAPA1_VCR_ENABLED		BIT(14)
>   
> @@ -183,6 +185,7 @@ enum {
>   	IDX_FLUSH_END,
>   	IDX_INT_STATUS,
>   	IDX_INT_CLEAR,
> +	IDX_CTRL_VM,
>   	MAX_REG_IDX
>   };
>   
> @@ -196,22 +199,22 @@ static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
>   	/* SysMMU v1..v3 */
>   	{
>   		0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
> -		0x18, 0x1c,
> +		0x18, 0x1c, 0x1,
>   	},
>   	/* SysMMU v5 */
>   	{
>   		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
> -		0x60, 0x64,
> +		0x60, 0x64, 0x1,
>   	},
>   	/* SysMMU v7: Default register set (non-VM) */
>   	{
>   		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
> -		0x60, 0x64,
> +		0x60, 0x64, 0x1,
>   	},
>   	/* SysMMU v7: VM capable register set */
>   	{
>   		0x00, 0x04, 0x08, 0x800c, 0x8010, 0x8014, 0x8018, 0x8020,
> -		0x8024, 0x60, 0x64,
> +		0x8024, 0x60, 0x64, 0x8000,
>   	},
>   };
>   
> @@ -567,6 +570,18 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
>   	sysmmu_write(data, IDX_CFG, cfg);
>   }
>   
> +static void __sysmmu_enable_vid(struct sysmmu_drvdata *data)
> +{
> +	u32 ctrl;
> +
> +	if (MMU_MAJ_VER(data->version) < 7 || !data->has_vcr)
> +		return;
> +
> +	ctrl = sysmmu_read(data, IDX_CTRL_VM);
> +	ctrl |= CTRL_VM_ENABLE | CTRL_VM_FAULT_MODE_STALL;
> +	sysmmu_write(data, IDX_CTRL_VM, ctrl);
> +}
> +
>   static void __sysmmu_enable(struct sysmmu_drvdata *data)
>   {
>   	unsigned long flags;
> @@ -577,6 +592,7 @@ static void __sysmmu_enable(struct sysmmu_drvdata *data)
>   	sysmmu_write(data, IDX_CTRL, CTRL_BLOCK);
>   	__sysmmu_init_config(data);
>   	__sysmmu_set_ptbase(data, data->pgtable);
> +	__sysmmu_enable_vid(data);
>   	sysmmu_write(data, IDX_CTRL, CTRL_ENABLE);
>   	data->active = true;
>   	spin_unlock_irqrestore(&data->lock, flags);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

