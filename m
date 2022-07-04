Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C32564F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGDIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGDILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:51 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04038A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:50 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id qwBo2700N4C55Sk06wBoqu; Mon, 04 Jul 2022 10:11:48 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o8HBM-001yB6-Cx
        for linux-kernel@vger.kernel.org; Mon, 04 Jul 2022 10:11:48 +0200
Date:   Mon, 4 Jul 2022 10:11:48 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.19-rc5
In-Reply-To: <20220704075036.3568980-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2207041010410.469588@ramsan.of.borg>
References: <CAHk-=wgAOr-+OWLGo+aCMjGWiJ8xMYXUm0v5f-G+eizmPa3kKw@mail.gmail.com> <20220704075036.3568980-1-geert@linux-m68k.org>
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

On Mon, 4 Jul 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19-rc5[1] to v5.19-rc4[3], the summaries are:
>  - build errors: +1/-0

   + /kisskb/src/drivers/mfd/asic3.c: error: unused variable 'asic' [-Werror=unused-variable]:  => 941:23

sh4-gcc11/sh-allyesconfig (fix available in akpm/mm-hotfixes-stable)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/88084a3df1672e131ddc1b4e39eeacfd39864acf/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/03c765b0e3b4cb5063276b086c76f7a612856a9a/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
