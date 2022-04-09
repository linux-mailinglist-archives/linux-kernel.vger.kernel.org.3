Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828A44FAB18
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiDIW6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiDIW6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 18:58:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773DB2DF5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 15:55:53 -0700 (PDT)
Received: from zn.tnic (p200300ea9715615c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:615c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 062741EC0374;
        Sun, 10 Apr 2022 00:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649544948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xIT9zTmzXlnnxsXpoina8IMgsOJaNX9T9llrfoqzbJc=;
        b=Hx8vWy8fQ1TynGbMxVT1gC76URc1gSq+hqnpzxCRyS4nShhLHNJo+p46T1TWum/hJSZsg7
        OJ5yAxkmwNMI5fJ2G1aqoymPuqs5CFB9/uGrIiv4wFhcC4kPvw1D4pNRxblc4yu7ulMUSl
        tABRoioVAaqb1sNkA6JfNDG7rUMCYIk=
Date:   Sun, 10 Apr 2022 00:55:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     NULL <ayz.out@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, x86@kernel.org, arnd@arndb.de,
        Kees Cook <keescook@chromium.org>
Subject: Re: Request: Regarding the phasing out of "a.out support" in Linux
 Kernels
Message-ID: <YlIO8GbSYN9xANnb@zn.tnic>
References: <CADt9uBkMkrywjSo_jyUJtS85ATTQtRTVXPRsRVUKZpujYo9SUQ@mail.gmail.com>
 <YlGoOXoBaW8i1xrt@zn.tnic>
 <CADt9uBnKs9p5BP6qF8+v+gQ8Pe7S10_CSiFLAr9GyBWnftGqUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADt9uBnKs9p5BP6qF8+v+gQ8Pe7S10_CSiFLAr9GyBWnftGqUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Readding back previous recipients. ]

On Sat, Apr 09, 2022 at 05:16:52PM +0100, NULL wrote:
> Thank you for your reply, I was hoping more that the 327 aout.o lines would
> remain in makefile & arch /ia32/ia32_aout.c for 5.19 (even if ignored by
> default KConfig flags as a test to see if it would break anything for
> other) as opposed to the currently proposed PR.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/diff/?h=x86/cleanups&id=f9444ea5e20847d1dd4a98d4dff4cc97655834bb
> 
>  Essentially just asking for 5.19 to announce the proposed removal & to
> hold/push the ia32 commits back by one or two releases, With complete
> removal of all the code only occurring in 5.21's Release.

First of all, please hit "reply-to-all" when replying to a mail on a
public mailing list so that others can see the conversation too and can
participate, if they wish.

Then, it is kinda hard to take you seriously if your name is "NULL" or
"Non Null". If I'm using my real name - you could too.

Furthermore, you haven't given any concrete reason why you'd need this
except maybe something along the lines that it might be good to have it
in an LTS release. And that's not nearly a good reason to keep ancient
code which no one uses and which current toolchains can't even produce.

If you've followed the previous discussions, there was a pretty simple
ELF loader posted for a.out executables so it's not like there are no
alternatives. You can also run an older kernel in a VM. And so on...

Finally, pls do not top-post but put your reply underneath the next
you're commenting on like I just did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
