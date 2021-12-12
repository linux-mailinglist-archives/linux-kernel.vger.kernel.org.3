Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63585471E4F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhLLWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLWr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:47:26 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9DC06173F;
        Sun, 12 Dec 2021 14:47:26 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u16so12996726qvk.4;
        Sun, 12 Dec 2021 14:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ix+G0zc+g6/N6041+1Hk6LHt/Y4Z+qpp/k2nnjfJ76s=;
        b=MpLM3+0TPWqdJ+7DzYXtgH/6RhHatrTyBWY6ICHaz9hQl4lExVUmsYY/G1zRoMz+Lp
         E9TVClJlGi2yDDaKDBeL7HwrFj63stulPxpfeyJj3Ks1Az9f34PgGj9fZUGnaBxDKfor
         N9F7IKATjEdFWllTPbqJ9hWb/JqSd3Ckb2bItL2pG1PsIMIIMH+eCtEUB810cwVWWswL
         BN9c4dzXx6TYNet9IM5t3up8nSR6DNiMIYreCjdJNvaQGkhiGmAICaxtBUbCLuhBQGfT
         TNdv9hfTVkAp/01h4xDg3alvxwCYoIDPUH/I9cl5QKyNgqbj8edwYNfFaklZOHrsMgkm
         3zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ix+G0zc+g6/N6041+1Hk6LHt/Y4Z+qpp/k2nnjfJ76s=;
        b=3BwSufZU6bWzAHHVvCW+VWYgJQtDbtU7sRDV08B67i2ypuN04by29PrzMb9a4nKxSo
         TKfp/AcnoVvkFDjQjBvNAbuibkn5IQjW0B0hKayjQy1TSRs+PcmEYbfchfYcPGZVif4I
         sI36EoCOVa4qoye3t/0g3608f8nQy6wQ3rC+LCmXvE8SXGtOXFCbigAzY7k0woPzDpYV
         K4SZWgbkVk2qRL6XlSb8IiWFPIkbQmqawAom2RlZ3TCJxkNFuUMVUVcpxF5ek2BN5FSM
         X0Nu2pVsQNVFvTX80CG9rupd3fsebeDC2mseonucAyeymDM55YONeiYtBSlhABYgAFnW
         1h3A==
X-Gm-Message-State: AOAM530s7tLfyfTZUXC45g7w6+QXeu0wn6fIj2q7C6IFf5m3/IcRHJbm
        j6PDij+hkFVKSghmuLnlQF4k2CcuU2o=
X-Google-Smtp-Source: ABdhPJx1M7WZxHZQTNZ/wYESqgILvAMdnpUS8cPtoHkLGib28aH89EBWD6xno9Y5OaASIppO0DuXbw==
X-Received: by 2002:ad4:4b26:: with SMTP id s6mr39537389qvw.92.1639349245306;
        Sun, 12 Dec 2021 14:47:25 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id s20sm8343124qtc.75.2021.12.12.14.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 14:47:25 -0800 (PST)
Subject: Re: [PATCH v2 1/1] of: unittest: fix warning on PowerPC frame size
 warning
To:     Jim Quinlan <jim2101024@gmail.com>, Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211210184636.7273-1-jim2101024@gmail.com>
 <20211210184636.7273-2-jim2101024@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <598c9bcd-a956-07f1-17a2-5177a8bd5458@gmail.com>
Date:   Sun, 12 Dec 2021 16:47:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210184636.7273-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

moved the file's maintainers from the "cc:" list to the "to:" list

review comments below


On 12/10/21 1:46 PM, Jim Quinlan wrote:
> The struct device variable "dev_bogus" was triggering this warning
> on a PowerPC build:
> 
>     drivers/of/unittest.c: In function 'of_unittest_dma_ranges_one.constprop':
>     [...] >> The frame size of 1424 bytes is larger than 1024 bytes
>              [-Wframe-larger-than=]
> 
> This variable is now dynamically allocated.

A side effect of the change is that dev_bogus is initialized to all
zeros instead of containing random data from the stack.

> 
> Fixes: e0d072782c734 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/of/unittest.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 481ba8682ebf..02c5cd06ad19 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -911,11 +911,18 @@ static void __init of_unittest_dma_ranges_one(const char *path,
>  	if (!rc) {
>  		phys_addr_t	paddr;
>  		dma_addr_t	dma_addr;
> -		struct device	dev_bogus;
> +		struct device	*dev_bogus;
>  
> -		dev_bogus.dma_range_map = map;
> -		paddr = dma_to_phys(&dev_bogus, expect_dma_addr);
> -		dma_addr = phys_to_dma(&dev_bogus, expect_paddr);
> +		dev_bogus = kzalloc(sizeof(struct device), GFP_KERNEL);
> +		if (!dev_bogus) {
> +			unittest(0, "kzalloc() failed\n");
> +			kfree(map);
> +			return;
> +		}
> +
> +		dev_bogus->dma_range_map = map;
> +		paddr = dma_to_phys(dev_bogus, expect_dma_addr);
> +		dma_addr = phys_to_dma(dev_bogus, expect_paddr);
>  
>  		unittest(paddr == expect_paddr,
>  			 "of_dma_get_range: wrong phys addr %pap (expecting %llx) on node %pOF\n",
> @@ -925,6 +932,7 @@ static void __init of_unittest_dma_ranges_one(const char *path,
>  			 &dma_addr, expect_dma_addr, np);
>  
>  		kfree(map);
> +		kfree(dev_bogus);
>  	}
>  	of_node_put(np);
>  #endif
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
