Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F847D383
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhLVOT1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 09:19:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59633 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbhLVOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:19:24 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6A7D2200002;
        Wed, 22 Dec 2021 14:19:21 +0000 (UTC)
Date:   Wed, 22 Dec 2021 15:19:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com,
        robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mtd: rawnand: omap2: Select GPMC device driver
 for ARCH_K3
Message-ID: <20211222151919.5d95d72c@xps13>
In-Reply-To: <2b4386a4-0acc-5db1-fc55-b57ad8a84be3@canonical.com>
References: <20211221131757.2030-1-rogerq@kernel.org>
        <20211221131757.2030-5-rogerq@kernel.org>
        <20211221144917.0a5d8f1a@xps13>
        <2b4386a4-0acc-5db1-fc55-b57ad8a84be3@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@canonical.com wrote on Wed, 22 Dec 2021 12:50:18
+0100:

> On 21/12/2021 14:49, Miquel Raynal wrote:
> > Hi Roger,
> > 
> > rogerq@kernel.org wrote on Tue, 21 Dec 2021 15:17:57 +0200:
> >   
> >> The GPMC device driver is required for NAND controller
> >> to work on K3 Architecture. Select it if required.
> >>
> >> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  drivers/mtd/nand/raw/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> >> index 67b7cb67c030..587f20c6184f 100644
> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> @@ -42,6 +42,7 @@ config MTD_NAND_OMAP2
> >>  	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
> >>  	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
> >>  	depends on HAS_IOMEM
> >> +	select OMAP_GPMC if ARCH_K3  
> > 
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >   
> 
> This patch looks actually independent. Miquel, do you want me to take it
> via memory controller drivers tree (like three other patches)?

Yes please, you can take it in your tree, I don't expect any conflicts
in this area.

Thanks,
Miquèl
