Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD14D0F78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiCHFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCHFu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:50:59 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378CB90
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646718603; x=1678254603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kehcbcYbbqv4Mc+VIdRnbHIfrlNDGyKgvl//coScXjs=;
  b=Km7V0REy0hjacRNOEV5T/S76+369dNE4AD4Mqfj2ZJJ5qQ0BZ0aPcHph
   iSmgs/0jKpzcFoG5oanP7TIckPj5KWK5AwZRAh4la2ABCjeMHVXTjuncf
   JNmsge/aU4xYqgwPXUjRDNK2yD+KEF8eBGFw71MnXm88gRirJ82iybV6H
   z26REIIxOnf8Ydf9AnOrLC/0K2ZSj5hArt2cWC2fc+n+s1roFUvPYFq0x
   oZh8drSboMTCD7s5XGFTdXL8CrqknqTWtxugtuGOg1d8OWMRiwdDLiIt0
   0WGJjVNhFXaN/39TAjn05f3cAUDDh2F5A3ij18RcdSxSpbjjRd/2u8k9K
   A==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643644800"; 
   d="scan'208";a="306680743"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 13:50:03 +0800
IronPort-SDR: tsvnFvF/FpmL7jfptSTMB9dVj1ITCVFbDKRrowivSZq4vXd+vrerQG3dnDuCjJm05SPqVQ3S+j
 FZaFYb0EkMTuKqL2hY12AXdMs+KJR/Z0hAb9z1BgzqD769b8DNwrUTlftLnuVtzPcD4bdwEixM
 ue/EqxwrDToJo0r85pOp0H73s9U9lN2RDo2EAKzsaaeSBTngs2J0FzCM4WOjGhkzo+KGUd1941
 xCT0Wqyhw7os+6RmXmh6oVyIYjPD1fPDYiAtl18LPmRqnV47knKciEA9eyXLuhd2aLKMBg8Jw/
 iBh/rU7gbMRnGzLC+LJ+b0UL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:22:21 -0800
IronPort-SDR: hToE45ZdNnoVMh6fD6ry+ER5KJm/CjApaYpWp9ADSDONOKFk4RSqS9BlmykLgs9cfww3I7u6YH
 I1RnrlQHDuGwbdxuJfiz0S1Y6bIUD4cdgNaytshItvBZmslzfGhO9dH98wzs61+87sW0M28Lh9
 ofakYR2vZPp/QL78XFTIxGDSCXHQyAjxFN/qT4k0HC84VO9hv5PQQ9eIfamEYvem/RXFVrA0t9
 W6BTYzbqtRp51IyeUpMYN7F7FrhQtxne6Lah+1T4Nsku/BHOXT3a53YLwzw8ip6zUUXJ00uUVA
 MNQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:50:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCPYR03Fdz1Rwrw
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:50:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646718602; x=1649310603; bh=kehcbcYbbqv4Mc+VIdRnbHIfrlNDGyKgvl/
        /coScXjs=; b=rBhI807HrS0lsFT1vp+rI7Ew6Fe9e8b2rcQCQh7DVRcJolyb9Yn
        rOPiln17mq26XRvzn4K9c1vK9sYWARPe8xydxFa1aYK9mueJinmFmsviCnRC7X9x
        18zKR1ohAU5NAea7SpolnwdELy8s+27RqnvQZL4Uf6L7JJ3UtDxza/Ew548ZKjl9
        eG6K0RY33l4WrkGMzXtIAEExXMK/8VfAg/tr4Bdi5CVd5Mq9r3sFmC8vduieeLUS
        2pWIVfyPQHDOY6EW5UUl52g/NOghXoceM7RvCEwXXGu2ndxuUQGdtHSsVWr3jx/n
        6VxWKMfJq1RahITkH6dyIgaZQyXH34KEolw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hQjHU4qPbLLo for <linux-kernel@vger.kernel.org>;
        Mon,  7 Mar 2022 21:50:02 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCPYP1rJwz1Rvlx;
        Mon,  7 Mar 2022 21:50:01 -0800 (PST)
Message-ID: <1a6aa747-1609-467a-ac23-953387dc1a4e@opensource.wdc.com>
Date:   Tue, 8 Mar 2022 14:49:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: Use platform_get_irq() to get the interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 11:59, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..6394ab4cbc1b 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	struct resource *cmd_res;
>  	struct resource *ctl_res;
>  	struct resource *dma_res;
> -	struct resource *irq_res;
>  	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct dma_slave_config	config;
>  	int ret = 0;
> +	int irq;
>  
>  	/*
>  	 * Resource validation, three resources are needed:
> @@ -205,8 +205,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))

This is not the hot path, so let's simplify: drop the unlikely() from
this if.

>  		return -EINVAL;
>  
>  	/*
> @@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * Activate the ATA host
>  	 */
> -	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
> +	ret = ata_host_activate(host, irq, ata_sff_interrupt,
>  				pdata->irq_flags, &pxa_ata_sht);
>  	if (ret)
>  		dma_release_channel(data->dma_chan);


-- 
Damien Le Moal
Western Digital Research
