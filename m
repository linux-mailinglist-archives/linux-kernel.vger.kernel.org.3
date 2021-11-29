Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1567461532
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbhK2Mih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:38:37 -0500
Received: from elvis.franken.de ([193.175.24.41]:48750 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346275AbhK2MgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:36:11 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrfq1-0005Wg-02; Mon, 29 Nov 2021 13:32:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 800BCC2FEA; Mon, 29 Nov 2021 13:32:42 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:32:42 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: CPS: Use bitfield helpers
Message-ID: <20211129123242.GC8232@alpha.franken.de>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
 <8bd8b1b9a3787e594285addcf2057754540d0a5f.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd8b1b9a3787e594285addcf2057754540d0a5f.1637593297.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:53:58PM +0100, Geert Uytterhoeven wrote:
> Use the FIELD_GET() helper, instead of open-coding the same operation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> 
> See "[PATCH 00/17] Non-const bitfield helper conversions"
> (https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
> for background and more conversions.
> ---
>  arch/mips/include/asm/mips-cps.h | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
