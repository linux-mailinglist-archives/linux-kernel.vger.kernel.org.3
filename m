Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB36482B73
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiABNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:33:05 -0500
Received: from elvis.franken.de ([193.175.24.41]:52758 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbiABNc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:58 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-03; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 785B8C0A4B; Sun,  2 Jan 2022 14:27:57 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:27:57 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-crypto@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     geert@linux-m68k.org
Subject: Re: [PATCH 3/3] MIPS: TXX9: Remove TX4939 SoC support
Message-ID: <20220102132757.GD3468@alpha.franken.de>
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
 <20211130164558.85584-3-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130164558.85584-3-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:45:56PM +0100, Thomas Bogendoerfer wrote:
> After removal of RBTX4939 board support remove code for the TX4939 SoC.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/pci/Makefile                |   1 -
>  arch/mips/pci/pci-tx4939.c            | 107 -----
>  arch/mips/txx9/Kconfig                |   8 -
>  arch/mips/txx9/generic/Makefile       |   1 -
>  arch/mips/txx9/generic/irq_tx4939.c   | 216 ----------
>  arch/mips/txx9/generic/setup_tx4939.c | 568 --------------------------
>  drivers/char/hw_random/Kconfig        |  13 -
>  drivers/char/hw_random/Makefile       |   1 -
>  drivers/char/hw_random/tx4939-rng.c   | 157 -------
>  drivers/mtd/nand/raw/Kconfig          |   2 +-
>  10 files changed, 1 insertion(+), 1073 deletions(-)
>  delete mode 100644 arch/mips/pci/pci-tx4939.c
>  delete mode 100644 arch/mips/txx9/generic/irq_tx4939.c
>  delete mode 100644 arch/mips/txx9/generic/setup_tx4939.c
>  delete mode 100644 drivers/char/hw_random/tx4939-rng.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
