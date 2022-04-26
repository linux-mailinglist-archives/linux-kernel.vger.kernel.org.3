Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349EC510256
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbiDZQBE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347456AbiDZQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:00:53 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029D387A0;
        Tue, 26 Apr 2022 08:57:45 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id v59so20855303ybi.12;
        Tue, 26 Apr 2022 08:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5UMIziwn3GcEpZ2EHO6PLtQUiahYmzZMqohaqW8D0IA=;
        b=cs/MShqilxyWrHAOk/6Kz5tTAlV7K4w8g4BSaNkIR+mFAJwlBTBPrui9zFJPm85DMH
         XxuaVku0rADvOqS4Ou5DV9jxa85u0Ry86uqSiUAHQQSuJ0oRDWpECyvUnpf5Pz8yIugR
         Ev3LGtuax6+2Se2pFAhCu7FrwxnIp8vrJ9a9GtkLTF3dSDMnH27shm8/cCW2G84b2iBe
         vM1isLxuXFNch+YRc55La1/RnxRxzuGf2aFMn+iHl/UlaX75xSw9GJrEIXMzIfZgDcDc
         18yNKm4LNtkWdwtBsgaYudXp29R8wKdQvyGcRghtjcWYoPv9Xd5rUT0LdqY16Vm85fPO
         6x/A==
X-Gm-Message-State: AOAM531oTbMdDZiC5k1jbZKhtbUOI7c+AV3ai36baVk1OkTRQBjq29kS
        /KE5p6wf55ZCWh6OsZ8gMRF9MK9eMDSlIfTYogo=
X-Google-Smtp-Source: ABdhPJxUaYxafCpZusev8ZL1gpQ6NzaKd7sZu4xO9qFeyZLl82Jn/WlTJdeHg/oFQ7v/wA5nSL29dF8pnpK+e/vn1Og=
X-Received: by 2002:a25:9f8a:0:b0:628:b9f3:6d2f with SMTP id
 u10-20020a259f8a000000b00628b9f36d2fmr21206839ybq.151.1650988664926; Tue, 26
 Apr 2022 08:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
 <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X> <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
 <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com>
 <CAMZ6RqL8G4uVn--Y5pBC+_c9Ex3Sjf8OJuVRwkVFFPwWd_ezLQ@mail.gmail.com> <CAK8P3a1_XoyjOPQ0ghku_QUjUL5V6BK9kSNUXoQj2RYaA=JxFg@mail.gmail.com>
In-Reply-To: <CAK8P3a1_XoyjOPQ0ghku_QUjUL5V6BK9kSNUXoQj2RYaA=JxFg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Apr 2022 00:57:33 +0900
Message-ID: <CAMZ6RqKxog4xS+E_HLQ1jE_s7oK8XfpT++8go6GZ0qS-utOejQ@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 25 Apr 2022 at 17:49, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 25, 2022 at 9:42 AM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Mon. 25 Apr 2022 at 15:50, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Apr 25, 2022 at 8:17 AM Vincent MAILHOL> <mailhol.vincent@wanadoo.fr> wrote:
> > > > When I run W=2, I want to only see the warnings of the file I am
> > > > working on. So I find it useful to fix the W=2 warnings which
> > > > show up when building other files to not get spammed by
> > > > irrelevant issues and to simplify the triage.
> > > >
> > > > My initial message lacked the rationale. I will add additional
> > > > explanations in the v2 of this patch.
> > >
> > > I agree this is worth fixing if we want to make W=2 have any meaning at all.
> > >
> > > Your approach is probably fine. We could try to improve this by comparing
> > > against the list from include/uapi/asm-generic/unistd.h instead of the i386
> > > list. I suppose that would involve rewriting the script into a simpler one,
> > > but I'm not sure if anyone has an interest in working on this.
> >
> > If someone wants to do it, great, but I do not have the
> > confidence to do it myself so I hope you will forgive me for
> > taking a pass here.
>
> Sure, no worries.
>
> > Another alternative I considered was to only call
> > checksyscalls.sh when doing a 'make all'. This way, we keep the
> > warning but people won’t be spammed when building sub projects
> > because the script would not be executed.
>
> Right, I like that as well, one less thing to be done for every
> iterative make as well. The syscall table really doesn't change
> all that much that this needs to be run by most developers.

I send a patch in a new thread to only call the script once:
https://lore.kernel.org/lkml/20220426155229.436681-1-mailhol.vincent@wanadoo.fr/T/#u

If this new patch gets rejected, then I will go back to the
-Wno-unused-macros approach.


Yours sincerely,
Vincent Mailhol
