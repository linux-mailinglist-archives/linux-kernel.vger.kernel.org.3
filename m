Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB554A207
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiFMWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFMWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:20:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80EE2DABF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:20:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e184so12160065ybf.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/CY0Q27yHpGkV4+fpgJ7Pxw8NnZ5Od7A7cmxLkzFwY=;
        b=kS5iUw1EVxmO6ZZ8eLYib7THdtsnLllWt+dvpRM8T5NVpyz13RFk5BLbQrsThxfbbx
         2a73quZ3rV3nRMjohfnBsc0XCP22uAEp50IfHE0ZgKCsguuyUE39t9SGKnaqM//l6385
         E1w1s6irDtze+iJpDgMM8sanUW4YBba1JkIPtIRf172U0+XajqR4wzadojz3uGi7Q3Rr
         auFBWZsoalm8+ugQ8DjlK/LsY63Ge5GONNAZUsi+ET+4zW7gPDaxjQxRfYIq62vbuxfQ
         DM9h37natb4kKWX1UFXayT8U942q0Zf+fU6D5+Znklsu1yiYiiwOJWYyVei/0+5t4PCm
         SwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/CY0Q27yHpGkV4+fpgJ7Pxw8NnZ5Od7A7cmxLkzFwY=;
        b=C3fzYDLlHkCK7kuomelqe19jIQXDGk04iaS91AkAVExcWccQcWO9tQPRlAfhu6zCoO
         3iERJN4zSSQvdggJZ59uaC0nPPY+zdbXRhYdwC4Idh4XZRkgg8amdjmlKL5priXz1wp0
         AZwuY7rjAmDYpsH/VACouHT56awV9BWxORsBb4f6dBXe6jGUCzteHsTmLzscrxUbx7ad
         O7ihgqE9A6yaYC6xGIil9fN/L+qns6RsBF8ISQBXl/yru30UBJZnxNKC7uvIlKRmocND
         PsT4HuAJ2IH/MQCQAM1iwU65Y9IyH1q5OJbPlx2xsSkBjFnHT0Lps+o8nWkwCRmjU1J4
         cgig==
X-Gm-Message-State: AJIora+MjJCVmCeQDZzZUoewb3VkJ9W+A4tGyH/A++Mdyl2ho1eQZ5HA
        3DCuMO3772I4m49HtmdMF8qK4yEv/N9U4aXqLso=
X-Google-Smtp-Source: AGRyM1sjI8SzOoU42VpIyO9+9QtzrqPeoNhv2Nu3d54grgzuRUENip+KgkPidYN6ZI558aWMO5+Ok6LKCfX7/JyYnAo=
X-Received: by 2002:a05:6902:4c3:b0:65c:ef52:e3bb with SMTP id
 v3-20020a05690204c300b0065cef52e3bbmr1863089ybs.362.1655158814853; Mon, 13
 Jun 2022 15:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <87zgihlbst.fsf@jogness.linutronix.de> <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
 <87sfo9l2rt.fsf@jogness.linutronix.de> <YqdTsjRQiJUilSg6@alley>
In-Reply-To: <YqdTsjRQiJUilSg6@alley>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 13 Jun 2022 18:20:03 -0400
Message-ID: <CAMdYzYr-oHp-EgNJxumsR+DrZS=U7dLpvHymkAHPYQO8FsrLrQ@mail.gmail.com>
Subject: Re: [BUG] Threaded printk breaks early debugging
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

On Mon, Jun 13, 2022 at 11:11 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2022-06-13 04:29:50, John Ogness wrote:
> > On 2022-06-12, Peter Geis <pgwipeout@gmail.com> wrote:
> > > The buffer isn't an issue here, everything is available in dmesg when
> > > userspace becomes available. Instead some messages bound for the
> > > serial console are never output.
> >
> > OK. Good to know.
> >
> > > We run a serial console at 1.5m baud which is significantly higher
> > > than most SoCs which default to 115200. I have noticed some timing
> > > differences since the introduction of the threaded console. A
> > > significant amount of information is dumped very early in the boot
> > > process (between 0 and 4 seconds into boot), as most drivers are
> > > probing during this time. It also happens to be when the earlycon
> > > console hands over to the normal console. There is no abnormal
> > > debugging enabled, the output is a standard (non-quiet) boot log. The
> > > question is why is direct mode not triggering during a panic?
> >
> > Just to be clear, you are not losing any intermediate messages. Only the
> > tail end of the kernel log was never printed. Is this correct?
> >
> > This may be the same issue being discussed here [0].
> >
> > John Ogness
> >
> > [0] https://lore.kernel.org/all/87v8t5l39z.fsf@jogness.linutronix.de
>
> If the last messages are missing then it is most likely the same
> issue.
>
> Peter, could you please try if the patch at
> https://lore.kernel.org/r/YqdSw/fJvnkRbjvc@alley
> would make any difference?

This patch permits the panic to come through to the console port. Thank you!
Tested-by: Peter Geis <pgwipeout@gmail.com>

>
> Best Regards,
> Petr
