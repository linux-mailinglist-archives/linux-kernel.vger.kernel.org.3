Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF34F4DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582841AbiDEXuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349719AbiDEJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:51:05 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267EDF87
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:49:06 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id t19so10135578qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98e9JuWzU+E3aW1OxhH7dluXsgHcJP+pexJl+baDgqc=;
        b=SBhCMA2CzgTaVDcN5KVxIl6GRs+BMpDp2DF3RBP/JLfVcW+p+GXn+pc/c78kNcCDU7
         yfH2NfqOwnho4I08xsg4bG95hKAjhdtYUaLxrT1QQamrkxMeKGiaYcrVQ1YmrGtzjCLy
         VnhYcyqP+9PtgYG3xsGaAw5la7DrJQKH71eeQRvAfxC0udNVXH1h9qvPG4BxbaG1wmCc
         GzLuEfxMfiBUGx3fMPaICag4IEjJIUeyRrt1QrfG0kGr9dLTg4QYA9bCfkU5oglK4hiy
         WCgr36YOzEYqXM3KkMetFipUmk92QSxTAOLF1uMX49XQfOEs3/yAkebX5Fj7D0+v0kYA
         /cuA==
X-Gm-Message-State: AOAM533socbl90J5g+gE29LTw3YzsE+tJEi3mOu3gJbnGSSGYJ8z5Tkn
        a+9OYIWGF87o4ULXWB1zAvkukBloT9PuHw==
X-Google-Smtp-Source: ABdhPJyp1F4sw9N5wd2Icf9Y7PVJqhy6aQag1BkceMv3PWuQQK+p+A2Dexoq4O/X6ow4iWJkcmK8rA==
X-Received: by 2002:a05:620a:ccb:b0:67b:3191:c635 with SMTP id b11-20020a05620a0ccb00b0067b3191c635mr1499452qkj.285.1649152145362;
        Tue, 05 Apr 2022 02:49:05 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h206-20020a379ed7000000b0067b5192da4csm7683331qke.12.2022.04.05.02.49.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:49:05 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id f38so22374966ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:49:04 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr1849700yba.393.1649152144476;
 Tue, 05 Apr 2022 02:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190617142156.2526-1-geert+renesas@glider.be>
 <20190617155633.GA3927@kernel.org> <c0fcd807-abf1-c7b1-4601-e0e46b0199b4@linux.intel.com>
In-Reply-To: <c0fcd807-abf1-c7b1-4601-e0e46b0199b4@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 11:48:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUn7rLBS6rpC5vMbrJzwtd0heU-EBdyWNpVy+FZyyoQwg@mail.gmail.com>
Message-ID: <CAMuHMdUn7rLBS6rpC5vMbrJzwtd0heU-EBdyWNpVy+FZyyoQwg@mail.gmail.com>
Subject: Re: [PATCH trivial] perf vendor events intel: Assorted style fixes
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:10 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 6/17/2019 11:56 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 17, 2019 at 04:21:56PM +0200, Geert Uytterhoeven escreveu:
> >>    - Do not use apostrophes for plurals,
> >>    - Insert commas before "and",
> >>    - Spelling s/statisfied/satisfied/.
> >
> > I think these files are generated from some other material from Intel,
> > i.e. if they update something somewhere else and regenerate those files,
> > your changes would be lost, right Andi, Kan? (Adding them to the CC list).
> >
>
> Yes, they are generated from JSON files in
> https://download.01.org/perfmon/
>
> I will forward the patch to our internal team to check the issues in
> JSON file.

The auto-generated files have been updated, the issues still exist.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
