Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9048A337
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiAJWxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:53:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38996 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiAJWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641855191; x=1673391191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCt7YeJ6ihHy34FQA1brq9w4AvGaHog9ruTyBQgPR64=;
  b=PLa5C8xVXKYtBgUlqJCCvNFWJaR1dFjsqgUevrnQ9gWCje7aurfDSBvB
   QBYcJ+olkXZqWce759xooM/t+pP+ua38UQbkb3bzzatIXL3pBB872t1HH
   MHBhmpSPIqT7moMp2eMB4QxqkhfqQOu0SCBj8qaGcRvqHRWaOtJs7RQ0U
   hc4ScTBIhsd48XPTdF4FKKfdW9I9/ZKkO5CHtLX/8bD/jbANlztt2IzHz
   RgtF80bAaGMKcgvqPZ1Dj9CWVx6grA+4BTIEMqYzlupQNAWB2F3V6t7uP
   r6CWlYnK61qiDncjRNE6Qs3agRc5WILBmTWViOhtRLxBjXHmZLoTndPI+
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="191147637"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2022 06:53:11 +0800
IronPort-SDR: BO/KgfzkseCrtzJ/wSgT3s0XF37sQyF48k9+bkzQ+jxgOuDvWLV1BU9zT1MfLRvQrIssbqIAXG
 z/oWxdBlliC4LYo/JSrl4ybBMgQ1twwMkx6YoLq/gIBKISeq0uLGxKy6FbD58v0S4jQwka/Bf+
 hFBKHL33s5Bjoa0FUjCiZPf0wxjANBE5Wha5Q0AKc1NlZLOHMEYd75o9yR4UaMHVHqZjCCLks+
 ecJzYlhfAMqV+2K/t+s87gwSNPlGwuVNDlgN+/nbz8TvvytmBzSD6oia42duFDwaevpee+vsVd
 t/yW6W6T59EK89UyBD2eXeC5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:25:34 -0800
IronPort-SDR: 7iFWoSvROlcJ//ZE3t58Ja5GXyqSUtfmkFPkLciSyMJWAmuL5ORpWr9cK29OfQfWsJrzZj8bjz
 i9H8Bg87Tum8KG0cTetQfjBUWUBvrNlvuYS2pdw9l6+ErDdOJy1b99Z1aHPwU1Mh5jXkjKYvFt
 JBMV74ny2SGqDW3kk2Sr9AajmSpPaoAlvb1wPJYAWwucheT3XcvsZV0Emi/4z31ud+XLixkJBl
 q54Fwfq5HcjndVOO6KNwZqKVeIr3xPtVsxDEKgeVPznMmBMK0Zma77NQaaZ9ygyvwbHpCU599V
 UtI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:53:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JXpyG2khXz1VSkW
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:53:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641855189; x=1644447190; bh=vCt7YeJ6ihHy34FQA1brq9w4AvGaHog9ruT
        yBQgPR64=; b=d5V/kww1vens9ElvcIjIOEDSaYJUlgc3bShj9AYaoTIyJ20TF96
        WOJqgP0+bzPDGv/k/5aEmLrZISU7eqPeam03JTJPWIbo5yiqRZB9Yw3/opAO9jxW
        6nsOaIBArX2XOTZ3aa9uqYhlae9zSpVA4Mt6OzMMxMA9rRKXyULl9aKYKftFMeOS
        T/L+Q228ELUwEY0Lzrj9LJd/UctAy4L/cDXSMmxe8E4Kjspy4E4KFlnygyTURTgP
        aucM/nBJvSunncZ2n4YH8TgONtqDOFZGLpWHcMn9Q1HCh81Kbo2VTT8aZuFbgYs6
        zyA+MgrcwCXQAPG9ELlL3mh46Qj6EHtI41g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mwG10VMtLROy for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jan 2022 14:53:09 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JXpyD4dSdz1VSkV;
        Mon, 10 Jan 2022 14:53:08 -0800 (PST)
Message-ID: <c9c63445-3ecc-4a0e-3e70-3b5942e0d5d5@opensource.wdc.com>
Date:   Tue, 11 Jan 2022 07:53:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v5] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/06 3:17, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Note the code does not set the IRQ flags as this is handled automatically
> for DT.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> This patch is part of series [1]. I'll re-visit merging of pata_of_platform
> into pata_platform at later point. As my primary focus is removal of static
> setup of IRQ resource from DT core code.
> 
> [1] https://patchwork.ozlabs.org/project/linux-ide/list/?series=278349
> 
> v4->v5
> * Set end member of IRQ resource
> * Clear irq_res un-conditionally.
> 
> Cheers,
> Prabhakar
> ---
>  drivers/ata/pata_of_platform.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..c3a40b717dcd 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -25,11 +25,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	struct device_node *dn = ofdev->dev.of_node;
>  	struct resource io_res;
>  	struct resource ctl_res;
> -	struct resource *irq_res;
> +	struct resource irq_res;
>  	unsigned int reg_shift = 0;
>  	int pio_mode = 0;
>  	int pio_mask;
>  	bool use16bit;
> +	int irq;
>  
>  	ret = of_address_to_resource(dn, 0, &io_res);
>  	if (ret) {
> @@ -45,7 +46,15 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  		return -EINVAL;
>  	}
>  
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	memset(&irq_res, 0, sizeof(irq_res));
> +
> +	irq = platform_get_irq_optional(ofdev, 0);
> +	if (irq < 0 && irq != -ENXIO)
> +		return irq;
> +	if (irq > 0) {
> +		irq_res.start = irq;
> +		irq_res.end = irq;
> +	}
>  
>  	of_property_read_u32(dn, "reg-shift", &reg_shift);
>  
> @@ -63,7 +72,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	pio_mask = 1 << pio_mode;
>  	pio_mask |= (1 << pio_mode) - 1;
>  
> -	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
> +	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq > 0 ? &irq_res : NULL,
>  				     reg_shift, pio_mask, &pata_platform_sht,
>  				     use16bit);
>  }

Andy,

Are you OK with this version ?

-- 
Damien Le Moal
Western Digital Research
