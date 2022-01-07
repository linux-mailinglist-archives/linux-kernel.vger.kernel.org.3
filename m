Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554584873B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbiAGHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:43:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45691 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiAGHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641541400; x=1673077400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YCWrzAAx3Oc2Xdo52FMTecKpm99vVhsUqGRO4lNpTM8=;
  b=P/52kQmp01ugNFtAmmIoh8vjWPWipl4R2/LVaDWf+jEwM9CXYQUQqtoR
   cMJFv7L8SZuw5M8QcK/tc3ZGkuXN7GwDNx6bd9pwir3PZQ4MNXC/US6Ai
   ZRFg0oqF6L88PJWoLJJfBxUqlMn2K1n/jHe5JVzNWCTeHF3XiT7kldvgO
   PuVSDH3bfQKCRixEsIp1999ekOFiL1lnkHBip6pM1If0I2NFwfM0NUw3b
   0DErd4oWGR/nKiRi1lEyfqkghNJnr56wmnzg+FuVRM/FCTigPpWtZ72Ng
   71KhSGkrGa15PCV52X8uAdX2mipwygjD8EPLb8W9ao/TKuQkLdX5fAPyX
   A==;
X-IronPort-AV: E=Sophos;i="5.88,269,1635177600"; 
   d="scan'208";a="293960089"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 15:43:20 +0800
IronPort-SDR: x76pMs3GPbhXP/N2gEsNYHXI8QxCwooAd/tqz9U2lmqQ2i/BQ9iTUh5hCJ8+WDowKZkKhEjNIE
 slf8hZIQ+uCwAzBqCFCj2qEyluLN6taXdc4lLCmUUDnLVcO7NcVMcgZg1XVkn3ba4cW/MkDK8R
 8Aqx1yGczA8FfDwzcO+kUOjl/TVTuhbQDqG77ATMZ1s5ZyV536CML+yEj/uSdjW6ahRWJ0gU5W
 5txcjlbhDc15wjrJgyUwbqYKZjzqHZn0F4kmjfGZ+5PM7C7iks4wTEd+JXmTmpNJiAM/DljrFv
 gJ8EB/8CDXWF7BxbedtlHl7C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:17:09 -0800
IronPort-SDR: fIdn0WQL/qyxRVxCRg1xizafGikQn7MPDjwyh0KujtzTGzjaXnYjaMmqFWkvfrK3/o7UjNZqWm
 wmdYcqanIRgg7Yi1CZ9AxgX56h8bVQO08D5ml2CyT4IR0nUZ/5e83dvtjHruiJSiP7ccVDuJSP
 2P9FkacAQSUFHt5zb9wFMwNNIJBSC0dArP6m/YQ0lCFmCRtcvw5JriEKM/9eKYuaBGqADHks/9
 jD1yjgOLFopdcBLBe2KR2PSpRbOKX9Zf7vYpdEhxPDgqe9MTG6II82TZ6n7Jgq8mjHaVLCpPrG
 yJE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:43:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVZvq62TYz1VttB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:43:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641541399; x=1644133400; bh=YCWrzAAx3Oc2Xdo52FMTecKpm99vVhsUqGR
        O4lNpTM8=; b=L37qQ14CIj4lYcb7NPW9qkuNqB6nugi4+OjNYYcSQtmJ1/4DftD
        kcCLJF6urbyQJopJD2u3W3UrGimDPwkCC4SJ1ixmd/NasfvPVhjVCvwMaFAIIWBh
        GpcP3AR4mhMfDg3anUbhaO/vKPZp0poFKXnsSPWkyKtzOxEb2STheanvZXQfNWXl
        QTQ7x2lN1oWzgOnNhO6I6nj3nlMhFnWGs09kmgzlk2jfenR0oS3dCPQwJ4hXEPPd
        sjA3q/wcB0orchKVJzWgRzS6qQiT4Vwg1OIE/19pa93CUJ9UQKPtV3UNjAcTgb+7
        C++Qqv8AoYmOdQl77IRUoBYKZDQJq78gUdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DGTEiQZSsA1Z for <linux-kernel@vger.kernel.org>;
        Thu,  6 Jan 2022 23:43:19 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVZvp4GMvz1VSkV;
        Thu,  6 Jan 2022 23:43:18 -0800 (PST)
Message-ID: <e592bbde-0e74-4f7c-9ffc-6b04b90d12ad@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 16:43:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107070404.3611861-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220107070404.3611861-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 16:04, Jiasheng Jiang wrote:
> As the possible failure of the devres_alloc(), the devm_ioremap() and
> devm_ioport_map() may return NULL pointer.
> And then, the 'base' and 'alt_base' is used in plat_ide_setup_ports().
> Therefore, it should be better to add the check in order to avoid the
> dereference of the NULL pointer.
> 
> Fixes: 2bfba3c444fe ("ide: remove useless subdirs from drivers/ide/")

This patch only renamed files under drivers/ide. I do not think it is
the patch that introduced the problem you are trying to fix.

> Cc: 5.10

Please read
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html?highlight=linux%20stable

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Add cc.

Adding a CC to the distribution list of the patch does not change the
patch itself, so no need for tagging "v2".

> ---
>  drivers/ide/ide_platform.c | 4 ++++

Again, this file does NOT exist anymore.
The legacy IDE driver was removed from the kernel with version 5.14 by
commit b7fb14d3ac63 ("ide: remove the legacy ide driver"). libata now
implements drivers for legacy PATA/IDE drives. Have you checked first if
your fix is needed there ? If it is, then please send your patch against
the current libata tree. If the fix is needed only in older LTS kernels,
then please make that clear in a cover letter with your patch.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
> index 91639fd6c276..8c6e1af7b6eb 100644
> --- a/drivers/ide/ide_platform.c
> +++ b/drivers/ide/ide_platform.c
> @@ -85,6 +85,10 @@ static int plat_ide_probe(struct platform_device *pdev)
>  		alt_base = devm_ioport_map(&pdev->dev,
>  			res_alt->start, resource_size(res_alt));
>  	}
> +	if (!base || !alt_base) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	memset(&hw, 0, sizeof(hw));
>  	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);


-- 
Damien Le Moal
Western Digital Research
