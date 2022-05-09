Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7251F845
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiEIJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiEIJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:17:56 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9020B57B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:14:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7048:8ec9:5f5b:8cb])
        by laurent.telenet-ops.be with bizsmtp
        id UZDc2700P1UlgJi01ZDc2B; Mon, 09 May 2022 11:13:37 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nnzSS-003WbP-Ju; Mon, 09 May 2022 11:13:36 +0200
Date:   Mon, 9 May 2022 11:13:36 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc6B
In-Reply-To: <20220509084005.4133902-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2205091113010.840289@ramsan.of.borg>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com> <20220509084005.4133902-1-geert@linux-m68k.org>
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

On Mon, 9 May 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc6[1] to v5.18-rc5[3], the summaries are:
>  - build errors: +1/-0

   + /kisskb/src/crypto/blake2b_generic.c: error: the frame size of 2288 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 109:1

sparc64-gcc11/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a/ (131 out of 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/672c0c5173427e6b3e2a9bbb7be51ceeec78093a/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
