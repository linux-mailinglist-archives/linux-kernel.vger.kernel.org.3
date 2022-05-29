Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC253715F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiE2Oi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiE2Oi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:38:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2BE71D9B;
        Sun, 29 May 2022 07:38:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v7so427762ilo.3;
        Sun, 29 May 2022 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ozCrCopKbo0DwEv7Yq/GTtQoqagjPnE8s0vgVexVARc=;
        b=pddeSOe2cKDs8JAIM8Ezki/L3cd6b0YhLNXlDW7fde5co0nAIW8j2AWc1mFAA0q8H4
         5BGrXeCFdEH3SXnWPFsrctil6SCAXRHwegINozXORJltcGeyFC51BvrZ6qSq751Yy+SJ
         c1xyQTpMbCDUitzxOFVGppJK7bB2PvGGfGbSAeXDJL9GE9yiDfFdI6KZUSSNpDfWRy3S
         ijhIeyLLDgpkxMRwZd1gRCa7CLxAANs4vbI2pEhOg/fCPpbGsgkvFV8wpCc2wqav40go
         03DccMplDmjbGsXHMk8cMjwqnD0hhC4/KmEXS0onE5rPbwe6rqRwyFCEG8GNHfDNmB+b
         AnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ozCrCopKbo0DwEv7Yq/GTtQoqagjPnE8s0vgVexVARc=;
        b=YK54j5OfS4B1HIQNbXWE5aRlt1LxC1XTfVO8Cpb90nZ9bjpNymn/scqe86PfUimC0l
         v9yRq9IoGhBvXLtlQoPHhWDNL/xJpZIoyz7oJ5hDInNU/xI5TGTAt7MbjqpzDK+fTDpv
         kTVEbu9RK9ubMKszrrdS4MfqQ4cNvpwTZUR2Nyu/EtoY9NFdvEpIBBcmy+F763HVKpbY
         /OEKwNz8bExwzrH+yzjndfYP3+P+AWkfZ2Yz/4DEIMLu1VOhjE+fNRyt/3KjjN+AZ9hh
         UR+H3odB5UogcdJxsFF65Si4CG/ue7QPIw6uRDF9jB4jrmfxSwsSI8nCOQBKXlMOIhzI
         x3OQ==
X-Gm-Message-State: AOAM531oCSLEVW8HcrqeKNA/jscLYagQgEoQ7M4iBT5Kot4elQYf86m4
        0lG0pjzXWKisn6s3ka5S+6NtRP5Rubkq/aGEjeDzvBPZ6S3qTw==
X-Google-Smtp-Source: ABdhPJymjW6pU80AWWjDWF5+oslAfWwSZYf/wRQde7Ls4AOkJRfjXGdjSx03QVYwpol3YBcnmV3kkS+Tt4mIYpKxzbg=
X-Received: by 2002:a92:6811:0:b0:2cd:994d:7406 with SMTP id
 d17-20020a926811000000b002cd994d7406mr24939917ilc.245.1653835103129; Sun, 29
 May 2022 07:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
In-Reply-To: <20220528154704.2576290-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 29 May 2022 16:37:47 +0200
Message-ID: <CA+icZUU7zUCD=xrrYLQyKkDMC-Fj-PFcmHbTiPU8ytOpYq8ZDw@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove redundant cleanups in scripts/link-vmlinux.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 10:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> These are cleaned by the top Makefile.
>
> vmlinux.o and .vmlinux.d matches the '*.[aios]' and '.*.d' patterns
> respectively.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I applied this patchset on top of yesterday's kbuild.git#for-next
(today's did not fit due to "kbuild: do not try to parse *.cmd files
for objects provided by compiler").

Might be related to this patchset or not:

$ LC_ALL=C ll .*vmlinux*export*
-rw-r--r-- 1 dileks dileks 4.2K May 29 15:11 ..vmlinux.export.o.cmd
-rw-r--r-- 1 dileks dileks 508K May 29 15:11 .vmlinux.export.c
-rw-r--r-- 1 dileks dileks 2.6M May 29 15:11 .vmlinux.export.o

You see the leading double-dot for ..vmlinux.export.o.cmd - intended or not?

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

> ---
>
>  scripts/link-vmlinux.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a7f6196c7e41..844fc0125d72 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -309,8 +309,6 @@ cleanup()
>         rm -f System.map
>         rm -f vmlinux
>         rm -f vmlinux.map
> -       rm -f vmlinux.o
> -       rm -f .vmlinux.d
>         rm -f .vmlinux.objs
>         rm -f .vmlinux.export.c
>  }
> --
> 2.32.0
>
