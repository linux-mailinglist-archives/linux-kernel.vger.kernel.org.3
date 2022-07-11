Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E065704A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGKNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGKNwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:52:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AEB61D63
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o18so4771074pgu.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QWFQ2C9WGXjYYYAgPGIAjeY5FYOxbTxL+i3z5rucXs=;
        b=PCTezIifMZ8asZN/i9985ObaF+vgX0sE0tdwjafsZ2HSG4VhynbVjITywekdHcP7OO
         8OWJnNHJHTzA1hPjW6gCEADyMr3Kxi2n0d+MKcteTNcuzzTU59StbVCVnfN8V9O/K/5i
         R4QPRzN1t6YecEKIXMDDMa+zO2VfCZFe8bXC7Dq4RezKymrU4Ddt7ioMT6czDWB/9/NO
         PihOIyIpGGeR6NJe3sKsZYnb/IFzjkZPgGqVslM/RCdvABaZWfz4m8A/wChpaLcYQJpl
         K1nl5ZhKyX8JfOwJEb1koStun8jJScXxYB6doP9dWWO4DHFQHwMt3xAx/RHrBt+YaWf4
         ogiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QWFQ2C9WGXjYYYAgPGIAjeY5FYOxbTxL+i3z5rucXs=;
        b=N2QrM3jtDDqon8sjQVZIscT7ndD20KGr6HYxHROwM8xtpsOo2/m/oAWGbKWrT3pLqv
         rGEIuYe//5t53SWDPyDmUQSLPJuAoEZXP1ywhcXv2XNsATZSIqrNsy5EBfGNzyZLD4b4
         vYZxgSCh5TSLLRkMqNRk2AIeA3DZOO0qOlONkXNCDrxdhD22ucdBJqwMxA0gQdfH8bZA
         g6dj+Lh74+feRRuNNNMOa73c843lVqxjZPzYPY2Wl9cIyTpkzIil7cOvV2SRmy3n5MSL
         LvD3dtf5Op564sbNhJg7+QzlQeJPB4K9mwn9uztRy3S/Kp0fopln8zAmPOTpw5cMaMw8
         Ecsg==
X-Gm-Message-State: AJIora9U150LkDpKRj78S3bMaz91Y2Q6Ij29euk9O8qjB3ELhxQ3YAQ0
        37+luH/ym7a5rEcj7mKs3lptyNV4E1d5mPEPkp4Hrw==
X-Google-Smtp-Source: AGRyM1uX1oZgFjnUS3kw1/kggtzktYcOrKLh0g2QMEvkUx0LfMVcZpYuvXN47IKfNcFCjhxbz0WN6LY9HmaQTvMN6Jo=
X-Received: by 2002:a05:6a00:1a86:b0:52a:d419:9552 with SMTP id
 e6-20020a056a001a8600b0052ad4199552mr4374528pfv.70.1657547521902; Mon, 11 Jul
 2022 06:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
 <CAFA6WYPmFqCXk24J71tNO=5bJHgJRAOPFr7cGq8YYLR+MWBoPw@mail.gmail.com> <CAD=FV=WdMsqrsWzX=0RU5HJ1a0cy-pm4BwP47siLj=+eeEXUQA@mail.gmail.com>
In-Reply-To: <CAD=FV=WdMsqrsWzX=0RU5HJ1a0cy-pm4BwP47siLj=+eeEXUQA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 11 Jul 2022 19:21:51 +0530
Message-ID: <CAFA6WYP_C7fOkgNw8n0OAaT92fr4UdBnCqAn_du6BT_sQB2KzQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 19:17, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 11, 2022 at 5:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > > I'll also note that I _think_ I remember that with Wei's series that
> > > the gdb function "call" started working. I tried that here and it
> > > didn't seem so happy. To keep things simple, I created a dummy
> > > function in my kernel that looked like:
> > >
> > > void doug_test(void)
> > > {
> > >   pr_info("testing, 1 2 3\n");
> > > }
> > >
> > > I broke into the debugger by echoing "g" to /proc/sysrq-trigger and
> > > then tried "call doug_test()". I guess my printout actually printed
> > > but it wasn't so happy after that. Seems like it somehow ended up
> > > returning to a bogus address after the call which then caused a crash.
> > >
> >
> > I am able to reproduce this issue on my setup as well. But it doesn't
> > seem to be a regression caused by this patch-set over Wei's series. As
> > I could reproduce this issue with v1 [1] patch-set as well which was
> > just a forward port of pending patches from Wei's series to the latest
> > upstream.
> >
> > Maybe it's a different regression caused by other changes? BTW, do you
> > remember the kernel version you tested with Wei's series applied?
>
> Sorry, I don't remember! :( I can't even be 100% sure that I'm
> remembering correctly that I tested it back in the day, so it's
> possible that it simply never worked...

Okay, no worries. Let me see if I can come up with a separate fix for this.

-Sumit

>
> -Doug
