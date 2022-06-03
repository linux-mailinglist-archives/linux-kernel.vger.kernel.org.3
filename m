Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5553CA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbiFCNX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiFCNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:23:26 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282EA2DAB2;
        Fri,  3 Jun 2022 06:23:24 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 253DN7xf004560;
        Fri, 3 Jun 2022 22:23:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 253DN7xf004560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654262588;
        bh=4+ITmI1zKvhMbZyJVLZqniddrIaJvXXjUmwoleE7riY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x8Ws7WqyU1OhE2RIpNETFM5COUYoTEebhNi15huLjkWV+gSSxXN+4z8T5mPl9J7R+
         i48f1dILT5TXdI1fd3WZ81pzntZe4HS3LVkR/NZb7uaOVqt6xjL5ei4T938/mpDFZo
         /Ms7n8pvnLiNpPoAX2YgA6pBpyGaN3+78felucMMnas27ZEPtB2BlusCAQidH+3RAk
         OCvgL3mb8LgQT0c8pdYbOSBeEXZSI3XrzXmlBFMXxzFKIihj6OWvwTuFXD4l3Rf7nS
         ItkRnUn3BT7ehBbYUi5vqtEvfgdbeBRxzmYdSI/A+pcpHLN1eWyzVHmCPZwhXWmNJz
         JahJFP1flXnDg==
X-Nifty-SrcIP: [209.85.210.171]
Received: by mail-pf1-f171.google.com with SMTP id 187so7175462pfu.9;
        Fri, 03 Jun 2022 06:23:07 -0700 (PDT)
X-Gm-Message-State: AOAM532rtMbpCc0jA1gDyeuZpuFsZ7vr/xkN8jDMCYMj3OwxFa41RFMS
        AljD5/q1jiLjpBylU4DqIYXhiZVUz8bWc//6dW8=
X-Google-Smtp-Source: ABdhPJxUPOKpkSIjzn62Y45WL2Sdi1QJP9qXW5fKZAfmIgHKH5PnxnhVd37/SECcpSAqAKQsw5KKVW6XsC7T6UVxlUA=
X-Received: by 2002:a05:6a00:a01:b0:51b:51d8:3c2a with SMTP id
 p1-20020a056a000a0100b0051b51d83c2amr10611413pfh.68.1654262586816; Fri, 03
 Jun 2022 06:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-2-masahiroy@kernel.org> <YpfC42gQGDJiMMNT@bergen.fjasle.eu>
In-Reply-To: <YpfC42gQGDJiMMNT@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 3 Jun 2022 22:22:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcJ903mM+XRGGWzdayDsk5vz6R1BVpe0vi_sqGDxygQg@mail.gmail.com>
Message-ID: <CAK7LNAQcJ903mM+XRGGWzdayDsk5vz6R1BVpe0vi_sqGDxygQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 4:50 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sun 29 May 2022 00:47:02 +0900, Masahiro Yamada wrote:
> > Change the "make clean" rule to remove all the .tmp_* files.
> >
> > .tmp_objdiff is the only exception, which should be removed by
> > "make mrproper".
> >
> > Rename the record directory of objdiff, .tmp_objdiff to .objdiff to
> > avoid the removal by "make clean".
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                | 4 ++--
> >  scripts/link-vmlinux.sh | 3 ---
> >  scripts/objdiff         | 2 +-
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> >
> ...
> > diff --git a/scripts/objdiff b/scripts/objdiff
> > index 72b0b63c3fe1..68b8d74e5c6f 100755
> > --- a/scripts/objdiff
> > +++ b/scripts/objdiff
> > @@ -32,7 +32,7 @@ if [ -z "$SRCTREE" ]; then
> >       exit 1
> >  fi
> >
> > -TMPD=$SRCTREE/.tmp_objdiff
> > +TMPD=$SRCTREE/.objdiff
> >
> >  usage() {
> >       echo >&2 "Usage: $0 <command> <args>"
>
> scripts/objdiff still has two occurrences of .tmp_objdiff (in the
> comment block at the top).


Ah, thank you for catching it.
I sent a fixup.


-- 
Best Regards
Masahiro Yamada
