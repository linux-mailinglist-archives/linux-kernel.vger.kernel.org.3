Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200A47891A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhLQKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:42:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35010 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhLQKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:42:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHAgF6S104426;
        Fri, 17 Dec 2021 04:42:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639737735;
        bh=S6ZLgkIQ+Q0XPCetUL1bICQ1qsCCb6+pIL5oIjtesTs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lV632QdrOsQRlkyaqM2cUdBiRrVzfa0QSpJPZeWqv5owiKoUcW+dSJ3Hd7SuqkaEl
         wO3IplgGBsMasb3gkjpFByCUO4HeQJP9ffYW7hugovsdk3h7Oi+dbjwdp0EgNO8rB1
         s3occh+pM0vq8kIxBLkItuENFi3nzRpTfdV5uti0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHAgFiS062610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 04:42:15 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 04:42:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 04:42:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHAgEI9062172;
        Fri, 17 Dec 2021 04:42:15 -0600
Date:   Fri, 17 Dec 2021 16:12:14 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET
 flash_info fixup_flag
Message-ID: <20211217104212.d37qeyomskjhdtvi@ti.com>
References: <20211209190436.401946-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211209190436.401946-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/21 09:04PM, Tudor Ambarus wrote:
> The Soft Reset and Rescue Sequence Support is defined in BFPT_DWORD(16)
> starting with JESD216A. The first version of SFDP, JESD216 (April 2011),
> defines just the first 9 BFPT DWORDS, thus it does not contain information
> about the Software Reset and Rescue Support. Since this support can not
> be discovered by parsing the first SFDP version, introduce a flash_info
> fixup_flag that will be used either by flashes that define
> JESD216 (April 2011) or by flashes that do not define SFDP at all.
> In case a flash defines BFPT_DWORD(16) but with wrong values, one should
> instead use a post_bfpt() hook and set SNOR_F_SOFT_RESET.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
