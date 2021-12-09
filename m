Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA546F747
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhLIXOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhLIXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:14:13 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B96C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:10:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so7874882otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwQ3/cvUvZwvZqmL1mCJROo89LdfAWk6eb0jRU/PPfA=;
        b=bleUAVWorez5jOJY3nEoJbhU7GbSzr7+LS0r/JZcBeOWYf5aC10+VHh1ubUWal9iJd
         cve8rftd0oSuPhuyK7h5v8ibpurBcfClv8FKcPwStqgxE+CzFri8DEFVIMMa6LqUnAZ5
         s7qiYV96LEsYjQWMsgZ+hx+gTGbr6JYOD/71Jh6mDb3igAoMD2tjfxy0XFWfonv4iC6W
         L+hKdh1GAzFl02VL/sCz8Qc/U74qa0skgCKkwXCBDdoSKC+Nv4gi22eJ4jeHjrVat7j7
         mbSVPxIYpxe9vMpMFzmYxEQzCwCnVhEz7p2vBjDQY9ZvfrxX1CGEj5e/fwcBz1EtGT++
         N7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwQ3/cvUvZwvZqmL1mCJROo89LdfAWk6eb0jRU/PPfA=;
        b=cbT+pT5FRIqiti0bd5r9dHM/08NCqH5nrV7gzBSSHorM+qmgp7bnwg6zVbNHnF40N8
         mAypBF2xiaLXMPHO5bT/rx+HSEZI/6hN3wn74clBiExi4jEaSIiw9qg/zg5WABplSuU6
         v+pG1Hccoc4u5l74AVBoRl4PvQUjzujaEEUdva7X21QznSjfZELuWDr7floFZbyBqZ6b
         i/Gb/jr+pC/Lgk3cjtlKWETiwyT4WFeFlJcYu6+rbf2Pp4tFfEST8l+y7JObm1cCEl26
         PsjeW7E92q+ZM9f4F+xMIlvy2AVpAyHl0+iziyHDgLYNE9qOsAPvPPwkDE/wwx5FHNkj
         i84Q==
X-Gm-Message-State: AOAM532iZvPHiR/VdgqCjbUlv2nVVtzexBw8DMd0LEth2fgC35wifNCH
        ugdIxlf1Hd6rmBaQENNgiEptthf7n5gzjIt+YAomoJ46KjM=
X-Google-Smtp-Source: ABdhPJzo+Qn3beEC2GCP40Dln8g3w03FB1cYts0c1cuXhM0sKcR+azpj0wOy3oZM9W3SYZUtgtldhp9j0UCVfnGVgMc=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr8426847otg.179.1639091438012;
 Thu, 09 Dec 2021 15:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20211209113456.33977-1-andriy.shevchenko@linux.intel.com> <YbI2Xb7gBfN4Kyid@smile.fi.intel.com>
In-Reply-To: <YbI2Xb7gBfN4Kyid@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 00:10:26 +0100
Message-ID: <CACRpkdZxWpygHBJFmuXft5yWhA9SWJzEubC6Oac0dUsLeFAjSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] pinctrl: Sort Kconfig and Makefile entries alphabetically
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 6:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Dec 09, 2021 at 01:34:56PM +0200, Andy Shevchenko wrote:
> > Sort Kconfig and Makefile entries alphabetically for better maintenance
> > in the future.
> >
> > While at it fix some style issues, such as:
> >   - "Say Y"/"Say yes"/"Say Yes" --> "Say Y"
> >   - "pullup/pulldown" --> "pull-up and pull-down"
> >   - wrong indentation
>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v3: fixed more grammar issues in AMD text
> > v2: rebased on top of very recent pinctrl/devel (Linus), added some grammar fixes
>
> I have noticed that you applied v2, thanks!
> Do you want me to sent a followup that fixes AMD help text?

Nah just pulled it out and applied v3 instead :)

Thanks,
Linus Walleij
