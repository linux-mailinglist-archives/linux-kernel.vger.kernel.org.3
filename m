Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10F46D343
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhLHMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:30:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhLHMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27B01B8206E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD04C00446;
        Wed,  8 Dec 2021 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638966404;
        bh=iFjSFhkXEyxlnYAr/ODxxAw9epQ2Ot80zBQC4xTiaII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQpDeFMp2HkzA2TbniWCOgjE0aMxCmfdey+jmExH0cjDQruwPr81bUsQrD4Mb1zmZ
         GxSlFs+EwjnLgVaWm6Hp47FEL9gH5Q99+apqytCOniHgdqXZnM3jHPDl/48SAzBZAi
         pDLn4hXTu0O+5nTOVPAxHAKNUUJ2fOsdBjQfxYLL83FVaa3CVBaRQFIwlhLzZeFkaV
         WVwDROa+s+VxRTUOvl0eKOT9bkJW5txwHr5YeHBer0+yUkAsmTt9JMy7rZ55wN2y2x
         qh3nqS08euO5Bs6duWo8lodovRK2zn7B75nr0zFp5Lz+qjSS1q5gek7oKILrzEEZTv
         kXolHs/lDoNuQ==
Date:   Wed, 8 Dec 2021 21:26:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] ARM: kprobes: Make a frame pointer on
 __kretprobe_trampoline
Message-Id: <20211208212638.e269d1282175c1b51014cc1e@kernel.org>
In-Reply-To: <CAK8P3a1m01-BZRjtMwV3qPbx0H9SyuL0BgLvTXbHMxdgN1Ky9Q@mail.gmail.com>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477772593.264901.7405996794526239017.stgit@devnote2>
        <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
        <CAMj1kXF3ZQ__trDo4PDfBmJsNoiqBkNB2CLK5pTFARTEYzDOzw@mail.gmail.com>
        <CAK8P3a1m01-BZRjtMwV3qPbx0H9SyuL0BgLvTXbHMxdgN1Ky9Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 13:08:46 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sat, Dec 4, 2021 at 9:45 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Does this help?
> 
> Yes, this fixes it, thanks for the quick help!

Thanks Ard and Arnd!
BTW, would you know what kconfig item warns this issue, or is it only
with gcc-11?
I would like to build the same environment.

Thank you,


> 
>        Arnd


-- 
Masami Hiramatsu <mhiramat@kernel.org>
