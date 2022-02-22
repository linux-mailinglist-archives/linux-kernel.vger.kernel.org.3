Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEF4BF3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiBVIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiBVIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:48:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A51A4190;
        Tue, 22 Feb 2022 00:47:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMQpn-0001CP-02; Tue, 22 Feb 2022 09:47:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 300C3C2609; Tue, 22 Feb 2022 09:46:15 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:46:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: remove asm/war.h
Message-ID: <20220222084615.GC7049@alpha.franken.de>
References: <20220218100441.81944-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218100441.81944-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:04:39AM +0100, Thomas Bogendoerfer wrote:
> The major part for workaround handling has already moved to config
> options. This change replaces the remaining defines by already
> available config options and gets rid of war.h
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/Kconfig                  | 38 ++++++++++++++++
>  arch/mips/include/asm/futex.h      |  1 -
>  arch/mips/include/asm/mipsmtregs.h |  1 -
>  arch/mips/include/asm/mipsregs.h   |  1 -
>  arch/mips/include/asm/war.h        | 73 ------------------------------
>  arch/mips/kernel/entry.S           |  1 -
>  arch/mips/kernel/genex.S           |  1 -
>  arch/mips/kernel/r4k-bugs64.c      |  9 ++--
>  arch/mips/kernel/scall32-o32.S     |  1 -
>  arch/mips/kernel/scall64-n64.S     |  1 -
>  arch/mips/kernel/signal.c          |  1 -
>  arch/mips/kernel/signal_n32.c      |  1 -
>  arch/mips/lib/delay.c              |  1 -
>  arch/mips/mm/c-octeon.c            |  1 -
>  arch/mips/mm/c-r4k.c               |  1 -
>  arch/mips/mm/page.c                |  5 +-
>  arch/mips/mm/tlbex.c               |  1 -
>  17 files changed, 47 insertions(+), 91 deletions(-)
>  delete mode 100644 arch/mips/include/asm/war.h

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
