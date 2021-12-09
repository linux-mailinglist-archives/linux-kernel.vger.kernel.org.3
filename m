Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B746F71D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhLIXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:01:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5660 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhLIXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639090672; x=1670626672;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=pRWOIhRZ7/jth57l2EGVis1/ca2m/O9kfl+rQemxeto=;
  b=Fj6d+QbI2D7SbIs//2aQ1eJa8O3IeBRBkBnfK/aMyz036MHcGJTUJ5pt
   V7vdU5FbURd50fhGqLM65NFPPaBPVZirZ7T8uE0oRw2FHsqSm9fmNxHkz
   e3f00VIGNbylqLr7uh+kz6MwrbcyO5iM4fwwdKF/GD2GukLpYn7yA0+wj
   Zf21yCicHMRz8YHPzcKApA0g1yiEhc/B5FuQZTJrKvi8lRppBoJs10vd7
   xJAjmhyz8hshrak+YnSIR6FrpZvlV100IiNgTd1pD7bL8NPnWupLGpqV0
   KYBM+ki52REVMhwdCxkm+AtG67nmb6it7dILVx80sikewO1LcoNo8/bB7
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="186865432"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:57:51 +0800
IronPort-SDR: 6iiSNtkcZpnkH7LCXzMCcfvCqP7iUDZP/WghVKy/iw/wjv41yuSFYNcuRIF9CslkTjxiShI9vv
 bPpdyUF+l6sCVTk6PiGOuodE+1vwdn+LLYXS7lA3LIlFeBM1buUVPzNCBf1C8CYWoi7/Yt0Xdt
 iWTqAGa/fL+GVA/1O3N400PTCGubcpY3w5IknUhbHYeh2P+Fl0upNs3/00Xh3hLafosWEbOPnC
 NRrIjeLu7al2HEHW/j1d2sX8LP08JWEHs8j2V1Sjah10B4ZJf9QgTRtbaOCSHktGn87wu5xkZD
 kb/Vn6hYH2uP8uSiyTbiAjBY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:30:53 -0800
IronPort-SDR: +2EZjYcJD8Rpi7Hzt+ryR6Zrp7rMKMr5V6S/bpMMXT/TvTSXZwchnpzu6B4bheVNNgHv021EFu
 CywJUzOaYOUMH+8j0pa5lqM1tt8KzygD2iAyyaYH/rE8ufSBTZ4kmAs69ajEq5S54mH4gyqxr1
 KiZIvYX1QwynkuBwHCL6ua+yll1Ud1u85Io6mtp0AjXRb8fBzwKk/cJhJqDuZwVeiYNt28Dq+Y
 2+r0ZIhOB7s7vu9S7O2jOcKPqT+M8efH6enH01olPLqNy+jYxW+/YtBIjd5XdsGE6SVoyV93oc
 fSM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:57:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J98ZR4WH5z1Rwnv
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:57:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639090671; x=1641682672; bh=pRWOIhRZ7/jth57l2EGVis1/ca2m/O9kfl+
        rQemxeto=; b=PcPnA2bmKfH52uxLnbvFdhq7CCy63cHtLkL2Y17GfFukik95q8s
        UxKnihjc8iTAQCA/MumcATRJUxwidbeMQP/SMTsTg29CqGfuusFo0052l+tJ/KQr
        +U/rBGzbXkewhAsBiZQmKYZuMTlDKNrp2eMW4ve56NlAApeVsJGQnru/dg8eEovy
        x9NJU8mT8T+/kwVzrMSyB0iixIwGDtxWyJ16gUNzk9C+PLPLhA1t71ZGEyv5Fzf9
        p76pluRiFTlkMyV5IQ3wvVsvo7tGNQB0Zs8q2Rk5u1ubA1hN/WyAwNXhCya9Ti3Q
        3B0h3sAU2YbxwVzoLochTZ81wopZ17TAASA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YBJbZSm4A9oA for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 14:57:51 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J98ZQ2L4Zz1RtVG;
        Thu,  9 Dec 2021 14:57:50 -0800 (PST)
Message-ID: <cf7b4f8b-3423-0cb3-c765-c2903a5f2e4d@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:57:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/10 7:49, Damien Le Moal wrote:
> On 2021/12/09 23:59, Andy Shevchenko wrote:
>> platform_get_irq() will print a message when it fails.
>> No need to repeat this.
>>
>> While at it, drop redundant check for 0 as platform_get_irq() spills
>> out a big WARN() in such case.
> 
> The reason you should be able to remove the "if (!irq)" test is that
> platform_get_irq() never returns 0. At least, that is what the function kdoc
> says. But looking at platform_get_irq_optional(), which is called by
> platform_get_irq(), the out label is:
> 
> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> 	return ret;
> 
> So 0 will be returned as-is. That is rather weird. That should be fixed to
> return -ENXIO:
> 
> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> 		return -ENXIO;
> 	return ret;
> 
> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

Replying to myself :)
I replied before reading Sergei replies that points this out.

> 
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/ata/libahci_platform.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 0910441321f7..1af642c84e7b 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -579,13 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>  	int i, irq, n_ports, rc;
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0) {
>> -		if (irq != -EPROBE_DEFER)
>> -			dev_err(dev, "no irq\n");
>> +	if (irq < 0)
>>  		return irq;
>> -	}
>> -	if (!irq)
>> -		return -EINVAL;
>>  
>>  	hpriv->irq = irq;
>>  
> 
> 


-- 
Damien Le Moal
Western Digital Research
