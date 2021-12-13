Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FC472AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhLMLAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Dec 2021 06:00:19 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34995 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhLMLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:00:14 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5811D24001E;
        Mon, 13 Dec 2021 11:00:08 +0000 (UTC)
Date:   Mon, 13 Dec 2021 12:00:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, vigneshr@ti.com, zealci@zte.com.cn
Subject: Re: [PATCH nand-next v2] mtd: rawnand: gpmi: remove unneeded
 variable
Message-ID: <20211213120007.6729afc4@xps13>
In-Reply-To: <20211213104930.436602-1-chi.minghao@zte.com.cn>
References: <20211213101519.25f4e2e1@xps13>
        <20211213104930.436602-1-chi.minghao@zte.com.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

cgel.zte@gmail.com wrote on Mon, 13 Dec 2021 10:49:30 +0000:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return status directly from function called.
> change since v1: mtd/nand:remove unneeded variable
>              v2: mtd: rawnand: gpmi: remove unneeded variable

Thanks for providing a changelog, this is indeed the right thing to do.
However it should not be part of the commit message and hence not be
located here...

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---

... but here!

Anything below these three dashes '---' will be ignored by Git.

>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 10cc71829dcb..ab9d1099bafa 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -1425,7 +1425,6 @@ static int gpmi_ecc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct gpmi_nand_data *this = nand_get_controller_data(chip);
>  	struct bch_geometry *nfc_geo = &this->bch_geometry;
> -	int ret;
>  
>  	dev_dbg(this->dev, "ecc write page.\n");
>  
> @@ -1445,9 +1444,7 @@ static int gpmi_ecc_write_page(struct nand_chip *chip, const uint8_t *buf,
>  				    this->auxiliary_virt);
>  	}
>  
> -	ret = nand_prog_page_op(chip, page, 0, buf, nfc_geo->page_size);
> -
> -	return ret;
> +	return nand_prog_page_op(chip, page, 0, buf, nfc_geo->page_size);
>  }
>  
>  /*


Thanks,
Miquèl
