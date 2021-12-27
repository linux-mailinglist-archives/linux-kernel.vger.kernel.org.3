Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3EA47FBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhL0KoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhL0KoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:44:05 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397A1C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:44:05 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:dd7:48a2:4f21:80d4])
        by albert.telenet-ops.be with bizsmtp
        id bNk2260010THM2Z06Nk2jY; Mon, 27 Dec 2021 11:44:02 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n1nU1-0079Vm-NX; Mon, 27 Dec 2021 11:44:01 +0100
Date:   Mon, 27 Dec 2021 11:44:01 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v5.16-rc7
In-Reply-To: <20211227083126.1153239-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
References: <20211227083126.1153239-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.16-rc7[1] to v5.16-rc6[3], the summaries are:
>  - build errors: +2/-1

   + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 109:1

sparc64-gcc11/sparc-allmodconfig

   + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10

um-x86_64/um-all{mod,yes}config

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
