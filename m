Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0D4C11FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiBWLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiBWLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:55:20 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E2A985A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:54:52 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBsjx6125254;
        Wed, 23 Feb 2022 05:54:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645617285;
        bh=nZ7gTtsnYSWT0640cyi2p07HuKh9WWN1Sd0k1wHT2yc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N7igpGNDbVhg91kQ8YcJjBMl0kBQ8zR6r5Oa4FwkGAMRga8lLAuH/FNuK4NOyrmui
         Zgoh6wARohWyrnNRVKxtiVnQTTBEi9QcnuTYotnuI2sFmRGFjlWjNB+4L6RtFZ0VNP
         xjZCYiF/wlN5523EHjm1YC67ljOE/N9e2sZrtJ/g=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBsjU0020751
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:54:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:54:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:54:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBsiFB046499;
        Wed, 23 Feb 2022 05:54:45 -0600
Date:   Wed, 23 Feb 2022 17:24:44 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Message-ID: <20220223115444.wj24a2vvtjc2zexv@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-27-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220221120809.1531502-27-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/22 01:08PM, Michael Walle wrote:
> Drop the generic spi_nor prefix for all the micron-st functions.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index f693f8720541..de450495e1ab 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -309,7 +309,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  }
>  
>  /**
> - * spi_nor_read_fsr() - Read the Flag Status Register.
> + * micron_st_nor_read_fsr() - Read the Flag Status Register.
>   * @nor:	pointer to 'struct spi_nor'
>   * @fsr:	pointer to a DMA-able buffer where the value of the
>   *              Flag Status Register will be written. Should be at least 2
> @@ -317,7 +317,7 @@ static int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
> +static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
>  {
>  	int ret;
>  
> @@ -353,10 +353,10 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
>  }
>  
>  /**
> - * spi_nor_clear_fsr() - Clear the Flag Status Register.
> + * micron_st_nor_clear_fsr() - Clear the Flag Status Register.
>   * @nor:	pointer to 'struct spi_nor'.
>   */
> -static void spi_nor_clear_fsr(struct spi_nor *nor)
> +static void micron_st_nor_clear_fsr(struct spi_nor *nor)
>  {
>  	int ret;
>  
> @@ -380,13 +380,13 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
>  }
>  
>  /**
> - * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flash is
> - * ready for new commands.
> + * micron_st_nor_fsr_ready() - Query the Flag Status Register to see if the
> + * flash is ready for new commands.

This is misleading. This function doesn't only query the FSR, but the SR 
as well. I think this should be renamed to micron_st_nor_ready(), and 
documentation updated to reflect that it checks for SR, and then FSR as 
well if the flag is specified.

>   * @nor:	pointer to 'struct spi_nor'.
>   *
>   * Return: 1 if ready, 0 if not ready, -errno on errors.
>   */
> -static int spi_nor_fsr_ready(struct spi_nor *nor)
> +static int micron_st_nor_fsr_ready(struct spi_nor *nor)
>  {
>  	int sr_ready, ret;

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
