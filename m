Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9E4A5905
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiBAJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiBAJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:15:37 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 01:15:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by andre.telenet-ops.be with bizsmtp
        id plFZ2600U2lsq0X01lFZYH; Tue, 01 Feb 2022 10:15:34 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEpG9-00Ch77-GK; Tue, 01 Feb 2022 10:15:33 +0100
Date:   Tue, 1 Feb 2022 10:15:33 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v5.17-rc2
In-Reply-To: <20220131093835.3146981-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2202011014260.3025644@ramsan.of.borg>
References: <20220131093835.3146981-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.17-rc2[1] to v5.17-rc1[3], the summaries are:
>  - build errors: +1/-3

   + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common' defined in .text section in arch/powerpc/kernel/head_64.o:  => (.text+0x3ec)

powerpc-gcc5/powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/26291c54e111ff6ba87a164d85d4a4e134b7315c/ (all 99 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e783362eb54cd99b2cac8b3a9aeac942e6f6ac07/ (all 99 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
