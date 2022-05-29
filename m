Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECC1537162
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiE2OlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiE2OlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:41:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E73C71D9C;
        Sun, 29 May 2022 07:41:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v7so430040ilo.3;
        Sun, 29 May 2022 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=F223AO/xfl4kYokCSpptIUPMuRsfYzoSF5Di0AhA78I=;
        b=qCyAslsCLoNXmQpv04ECH4UJtAkuIlU8t1kCpJv9EmSZNN5PVlWPR+hRh5SU+3qW5c
         JdNeziYReSwPGr2RHm0dSOZTk+aEjE35iNSn5AlOWllUwiluA3Tu+vOYv6O2kKUhJQnC
         2eEB7J8yvo1MAHWS1PK8aUdQsly7miIrm0Bqk8ISfboPi/chVRKeLBuQ8Rfm9YgB4P9/
         orqvoy5l8nqiYCOqNRbEwjvyrWK43Ms8JicstB4QfU7H4xkWkRqVcBAXq/QyZMd/Knoj
         WrcRUrPHgZnapnEwBLJdhgi9hf5i7WpDaYlYGyVZ/Cz9PWSIdjNvqrv4Y9ih0F7CF8fS
         nDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=F223AO/xfl4kYokCSpptIUPMuRsfYzoSF5Di0AhA78I=;
        b=Fazgo57UzlEEieVJiHLSfI9rdOdizQY1AGkKeKp7Js/6tXBsxWeBrdyZNOr1hgXTyF
         x0ZtGKHFlp4dXbHiHP8qX+A721DiQ1l9OufFKTP7sIw5y3SNsTPM1ZLnC6FOUZmOzeni
         un1AVcB+jXKBJGvD+mrjYM4S8phI0RQonJJZfM4RFkFAK34pVYQ/VjuwUwT5cN4xcg1X
         LWDBxvKfrhYmXx7SWDQNFwWXiMHFcNn5KwX8Z0U3qBZgYsuSgJDwM0j4NxkFXpc/JleC
         5LzkTqTdKV013koz5qOHalqLfvRLwlWG/gMDHVZT1oLXK93FhWGa6V0qtJ1oFrdWqHa2
         Tf0Q==
X-Gm-Message-State: AOAM5309Lddbmpe67Mh1JFWi8l9g8E6gNMSmWZpszG4Q6gfWB0leJJiJ
        CtYyjIBWFLbP5yorzMYUw+HpadQzBrCxii3N4g1zpscZiyUXhg==
X-Google-Smtp-Source: ABdhPJzNAV07rZFb56SBd/LkA2xYnwwH3V0BXubaXVDWxZgVyyPEYz/Se+7w32XIitrt4Gx7/3ADNZAmlvXZD6+kD28=
X-Received: by 2002:a05:6e02:174f:b0:2d1:3971:9348 with SMTP id
 y15-20020a056e02174f00b002d139719348mr26825448ill.4.1653835276803; Sun, 29
 May 2022 07:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org> <20220528154704.2576290-2-masahiroy@kernel.org>
In-Reply-To: <20220528154704.2576290-2-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 29 May 2022 16:40:41 +0200
Message-ID: <CA+icZUX2k6eB_JfRJ3X3te44nV0CZycpWX5cT1YMPGR1_VrXjg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
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

On Sat, May 28, 2022 at 9:43 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Change the "make clean" rule to remove all the .tmp_* files.
>
> .tmp_objdiff is the only exception, which should be removed by
> "make mrproper".
>
> Rename the record directory of objdiff, .tmp_objdiff to .objdiff to
> avoid the removal by "make clean".
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

When does someone see .objdiff file(s)?

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
( Never seen here. )

-Sedat-

> ---
>
>  Makefile                | 4 ++--
>  scripts/link-vmlinux.sh | 3 ---
>  scripts/objdiff         | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index edc3f44cd96c..7011d43dff35 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1490,7 +1490,7 @@ CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> -                 arch/$(SRCARCH)/include/generated .tmp_objdiff \
> +                 arch/$(SRCARCH)/include/generated .objdiff \
>                   debian snap tar-install \
>                   .config .config.old .version \
>                   Module.symvers \
> @@ -1857,7 +1857,7 @@ clean: $(clean-dirs)
>                 -o -name '*.lex.c' -o -name '*.tab.[ch]' \
>                 -o -name '*.asn1.[ch]' \
>                 -o -name '*.symtypes' -o -name 'modules.order' \
> -               -o -name '.tmp_*.o.*' \
> +               -o -name '.tmp_*' \
>                 -o -name '*.c.[012]*.*' \
>                 -o -name '*.ll' \
>                 -o -name '*.gcno' \
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 844fc0125d72..b593cb1a8137 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -303,9 +303,6 @@ sorttable()
>  cleanup()
>  {
>         rm -f .btf.*
> -       rm -f .tmp_System.map
> -       rm -f .tmp_initcalls.lds
> -       rm -f .tmp_vmlinux*
>         rm -f System.map
>         rm -f vmlinux
>         rm -f vmlinux.map
> diff --git a/scripts/objdiff b/scripts/objdiff
> index 72b0b63c3fe1..68b8d74e5c6f 100755
> --- a/scripts/objdiff
> +++ b/scripts/objdiff
> @@ -32,7 +32,7 @@ if [ -z "$SRCTREE" ]; then
>         exit 1
>  fi
>
> -TMPD=$SRCTREE/.tmp_objdiff
> +TMPD=$SRCTREE/.objdiff
>
>  usage() {
>         echo >&2 "Usage: $0 <command> <args>"
> --
> 2.32.0
>
