Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D84B4C68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349428AbiBNKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:41:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiBNKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:43 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CD71CA5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:03:05 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8c73:faf1:1d11:4a47])
        by xavier.telenet-ops.be with bizsmtp
        id uy2z2600Q3BmCM301y2zvS; Mon, 14 Feb 2022 11:02:59 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJYCB-000kAi-A6; Mon, 14 Feb 2022 11:02:59 +0100
Date:   Mon, 14 Feb 2022 11:02:59 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v5.17-rc4
In-Reply-To: <20220214093704.1773948-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2202141102110.177467@ramsan.of.borg>
References: <20220214093704.1773948-1-geert@linux-m68k.org>
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

On Mon, 14 Feb 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.17-rc4[1] to v5.17-rc3[3], the summaries are:
>  - build errors: +1/-0

   + error: arch/powerpc/kvm/book3s_64_entry.o: relocation truncated to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common' defined in .text section in arch/powerpc/kernel/head_64.o:  => (.text+0x3ec)

powerpc-gcc5/powerpc-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/754e0b0e35608ed5206d6a67a791563c631cec07/ (all 99 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/dfd42facf1e4ada021b939b4e19c935dcdd55566/ (all 99 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
