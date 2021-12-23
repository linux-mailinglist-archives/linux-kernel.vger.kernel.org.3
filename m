Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DF47DC10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhLWAf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:35:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhLWAf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640219727; x=1671755727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FJoVc4dAwzd533OMIKZS9+1/T26+GvCBRtbTTG2MG3g=;
  b=PHErUyB76Fv1NRUwiJa5Xfbm9r0q2dL5dA9vUW/6kNj3CPCECZqJ8IqS
   eLAO0uRd40AqBbcooKVVigd3TKOxEkoPr6+ugZ2Fx7Nf50qiqUHtVRNT/
   4ccs9ufBqtF8Mr9VdDjsEMIUdGkmmJ4P7D6+4Tzj7TdYKFx14Gk2SDMbF
   kbs2p/dwr77sw37R/0YIRkFB+BtTXS4gTxjL04U2405OlQ56vWl8RF5AB
   aT29G8hiQc6OfujdSzNMtJ77KeOWW8huxIZIlYp/pehkK/p/i1otQbKoG
   cpdF9WKZnnPhjQaO6x4k5lgj0VU50Dchhkp1nS/vPn81sLXzwvN4SxjvE
   A==;
X-IronPort-AV: E=Sophos;i="5.88,228,1635177600"; 
   d="scan'208";a="187873536"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2021 08:35:27 +0800
IronPort-SDR: h6pnkbaekqyztOOpKDko8cYeZBKO/R+My30sifgeKS2qWt57KwgfgIsU8O73PlducTOUxW+Z/j
 T6/k5XiJrtY9UgdqZKyOwAHeLL4OPV09kCDZWxdIuRr9kY1UDOJw45sXjy+kOs8TE3EkDEBKmK
 iEw9Xnr4dlN8oJB04N4OPd2eRcFl7lefaII7nbut2GICtfvFBEFi3I2tojma9QfenFT1Vz3eCY
 iCoRPkuc2V+ZGE6r+8/ZCxB91tAgZ+NjvpHVorcv3YxjV8nS8q6w6C20EZl6WGdGcyFQ/L3Yn3
 nAUz/wdsTH4cMn57/Q8Y2T+D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:08:14 -0800
IronPort-SDR: Yc9TfOGZdmtVYXrfG8fBGweR9e+zg9vK2rSdxUXZN3+0py2Vf8U266VJJ8g3S3eU+zhxHE8IS1
 OMixxb7kTyQIiRLZ++dTvS7klR5CY3kiHEMjQwQF92gKxf13bTsPHVn7QvXIxExqRCgCif0PG2
 ZX4h7l0EZWbL7W4w1tVG2WgFvbWSMVVFQQWHzVTlKH4fKYXcvZ1seRPDJ8M1HcqD4CeIoT/ovK
 ORHf2XWeByiNQKP0EXB0pa1YBQxGqJ1ny5/jagq9MDIt92zo6kF4c1uNoSDx4NkYPW4xucEg7h
 0XU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:35:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JKB731JcKz1Rwns
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 16:35:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640219726; x=1642811727; bh=FJoVc4dAwzd533OMIKZS9+1/T26+GvCBRtb
        TTG2MG3g=; b=B2nhR3cayhmNKO9nGybK/8FxEQDeMnII2cYvbb3R/Q6TrVLg8E0
        xRkape75ud1R63ChmYQviHQaVqckRQ9oXjyppRuJnMduyFCxq6hUS9b/lzqxvyTT
        gxHYJnN3zpondXbkjmDCdKFU8bWaJ1oJnMLjf1tkpDyB9dendjPdQ2dPv8xXqOdF
        czAecT3P0dS+ILGBXwGHt22vyqSsjfS/lUBs42doNBXN+f1d3RVfrQZiBiM/W85E
        jT2LH+H4C6o/pDCrDEoOJxyLByzp/uCp1rfLVsLU/wKQ/GL3c+rTthg/N1w9tP2o
        Ok08b/e2o8HKeN94Yk89GfEypck7zVJ2o3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n8pz_IJJ-KmQ for <linux-kernel@vger.kernel.org>;
        Wed, 22 Dec 2021 16:35:26 -0800 (PST)
Received: from [10.225.163.35] (unknown [10.225.163.35])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JKB7127BFz1RtVG;
        Wed, 22 Dec 2021 16:35:25 -0800 (PST)
Message-ID: <d851cdc5-78c6-ff35-979f-7aec71f3cb9b@opensource.wdc.com>
Date:   Thu, 23 Dec 2021 09:35:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/4] ata: pata_platform: make use of
 platform_get_mem_or_io()
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 01:26, Lad Prabhakar wrote:
> Make use of platform_get_mem_or_io() to simplify the code.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1-->v2
> * No change
> ---
>  drivers/ata/pata_platform.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index 028329428b75..cb3134bf88eb 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -198,22 +198,16 @@ static int pata_platform_probe(struct platform_device *pdev)
>  	/*
>  	 * Get the I/O base first
>  	 */
> -	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (io_res == NULL) {
> -		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (unlikely(io_res == NULL))
> -			return -EINVAL;
> -	}
> +	io_res = platform_get_mem_or_io(pdev, 0);
> +	if (unlikely(!io_res))

This is not the hot path, so I do not think that the unlikely() is
necessary here.

> +		return -EINVAL;
>  
>  	/*
>  	 * Then the CTL base
>  	 */
> -	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
> -	if (ctl_res == NULL) {
> -		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		if (unlikely(ctl_res == NULL))
> -			return -EINVAL;
> -	}
> +	ctl_res = platform_get_mem_or_io(pdev, 1);
> +	if (unlikely(!ctl_res))

Same comment here.

> +		return -EINVAL;
>  
>  	/*
>  	 * And the IRQ


-- 
Damien Le Moal
Western Digital Research
