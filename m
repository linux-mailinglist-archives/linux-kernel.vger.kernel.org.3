Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD45A53D610
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiFDILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiFDILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 04:11:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD438BC8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 01:11:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-30c143c41e5so102154267b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I13xghRJZ9qk6cykz4w1fDYTb/H8Sm22vdjVHXo29TE=;
        b=VdmAmBHA6m7bm4C1XCyzAxo3GzpxdcMBRmGnlFBqYxTJLccgCZo4222kvHR9L/ZFqg
         yEtwitNUpVX8wc5cDxSYADo6KRiqOjnsk+d9+X/7i9Vn+eSkH6HDZulVWycy/dlcFVwS
         wrG3KhIFoyJwaaREbOCwu4cQtofeXqBu6gnXb4UQhKX8HOrxbZSGtkFs8+4NT9HiPRMV
         q/cLeEhaVBKcxN7iCP5p2vH5M37g3D4McCL7rERy4rzIRALiBL2UGUYbqWQNZiUeQvup
         PoDZS3uGmIdmVhAm4bCFoKhv7ykqZBoJOU6UJW2D6W4Lo+UAho8WEefF3qg5Oi0tQafL
         Z69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I13xghRJZ9qk6cykz4w1fDYTb/H8Sm22vdjVHXo29TE=;
        b=x048JgP5SDXg8evkzh2hBv/l4ppyQGQrK2l9iM3WNKPwK5gVK1eOSFfrG5fJME09cJ
         0SXmIPd0mQASB3+xNs//E/cJMyvUZrISQQd/9LARRTm66LJBLS5j+Ig4MbTYPFHOpkfn
         xbYEnqDPNhyY2HUEW3EVbxwKHX1mOTUg25invsf8JZsG/22zbhbqUPE2rV9+2hyPcaaB
         a/Co68Tv0mN0nW1RMJz5zcbLyEY0eX/FeXG5k/xayp7PBqwBdnDsrVyeGY4+X0+o6KTT
         hQEN4fT+Pqj77+wrUfKUok1LvPNiL4dIN9ou8/tGTmItgtaPJ2ZWKV5r3MXpCNXpX1ox
         30PA==
X-Gm-Message-State: AOAM530UrU4MhcCc8M7zWkOMAZpZRM/qJd+2QPQh6i2aGnrviEH7KotX
        TdgdHufMO1U+FUJYX9G3+DcpK+6HcaXku6t+DtZ+9Q==
X-Google-Smtp-Source: ABdhPJy4i6fQu4ekTJ5vsn5HDSlqWGJnhhSGVcuU4GviBejc544f0mPcEQt3SeSBlz0VlMOv4J5zkuoP9Z9mfbnG1sI=
X-Received: by 2002:a81:1154:0:b0:2fe:d5a4:f26b with SMTP id
 81-20020a811154000000b002fed5a4f26bmr15921192ywr.140.1654330288381; Sat, 04
 Jun 2022 01:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220603113908.78777-1-thierry.reding@gmail.com> <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
In-Reply-To: <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jun 2022 10:11:17 +0200
Message-ID: <CACRpkda0KiyjV27WEP_MYpvWXyG787L9PJZaP_hnXh_DFpSj5Q@mail.gmail.com>
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
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

On Sat, Jun 4, 2022 at 6:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 3, 2022 at 4:39 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > Note that this currently supports only one provider, but there seems to
> > be enough interest in this functionality and we expect to see more
> > drivers added once this is merged.
>
> So the "one provider" worries me, but the part that really doesn't
> make me all warm and fuzzy is how this came in at the end of the merge
> window.

Another provider did come up, and were requested (by me) to work with
Dipen on the subsystem in august last year, that was the Intel PMC in the
Elkhart and Tiger Lake platforms and forward:
https://patchwork.ozlabs.org/project/linux-gpio/cover/20210824164801.28896-1-lakshmi.sowjanya.d@intel.com/#2766453

[I added the other Intel people on that submission to CC]

Intel wanted to put this into the GPIO subsystem and what I saw as maintainer
was that this is a general problem and general purpose (binary) I/O just isn't
going to be the only thing they timestamp. Other events will be for IIO and
hwmon or whatever. They have been
requested to contribute to Dipens work the recent 9 months ... so... well I
understand people can get other priorities and stuff.

Dipen did the right thing and created a separate subsystem that is a provider
to GPIO and can be a provider to things like IIO as well, which is what
it needs to be because for things like sensor fusion and industrial control
systems in general precise timestamps are
of uttermost importance. And IIO handle a lot of sensors.

> The DT bindings got the comment "why call it 'hardware timestamp'"
> when no other case seems sane.

Intel is talking about "input timestamping", admittedly it is done in hardware
but the point is to timestamp input I/O events.

> So the DT bindings got renamed. So now part of the code calls it "hte"
> (which nobody understands outside of the hte community that is
> apparently one single device: Tegra) and part of the code calls it
> "timestamp".

HTE is "hardware timestamping engine", we have hwmon, hwspinlock,
hwtracing so maybe hwstamping would be a more natural name then?

Yours,
Linus Walleij
