Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345EC462FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhK3Jgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:36:53 -0500
Received: from elvis.franken.de ([193.175.24.41]:50764 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235138AbhK3Jgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:36:52 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrzVz-00063t-00; Tue, 30 Nov 2021 10:33:31 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1216FC2FF1; Tue, 30 Nov 2021 10:32:52 +0100 (CET)
Date:   Tue, 30 Nov 2021 10:32:51 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: Let MACH_TX49XX select BOOT_ELF32
Message-ID: <20211130093251.GA9308@alpha.franken.de>
References: <de47b857667a73d205b20d419f4aebaa2a885484.1638210176.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de47b857667a73d205b20d419f4aebaa2a885484.1638210176.git.geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:57:14PM +0100, Geert Uytterhoeven wrote:
> Some bootloaders (e.g. VxWorks 5.5 System Boot) on TX49 systems do not
> support loading 64-bit kernel images.  Work around this by selecting
> BOOT_ELF32, to support running both 32-bit ("vmlinux" with
> CONFIG_32BIT=y) and 64-bit ("vmlinux.32" with CONFIG_64BIT=y) Linux
> kernels on TX49 devices with such a boot loader.
> 
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on RBTX4927, running a Debian jessie 32-bit mipsel nfsroot userland, and
> some 32-bit and 64-bit test binaries.
> ---
>  arch/mips/txx9/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
> index 85c4c121c71f72d9..00f6fc446abeefe8 100644
> --- a/arch/mips/txx9/Kconfig
> +++ b/arch/mips/txx9/Kconfig
> @@ -6,6 +6,7 @@ config MACH_TX39XX
>  
>  config MACH_TX49XX
>  	bool
> +	select BOOT_ELF32
>  	select MACH_TXX9
>  	select CEVT_R4K
>  	select CSRC_R4K
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
