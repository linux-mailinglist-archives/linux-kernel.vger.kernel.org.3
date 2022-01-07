Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE80487768
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347044AbiAGMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:07:46 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62151 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiAGMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641557264; x=1673093264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DIqbI5MDg3/Xzqi8tsz5+ABmdVszh5nOou+bQe7BFfc=;
  b=dDWeIRGPJcksR51HbjGvvbQOlCMC0cS79TJqMKobMD/DVXfBX3RcEZ+/
   JyHGV22vWW+bvgadIogdW+Y5w0mZLdcS9mlUyHsH94fXF2sDZEEPNZpAi
   n7Ly8LwnWsOiRthvTHKfVysbTh+BRCZ2i2bfwOmX0vN11R++f7jGUm5ir
   4+wv6TO+2vE/W77Cd2BvuSrXP0uvGgU2uDR7vz9JNHdiqH/GXU9qwrLw/
   sbwLGsuKAf9m05iM2XVYgD8BEtFDXowTyW2GnzDEwmaKUP3gSRld2TD9M
   OR/8jb0zew8owRkWn0qoqa6+kHjgM2KgEaxRvQ1Dj61KRIxNrIMHMpB8h
   A==;
X-IronPort-AV: E=Sophos;i="5.88,269,1635177600"; 
   d="scan'208";a="190946848"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 20:07:44 +0800
IronPort-SDR: TqnrKY7m1v3mRAdtVd5jlcJgHmxf0nadps0LIComD8uis1LqlmrwoqNQOVJyqrZcC8oRU/KoJi
 fecDSlNqDMTI1ZCe2HIvQBXjmd8UjpENM/jOZi+o7k4HKl7ishSxF1XejPn6HD4wjppCmoxNdJ
 /7gJiF39L5mwj68wACZSi/FnY8bcYaeoEt+4U8nz63X1Qfb/QxsAibVPSI8a7dMAlyoiWuEYhB
 n9E2MrGczA9R9dfqkU5/h5TVD2DgVDXooxtVwfLPJhCKgAHOQG5TUni6wf6JHmQleCaQ90N4QE
 WBoZ43+41NRQ4wKjmZNIQGpU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 03:40:11 -0800
IronPort-SDR: v16p06sQiHeo9jfDYCcY6ng8fTePy17O4cd/LTm9hxQXRUnV8dVz7ZEX+GwYJV0qVFd5UGjzET
 WuLg2PWSOG1AZrZjlM3D5E2apazYUNt98mbzn1CO9Mgq/l9YT86pINzuVrAGpQO4BdIC//DAve
 a6uUh9QhUiYgPo2Ll+t8RBgysXtFlf6Fxk+Ou540uhsT+NC5nfi+THoCZ6V2QGnCFnAWlMa0Hl
 gkMkbL3hGTzN3efOMZrgCSP2TfSNqpIz8mQ/BH5W0wwViW94LVx/Ztclft8UfizWAXgySTfUc3
 LBQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:07:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVhmv2Xfcz1VSkZ
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:07:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641557263; x=1644149264; bh=DIqbI5MDg3/Xzqi8tsz5+ABmdVszh5nOou+
        bQe7BFfc=; b=pIxFWFpQlgfhPpbYpqsi1gnMnYpX9kQ+0n/AeYuBRV07jLd+UXA
        GF/uzeHaW6R2oAhXAM8CevABhDGu1D2o2p/jD0hQqXRygm63av4qKCZnypUaQ96P
        olX2VsE2cr2BcyiNPw2eeSYISTwQym71/o/LrFWc8FBl6yc2go2R1QKm/3DuYfq9
        HowfZhOAD6HPTy1wfqny9GJ0cfkFzZbvJ05yjcGgWKxCUnIwjq9lmwBX3W8lr8HT
        yAeG807zTUlXEUyyLW0pGQEQXfe7WOOwsk6+R8nWSOFNsEntbDdRgebAKHlh9NQV
        aSo1Rz5hXbCbFP/IArULpoHpLMKyKbpKyWA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J9uBGq8Bdky9 for <linux-kernel@vger.kernel.org>;
        Fri,  7 Jan 2022 04:07:43 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVhmt1HKlz1VSkV;
        Fri,  7 Jan 2022 04:07:42 -0800 (PST)
Message-ID: <604c4187-ba45-1395-1409-103865d82c53@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 21:07:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, David.Laight@ACULAB.COM,
        davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107115000.4057454-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220107115000.4057454-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 20:50, Jiasheng Jiang wrote:
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
> Cc: stable@vger.kernel.org#5.10.90

This should be:

Cc: stable@vger.kernel.org #5.10

(no release number specified)

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v2 -> v3
> 
> * Change 1. Correct the fixes tag and commit message.
> * Change 2. Correct the code.

What exactly was corrected should be the change log.
And please keep the history for all versions of the patch (keep v1 -> v2
changes listed here).

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


-- 
Damien Le Moal
Western Digital Research
