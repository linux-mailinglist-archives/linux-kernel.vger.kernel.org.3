Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC84972AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiAWPnW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Jan 2022 10:43:22 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41097 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiAWPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:43:21 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EDAF1FF802;
        Sun, 23 Jan 2022 15:43:19 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:43:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: rawnand: Remove of_get_nand_on_flash_bbt()
 wrapper
Message-ID: <20220123164250.6ff0e49e@xps13>
In-Reply-To: <20220106131610.225661-1-tudor.ambarus@microchip.com>
References: <20220106131610.225661-1-tudor.ambarus@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@microchip.com wrote on Thu, 6 Jan 2022 15:16:09 +0200:

> Remove the wrapper as it hides for no reason what we really want: find an
> of_property. Removing the wrapper makes the code easier to read.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Series applies to nand/next.

Thanks,
Miquèl
