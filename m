Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971A47FB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhL0JCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:02:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48916 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhL0JCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:02:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BR91sTG070872;
        Mon, 27 Dec 2021 03:01:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640595714;
        bh=EPaFMRenw90ORhu3akBUpRn776wRoahCOByuKbvuLiQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VMrHmVioFd0tO1vp7RBkswqdDwu0vcb81ngHLmE82BZDElIzf0osZQptOritMJ/yl
         JAdiT5ggU4nKdvSKYmgfMunsLZZoxq0W23Bc4w5WxHA/Zos/4qc8R3cdUln02Axgnr
         tfp1mJfWbviGMphCYF9GyJe+Z3d4XTK2KymFIn48=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BR91rl1010132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Dec 2021 03:01:53 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Dec 2021 03:01:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Dec 2021 03:01:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BR91qSt053303;
        Mon, 27 Dec 2021 03:01:53 -0600
Date:   Mon, 27 Dec 2021 14:31:51 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Potin Lai <potin.lai@quantatw.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Message-ID: <20211227090149.k53bhq3h3giuz2h2@ti.com>
References: <20211224104522.24615-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211224104522.24615-1-potin.lai@quantatw.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/21 06:45PM, Potin Lai wrote:
> Add support for winbond w25q01jv-iq chip
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index c783ab4ba1e4..a2a72d05fc28 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -104,6 +104,8 @@ static const struct flash_info winbond_parts[] = {
>  			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q01jv-iq", INFO(0xef4021, 0, 64 * 1024, 2048,
> +				SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

We recently reworked how flags are set. Please use the new flags 
variants. See [0] If the flash supports SFDP then we prefer you only set 
the PARSE_SFDP flag. See [1].

You also need to show the dumps of the SFDP and other flash parameters. 
See [2].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=ec1c0e996035c8f93eca7bb64ccf0411b57fddea
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=1c513c986b0a4c7151cb4571e568136f16c9dc58
[2] https://patchwork.ozlabs.org/project/linux-mtd/patch/20211209190436.401946-2-tudor.ambarus@microchip.com/

>  };
>  
>  /**
> -- 
> 2.17.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
