Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548A04F8461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbiDGQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbiDGQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:00:08 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D26DD4474;
        Thu,  7 Apr 2022 08:57:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t4so4504728ilo.12;
        Thu, 07 Apr 2022 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hjbjJkN6I4ZX7/zcpEejLYM/M3ygCY/WGZ+BOtWMRk=;
        b=ZBUfLdLfvQL7wOr220bDHIgkknIh+bsgIn6MCD6ymi80T58vUItac3aFlAWbIi13dm
         oCYwuJ5a6iGCGtjmjH5JNMg6lVW0598p7PybLKHEET1/taw9uhIjt5QBR3g+RQjdSD+o
         DbKH9dddxLBBR+ejK4Wcc7HwuorxgOFb5PPTU2Q1BHacFMA1YNzvEJULfDvIMgJe2Tju
         C6ro6RkT2t5Hwt3FYHAM20bKjqL/UAjwiua3CoR3XexHCV0eGGnybywcKQNVZhO/yk1w
         OzQ6iNCxEv8Vr8Qlu1aPkrptS/k2Qwz77Pzz/g8uNEv8B0ofKyFxVPOhZavwpFv88qoQ
         E6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hjbjJkN6I4ZX7/zcpEejLYM/M3ygCY/WGZ+BOtWMRk=;
        b=2ig0/Hl9bydxJTNnJfWGaUksptmhbvToWHU4YmVX81f1LBQ81XI4UcDqTNBTo8ah+a
         biSbBGxxqiTmYNkPeu2+B9jqKwps6xsMZg/avDP7f5gqOrgxRQdoBof9FHYj+kMUiVVH
         I7oAiLstPTwYoLRvX6LWi60Hf0Cl3O/O1VIDJTxEeVzokN1CIYD/HzdsxMnVDVdki+x8
         DYHAHvM39WKhAKi1E3lcWmXuKh4XCDnRzIC3rtVbV1DsmUblc06BPlFdkFEBNOwtxPRd
         USyRtDZvslIqCBVCNm907jvclTXmk7FKvs7o836rWrsXogqMdwQysn+61It4ZePTeqq1
         tKSA==
X-Gm-Message-State: AOAM531NCQ3HxlrFfYSDRXa8RDWj7K37S2G4nWteIAbpIkTSCcsCDHIi
        Nrmf/MET/6rqbWpj/YE4hox6NPgvyCf90TxLOX0=
X-Google-Smtp-Source: ABdhPJxvy0fJPSfu48da3e/8f0cZHIcWxfP5X9jdW4diu1ogsCNK8tPh0Oo0T7Y5fgCVP7oGaHCCz4wGV13xlf8Haio=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr6530308ilb.305.1649347069775; Thu, 07
 Apr 2022 08:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvdH87k2sSy6g3ehkqE8W94wdg-ww9-wS_t9w48Sp55PQ@mail.gmail.com>
 <20220407222341.626d8377@canb.auug.org.au>
In-Reply-To: <20220407222341.626d8377@canb.auug.org.au>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Apr 2022 08:57:38 -0700
Message-ID: <CAEf4BzYCaU9959tYrLSc=kxnJvqg_W_i=AnLWV9m2Fy81Db60A@mail.gmail.com>
Subject: Re: [next] perf build failures: libbpf.c:10946:50: error: format
 '%li' expects argument of type 'long int *', but argument 4 has type 'size_t
 *' {aka 'unsigned int *'} [-Werror=format=]
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        perf-users <perf-users@linaro.org>, lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        NeilBrown <neilb@suse.de>, tanu235m@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 5:23 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Naresh,
>
> On Thu, 7 Apr 2022 15:46:53 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > perf build errors on i386 [1] on Linux next-20220407 [2]
> >
> > usdt.c:1181:5: error: "__x86_64__" is not defined, evaluates to 0
> > [-Werror=undef]
> >  1181 | #if __x86_64__
> >       |     ^~~~~~~~~~
> > usdt.c:1196:5: error: "__x86_64__" is not defined, evaluates to 0
> > [-Werror=undef]
> >  1196 | #if __x86_64__
> >       |     ^~~~~~~~~~
> > cc1: all warnings being treated as errors
>
> Caused by commit
>
>   4c59e584d158 ("libbpf: Add x86-specific USDT arg spec parsing logic")
>
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/values.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/backward-ring-buffer.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/sdt.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/is_printable_array.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/debug.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/fncache.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/bitmap.o
> >   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/machine.o
> > libbpf.c: In function 'attach_uprobe':
> > libbpf.c:10946:50: error: format '%li' expects argument of type 'long
> > int *', but argument 4 has type 'size_t *' {aka 'unsigned int *'}
> > [-Werror=format=]
> > 10946 |         n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
> >       |                                                ~~^          ~~~~~~~
> >       |                                                  |          |
> >       |                                                  long int *
> > size_t * {aka unsigned int *}
> >       |                                                %i
> > cc1: all warnings being treated as errors
>
> Caused by commit
>
>   39f8dc43b7a0 ("libbpf: Add auto-attach for uprobes based on section name")
>

My bad, I'll fix both issues in bpf-next and will send a fix today.
Thanks for letting me know!

> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 2e9a9857569ec27e64d2ddd01294bbe3c736acb1
> >   git_describe: next-20220407
> >   kernel-config: https://builds.tuxbuild.com/27SL0lCnWoPP04Jn8zKQ5nEEX7i/config
> >   target_arch: i386
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
> >
> > [1] https://builds.tuxbuild.com/27SL0lCnWoPP04Jn8zKQ5nEEX7i/
> > [2] https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/2302706510
>
> --
> Cheers,
> Stephen Rothwell
