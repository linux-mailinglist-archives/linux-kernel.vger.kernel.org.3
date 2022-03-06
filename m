Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7660B4CEC19
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiCFPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 10:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiCFPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 10:32:53 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4762540928;
        Sun,  6 Mar 2022 07:32:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id t11so14567637ioi.7;
        Sun, 06 Mar 2022 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lTxXsLQ3/sJFqkOXAUPDqcJOvuhEL+3+rvVpOV3yWgw=;
        b=RnGMWIJ3X7XTQvdkajhB5xVRNavoMahZJLBD9vyo0KNzdbWHGQaNf6knBDBoQ55VKT
         F1YZYuOBsKX7jyVBVwT6yyn6ij94uvyHV75j+fGsXYREYMcGkTcobcAkuRiSpWYhyHbj
         4apRIQoLGDHinLIEd+yHG8G1ErdUdvduAtRLBoAmOf3DsWksKa8xDilKfoZNdqxC0urv
         8sYOAwGPAjSknRcnPCgDWuzHcloa4RF3zBgQPUqtiLbF1xLpauScZEhOgHQJQUCzcu13
         1g46ZyUKbOOCasFMGWhP2+Arb1JT/MrH66sT0nJia2yu+1W1ufX86S1zeHHIF+9e8M+O
         HYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lTxXsLQ3/sJFqkOXAUPDqcJOvuhEL+3+rvVpOV3yWgw=;
        b=tGppqTxHMLi1QrCSoiQmmc3yLzTrXPKz6e0P7a0pkiLmrDHdrtFQ5YxZLs5yCcIyV0
         CwGyUDyGGg4SkfrDRDY74susVcc8gZdeZrBD/6Mq+bmvkhsSbocOO6IZB3k1rHuE1cMh
         Eg91o5pK31b2VSCkmc+xpq5CQJUs61L8rG4eQ36aRlP+Ixmmvgz7G6dyoUHIaaLYP57p
         2yBp8zFHDmXAMf7wEGel3n4R4awGkifOMfpTx+qKd0u2CX4He0sew8Ab6sSQRXOnhl1Z
         LrBxV7Z35i3hITzm3fCeyqEbrd+RLQraoIwlbn8/b82mggxQ1CrQ2RVl+eVNwE5QZxQx
         T+IA==
X-Gm-Message-State: AOAM530FfYYbQdazA3wcJiV+/0VQGq7G2KssEAaza6qBI5RPIpPyOHzl
        B2D5h8EnxnS61ojkuGzVaDB6eKFeVJ1lQYW/JH8LRo+GIZDinw==
X-Google-Smtp-Source: ABdhPJyurIugi2NpH/AHJdPJSjrCSnkjk+CgFnV6VItjl+2OHue5fkK5G7G6tY9vo60gMRNBnEb4/q68ZQ/zEQ56f2o=
X-Received: by 2002:a05:6638:168b:b0:314:7a8d:19d4 with SMTP id
 f11-20020a056638168b00b003147a8d19d4mr7354926jat.199.1646580720634; Sun, 06
 Mar 2022 07:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <CA+icZUW8N25F_9_DVhRiQoe6rnvARH2AhKJgjKeYyNmdz5t_Lw@mail.gmail.com>
In-Reply-To: <CA+icZUW8N25F_9_DVhRiQoe6rnvARH2AhKJgjKeYyNmdz5t_Lw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 6 Mar 2022 16:31:24 +0100
Message-ID: <CA+icZUUM1v1FCaJDk1BaRN9+uOQD53r5Rwcv=ESQHhdN9QRedA@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v3] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 4, 2022 at 5:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
[ ... ]
> When I saw the first patches in this area, I was thinking what about
> the tools/ build-system?
> This ECO system has its own rules.
>

My other goal was to build perf with my selfmade or distro LLVM/Clang
and -std=gnu11.

I was able to do so:

$ git log --oneline --no-merges v5.17-rc6..for-5.17/tools-std_gnu11-dileks-v2
2d99b1cfa897 (for-5.17/tools-std_gnu11-dileks-v2) perf: Use -std=gnu11
c345a183c4ef tools: libtraceevent: Use -std=gnu11
26f77082f233 tools: libsubcmd: Use -std=gnu11
aaba58ec81c8 tools: libbpf: Use -std=gnu11
ffc800af3be4 tools: libapi: Use -std=gnu11

For perf/libperl-support I needed an extra patch:

$ git log --oneline --no-merges
v5.17-rc6..for-5.17/perf-libperl_support-clang-dileks
316a1917ec05 (for-5.17/perf-libperl_support-clang-dileks) perf: Fix
libperl support with clang and perl v5.34

For details see [1].

I can send the patches if someone wants them.

[1] https://marc.info/?t=164646683300002&r=1&w=2
