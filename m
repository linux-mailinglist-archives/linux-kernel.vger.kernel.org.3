Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB484631DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhK3LOf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 06:14:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39551 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbhK3LOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:14:33 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B01DF6000C;
        Tue, 30 Nov 2021 11:11:11 +0000 (UTC)
Date:   Tue, 30 Nov 2021 12:11:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] mtd: dataflash: Add device-tree SPI IDs
Message-ID: <20211130121110.6026f788@xps13>
In-Reply-To: <a799095a-e046-ae56-c2db-f527e199b5fb@nvidia.com>
References: <20211119183316.1329089-1-miquel.raynal@bootlin.com>
        <a799095a-e046-ae56-c2db-f527e199b5fb@nvidia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

jonathanh@nvidia.com wrote on Tue, 30 Nov 2021 08:53:08 +0000:

> Hi Miquel,
> 
> On 19/11/2021 18:33, Miquel Raynal wrote:
> > On Mon, 2021-11-15 at 11:36:55 UTC, Jon Hunter wrote:  
> >> Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> >> compatible") added a test to check that every SPI driver has a
> >> spi_device_id for each DT compatiable string defined by the driver
> >> and warns if the spi_device_id is missing. The spi_device_ids are
> >> missing for the dataflash driver and the following warnings are now
> >> seen.
> >>
> >>   WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
> >>   WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,dataflash
> >>
> >> Fix this by adding the necessary spi_device_ids.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>  
> > 
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.  
> 
> 
> Please can you submit as a fix for v5.16? The commit that introduced this is already in the mainline.

Yes of course. Can you resubmit with a Fixes tag?

> 
> Thanks
> Jon
> 


Thanks,
Miquèl
