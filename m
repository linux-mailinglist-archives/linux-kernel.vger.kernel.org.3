Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2A4EDAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiCaNjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiCaNjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:39:40 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A21E6E98
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:37:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VDbiET076878;
        Thu, 31 Mar 2022 08:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648733864;
        bh=2bGp4284cM8cKAbzO0/cvaQY2N+SMPlAqI1jkBzZsOI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JRIDTkx7SbRgySpI3oDV8d2umgS2slPg6vFWnBxAUYTbE7zN7szBhIe5rGdKDFPhW
         Qxe0aedQ2d6YoJy9+B04dYYYd41jZKSoXb/7CUqdzr04vXwWL064cwGyEmbqosdcFr
         ZsqGbYaTjxmi8SyAd8uJjgxl1s5p60V9Anh8uNKk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VDbisW022194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 08:37:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 08:37:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 08:37:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VDbiEB127554;
        Thu, 31 Mar 2022 08:37:44 -0500
Date:   Thu, 31 Mar 2022 08:37:44 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
CC:     <outreachy@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: Fix No space before tabs
Message-ID: <20220331133744.lypehhmz2wxngvzl@bryanbrattlof.com>
References: <20220331130948.74835-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220331130948.74835-1-eng.alaamohamedsoliman.am@gmail.com>
User-Agent: NeoMutt/20171215
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

Hi Alaa!

Thank you for the patch

On March 31, 2022 thus sayeth Alaa Mohamed:
> Fix "WARNING: please, no space before tabs"
> reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_efuse.c | 54 +++++++++++-----------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index 3d3c77273026..06e727ce9cc2 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -100,7 +100,7 @@ u8 PwrState)
>  u16
>  Efuse_GetCurrentSize(
>  	struct adapter *padapter,
> -	u8 	efuseType,
> +	u8	efuseType,
>  	bool		bPseudoTest)
>  {
>  	return padapter->HalFunc.EfuseGetCurrentSize(padapter, efuseType,
> @@ -124,29 +124,29 @@ Efuse_CalculateWordCnts(u8 word_en)
>  }
>  
>  /*  */
> -/* 	Description: */
> -/* 		1. Execute E-Fuse read byte operation according as map offset and */
> -/* 		    save to E-Fuse table. */
> -/* 		2. Referred from SD1 Richard. */
> +/* Description: */
> +/*		1. Execute E-Fuse read byte operation according as map offset and */
> +/*			save to E-Fuse table. */
> +/*		2. Referred from SD1 Richard. */
>  /*  */
> -/* 	Assumption: */
> -/* 		1. Boot from E-Fuse and successfully auto-load. */
> -/* 		2. PASSIVE_LEVEL (USB interface) */
> +/* Assumption: */
> +/*		1. Boot from E-Fuse and successfully auto-load. */
> +/*		2. PASSIVE_LEVEL (USB interface) */
>  /*  */
> -/* 	Created by Roger, 2008.10.21. */
> +/* Created by Roger, 2008.10.21. */
>  /*  */
> -/* 	2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
> -/* 					2. Add efuse utilization collect. */
> -/* 	2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
> -/* 					write addr must be after sec5. */
> +/* 2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
> +/*					2. Add efuse utilization collect. */
> +/* 2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
> +/*					write addr must be after sec5. */
>  /*  */
>

I'm wondering if it would be OK if we removed the change history and 
tried to align the indentation a little. (This may need to be multiple 
patches depending on how everyone else feels)

It may help if we converted the comments into one block. eg:

   /* ... */
   /* ... */

to

  /*
   * ...
   * ...
   */

thank you again for the patch
~Bryan
