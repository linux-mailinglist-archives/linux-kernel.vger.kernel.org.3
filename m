Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2747C118
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhLUN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:58:03 -0500
Received: from elvis.franken.de ([193.175.24.41]:58830 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhLUN6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:58:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mzfeR-0000gu-00; Tue, 21 Dec 2021 14:57:59 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 855FBC09B7; Tue, 21 Dec 2021 14:56:39 +0100 (CET)
Date:   Tue, 21 Dec 2021 14:56:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-mips@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Support MT SMP on generic MIPS kernel
Message-ID: <20211221135639.GA9153@alpha.franken.de>
References: <20211218100511.42508-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218100511.42508-1-sander@svanheule.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 11:05:09AM +0100, Sander Vanheule wrote:
> These patches should allow a generic kernel to enable MT SMP, if
> supported by the current CPU.
> 
> Changes since v1:
> Link: https://lore.kernel.org/all/20211217183930.16192-1-sander@svanheule.net/
> - Add patch suggested by Jiaxun
> 
> Sander Vanheule (2):
>   MIPS: only register MT SMP ops if MT is supported
>   MIPS: generic: enable SMP on SMVP systems
> 
>  arch/mips/generic/init.c        | 11 ++++++-----
>  arch/mips/include/asm/smp-ops.h |  3 +++
>  2 files changed, 9 insertions(+), 5 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
