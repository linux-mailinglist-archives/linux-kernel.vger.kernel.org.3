Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E85065CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349371AbiDSH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiDSH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:28:47 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B24DECE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:26:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:4e4:402f:1025:9028])
        by xavier.telenet-ops.be with bizsmtp
        id LXS32700R14lGwr01XS3dH; Tue, 19 Apr 2022 09:26:03 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ngiFP-001GdZ-5S; Tue, 19 Apr 2022 09:26:03 +0200
Date:   Tue, 19 Apr 2022 09:26:03 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc3
In-Reply-To: <20220419072058.4015664-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2204190925230.302265@ramsan.of.borg>
References: <CAHk-=wgBR6P8EseYMjfMjxQ_oTpoQmL0qvKpAw04kP-HBgSGFg@mail.gmail.com> <20220419072058.4015664-1-geert@linux-m68k.org>
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

On Tue, 19 Apr 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc3[1] to v5.18-rc2[3], the summaries are:
>  - build errors: +3/-6

   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]:  => 38:37

sparc64/sparc-allmodconfig
sparc64-gcc11/sparc-allmodconfig

   + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 109:1

sparc64-gcc11/sparc-allmodconfig

   + /kisskb/src/sound/oss/dmasound/dmasound_core.c: error: 'dmasound_setup' defined but not used [-Werror=unused-function]:  => 1431:12

m68k-gcc8/m68k-defconfig
m68k-gcc8/m68k-allmodconfig
m68k-gcc11/m68k-defconfig
m68k-gcc11/m68k-allmodconfig

Fix available

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b2d229d4ddb17db541098b83524d901257e93845/ (all 96 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e/ (all 96 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
