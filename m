Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A984872C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbiAGFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:31:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44763 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346233AbiAGFbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641533498; x=1673069498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SYi02gry4KY913GWD4js08rQ2431DuZd5vGWNXamk/8=;
  b=rHbbMne92WSbctGchNTeT1mN2rZqtDgYbT5B/85pgWeX1q2rCQKU2enT
   kX5r3e/WuOIXt2M/bQjMOW9+DAj+oRn1U4sm6MuLCDHTmi02XNxSSMkPf
   HxelDhJrvbRDWIm2cQiFShRv0TiOGNx2Gp4vKB0N9htv1YNSmmQCoDwQ+
   6Kd1Df75Vm1lBvq3mfTO1sIsl739KM5ME5xC9sdhXHUpfb11x90zB+Zor
   8tdxlzEgiOWJNZHFqHE4pRPnuAkG1qeQ0uyLXJEuupc4POCR6sLX48Fsk
   Brl5M0Yr/edrQwPp/yc/woE+QbC4Syl4dhC9Qm5KhsKv2DPfe2Lq2J8aG
   w==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="293952302"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 13:30:38 +0800
IronPort-SDR: 7xGKKR8Ff3mrezAyJLtNsZCI/5IxlkksHDPUs57O9M+3q/dEKNnD09YkaxtgFh0Q9wtVfiifna
 SKdSdC3yX8cp3fC7MUFWHXrlsH7FOeKzHijdvJY2yLEpC2qobpmOF37HuxndtwoaQDOLjzYCwW
 f5zutsC2VqdNLNB1pUAgRJ5hvMRN6Kpt8zIUrr+fxIhz20DbguBkel5Rmm1F60xnXcQh7Bovtq
 fGzUbmRjCM9Qb4PKxLCZo9HOxv7FwNt9DhgJkC3NLYjf/yI4RJs50KQvZ8xOfKoJ+Y4E74wsbs
 33Ej8QaV6x5x9sHLIadoZFy5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:04:27 -0800
IronPort-SDR: IyZx+dYR7jpEUUEXyHlrmMKGHF8ybDUl/njVMLO7ArQsBf7nZ22U69T4wSMb6u6o/msjfj14p/
 +cvgeRiQDIUN3/0hBo1P+IUFOY87IbHPLUkP05UGfm/2wYzfJZxAe+bPqzfPcmCmp+/4pG3zKb
 00GY2xoG2qNQ7S5eYyHxXxkbe/RgSYxzFrIbXR8lcJV4FSCWqSlNsQZlWysyN4IMHm8elnOGJo
 40J5yzP58ckXBUy+jAv4FkWB+oSZcbd8QIphzqR7NB/5LrYJyFcHx5hMPQxFv8dWMd4t94sP8I
 N+A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:30:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVWyj5YbLz1VSkY
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 21:30:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641533437; x=1644125438; bh=SYi02gry4KY913GWD4js08rQ2431DuZd5vG
        WNXamk/8=; b=gnrN4km1uEhgyeNbHHF3p0efRl7iTX+ztV1BPAOVmcHSMkxMIoR
        VFBcR318Pp7Q3KbOLrJUz9GDTPI2PCRRVpMYPTQxxf5Kck5DXn3Q5v94HirIsmz0
        zd6O/tpb6UEZR2HOq0Cw/TOIPJFLMcueYJvIM/4iiue6buhtAnXSPd9aE63fE4VK
        QI6ODluJ6OySphNT+zYUf2V3AgTbUEPpBI4Od/UE7Lq9WxdIW043FvS6fgDuoPz6
        x7wvX1n3oMKdARUKZjaiWww+zDkAorlk8bfIYD2BI0VXqWzKbGm2Ytt18FS7GRjo
        +TiWr3LttUpW+tM1ejc5rUBP830yHx+vI6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ED1p4f1T6_9g for <linux-kernel@vger.kernel.org>;
        Thu,  6 Jan 2022 21:30:37 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVWyh5855z1VSkV;
        Thu,  6 Jan 2022 21:30:36 -0800 (PST)
Message-ID: <087ac312-1d73-4721-f17f-af48b6ea65a2@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 14:30:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107031733.3588290-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107031733.3588290-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/07 12:17, Jiasheng Jiang wrote:
> As the possible failure of the devres_alloc(), the devm_ioremap() and
> devm_ioport_map() may return NULL pointer.
> And then, the 'base' and 'alt_base' is used in plat_ide_setup_ports().
> Therefore, it should be better to add the check in order to avoid the
> dereference of the NULL pointer.
> 
> Fixes: 2bfba3c444fe ("ide: remove useless subdirs from drivers/ide/")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/ide/ide_platform.c | 4 ++++

There is no such file... What kernel is this patch against ?

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
