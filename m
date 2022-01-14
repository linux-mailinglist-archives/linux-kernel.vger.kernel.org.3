Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777A148F03E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbiANS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:58:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50034 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237032AbiANS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:58:15 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20EIvnlp024350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:57:50 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B31E215C411B; Fri, 14 Jan 2022 13:57:49 -0500 (EST)
Date:   Fri, 14 Jan 2022 13:57:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeHHrb3RGYxARLCC@mit.edu>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:52:29PM +0100, Geert Uytterhoeven wrote:
> Hi Boris,
> 
> On Fri, Jan 14, 2022 at 3:36 PM Borislav Petkov <bp@alien8.de> wrote:
> > Btw, pls do note that this is removing only the x86 a.out support -
> > other arches (m68k and alpha) still select HAVE_AOUT and thus the
> > respective glue in fs/binfmt_aout.c
> 
> Quoting myself (do I need a canned response for this? ;-):
>    "I think it's safe to assume no one still runs a.out binaries on m68k."
> 
> https://lore.kernel.org/r/CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com/
> https://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com
> 
> Of course, m68k is not encumbered by a.out Netscape binaries, unlike
> ia32 and alpha ;-)

And Alpha's a.out Netscape binary is what required OSF/1 compatible
system calls, so if and when we ever can nuke a.out Alpha support, so
perhaps there might also be an opporunity to remove OSF/1
compatibility support...

						- Ted
