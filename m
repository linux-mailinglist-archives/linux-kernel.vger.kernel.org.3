Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ECF49DC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiA0If7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:35:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:42276 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbiA0If4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:35:56 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nD0G2-0001fL-00; Thu, 27 Jan 2022 09:35:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 74677C117C; Thu, 27 Jan 2022 09:10:13 +0100 (CET)
Date:   Thu, 27 Jan 2022 09:10:13 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix build error due to PTR used in more places
Message-ID: <20220127081013.GA6362@alpha.franken.de>
References: <20220125141946.54114-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125141946.54114-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:19:44PM +0100, Thomas Bogendoerfer wrote:
> Use PTR_WD instead of PTR to avoid clashes with other parts.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/include/asm/asm.h            |   4 +-
>  arch/mips/include/asm/ftrace.h         |   4 +-
>  arch/mips/include/asm/r4kcache.h       |   4 +-
>  arch/mips/include/asm/unaligned-emul.h | 176 ++++++++++++-------------
>  arch/mips/kernel/mips-r2-to-r6-emul.c  | 104 +++++++--------
>  arch/mips/kernel/r2300_fpu.S           |   6 +-
>  arch/mips/kernel/r4k_fpu.S             |   2 +-
>  arch/mips/kernel/relocate_kernel.S     |  22 ++--
>  arch/mips/kernel/scall32-o32.S         |  10 +-
>  arch/mips/kernel/scall64-n32.S         |   2 +-
>  arch/mips/kernel/scall64-n64.S         |   2 +-
>  arch/mips/kernel/scall64-o32.S         |  10 +-
>  arch/mips/kernel/syscall.c             |   8 +-
>  arch/mips/lib/csum_partial.S           |   4 +-
>  arch/mips/lib/memcpy.S                 |   4 +-
>  arch/mips/lib/memset.S                 |   2 +-
>  arch/mips/lib/strncpy_user.S           |   4 +-
>  arch/mips/lib/strnlen_user.S           |   2 +-
>  18 files changed, 185 insertions(+), 185 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
