Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254B57216B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiGLQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiGLQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:52:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05030C54B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:52:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so14923387lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hk91vgCrBTUvEpGSrKbGq5iow1WG9u7J+VYZ+z7HncQ=;
        b=wWFiS3SEigESx+/qdsuHPrOMuSFVDZ8NNlNoUFV4zIU5vZIB9wmYnN2DNO8WV7IBgR
         d2cJMJCkK3rVHRQOVUBJoZAXy1cgu+1AOJ4peL3SUSkpMXxR9QPrEjeP3tTIosq39GhB
         mhvRjKTelDkItHYLhMtBRsIo2vSxpKtyXg5StsUt5V5huMiJuc6iRCy4WdODh7Uw1LCs
         1+nuHx2EfaDrXl4lnsdPLUGwP1hc7SMm6P80yMDgBvpyh+o3l8fOWF7WN7nsvwCRINbe
         uyXQCqe45bL5achZDh8VEeQD/Tz9g42IUJ7KzlYhmaW331JnyiieyLtf+Ed8b5AHX3DC
         jn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hk91vgCrBTUvEpGSrKbGq5iow1WG9u7J+VYZ+z7HncQ=;
        b=38vAisZon5BP9UUuy3kOuJymJVU5c1js9Y4joDaj/UM1vS9ax7i78Fh3TTrGFonD9V
         oJKWtXuETQb6wAdxBnBNQP5TquKNTViVq5jzOI+9FpBcGzYTgVTBT+mxr9Mg1UNdoWxL
         euNmxbwkLgH5KvcLyRr8pfVbI2nkRMvfFNyF+cW6MUmlqiUe/CpQOnt3DPDoC1gfIrnI
         KJ0NcapzwdmBUY9O8rZAHRdjURN7g0+wPQPXXJrvZFekzxmdPYU6pI7qMZyIoPMI7Go9
         sv2FdEBLZyWSTzjTpqVmJU99g09vET0ACI3msJDsRlu6Zjd2VbetouPzBtwRLZyJdJGc
         Qeyw==
X-Gm-Message-State: AJIora8XkpxnjT7TSSem+mDwkvg83FCR9gEhPTGYRhPww4HHng2SQT7o
        B/6qGIf240pvZkTXKADLPkLQeg==
X-Google-Smtp-Source: AGRyM1v/dKeiG9uF3Q11EN7iwNXDDikvgf15Kljcs4hTXl5qB2EU9cPzZbfR68r8CVYNNFKBW5+TYQ==
X-Received: by 2002:ac2:4e03:0:b0:485:74c4:97ce with SMTP id e3-20020ac24e03000000b0048574c497cemr15368417lfr.13.1657644775361;
        Tue, 12 Jul 2022 09:52:55 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b15-20020a19644f000000b00488fd910e22sm2280059lfj.140.2022.07.12.09.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:52:54 -0700 (PDT)
Message-ID: <4d198463-fedc-a5d9-6804-63c134da76e7@linaro.org>
Date:   Tue, 12 Jul 2022 18:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access
 registers
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 01:06, Sam Protsenko wrote:
> At the moment the driver supports SysMMU v1..v5 versions. SysMMU v5 has
> different register layout than SysMMU v1..v3. Instead of checking the
> version each time before reading/writing the registers, let's create
> corresponding register table for each SysMMU version and set the needed
> table on init, checking the SysMMU version one single time. This way is
> faster and more elegant.
> 
> No functional change here, just a refactoring patch.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Reworked existing code (SysMMU v1..v5) to use this approach
>   - Extracted v7 registers to the separate patches
>   - Replaced MMU_REG() with corresponding SysMMU read/write functions
>   - Improved the comment for 0x1 offsets triggering an unaligned access
>     exception
>   - Removed support for VMID number, as only VMID=0 (default) is used
>     for now
>   - Renamed register index names to reflect the old SysMMU version
>     register names
> 
>  drivers/iommu/exynos-iommu.c | 141 ++++++++++++++++++++++-------------
>  1 file changed, 90 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 494f7d7aa9c5..0cb1ce10db51 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -136,9 +136,6 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>  #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
>  
>  /* common registers */
> -#define REG_MMU_CTRL		0x000
> -#define REG_MMU_CFG		0x004
> -#define REG_MMU_STATUS		0x008
>  #define REG_MMU_VERSION		0x034
>  
>  #define MMU_MAJ_VER(val)	((val) >> 7)
> @@ -148,31 +145,57 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
>  #define MAKE_MMU_VER(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0x7F))
>  
>  /* v1.x - v3.x registers */
> -#define REG_MMU_FLUSH		0x00C
> -#define REG_MMU_FLUSH_ENTRY	0x010
> -#define REG_PT_BASE_ADDR	0x014
> -#define REG_INT_STATUS		0x018
> -#define REG_INT_CLEAR		0x01C
> -
>  #define REG_PAGE_FAULT_ADDR	0x024
>  #define REG_AW_FAULT_ADDR	0x028
>  #define REG_AR_FAULT_ADDR	0x02C
>  #define REG_DEFAULT_SLAVE_ADDR	0x030
>  
>  /* v5.x registers */
> -#define REG_V5_PT_BASE_PFN	0x00C
> -#define REG_V5_MMU_FLUSH_ALL	0x010
> -#define REG_V5_MMU_FLUSH_ENTRY	0x014
> -#define REG_V5_MMU_FLUSH_RANGE	0x018
> -#define REG_V5_MMU_FLUSH_START	0x020
> -#define REG_V5_MMU_FLUSH_END	0x024
> -#define REG_V5_INT_STATUS	0x060
> -#define REG_V5_INT_CLEAR	0x064
>  #define REG_V5_FAULT_AR_VA	0x070
>  #define REG_V5_FAULT_AW_VA	0x080
>  
>  #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
>  
> +enum {
> +	REG_SET_V1,
> +	REG_SET_V5,
> +	MAX_REG_SET
> +};
> +
> +enum {
> +	IDX_CTRL,
> +	IDX_CFG,
> +	IDX_STATUS,
> +	IDX_PT_BASE,
> +	IDX_FLUSH_ALL,
> +	IDX_FLUSH_ENTRY,
> +	IDX_FLUSH_RANGE,
> +	IDX_FLUSH_START,
> +	IDX_FLUSH_END,
> +	IDX_INT_STATUS,
> +	IDX_INT_CLEAR,
> +	MAX_REG_IDX
> +};
> +
> +/*
> + * Some SysMMU versions might not implement some registers from this set, thus
> + * those registers shouldn't be accessed. Set the offsets for those registers to
> + * 0x1 to trigger an unaligned access exception, which can help one to debug
> + * related issues.
> + */
> +static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
> +	/* SysMMU v1..v3 */
> +	{
> +		0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
> +		0x18, 0x1c,
> +	},
> +	/* SysMMU v5 */
> +	{
> +		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
> +		0x60, 0x64,
> +	},
> +};
> +
>  static struct device *dma_dev;
>  static struct kmem_cache *lv2table_kmem_cache;
>  static sysmmu_pte_t *zero_lv2_table;
> @@ -274,6 +297,7 @@ struct sysmmu_drvdata {
>  	unsigned int version;		/* our version */
>  
>  	struct iommu_device iommu;	/* IOMMU core handle */
> +	const unsigned int *regs;	/* register set */
>  };
>  
>  static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -281,20 +305,30 @@ static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct exynos_iommu_domain, domain);
>  }
>  
> +static void sysmmu_write(struct sysmmu_drvdata *data, size_t idx, u32 val)
> +{
> +	writel(val, data->sfrbase + data->regs[idx]);

Beside what Robin wrote, I also don't think these wrappers actually
help, because you reverse arguments comparing to writel.

How about having a per-variant structure with offsets and using it like:

#define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
writel(CTRL_ENABLE, SYSMMU_REG(data, mmu_ctrl_reg))

Would that be more readable?


Best regards,
Krzysztof
