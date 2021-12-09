Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D446E5A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhLIJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:35:30 -0500
Received: from elvis.franken.de ([193.175.24.41]:38029 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhLIJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:35:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvFmB-0001l4-00; Thu, 09 Dec 2021 10:31:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0E387C4E1D; Thu,  9 Dec 2021 10:30:02 +0100 (CET)
Date:   Thu, 9 Dec 2021 10:30:01 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     geert@linux-m68k.org
Subject: Re: [PATCH 1/3] MIPS: TXX9: Remove rbtx4938 board support
Message-ID: <20211209093001.GA7077@alpha.franken.de>
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130164558.85584-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:45:54PM +0100, Thomas Bogendoerfer wrote:
> No active MIPS user own this board, so let's remove it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/configs/rbtx49xx_defconfig  |   2 -
>  arch/mips/include/asm/txx9/boards.h   |   3 -
>  arch/mips/include/asm/txx9/rbtx4938.h | 145 ----------
>  arch/mips/include/asm/txx9/spi.h      |  34 ---
>  arch/mips/pci/Makefile                |   1 -
>  arch/mips/pci/fixup-rbtx4938.c        |  53 ----
>  arch/mips/txx9/Kconfig                |  28 --
>  arch/mips/txx9/Makefile               |   1 -
>  arch/mips/txx9/generic/Makefile       |   1 -
>  arch/mips/txx9/generic/setup.c        |   5 -
>  arch/mips/txx9/generic/spi_eeprom.c   | 104 -------
>  arch/mips/txx9/rbtx4938/Makefile      |   2 -
>  arch/mips/txx9/rbtx4938/irq.c         | 157 -----------
>  arch/mips/txx9/rbtx4938/prom.c        |  22 --
>  arch/mips/txx9/rbtx4938/setup.c       | 372 --------------------------
>  15 files changed, 930 deletions(-)
>  delete mode 100644 arch/mips/include/asm/txx9/rbtx4938.h
>  delete mode 100644 arch/mips/include/asm/txx9/spi.h
>  delete mode 100644 arch/mips/pci/fixup-rbtx4938.c
>  delete mode 100644 arch/mips/txx9/generic/spi_eeprom.c
>  delete mode 100644 arch/mips/txx9/rbtx4938/Makefile
>  delete mode 100644 arch/mips/txx9/rbtx4938/irq.c
>  delete mode 100644 arch/mips/txx9/rbtx4938/prom.c
>  delete mode 100644 arch/mips/txx9/rbtx4938/setup.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
