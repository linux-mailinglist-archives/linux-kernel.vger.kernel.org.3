Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A44EED15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbiDAM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbiDAM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:28:12 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A57B183815
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:26:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 231CQ35u017451;
        Fri, 1 Apr 2022 07:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648815963;
        bh=2q2pigkmrlwExP6Zu0cReT2KqY14VuIXr33i4WynK0o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r1PcSdo6RU/3YbUeZGH71AmfN4FqwZXqmqKF0t2e3NZ8vrhONam4TNtTYc0Dgb5ml
         1uRiLNvwpRXS51sFI9cxhwV4Yg3fwSk7zlhwM7YC0hGvEgwPygrJ5l8lJ5EQ6SvQnT
         x5BHzrE0uSWx9L8TzMVHyO2ivor3ok9gbxSl9XPM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 231CQ3eq012595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Apr 2022 07:26:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Apr 2022 07:26:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Apr 2022 07:26:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 231CQ1mc041084;
        Fri, 1 Apr 2022 07:26:02 -0500
Date:   Fri, 1 Apr 2022 17:56:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 2/4] mtd: spi-nor: Update name and description of the
 set_4byte_addr_mode BFPT methods
Message-ID: <20220401122601.4uhznhscizpjdh6z@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309144215.179449-3-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/22 04:42PM, Tudor Ambarus wrote:
> BFPT defines some standard methods to enter and exit the 4-Byte Address
> Mode. Use generic names for these methods and update their description.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c      |  2 +-
>  drivers/mtd/spi-nor/macronix.c  |  3 ++-
>  drivers/mtd/spi-nor/micron-st.c |  3 ++-
>  drivers/mtd/spi-nor/sfdp.c      | 32 ++++++++++++++++++++------------
>  drivers/mtd/spi-nor/sfdp.h      |  7 ++++---
>  drivers/mtd/spi-nor/winbond.c   |  2 +-
>  6 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 452d0f91a8df..91d3754baa59 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2492,7 +2492,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	struct device_node *np = spi_nor_get_flash_node(nor);
>  
>  	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
> -	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
> +	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
>  	params->otp.org = &info->otp_org;
>  
>  	/* Default to 16-bit Write Status (01h) Command */
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index d81a4cb2812b..85e8655d362c 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -105,7 +105,8 @@ static const struct flash_info macronix_nor_parts[] = {
>  static void macronix_nor_default_init(struct spi_nor *nor)
>  {
>  	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> -	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
> +	nor->params->set_4byte_addr_mode =
> +		spi_nor_set_4byte_addr_mode_en4b_ex4b;
>  }
>  
>  static const struct spi_nor_fixups macronix_nor_fixups = {
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index c348419d24a0..4baa9dce04f9 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -410,7 +410,8 @@ static void micron_st_nor_default_init(struct spi_nor *nor)
>  	nor->flags |= SNOR_F_HAS_LOCK;
>  	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
>  	nor->params->quad_enable = NULL;
> -	nor->params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
> +	nor->params->set_4byte_addr_mode =
> +		spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
>  }
>  
>  static void micron_st_nor_late_init(struct spi_nor *nor)
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 108a74ce38e0..01e35354db3e 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -402,15 +402,20 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>  }
>  
>  /**
> - * spansion_set_4byte_addr_mode() - Set 4-byte address mode for Spansion
> - * flashes.
> + * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
> + * SPINOR_OP_BRWR.
>   * @nor:	pointer to 'struct spi_nor'.
>   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
>   *		address mode.
>   *
> + * 8-bit volatile bank register used to define A[30:A24] bits. MSB (bit[7]) is

Typo. s/30:A24/30:24/

Other than this,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> + * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 4-byte
> + * address mode is active and A[30:24] bits are don’t care. Write instruction is
> + * SPINOR_OP_BRWR(17h) with 1 byte of data.
> + *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
> +int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
>  
> @@ -434,14 +439,15 @@ int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  }
>  
>  /**
> - * spi_nor_set_4byte_addr_mode() - Enter/Exit 4-byte address mode.
> + * spi_nor_set_4byte_addr_mode_en4b_ex4b() - Enter/Exit 4-byte address mode
> + * using SPINOR_OP_EN4B/SPINOR_OP_EX4B.
>   * @nor:	pointer to 'struct spi_nor'.
>   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
>   *		address mode.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
> +int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
>  
> @@ -465,15 +471,15 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  }
>  
>  /**
> - * micron_st_nor_set_4byte_addr_mode() - Set 4-byte address mode for ST and
> - * Micron flashes.
> + * spi_nor_set_4byte_addr_mode_wren_en4b_ex4b() - Set 4-byte address mode usingf
> + * SPINOR_OP_WREN followed by SPINOR_OP_EN4B or SPINOR_OP_EX4B.
>   * @nor:	pointer to 'struct spi_nor'.
>   * @enable:	true to enter the 4-byte address mode, false to exit the 4-byte
>   *		address mode.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
> +int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
>  
> @@ -481,7 +487,7 @@ int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_nor_set_4byte_addr_mode(nor, enable);
> +	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
>  	if (ret)
>  		return ret;
>  
> @@ -729,15 +735,17 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  
>  	switch (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_4B_ADDR_MODE_MASK) {
>  	case BFPT_DWORD16_4B_ADDR_MODE_BRWR:
> -		params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
>  		break;
>  
>  	case BFPT_DWORD16_4B_ADDR_MODE_WREN_EN4B_EX4B:
> -		params->set_4byte_addr_mode = micron_st_nor_set_4byte_addr_mode;
> +		params->set_4byte_addr_mode =
> +			spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
>  		break;
>  
>  	case BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B:
> -		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
> +		params->set_4byte_addr_mode =
> +			spi_nor_set_4byte_addr_mode_en4b_ex4b;
>  		break;
>  
>  	default:
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index b56849079aea..da2d7ec2e0aa 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -107,9 +107,10 @@ struct sfdp_parameter_header {
>  	u8		id_msb;
>  };
>  
> -int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
> -int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
> -int micron_st_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
> +int spi_nor_set_4byte_addr_mode_brwr(struct spi_nor *nor, bool enable);
> +int spi_nor_set_4byte_addr_mode_en4b_ex4b(struct spi_nor *nor, bool enable);
> +int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor,
> +					       bool enable);
>  int spi_nor_parse_sfdp(struct spi_nor *nor);
>  
>  #endif /* __LINUX_MTD_SFDP_H */
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 374ba82bff49..590e4d2c99d7 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -142,7 +142,7 @@ static int winbond_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>  {
>  	int ret;
>  
> -	ret = spi_nor_set_4byte_addr_mode(nor, enable);
> +	ret = spi_nor_set_4byte_addr_mode_en4b_ex4b(nor, enable);
>  	if (ret || enable)
>  		return ret;
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
