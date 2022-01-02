Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA0482B72
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiABNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:33:02 -0500
Received: from elvis.franken.de ([193.175.24.41]:52756 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbiABNc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:56 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-02; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9641AC0A4B; Sun,  2 Jan 2022 14:27:33 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:27:33 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     geert@linux-m68k.org
Subject: Re: [PATCH 2/3] MIPS: TXX9: Remove rbtx4939 board support
Message-ID: <20220102132733.GC3468@alpha.franken.de>
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
 <20211130164558.85584-2-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130164558.85584-2-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:45:55PM +0100, Thomas Bogendoerfer wrote:
> No active MIPS user own this board, so let's remove it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/configs/rbtx49xx_defconfig          |   2 -
>  .../include/asm/mach-tx49xx/mangle-port.h     |   8 -
>  arch/mips/include/asm/txx9/boards.h           |   3 -
>  arch/mips/include/asm/txx9/rbtx4939.h         | 142 -----
>  arch/mips/txx9/Kconfig                        |  12 -
>  arch/mips/txx9/Makefile                       |   1 -
>  arch/mips/txx9/generic/7segled.c              | 123 ----
>  arch/mips/txx9/generic/Makefile               |   1 -
>  arch/mips/txx9/generic/setup.c                |  20 -
>  arch/mips/txx9/rbtx4939/Makefile              |   2 -
>  arch/mips/txx9/rbtx4939/irq.c                 |  95 ---
>  arch/mips/txx9/rbtx4939/prom.c                |  29 -
>  arch/mips/txx9/rbtx4939/setup.c               | 554 ------------------
>  drivers/mtd/maps/Kconfig                      |   6 -
>  drivers/mtd/maps/Makefile                     |   1 -
>  drivers/mtd/maps/rbtx4939-flash.c             | 133 -----
>  16 files changed, 1132 deletions(-)
>  delete mode 100644 arch/mips/include/asm/txx9/rbtx4939.h
>  delete mode 100644 arch/mips/txx9/generic/7segled.c
>  delete mode 100644 arch/mips/txx9/rbtx4939/Makefile
>  delete mode 100644 arch/mips/txx9/rbtx4939/irq.c
>  delete mode 100644 arch/mips/txx9/rbtx4939/prom.c
>  delete mode 100644 arch/mips/txx9/rbtx4939/setup.c
>  delete mode 100644 drivers/mtd/maps/rbtx4939-flash.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
