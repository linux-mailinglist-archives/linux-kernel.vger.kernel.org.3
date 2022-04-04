Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC14F1390
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359044AbiDDLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiDDLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:05:36 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8315B25;
        Mon,  4 Apr 2022 04:03:35 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 234B3NEQ001658;
        Mon, 4 Apr 2022 20:03:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 234B3NEQ001658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649070203;
        bh=JG/zbhRcdhdcznjejyKbFMjaPGTJpepqOa9qTr7iSoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1RfW205fo5MTTxQ6H4d/yTfBYYZl3gFZRvDg7d3VN8phK15nt8kOZWrE27dfOkRkN
         TwxsF8vUa0nCy9ufA+lM50D3bAEdlNTbZHh9R7rzZsvNVgH/7Kvi3kYkdQPmJhSiQd
         0uk8uZ8QiPIt4xQdbvxeAZKM/Mkj/hrdnMZVtZPSjYOqj+dzICLF0Ir9uSSYlWzVc5
         ts2cWBeg1OzjMNU+RK7QpjvOOeRwGM1Vuilu/7y+AYuGtr1GDNLencM42j/ZscDXb6
         KB1c50oGYgLbFKDGsznof7aE1pBxComsXRzgxK7RFPI5kxzhpXnXTAbr2HTgIQvANk
         3pf4Ln1m5quyQ==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id h24so4295747pfo.6;
        Mon, 04 Apr 2022 04:03:23 -0700 (PDT)
X-Gm-Message-State: AOAM5336t/R0CC04aC+whczX++EoDS5N4SYB9bNSYeY/oNntDLJgJ1il
        Bxnpke3n+mm89qJW1FCW7ctFBHn/PSTx602wFAs=
X-Google-Smtp-Source: ABdhPJy2XI7PU06Z81w2Q/TzQqR37viCjtaYtzW7uB0xOB4zElHSENcTHkICyhaiTO8LEh/H5SWQl8PL56i/NBmqoZI=
X-Received: by 2002:a05:6a00:24d2:b0:4fb:1b6d:ee7d with SMTP id
 d18-20020a056a0024d200b004fb1b6dee7dmr23384787pfv.36.1649070202372; Mon, 04
 Apr 2022 04:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220307223231.608498-1-mst@redhat.com> <CAK7LNAR=fs+VJUZJj7YyprdA6xjx=4bttPRL6e4bvNkEeX9eng@mail.gmail.com>
 <t2boae$9u9$1@ciao.gmane.io>
In-Reply-To: <t2boae$9u9$1@ciao.gmane.io>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 20:02:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQboNkJcmWdq6=P_PQck3oUGNU_d25PHowtYa2sMcMD-w@mail.gmail.com>
Message-ID: <CAK7LNAQboNkJcmWdq6=P_PQck3oUGNU_d25PHowtYa2sMcMD-w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix config cc version check
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 3, 2022 at 6:11 PM Akemi Yagi <toracat@elrepo.org> wrote:
>
> On Tue, 08 Mar 2022 11:23:31 +0900, Masahiro Yamada wrote:
>
> > On Tue, Mar 8, 2022 at 7:32 AM Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> >>
> >> .config is of the form:
> >> CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)"
> >
> >
> > No. This was changed.
> >
> > See this:
> >
> > $ git show 129ab0d2d9f -- Makefile
> >
> >
> >
> >> while CC_VERSION_TEXT is of the form: gcc (GCC) 11.2.1 20220127 (Red
> >> Hat 11.2.1-7)
> >>
> >> thus when comparing these, CONFIG_CC_VERSION_TEXT should not be put in
> >> "", otherwise we get () outside "" which shell then tries to evaluate.
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >>  Makefile | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile index daeb5c88b50b..d5c03c827825
> >> 100644 --- a/Makefile +++ b/Makefile @@ -1714,9 +1714,9 @@ PHONY +=
> >> prepare
> >>  # now expand this into a simple variable to reduce the cost of shell
> >>  evaluations prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
> >>  prepare:
> >> -       @if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ];
> >> then \
> >> +       @if [ "$(CC_VERSION_TEXT)" != $(CONFIG_CC_VERSION_TEXT) ]; then
> >> \
> >>                 echo >&2 "warning: the compiler differs from the one
> >>                 used to build the kernel"; \
> >> -               echo >&2 "  The kernel was built by:
> >> $(CONFIG_CC_VERSION_TEXT)"; \ +               echo >&2 "  The kernel
> >> was built by: "$(CONFIG_CC_VERSION_TEXT)";" \
> >>                 echo >&2 "  You are using:
> >>                 $(CC_VERSION_TEXT)"; \
> >>         fi
> >>
> >> --
> >> MST
>
> I believe the patch proposed by Michael indeed fixes an issue
> introduced by 129ab0d2d9f (Makefile).
>
> Please see the following bug reports:
>
> https://elrepo.org/bugs/view.php?id=1215
> https://elrepo.org/bugs/view.php?id=1214
>
> and this forum post:
>
> https://www.phoronix.com/forums/forum/software/general-linux-open-source/
> 1303986-linux-5-17-rc1-released-a-little-bit-early-but-with-shiny-new-
> features#post1304036
>
> Akemi
>

I left a comment:
https://elrepo.org/bugs/view.php?id=1215


This is a bug in ELRepo.

The upstream kernel is good.

Please do not come back to this over again.




-- 
Best Regards
Masahiro Yamada
