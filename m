Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B74D11FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbiCHIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiCHIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:20:34 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0A3EF0C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:19:37 -0800 (PST)
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDQqk-1nH5kJ0ReA-00AVFh; Tue, 08 Mar 2022 09:19:33 +0100
Received: by mail-wm1-f50.google.com with SMTP id q20so8300098wmq.1;
        Tue, 08 Mar 2022 00:19:33 -0800 (PST)
X-Gm-Message-State: AOAM531jGnYDzGy0tgmqsz8YiU66mxNVIfktW0idKpU/Pr+qls9YoKjQ
        CjkIaf+8HdIEElG3mQYV+p1QqMn+LDyds7SwWEQ=
X-Google-Smtp-Source: ABdhPJy3brkt9uo9Q5o03ssSuLxoPFwO5qVCCm/59VQcNJT+nLgFYrX/h0mYQSB3s/mvNn3/m0fMo2z4VwgAr+k4v+o=
X-Received: by 2002:a05:600c:3b89:b0:389:a466:43bf with SMTP id
 n9-20020a05600c3b8900b00389a46643bfmr2460412wms.1.1646727572620; Tue, 08 Mar
 2022 00:19:32 -0800 (PST)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org>
In-Reply-To: <Yib9F5SqKda/nH9c@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Mar 2022 09:19:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
Message-ID: <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1QIVENilavwLk2UjvuhOBsxHDfPM3lMu4i0t9qV5UGcPGcFuKVg
 8MND9UOh+7Dg8yE9pi/JYI3hXXwHvtqPVpj7jJVExkyKGAzHq+yViBOmQMP/p7kxWm9I+Mm
 To5S3cXxHcLLD/nRtekxSWbGWDOVXBK+2H1n/Alfx9yDX+j555P2eebWeAQneNDvYKnmi98
 qrzStheJb2RRuhO8wzDFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ChVpNRR6khc=:Epb4Zhwk6ut2R6JD4D7fMK
 MraZahfETrh0Mh1JEEaO5Ds51fEK9TlWkjM8xzxSr6v9f3o0iT6AcV10wqZ3ETKugrOMUQoE/
 b5m+GxwjPKQloKK6APPrPDjKDosxq7UP4Vs+e8Wg8/lqNH2n2sz1O0xW0et18Jq06ichchWKx
 kNX8R4Tl2oqvF7PULWJDa0oIIHv+XgHxPqWs9glqb7lZ1M9PELUmMPfdo8DioDrJUC/WgQPJE
 c8hFmOWI3O1Ram7jGxnpioBTdBp3uKHVv3Z0b1cRbK4w9+SecVHLL3sbn/4fk6PC+hYHJcghF
 TWUOtlKmpsbpuJprB6jbQGVuSbo/b9E1fQF5glcOnjj+k0DOmE2ylUy+7zHSSZbqLs0CKIK55
 T3qrd7xwu3fbEcTstTQ9rLWRRgSVg6BPP1nUMnilE3xfBrrqNlHlaTtrZPvu3VqN/VQ2BiGP5
 FAWvSSXoPp9z7y+Aa87KH4AcXhVhaIj2uPGIER+BsU2o7xXUO5UEG5r0+zI2ash0Io+cUjhDq
 UhgSehXM7SKsdL1ItoloP2hMIn4cgJeokwVMnRie02OvPJDZRbpEBxnUHRaHxF4DFod/dF9KZ
 v/suxfAHVsXZ4iwh+d1xfcGO9fDQ//UiyPi5vpq0v/pdPblGtoFqQa5qo2PhK5QAXx/jC4JqX
 msGjz3NMySfWgnZrK6EK97DQlGrr5rW9MSzGUz/O2kLoKZxtTk4p5Ck7IVaGaLEDSWaI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 7:52 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Hi all,
>
> h8300 hasn't been maintained for quite a while, with even years old
> pull request lingering in the old repo.  Given that it always was
> rather fringe to start with I'd suggest to go ahead and remove the
> port:
>
> The following changes since commit 5c1ee569660d4a205dced9cb4d0306b907fb7599:
>
>   Merge branch 'for-5.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2022-02-22 16:14:35 -0800)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/hch/misc.git remove-h8300
>
> for you to fetch changes up to 1c4b5ecb7ea190fa3e9f9d6891e6c90b60e04f24:
>
>   remove the h8300 architecture (2022-02-23 08:52:50 +0100)

I agree, this is clearly the least actively maintained architecture we
have at the moment,
and probably the least useful. It is now the only one that does not
support MMUs at all,
and most of the boards only support 4MB of RAM, out of which the
defconfig kernel
needs more than half just for .text/.data.

Guenter Roeck did the original patch to remove the architecture in 2013 after it
had already been obsolete for a while, and Yoshinori Sato brought it back in
a much more modern form in 2015. Looking at the git history since the
reinstantiation,
it's clear that even he barely cared, almost all commits in the tree
are build fixes or
cross-architecture cleanups:

$ git log --no-merges --format=%an v4.5.. arch/h8300/  | sort | uniq
-c | sort -rn | head -n 12
     25 Masahiro Yamada
     18 Christoph Hellwig
     14 Mike Rapoport
      9 Arnd Bergmann
      8 Mark Rutland
      7 Peter Zijlstra
      6 Kees Cook
      6 Ingo Molnar
      6 Al Viro
      5 Randy Dunlap
      4 Yury Norov
      4 Yoshinori Sato

If there are no other objections, I'll just queue this up for 5.18 in
the asm-generic
tree along with the nds32 removal.

          Arnd
