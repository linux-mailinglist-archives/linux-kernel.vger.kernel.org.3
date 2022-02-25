Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58444C3F13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiBYHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiBYHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:33:31 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A225D6F3;
        Thu, 24 Feb 2022 23:32:59 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21P7Vu6H114581;
        Fri, 25 Feb 2022 01:31:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645774316;
        bh=1jhEkkUHjPfXmVDqozvs1ZMseyvKYmDv+DanJ2yLQfg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=u4KS62z8fWz1UQ7srRh4oX1GPiPrzgXvR2Ys9m6s4t2UvOoUSvcPw1s4LOOt7ceX3
         Q9hn3ZnhQX+XsFX9fgCKWkUkoK6aMu5Ita6W9oPoSFyGqTIpCLHo2FdU+x1qb5PZ6r
         +eV6PlHxDi8vKVCizPZ9NOQhLP2o4tGwo/Bb5RKE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21P7VunC068247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 01:31:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 25
 Feb 2022 01:31:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 25 Feb 2022 01:31:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21P7VtmG125179;
        Fri, 25 Feb 2022 01:31:56 -0600
Date:   Fri, 25 Feb 2022 13:01:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
Message-ID: <20220225073155.f2cxfhm7surf34d4@ti.com>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214094231.3753686-2-clg@kaod.org>
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

On 14/02/22 10:42AM, Cédric Le Goater wrote:
> To prepare transition to the new Aspeed SMC SPI controller driver using
> the spi-mem interface, change the kernel CONFIG option of the current
> driver to reflect that the implementation uses the MTD SPI-NOR interface.
> Once the new driver is sufficiently exposed, we should remove the old one.

I don't quite understand the reasoning behind this. Why keep the old 
driver around? Why not directly replace it with the new one? Does the 
new one have any limitations that this one doesn't?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
