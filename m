Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0F4708A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbhLJSak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbhLJSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:30:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C142C061746;
        Fri, 10 Dec 2021 10:27:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so10022106pju.3;
        Fri, 10 Dec 2021 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ivr1CtMEzoAswhXgOrAn3TQUCIgfiuUzQn7jPUFw3T8=;
        b=BW+0H+e4QrSwTk1qlN93GbqnnYZhT3nKUQa2BdTcXOHaFNkFivnIbovLfDcAC51Hrp
         ZDaOAIQbd8fPd7sjRlD44uwNxbhqJPOCxSpK4dAVdqkrZMkod0lrOaSv/RenqZDAt8HD
         NzmA8mbeTY9F/TdGKYh7XHGY8Be1CVaWgewNj2KeanFgTUQSHwY7jb+mz3fMaYXWQ2ND
         MWTuxC5UUlie70EfttVaZN64JU0GR/FZTGKxLoTJIg6unL4FlT8VUmOB84/g+VvlDq9E
         ZrPiFAnQCQhCijiX9GnB2Nd2SfFuWw6w/UddTIkGInc2NUrgyRVrR4rP/gKjWNuxLqtA
         pj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ivr1CtMEzoAswhXgOrAn3TQUCIgfiuUzQn7jPUFw3T8=;
        b=LgJ7hr5GbkJiRpNY92ssdFCEqBCwIYy94ydSDb/nvIeE/wp0hv5nfe4XMPP2CHZJYx
         msvsAHPGiJsxIgD+DbyZIJwnCKFQ+4tKkO8+nfU7QmDtfFmrVAkuIN2hBQXeUDvlsmE3
         6zXdYrofhCWx+rdCK7hHSI6mPWYUme1N9Yvx9/yNAMPstQZqK16E3CQzVREFSJzk5idq
         hNE2iQjlLK/iNFQv/bx4JkeJ+y5/SYxeTuBhAf+/fuMYaeuqZmNLoY8Gt3fQ/k2WUleI
         iWyn7UVIElrloU5a8E8NkJdZ0wcGHJgkNmMzRBbdRAwI+2AJF46mElLPanr5kfp3pP45
         KnMA==
X-Gm-Message-State: AOAM531MzpuA5uCZ5RBRqbHBzw3Mb/wPdY+g+JXIyW91Dv/uiWYUoqDe
        dMFFkOSXudVeKsftRoyfeTc7Js50YE8=
X-Google-Smtp-Source: ABdhPJw5GEP3fdO2hw64UN7kqCTtIB83hoxp6xtXwUTG9QBrIVsXNkgDcO0Iwe5bTfH67b4a8hb8EA==
X-Received: by 2002:a17:90a:fe14:: with SMTP id ck20mr25992259pjb.72.1639160823082;
        Fri, 10 Dec 2021 10:27:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mm22sm3470328pjb.28.2021.12.10.10.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:27:02 -0800 (PST)
Subject: Re: [PATCH v1] of: unittest: fix warning on PowerPC frame size
 warning
To:     Jim Quinlan <jim2101024@gmail.com>, Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211210171258.41138-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <31d35f52-2551-05a0-7aa1-7a2e87ab62c9@gmail.com>
Date:   Fri, 10 Dec 2021 10:27:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210171258.41138-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 9:12 AM, Jim Quinlan wrote:
> The struct device variable "dev_bogus" was triggering this warning
> on a PowerPC build:
> 
>     drivers/of/unittest.c: In function 'of_unittest_dma_ranges_one.constprop':
>     [...] >> The frame size of 1424 bytes is larger than 1024 bytes
>              [-Wframe-larger-than=]
> 
> This variable is now dynamically allocated.
> 
> Fixes: e0d072782c734 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/of/unittest.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 481ba8682ebf..945cda299a63 100644
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

You are leaking dev_bogus here.
-- 
Florian
