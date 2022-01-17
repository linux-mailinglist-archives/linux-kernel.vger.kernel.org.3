Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7680E491160
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiAQVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiAQVl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:41:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:41:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v6so23198306iom.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOJESRtY9BzbEcYJYsvYnhPon1f3/YcWQoV18bvVlMw=;
        b=GMUyB9LHmMzfq9W6DiULZiGv3mYrDCQJNuHBiUuXWW4ZZUdAZveMEhJ+7TxEZf0TJg
         w61HJinH0HQDQxBtoY8DFTisBXP21+m4Azz3ojcjcTvxq0dUg6NguvL+bIOfIdc4iaOf
         SKDjbH6fYUarfgRdQjms6oQdHqh0VPiLS7Bd6u21KOjtKA64PzUY4BL0QmZI0WYzYtfM
         Svld77kHKgCydecJUO7b69WxgWWhS12WWPx9xS1b03YgS+iSLhr37akVWJgLugucwrTY
         0Q4j6hulpe/OVsRyg4jZSm3pSfVD8DR/jC61ltjq7jAdo2KH8WFySJBBIViDJ+nGPQhB
         Ebag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOJESRtY9BzbEcYJYsvYnhPon1f3/YcWQoV18bvVlMw=;
        b=UYkO6otm5TMyrKj0L80UyiB7oeIrC7/v6t40+RxJZ6IL4VwEg+Xh6D/o8zQF/l95Kc
         04WTEy0f+T1Ftlnih1qxgTeRXRok/N0cq+/iEFaq5ZtrOhYH6Bbt1RAYlYIkfesAjd/u
         DlhkPbOLJ/E+e5wMvAt9mJ0/01d3u0/RroPrPMUdjiFa1YfYIyT3gQSTjXJ4Z3aZ84kJ
         VMqp3HgWxMgZcXbP4jlM0fF++cl/QQXVEJBFKW3q6shUsAj5CWqWi0ff/tModG2e1Qff
         SQ5T615zMX8osjUc5tCzCc+W0XtK+uI/nL1OAKDmHdLmojt1HrT+RSbzIueyT+6dqTrp
         eyFQ==
X-Gm-Message-State: AOAM5311odTM4Mon1ulL2bgVxRWe9jbwi3Zr3FG/jwZV6yM+tZUv+Rt4
        Mxfn5rLpIZJLQ1t/tK42Btwckh97cq2+x/gzFOg=
X-Google-Smtp-Source: ABdhPJzYInLjRb9pOSgufYcs1HmvpZV4AfHcfJuLYvcqJUaJTkpcKE7TPLEHM7Q8k3RpYPYsw5DqZiwmlalJODgI6t0=
X-Received: by 2002:a05:6602:1502:: with SMTP id g2mr10433383iow.155.1642455687223;
 Mon, 17 Jan 2022 13:41:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
 <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
 <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com> <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
In-Reply-To: <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 17 Jan 2022 22:41:16 +0100
Message-ID: <CANiq72nyGijSO8ShcDx5eg=O1+_hO9-gOgrqmoDYhc9K0Mojow@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Jan 17, 2022 at 7:05 PM Joe Perches <joe@perches.com> wrote:
>
> Doubtful as it's likely the .clang-format for_each list is
> just out of date for your particular for_each type use and
> the scripted bit that it uses to create them hasn't be

I will send an update.

> updated in awhile.  Also that scripted bit only works on files
> in include/ and not anything locally defined.
>
> [...]
>
> So it has false positives for some functions and not macros.

Yeah, for `clang-format` I tried to be conservative having only
`include/`, but we could change that.

Cheers,
Miguel
