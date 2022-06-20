Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8FD551271
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiFTISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiFTISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:18:11 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215EDEAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:18:09 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:1949:b867:c4bf:a30a])
        by andre.telenet-ops.be with bizsmtp
        id lLJ72700B3sdbfl01LJ70c; Mon, 20 Jun 2022 10:18:07 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3Cbm-004mYn-VY
        for linux-kernel@vger.kernel.org; Mon, 20 Jun 2022 10:18:06 +0200
Date:   Mon, 20 Jun 2022 10:18:06 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.19-rc3
In-Reply-To: <20220620070218.3038541-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2206201017400.1139962@ramsan.of.borg>
References: <CAHk-=wgErDgDFbU9astx+NTUu_KNi-jgzfF6RGup=cVee6+U=g@mail.gmail.com> <20220620070218.3038541-1-geert@linux-m68k.org>
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

On Mon, 20 Jun 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19-rc3[1] to v5.19-rc2[3], the summaries are:
>  - build errors: +2/-0

   + /kisskb/src/drivers/mfd/asic3.c: error: unused variable 'asic' [-Werror=unused-variable]:  => 941:23
   + /kisskb/src/drivers/tty/serial/sh-sci.c: error: unused variable 'sport' [-Werror=unused-variable]:  => 2655:26

sh4-gcc11/sh-allmodconfig
The second one was seen before.
The fix for both has been available for quite some time.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a111daf0c53ae91e71fd2bfe7497862d14132e3e/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
