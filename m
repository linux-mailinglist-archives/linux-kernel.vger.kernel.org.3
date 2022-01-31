Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9BF4A3FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357977AbiAaKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:17:11 -0500
Received: from elvis.franken.de ([193.175.24.41]:48627 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbiAaKRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:17:07 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nETk9-0001MI-00; Mon, 31 Jan 2022 11:17:05 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EEB46C1DA8; Mon, 31 Jan 2022 11:08:45 +0100 (CET)
Date:   Mon, 31 Jan 2022 11:08:45 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix build error due to PTR used in more places
Message-ID: <20220131100845.GA19252@alpha.franken.de>
References: <20220125141946.54114-1-tsbogend@alpha.franken.de>
 <20220130163725.GA2792319@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130163725.GA2792319@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 08:37:25AM -0800, Guenter Roeck wrote:
> On Tue, Jan 25, 2022 at 03:19:44PM +0100, Thomas Bogendoerfer wrote:
> > Use PTR_WD instead of PTR to avoid clashes with other parts.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Building mips:cavium_octeon_defconfig ... failed
> --------------
> Error log:
> arch/mips/cavium-octeon/octeon-memcpy.S: Assembler messages:
> arch/mips/cavium-octeon/octeon-memcpy.S:187: Error: unrecognized opcode `ptr 9b,l_exc'
> ...
> 
> Missed one place in Cavium assembler code.
> 
> arch/mips/cavium-octeon/octeon-memcpy.S:        PTR     9b, handler;
> 
> #regzbot introduced: fa62f39dc7e2

d'oh, fix sent.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
