Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD14C6E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiB1NaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiB1NaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:30:13 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44A7B54F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:29:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a4f2:4931:edd0:99e3])
        by michel.telenet-ops.be with bizsmtp
        id 0dVW2700W5QlnJa06dVWy5; Mon, 28 Feb 2022 14:29:31 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nOg5i-002DyN-Di; Mon, 28 Feb 2022 14:29:30 +0100
Date:   Mon, 28 Feb 2022 14:29:30 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc6
In-Reply-To: <20220228092810.815034-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2202281425430.530334@ramsan.of.borg>
References: <20220228092810.815034-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.17-rc6[1] to v5.17-rc5[3], the summaries are:
>  - build errors: +1/-2

   + error: verifier.c: relocation truncated to fit: R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x10228)

nds32le-gcc8/nds32-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3/ (all 99 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/cfb92440ee71adcc2105b0890bb01ac3cddb8507/ (all 99 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
