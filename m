Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290A0467886
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381156AbhLCNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:39:42 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60071 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381147AbhLCNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:39:41 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C192C24000C;
        Fri,  3 Dec 2021 13:36:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] mtd: dataflash: Add device-tree SPI IDs
Date:   Fri,  3 Dec 2021 14:36:14 +0100
Message-Id: <20211203133614.1372812-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211130112443.107730-1-jonathanh@nvidia.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'27a030e8729255b2068f35c1cd609b532b263311'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 11:24:43 UTC, Jon Hunter wrote:
> Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> compatible") added a test to check that every SPI driver has a
> spi_device_id for each DT compatiable string defined by the driver
> and warns if the spi_device_id is missing. The spi_device_ids are
> missing for the dataflash driver and the following warnings are now
> seen.
> 
>  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
>  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,dataflash
> 
> Fix this by adding the necessary spi_device_ids.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
