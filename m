Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2352E480740
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhL1ILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhL1ILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:11:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F3C061574;
        Tue, 28 Dec 2021 00:11:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i3so37213409ybh.11;
        Tue, 28 Dec 2021 00:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9OnzWfOxtr0nn687lLrh8Ahc8zvomjVWssCtaDeyTw=;
        b=Lfpu9/BT5AYtS2pXE7LFVLEzluSq2XOJ8RBVaMN0mFulwFbRVaXRwSIeckZEZURsfo
         1806rAOJbXUz/eHXx5wJtL8ncNkLgytegjTFB4oORAJVcwpyCh62hVZmqPNU5k3hMzes
         FeRtfy6dMzx27yr6VW09SMcS+uvIcUWkpf7+T3td/E8gNo4EaxtpaSw2gBzbsGUGNtDc
         F60y3ZDfiMGhcfrV+BqjB3yuALNpEQiWCnmqJNkCG6pKMdePlW2lWmjMGIt1tKhb//zA
         ATR9SCLiY6hru/OgLa0xU8RlzaHR8Hmv5dFiBhHAKcl5qxtzWHqaDOIerE0MDXE8mamn
         K7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9OnzWfOxtr0nn687lLrh8Ahc8zvomjVWssCtaDeyTw=;
        b=W9f5wARsaFZuNgxVJct4IjN7GNk+yyMqqSM8dNHfQWRiqdSP5lBka7Bk35q1+cFdbW
         On9uTHd+KJaa/2SZ9PSnpx3doyYx4F8mkTBoI8QiphWjvUiNsRnFPaL8ntkVYGEJMv2Q
         cFV3392biODGELxQcU54ZG9RyAdinJ5in1qn+C9rUELgkVFRhubZGI9x3Q8L357GaLXM
         tD6WYcTGh7p9N3jJaXoXwz+Nq0lu9l6YURWRaGYe+LgY9nOXuOXdTnlQ8pUZp0lw81Gr
         EWsSOSOHo8hJpdAuvl5pHcD2CmyfaKt/RLJQEvXTifE6AZKnqCpqm7NyVZzd/cfG9mYx
         SM3Q==
X-Gm-Message-State: AOAM530o9KmPCXjiYgHm2Y2lY4KUrClWVi0MfBkFJ8bBK/qmtHE+83Iq
        wxDyy+6NdEZ8ORzhUqGM91rFGAExI81Evu4kxxyG6tdM
X-Google-Smtp-Source: ABdhPJwZ1fIeb5IyXipxUDoGxzNopK3HD6DBvor7L6/Gpw+boBvFuI5yhjkwo3mId2//GRkVAW0xKRfz5mLPH7yfuYI=
X-Received: by 2002:a25:2cd0:: with SMTP id s199mr10972416ybs.234.1640679074872;
 Tue, 28 Dec 2021 00:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20211227064839.21405-1-lukas.bulwahn@gmail.com> <CACRpkdbFf3cNk6AKoahGsvY_RU+F0hnM6NWv0vcfjJO6RsQa+g@mail.gmail.com>
In-Reply-To: <CACRpkdbFf3cNk6AKoahGsvY_RU+F0hnM6NWv0vcfjJO6RsQa+g@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Dec 2021 09:11:04 +0100
Message-ID: <CAKXUXMyq-M7Cc-1mN=Xp=Vov9qfE=+vix97kBZWMqEOjL_mjGw@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: remove dead code for a non-existing config
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 1:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Dec 27, 2021 at 7:50 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> > The config DBX500_PRCMU_QOS_POWER was never introduced in the kernel
> > repository. So, the ifdef in  ./include/linux/mfd/dbx500-prcmu.h was never
> > effective.
> >
> > Remove these dead function prototypes.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> BTW: Lukas are you using this platform or just general winter cleaning?
>

I am not using this platform, but just doing some janitorial work with
the checkkconfigsymbols.py script, which Randy Dunlap has pointed out
to me. This "general winter cleaning" really started as a "summer
break clean-up" and just took longer... I am also writing a blog post
summarizing the results of these whole kernel clean-up activities and
I will share it with you once it is published.

Lukas

> Yours,
> Linus Walleij
