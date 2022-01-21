Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC70F495D25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379813AbiAUJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:58:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8012 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbiAUJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642759083; x=1674295083;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YAZyTUCMBE+usCyuCqOqnYpV7QsKpbedraJMknC/4XU=;
  b=o6ifA1YCRvvOVKaFEH7qrg4fDA97102UwPrxzkBf/qpEaAmGYZBOu1w+
   CXgwo07rKsUpcFEMOEWgqkqWT/Z0GKCyzkCuO388SYJ/sCrOJU7XKB6h8
   QOiuItLMsud/uG+1X5XFoez7PCGTNB4J/qW+JzvToZ6zRZmOK+oTh5H4q
   jj1YvUVK97SzCaLB8HEPindAhMMXC/4TU47BvPg0W2Ev5pcUkvjhdl2kR
   kkVwpdSyoxnj49qiDo9Xdv/mygn4j547Npzmx/GN9WK0aM++7M6P6AEqK
   ab1HdUeUwgswqtrQuRT2I1RoBNS4ZbL7gIig0cuZtitgrz9i8Y8ncDNHQ
   w==;
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="191031972"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 17:58:02 +0800
IronPort-SDR: 69W2gPcL7qp09eWa9K0rbWCjNmjPILj0N+tJEmmmbgyaPdsm7exDi/iqVo0v/cgCoG3PMZwBCX
 pYzloXBvGz0Y9hXmK0i2EOyOauXZr9uN5276e2RoEVx/pPd/sQs4gxUtBNI1cPiIxSUoG27mRu
 qlX93Lcx79YQJAH1CRQKOEMiIbPGlvfghLrpkbGcNp+sgBetV3tuRWMpwXoLr9yb1mrfvATCCY
 bJBi5rFPNiLYUeahZJIODSogbblFZO2ArkXcdgydl2wrWLwDkDgJBQuOSDA3YvEpyGIqDxLcBI
 PMpYIx5zJrxK+TyDsHK7TCE3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:31:30 -0800
IronPort-SDR: WGte4rypfIfzD5MuM5fmWKT4GrqNaII24jMZI0yqSqRmunQxOKBXINC9dhxpT1GEEct7Mxtdai
 HCJhNGLNOqZFOIPs4zBqexMZqOBtm3hqB5MlF6fUBqSEpgp4WQn1zIhafF8OI8LJfb6deUaJs7
 iWIDhRDUR+eCXNAn1qqKh7WMX7e9UEeBXwt9jHmS6vzUYibM3ZaedDPdb0jtiB1qq0CQqbKaRl
 LHuGISi8BOMGz+LZ7F/lMbNH0ilga7inECSJh1Kh7z0FNstnkW2Z85h20oUiMcV9KPhNgDLmeg
 BgU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:58:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JgFDq2DvFz1SVp3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:58:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642759082; x=1645351083; bh=YAZyTUCMBE+usCyuCqOqnYpV7QsKpbedraJ
        MknC/4XU=; b=nkMn+kdZP+JDNpI6G8mqhyR+H2cHtKqDKg2m/jBOuxhjK+hFFqK
        6pNYko4CWNdFPkW9m/71OUxY6vRzZSaLPXABP4tyW3+6TLPWFaxoX3Fgj2+zbsBb
        PUvlB64fdCCIHnjkDMNwzRA4p4mUQJ6fSLsSOx10jwnHaTdUu5A5HJRO1sWPXuNX
        QAxurixFEUkVlDOkOKrhA7/WueqWglgT2cmS1xoX74QMqyt8aB9dfuLXT4zMsKX7
        miEuzk6lUvX6gtDFuE14siNuKy9dFYjwUnplfXvtdeLnpSQsdJB038gPfTCqqWOR
        /2UkizarL5CjGHSilHaBk4YS7OduDVz71AQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s8aHEGTfD5G8 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jan 2022 01:58:02 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JgFDn3lyGz1RvlN;
        Fri, 21 Jan 2022 01:58:01 -0800 (PST)
Message-ID: <b239d566-1134-a063-4727-65c0f092400c@opensource.wdc.com>
Date:   Fri, 21 Jan 2022 18:57:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: fix memory leak in
 disk_register_independent_access_ranges
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120101025.22411-1-linmq006@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220120101025.22411-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 19:10, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix this issue by adding kobject_put().
> Callback function blk_ia_ranges_sysfs_release() in kobject_put()
> can handle the pointer "iars" properly.
> 
> Fixes: a2247f19ee1c ("block: Add independent access ranges support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  block/blk-ia-ranges.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
> index b925f3db3ab7..18c68d8b9138 100644
> --- a/block/blk-ia-ranges.c
> +++ b/block/blk-ia-ranges.c
> @@ -144,7 +144,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
>  				   &q->kobj, "%s", "independent_access_ranges");
>  	if (ret) {
>  		q->ia_ranges = NULL;
> -		kfree(iars);
> +		kobject_put(&iars->kobj);
>  		return ret;
>  	}
>  

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
