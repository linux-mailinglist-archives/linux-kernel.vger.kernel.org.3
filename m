Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039694B76A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiBOTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:05:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiBOTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:05:09 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B3F94F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:04:58 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FJ4hL8050006;
        Tue, 15 Feb 2022 13:04:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644951883;
        bh=e9QGUJwqOEL4b6TS0m6Ew3y92faJf7vP7fE+12uFZkU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=V0Y7Jnu2yS/6Evb941SNISkfhE16A5JFL6UiFkwRMaHdR7GIWdXzm2xxtfD7xuRvc
         c/5aRQY6WN4ZtbrH9XOZPRO7U2RWuvxjh3KD5eaYP5xIS86QzCkx49yZfHSm4Jq6fy
         n8AlhlwiUgm5cfLsBCYi6WQmo1tXejs1wybF7oD4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FJ4hu3029144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 13:04:43 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 13:04:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 13:04:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FJ4gkd076015;
        Tue, 15 Feb 2022 13:04:43 -0600
Date:   Wed, 16 Feb 2022 00:34:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Message-ID: <20220215190442.yid52fab32sjyd6n@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-6-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 03:58PM, Michael Walle wrote:
> Drop the generic spi_nor prefix for all the xilinx functions.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/xilinx.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index a865dadc2e5d..3e85530df1e4 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -8,9 +8,9 @@
>  
>  #include "core.h"
>  
> -#define SPINOR_OP_XSE		0x50	/* Sector erase */
> -#define SPINOR_OP_XPP		0x82	/* Page program */
> -#define SPINOR_OP_XRDSR		0xd7	/* Read status register */
> +#define XILINX_OP_SE		0x50	/* Sector erase */
> +#define XILINX_OP_PP		0x82	/* Page program */
> +#define XILINX_OP_RDSR		0xd7	/* Read status register */
>  
>  #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
>  #define XSR_RDY			BIT(7)	/* Ready */
> @@ -60,20 +60,20 @@ static u32 s3an_convert_addr(struct spi_nor *nor, u32 addr)
>  }
>  
>  /**
> - * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
> + * xilinx_read_sr() - Read the Status Register on S3AN flashes.
>   * @nor:	pointer to 'struct spi_nor'.
>   * @sr:		pointer to a DMA-able buffer where the value of the
>   *              Status Register will be written.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
> +static int xilinx_read_sr(struct spi_nor *nor, u8 *sr)

Great minds think alike huh ;-)

But I agree with Tudor. vendor_nor_* or spi_nor_vendor_* would be 
better. I don't have much preference for any though. Please also 
remember to update the name in the doc comment, as the kernel test robot 
has already pointed out for this patch.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
