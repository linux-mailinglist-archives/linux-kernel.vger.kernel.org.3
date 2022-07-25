Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FE5805D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiGYUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiGYUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:39:26 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705A22BF0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:39:25 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id zYfN2700F4C55Sk01YfNAN; Mon, 25 Jul 2022 22:39:23 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oG4rK-005GYD-Hj; Mon, 25 Jul 2022 22:39:22 +0200
Date:   Mon, 25 Jul 2022 22:39:22 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v5.19-rc8
In-Reply-To: <20220725203417.3446690-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2207252237200.1255142@ramsan.of.borg>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com> <20220725203417.3446690-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19-rc8[1] to v5.19-rc7[3], the summaries are:
>  - build errors: +1/-5

   + /kisskb/src/include/ufs/ufshci.h: error: initializer element is not constant:  => 245:36

v5.19-rc8/powerpc-gcc5/ppc64_book3e_allmodconfig
v5.19-rc8/powerpc-gcc5/powerpc-allmodconfig
v5.19-rc8/powerpc-gcc5/ppc64le_allmodconfig

Seen before

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e0dccc3b76fb35bb257b4118367a883073d7390e/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ff6992735ade75aae3e35d16b17da1008d753d28/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
