Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E514B47AA06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhLTNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:00:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50664 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLTNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:00:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKCxpmI023603;
        Mon, 20 Dec 2021 06:59:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640005191;
        bh=hMVOqmAJZbsyb3QBuNTaaQMcPGqxuuGKv7gUTecph3w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iBewReKsviy9/YTyjKmwvwR+A5fp89CHBX9Bng4wyjEiyOB9XaHGX1E7mhJORtLZ4
         3pQoDoHBIbeXZNpVK/t+h7u4BWfVx2T2FE3Woee++OBip761lwFL5VmOfcJwDpSudU
         7nSXc6hrQS+0A3AZXFamyey+VMv4duo7Fu2SXuc8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKCxpE1039047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 06:59:51 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 06:59:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 06:59:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKCxoIu123519;
        Mon, 20 Dec 2021 06:59:50 -0600
Date:   Mon, 20 Dec 2021 18:29:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Remove debugfs entries that duplicate
 sysfs entries
Message-ID: <20211220125947.vkcslquovvm432qy@ti.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
 <20211217122636.474976-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217122636.474976-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/21 02:26PM, Tudor Ambarus wrote:
> SPI NOR sysfs defines partname and jedec_id device attributes, which
> duplicate the information from debugfs. Since the sysfs directory
> structure and the attributes in each directory define an ABI between the
> kernel and user space, thus it can never be removed, remove the debugfs
> entries so that we don't duplicate the information.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
