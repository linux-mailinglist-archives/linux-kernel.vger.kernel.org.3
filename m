Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86CB46F70E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhLIWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:53:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9077 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhLIWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639090181; x=1670626181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=meD9UwDEvaPB0UppYvKmiGhMIwn82GUCVzJyp0aM/8Q=;
  b=Uu4xbOzcyvMOBiYIyaMUmCshKhtzgFaOVg58c3m13zrcV8a3txZV/DuQ
   dMO+dlx1hY/9i/zYVoLGXL2Te73Sk0CLgViFSES+m0BcslckYasQWRBGa
   HF+tTSeNHhPeiFPAhy59YNrnXmIt4zNBxn5n8SfxmRkWv7RKlGl7RX17B
   Y+l/s2uhcTyZ7eMQXxjndVtRMLqtVq7tjOacFWoPp4Vn8JdbYhzEFnMCL
   zAhhtBM1P023hRa+iTtC46U8SGqmY/+M1t8BIj14dulNIJtve/TD4nraW
   21yYxqHcMTE1EmaYJQr4ZxlkXu6XYyDdL7sMSW9QO2csap389fH/b52s3
   A==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="186865164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:49:41 +0800
IronPort-SDR: C5eJOhXiBlFb3CvhkJhu0qCNjkl/6hVnzz7BeWsrguNMCAo4RasHY4HR//SBB5Lj5oXK4qSd85
 HW7ZKLAWafsC47047fiTuLfqSXC3OvLMZ7FB+E4lpa3a7li2bzaefBxWHdeaCb+Q/ykAvCjAmJ
 KJ40MSHqIevKTy6nLYFlz2lCeCfO9QlVQUeYNGYk5nJDoPspLRXeAdACBFMMcHjBIaPdbQiixj
 CM0ApSRzrgiGB4vpbpe/XUt298ucC4RCzw/U0Do02b5ERNF0fKSG/koVOoG+aIkzsX0872D5uc
 6jJ+LcusvFpWmFCZSWeScvSE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:22:43 -0800
IronPort-SDR: 2V+wyiVeGqndri6uoHJkm4i4uT55tSo/6ZTub25Ch4v22o95ToebIwQDeAtfi2qL4NDgeKkgJt
 GsSLy9NQL5S7jFC1N4QWytlPBfoqzjKnpcOUk69OEHGI6+mnDd8bD2IL7YeY6epk2bmphAr12F
 tH0Nf9C7rzLj9wElkXbhO8ln3joJZlCCk8DnbumOtF0k5yK8lpQUlFT3E9L6eG/FE4ec0rYUtl
 s2P36ZRN6Ix3to8LAQDz3YPjSoUWljnGsXNzULBDcgUd7TKBQbU83cmEMCT/5p5V5p82grNIyo
 WvM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:49:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J98P11QbJz1Rwns
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:49:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639090180; x=1641682181; bh=meD9UwDEvaPB0UppYvKmiGhMIwn82GUCVzJ
        yp0aM/8Q=; b=aHqROgplyQ+4nC+RsXoQZg1A9a9bR9FzFbJeeuwbHY6SZd0Ue97
        Zet7lnW2gxmB2e++S0Ppzp8HOG1/L8MlI+65BoJ9V6Xt/T7useac85R2gxkNWGyV
        OE+vwNE/o7Ksr19oVllzKvxMhDSjOYMlfJVkfZTPP1rb14lFWS4mcUkTE8XNNyrs
        8EhAQowOMZXrfRI6AsYtaoXHUbk+LNRBLdYbd9KQRhVk9+ENqruEM1AeOqjA2jN7
        HwpmXecRB4K4IxNJOjuYSn6YBA/VUsydMmNTGpTBl4F0Jl9NJsItPPiAM4gb3rBS
        ksRxnEe4UYsWufkW/d6MzU38Uuha7HWy4VA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tdtvB6MOTc7x for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 14:49:40 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J98Nz6n9Vz1RtVG;
        Thu,  9 Dec 2021 14:49:39 -0800 (PST)
Message-ID: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:49:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/09 23:59, Andy Shevchenko wrote:
> platform_get_irq() will print a message when it fails.
> No need to repeat this.
> 
> While at it, drop redundant check for 0 as platform_get_irq() spills
> out a big WARN() in such case.

The reason you should be able to remove the "if (!irq)" test is that
platform_get_irq() never returns 0. At least, that is what the function kdoc
says. But looking at platform_get_irq_optional(), which is called by
platform_get_irq(), the out label is:

	WARN(ret == 0, "0 is an invalid IRQ number\n");
	return ret;

So 0 will be returned as-is. That is rather weird. That should be fixed to
return -ENXIO:

	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
		return -ENXIO;
	return ret;

Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/libahci_platform.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 0910441321f7..1af642c84e7b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -579,13 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> -	if (!irq)
> -		return -EINVAL;
>  
>  	hpriv->irq = irq;
>  


-- 
Damien Le Moal
Western Digital Research
