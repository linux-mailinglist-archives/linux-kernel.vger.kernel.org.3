Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088951D721
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391571AbiEFMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391558AbiEFMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:00:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F344A918
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:57:07 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mqrs9-1o8r8S2abx-00mwN1 for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022
 13:57:05 +0200
Received: by mail-yb1-f178.google.com with SMTP id m190so884450ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:57:05 -0700 (PDT)
X-Gm-Message-State: AOAM532x9jium+iJfrl6mTL2WOFvW664RnwpGTbaMHF2E0FTOeNFGUsP
        Ol+Hq2vFy57QVMVsMG+fatpz+AZwFRkvixUXtYU=
X-Google-Smtp-Source: ABdhPJxRJvVp4WSdDwMumBobaUVH2AKop8JezHcIZ3thL7fqDYwNyZ/neaZTOOGPQg//WN+9ZbOU1lJxM8I51kYcvzY=
X-Received: by 2002:a25:c50a:0:b0:647:b840:df2c with SMTP id
 v10-20020a25c50a000000b00647b840df2cmr1936326ybe.106.1651838224389; Fri, 06
 May 2022 04:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220506091338.GE4031@kadam>
In-Reply-To: <20220506091338.GE4031@kadam>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 13:56:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0DY2b15yyzpwsjOCqOALfTbsmYf1kTnQZF5wPW8mtFbQ@mail.gmail.com>
Message-ID: <CAK8P3a0DY2b15yyzpwsjOCqOALfTbsmYf1kTnQZF5wPW8mtFbQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] uninitialized variables bugs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/1Uq3+YDH0S131NswzFnt0uttIf9AzV+f6Wyn8DwSSkvLyRkQ2B
 KjydhfMR0QYhERCX1makarGN3KCnewpW4Lp4SylbzKyUCwjHB6c9JBmQYEO6CMrV5BD+y/a
 NR25O9ZaAjrPmybBwvsN4k2IjtB9MxU/8N9iEe+n5T2R4k1jxxLfjwg0YENTtfpK52OoW4E
 J8sdlRsL7WozqW8u9nvWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bUfXL/3JsyQ=:QFgPssFkSAi/p9K2i9aR9A
 /caWEQenuhoZgHSivEG5b5SV6WzzwsjR9MZfmXQLuX7+ImJkStpo0SFXELNuH9wJyy3ZTeCHP
 +5OTi9osYeWvR7bfvsWa5myRDqqF+bZVblHlZMI2fgwSlN+wKQgUZq+2PxVLEd+Pb7iSMGWQG
 8jWP23iUlOo3WFLQq+qQPxMb+/uQSXMDa3BtqhIodmhaVS4hV8lmQJNAVd2aDlJNgWjHYHpcg
 KhAIcYPKkv5OnErVv/7CVIG13Swi391BZwgJFXkDp6P9esROXCZ5lnsiWsXjcEaXyG80/9OBz
 QKUNuqEMnNAcNCnSBnYBOaisb4LpOqpK3I6t+PhzD8kTVIWClEY26XncEb9hv1j9Mo6RWn7gm
 aAJdjVsH+P6jSsAvPHl5JsdpXiYoCw3gS6Es+d8TvJBaSdefiQgA5MhV6ZSCKgjKegjgCPDhy
 HRjEYhXwOn6NBCfaxHqYtW96VzDgyWONBh0S6IGQWeE72ATqAW40HohYoZ9bSdb6h4oKkcDat
 hnx91Z+Fd54UglrUXVe7yZTtGdutgJm27G2DWKSI+YRmJC7cZUXMxkrgKs184Okq4msZHfS8B
 ofd/7iNYSBz6VpN3uONAN6a82xszGX9aR/dcmhfkNeV2UEIBSW0DRX9ittw8GYRKK/K4+9FQV
 SMBdgBz6VKC7fJe6qFs5j8S8r4d4O81po5z2D6GGowJoHQWiPoqM/rOkIE2qhw20MXBptx0YB
 DdgWPpw/NB8iSwv0nWPfybEHZCRtNhWOhB7uITsSSgRhQNSuL2qNoutmrfFPowSX6Muyxi6BP
 vTE94eoaZhHoljkrd9uHfCBZ+wJs3ZieBKiIIcxfnHtslXkpAQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 11:13 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

>
> It's frustrating.  Sometimes the false positives are hard to analyse
> because I have to read through multiple functions.  A lot of times
> when I write a patch and a commit message Nathan has already fixed it
> so it's just a waste of time.

Agreed. I'm not actually checking for those warnings on gcc any more,
but just the clang warnings point to a bigger problem.

> It's risky as well.  The Smatch check for uninitialized variables was
> broken for most of 2021.  Nathan sometimes goes on vacation.
>
> I guess I would hope that one day we can turn on the GCC uninitialized
> variable warnings again.  That would mean silencing false positives
> which a lot of people don't want to do...  Maybe Clang has fewer false
> positives than GCC?

I think for the gcc warnings to become useful again, we may have to
wait for a future compiler release. I have not checked gcc-12 for this,
but it's a very old topic.

Fundamentally, it's impossible for any compiler to do this correctly,
because of the halting problem. gcc apparently has some heuristics
that worked well enough in the past, but it misses some obvious
cases and causes false positives in unexpected places, often
depending on optimization flags.

Recent gcc versions are much worse than older ones, since the
inlining changed in a way that caused a ton of false-positives.

clang is generally better at catching the simple cases reliably,
and it does this independent of optimization flags. However, it
stops at the function boundary, so it never catches some of the
cases that gcc was good at.

The gcc static analyzer apparently gained an option[1] that
works similarly to what you have in smatch. I have not tried
using this, but this may be something we can do in CI
systems that may not want to run smatch for some reason.

        Arnd

[1] https://gcc.gnu.org/onlinedocs/gcc-12.1.0/gcc/Static-Analyzer-Options.html#index-Wanalyzer-use-of-uninitialized-value
