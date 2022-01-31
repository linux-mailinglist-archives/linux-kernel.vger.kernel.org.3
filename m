Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6563F4A4D03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380888AbiAaRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:19:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34170 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbiAaRTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:19:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20VHJVPF029858;
        Mon, 31 Jan 2022 11:19:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643649571;
        bh=QeEtQGYhhkgtmo7vgTLQpZJwW10aDSc+Qga0JWAvFHI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YyO7w5JZcy0w+ZTgIIjZOUp7MTFqLivSBTUGHyvjt9Hv964RaHKjskkIIFts0g/J5
         SjS6/UxTyQyBQ6v5fYHkgLI480iK4BWBZJhBhew9DVFqeilzfyiwcbltiREQOkrcTi
         FjlYhosEShna5KEifL16GmagHlRssrVMWbwTECNg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20VHJVnj051055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 11:19:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 31
 Jan 2022 11:19:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 31 Jan 2022 11:19:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20VHJUJ4087859;
        Mon, 31 Jan 2022 11:19:30 -0600
Date:   Mon, 31 Jan 2022 22:49:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Chen-Tsung Hsieh <chentsung@chromium.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Message-ID: <20220131171929.uk3z5sr453c3eefp@ti.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220126073227.3401275-1-chentsung@chromium.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/22 03:32PM, Chen-Tsung Hsieh wrote:
> Read back Status Register 1 to ensure that the written byte match the
> received value and return -EIO if read back test failed.
> 
> Without this patch, spi_nor_write_16bit_sr_and_check() only check the
> second half of the 16bit. It causes errors like spi_nor_sr_unlock()
> return success incorrectly when spi_nor_write_16bit_sr_and_check()
> doesn't write SR successfully.
> 
> Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
> Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>

I don't know much about this bit of code but this patch looks fine to me 
from the surface. Would be nice to hear from Tudor about this too since 
he added the function.

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
