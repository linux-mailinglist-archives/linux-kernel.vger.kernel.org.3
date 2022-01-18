Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7532492ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348932AbiART7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:59:44 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38966 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348062AbiART7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:59:41 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BA29492009C; Tue, 18 Jan 2022 20:59:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AEA7992009B;
        Tue, 18 Jan 2022 19:59:39 +0000 (GMT)
Date:   Tue, 18 Jan 2022 19:59:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
In-Reply-To: <CAMuHMdU94tk5pcTK4Fa-g9vm56oooCeWXkkL8nOgofk5aKbwig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2201090221150.56863@angie.orcam.me.uk>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com> <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com> <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com> <20211129122052.GA7921@alpha.franken.de>
 <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com> <20211129130535.GA8644@alpha.franken.de> <CAMuHMdU94tk5pcTK4Fa-g9vm56oooCeWXkkL8nOgofk5aKbwig@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> Took me a bit to test proper operation, as contemporary cross-toolchains
> create userland binaries that can no longer run on MIPS-II/III CPUs,
> and native development is slow and memory-constrained (dpkg OOM)...

 You mean cross-toolchains included with (some) distributions, right?

 I do hope so or otherwise I'd be very concerned.  Myself I've been using 
a self-built MIPS cross-compiler, running on POWER9, which builds MIPS I 
binaries just fine, e.g.:

$ file install/usr/sysroot/{lib/ld-2.32.9000.so,usr/bin/gdbserver}
install/usr/sysroot/lib/ld-2.32.9000.so: ELF 32-bit LSB pie executable, MIPS, MIPS-I version 1 (SYSV), dynamically linked, with debug_info, not stripped
install/usr/sysroot/usr/bin/gdbserver: ELF 32-bit LSB executable, MIPS, MIPS-I version 1 (GNU/Linux), dynamically linked, interpreter /lib/ld.so.1, for GNU/Linux 3.2.0, not stripped
$ install/usr/bin/mipsel-linux-gnu-gcc -dumpversion
11.0.0
$ 

(time to upgrade perhaps).

  Maciej
