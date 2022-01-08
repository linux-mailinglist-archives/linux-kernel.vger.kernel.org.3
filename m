Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB24880FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiAHCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:53:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24319 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiAHCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641610426; x=1673146426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=18sCj2RdcKGXbsg4flhwNXu4sUx9xxzs677rPpeglEw=;
  b=VGj29Vo/b9mmlegHomsxcNnI1oEDR0yY0t4YgBkj1qGBI6U12Qy8s/aG
   bbMTR4pFeOMx4gWP3UC+HMLfgE9LA5jm5762+phNYlBNx3E30rLbihWA7
   YAt2sQDvR5i37o+0XZ8eGm/jNbLc26ZSvzv3Hnho/YDTgUAoIZHSsLs13
   3u1v7xhm0yH60ss054Itb0EkOnN8qPRCc2tuKZUiKR/YVcqZAnHtTka5x
   6aksPVSoil3xNoM7SClY3K8xx3EbKGUFGfFeSWDqhmweG2gm6I/434Dlp
   HIXm95L41k4un7DSMClVMSe9fl8J1iY59kexs4fuo/6VU6vGZN43PWdM9
   A==;
X-IronPort-AV: E=Sophos;i="5.88,271,1635177600"; 
   d="scan'208";a="301840972"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2022 10:53:46 +0800
IronPort-SDR: stbXmIIZMtznk5lAw/OPO2AB7oG6s7PuPQCYm4dKmynmg4sadozNkBN5/6STVDRTSslW7PZ0UM
 RBtgHvUJSxkRFnvSsPSjJQjEBMA86B/9gbK5upryOUVaIyRT6D6dbcAFSQJ7M1twHsGpxxSHF1
 5Bo7+Vtoe/Jn6zHwWM6wh01E8yFCr+bELeOO01s5fH3MRKlkG2FYmD7LGbLG10sHDUJk3vDHK8
 4bxLA1Ci6Y8sCN/McsDNSGggFus6y5u3YGQ1kcKRcTAu+Fnq30PrYOUrG4q9e0h9Bifq5ofpCh
 +vYiFewrxvlL0poC/1jRyNms
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 18:27:33 -0800
IronPort-SDR: EV69dzOK+BCNsdBb3wJ/jNAf9G4PPWRY3YGMbmtfnRj4FA1qJAuufyxX54k/6lXKQTcDnnVFs2
 V5R8CYPJRGaagBBAqYwJhqIV1xiJA1Q1eycKMHAV741Zr9Qjw0vPTyZnWfc65IKfHdfg7iKjv/
 NzWqUWmvRdOxXg9A7l7leHr14W5gFdrFITX8gZ9ZSFVGC+6QYSP0VYpn1+Zfg17+6We+3VCMF7
 KU7qaQLIEihzWwoS+1tAX5F5GWwniIUpUXFHyvtdi+36BnZ4Gjf57BIwtnXTDvR+ls+71aWq4u
 Ytw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 18:53:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JW4RG15hPz1VSkZ
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 18:53:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641610425; x=1644202426; bh=18sCj2RdcKGXbsg4flhwNXu4sUx9xxzs677
        rPpeglEw=; b=gG/UklnlqCZw/fTapytooML9rRIbyJaTOGNUDvCHMrmcmC+FpnE
        NmiCH6V4JuBcvdKpFI6iKj6c1PYKujBJe9IhtnjRDLf/ePTIzk178IDpaWriKYGu
        CkmmsZ0zywOsLJdtdChNbjFsHSXgA+at0tbKLrZD6Gaj0P+rO3wqGyCLtt0D5k+9
        N4BDgfUVKZUjdG7EzIAd9pzUMXYLgGd7kDL8jFl89vB61DFIXwMfKEXQkj2Atjf/
        7t5SDjTckzpFW2BFfTrtGDK6Gf8Cti4A3rUVfsbK7tXuuNa/4x3VO97/Fcd8/ORy
        CVPbs/h4nMBTnHsbsWkCPFphhnOvnzr/P1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KdVueIEq29F0 for <linux-kernel@vger.kernel.org>;
        Fri,  7 Jan 2022 18:53:45 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JW4RD0T8tz1VSkV;
        Fri,  7 Jan 2022 18:53:43 -0800 (PST)
Message-ID: <177f3741-ca31-b5ac-69ff-1adf346f1199@opensource.wdc.com>
Date:   Sat, 8 Jan 2022 11:53:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, David.Laight@ACULAB.COM,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107125308.4057544-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107125308.4057544-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/07 21:53, Jiasheng Jiang wrote:
> In linux-stable-5.15.13, this file has been removed and combined
> to `drivers/ata/pata_platform.c` without this bug.
> But in the older LTS kernels, like 5.10.90, this bug still exists.
> As the possible failure of the devres_alloc(), the devm_ioremap() and
> devm_ioport_map() may return NULL pointer.
> And then, the 'base' and 'alt_base' are used in plat_ide_setup_ports().
> Therefore, it should be better to add the check in order to avoid the
> dereference of the NULL pointer.
> Actually, it introduced the bug from commit 8cb1f567f4c0
> ("ide: Platform IDE driver") and we can know from the commit message
> that it tended to be similar to the `drivers/ata/pata_platform.c`.
> But actually, even the first time pata_platform was built,
> commit a20c9e820864 ("[PATCH] ata: Generic platform_device libata driver"),
> there was no the bug, as there was a check after the ioremap().
> So possibly the bug was caused by ide itself.
> 
> Fixes: 8cb1f567f4c0 ("ide: Platform IDE driver")
> Cc: stable@vger.kernel.org#5.10

Please keep the space before the #

Cc: stable@vger.kernel.org #5.10

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Correct the fixes tag and commit message.
> 
> v2 -> v3
> 
> * Change 1. Correct the code.

As commented before, what exactly was corrected ? That is what needs to be
mentioned here. In any case, I fail to see what code change you added between v2
and v3. The code changes are identical in the 2 versions.

> ---
>  drivers/ide/ide_platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
> index 91639fd6c276..5500c5afb3ca 100644
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

Greg,

The above patch is OK but cannot be applied in the current kernel:
* The Legacy IDE drivers were removed in 5.14, replaced by the already existing
* The current equivalent libata driver (drivers/ata/pata_platform.c) already has
the above error check.

So I think this patch needs to go directly to stable # 5.10 and earlier LTS
kernels. Can you take it ?

Feel free to add:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Note that I was not the maintainer of the IDE drivers. If more appropriate
please feel free to replace that with a Reviewed-by tag.

Thanks !

-- 
Damien Le Moal
Western Digital Research
