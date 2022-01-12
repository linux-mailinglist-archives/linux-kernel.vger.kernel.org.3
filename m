Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7F348C148
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352193AbiALJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:49:14 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23039 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349488AbiALJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641980951; x=1673516951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JQDGrSW+eyxzTUel+uhuRcG3nVZP4C61sljAPMCmUZQ=;
  b=aAo3a0t3Iwg+qSYPr45Algp5oHolnR0xKXE4Wg6G9jjvNCDyZFjVTNR+
   lbzhRDIW1JUp7PM+uDLgTg3xpo8EgG4BDa7yA5qVm4CRamnVAEKocXroE
   x3T1q5GPHMNiV9zHyIIiUgdLPGYPVI6GJkqsZOrEzFRdmqdrwiLa2wtKi
   h6FIj1cJqJ+wgg2dm5QrCO9kzqlMHPCw9uZ+WC18QsxoG5hSUIL5zSTs9
   VKgWSRtP867QbU12D/JsjREJIpIdC4HjOyrNZyAoSX+SNGxDzaUQOOKTW
   DYFMRoTICJtLshun+Lf1pyw7sKWgihOyjpJVzxAVTWsTh1/DRabfhGJTP
   g==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635177600"; 
   d="scan'208";a="190269246"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2022 17:49:11 +0800
IronPort-SDR: ga2JIToS4S5Gj6r4SntUCqYfWD+pKawTT2iJfyZbewTbd7070ZgcGRBPRh2H/SzeRC9DVX+E8G
 T+Wx5heN1VQhwyKwJSCQy673Fc3LH1FjQbjuZXrfM04gS485ZMf6ZZ1obRfqagP15l6wnnja2D
 VIPxtPwa/pJan1VE1FW6+/qK/SEwvy1AGmIxIEH+qvRvcjVuqmeFHGleRDJtO2OeTpNJaU3sIe
 TZcuTw34uexIr+dfZtpEco7h5VQQlrKESmuXHsYRkQXG9w2MtGPafTWDG0Sdi98w9hWX2L3liw
 m2hhkvYhIBBCguWulXovyT+p
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:21:35 -0800
IronPort-SDR: Dv1KpxTe9WOEhSyolrYJwN38bkW1hNPBgjVpnbU3RRetpkMlokcOPg+XMvWIAEz3dyIEY9O/0n
 spfVcupV83lNbwxDnl9CM/AXFVai9ozEwrjFfAY9OcOrEYY7nWFRVI1ZPLPcJUlEfRSm0/osPe
 VAod931CQYHOSbms4XihbNeecXpJp5QXhd7xaDTcP9NIUlL2JFvotIDk4we+vNWh57CWpr9TS4
 M6dptwFTH6NgEn/B+d5wWKcHSuZ3QoZB5vet+okod/+rnHcbt+ZCdJdMmhvR3e0ku1L6rLLX2m
 rnE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:49:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JYjSn0Vqpz1VSkX
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:49:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641980952; x=1644572953; bh=JQDGrSW+eyxzTUel+uhuRcG3nVZP4C61slj
        APMCmUZQ=; b=IxIt4AgvJtD9i2g/3w07Kbv9WkwW4lfVaZwW2Olx4RVHSCFbIPp
        E8dTY3Kzin5gnrcSSS3QrOjBtHP0EXNWabhN7OL8l2mHFjctCCSJUG+e7sxz3u2O
        +n38NKvkUSwCPFCQjDnclanynxKojQHXYr4h1GQGzlFNXp/DFGEKQ6pl6AFSSzi1
        7k/XY5FmS56Rm/gYdvdwlp1rL0tq6ra6GrXtoThUVUwlnL2OyfclXMMJESlCQxWa
        5+9UNF867qm14MYXpVAmxkaeRqxboyUXqmw3KWTNbMsy7r7LxajACAQkVH8WWK1i
        ckVvW1IRpYBK/QllvWddsyO+odKwlCqRHfQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HtHN1INKCb1l for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jan 2022 01:49:12 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JYjSm10nQz1VSkV;
        Wed, 12 Jan 2022 01:49:11 -0800 (PST)
Message-ID: <77ce7860-4857-a4e4-e7b3-08f56312cf87@opensource.wdc.com>
Date:   Wed, 12 Jan 2022 18:49:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/2] ahci: Rename flag `ATA_LFLAG_NO_DB_DELAY` to
 `ATA_LFLAG_NO_DEBOUNCE_DELAY`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220105153618.2395-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 00:36, Paul Menzel wrote:
> The new name is longer, but clearer.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/ahci_brcm.c   | 2 +-
>  drivers/ata/libata-sata.c | 2 +-
>  include/linux/libata.h    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6e9c5ade4c2ea..649815c196ed0 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
>  
>  static const struct ata_port_info ahci_brcm_port_info = {
>  	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
> -	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
> +	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
>  	.pio_mask	= ATA_PIO4,
>  	.udma_mask	= ATA_UDMA6,
>  	.port_ops	= &ahci_brcm_platform_ops,
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b9c77885b8726..67b2e7cf3cc4e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
>  		 * immediately after resuming.  Delay 200ms before
>  		 * debouncing.
>  		 */
> -		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
> +		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
>  			ata_msleep(link->ap, 200);
>  
>  		/* is SControl restored correctly? */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2a8404b26083c..15802e644962d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -191,7 +191,7 @@ enum {
>  	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
>  	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
>  	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
> -	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
> +	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
>  
>  	/* struct ata_port flags */
>  	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */

I applied both patches to for-5.17 (sorry, I am late, this fell through
the cracks...).

I simplified the commit messages though, especially patch 2, since the
main point of that patch is to introduce support for a new controller
rather than discussing the debounce delay thingy.

If you are OK with it, I will reuse your well written commit message for
a patch removing the debounce delay though :) Working on it now, I will
post something by week end after testing.


-- 
Damien Le Moal
Western Digital Research
