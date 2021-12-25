Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA84947F3EA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhLYQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:54:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787ADC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:54:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so44443903edd.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MDYD3U7Cm0jlbhMcyxoqyIfaCYUWl73kbcGfWFfQ2E=;
        b=Cie5G68UQPJ55WmkCR8DkZs3LRij3FNrVklrWPbeWkUMt5CsTvRNECx3RpjK8ha5xt
         XoW58z0uZXS9oS0J6+Gc7m/hjh8sl0UuSLcroWH0hQYdjB/npIg0DButU4ogWxLApjlB
         KtXGI65Ml7Zb8TFPaaRF/OQ014otsvsDnAuDOX/3cyv0CfGFaxWZhqqAA8sIsHly+DDx
         vZo+IpXTr/T1Bm71ytbIq+o4s/MgN/MNpFteLaqSW8awi//Gdb5F+E4Y5hvlV0DWng/z
         F+QqGQ8iXeAVkarsYetsFjKOffxA/H1HJUpFG0cbZLQrg19xOoMxstHm4DtK7eetEpvN
         2FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MDYD3U7Cm0jlbhMcyxoqyIfaCYUWl73kbcGfWFfQ2E=;
        b=GOv3YHQKenINNclaSyGvGGl0ZlRRM9As9b+S5esPRAZxjqLGnVHFjDKvhrKcWUxZVq
         XjU2kM5RYTAX/Ur7o3uUKSYDFmHjYS6phmaP3RbOcZMM84I9uyqt3Clf4LePAtP5+B9G
         wsesZAFqKoHQXFK2EeO3S6bdZTBr9h+LE0rNxC/HOQw7BdxtaylLHCYI8+HxWM710jsn
         j0Rcvqvnacwe4yAZjbjVFCj+iVRJVz25i1oorqz6JxpSmyeZy6VKUv4Gz+RI8MlOjWRs
         v9MO05qwibaFmncVhgQIrgfivDqIQCTE3DdyC6c1TcVL2e0seihTyiYfXC5SAmot1EkA
         31xQ==
X-Gm-Message-State: AOAM5335vAX0OyAN7xMH5NLDfO1SUUznFn6nCMm7pJvMdVa3LyeNh06U
        TKmeGIs7E5Q5JlQ+xF5UIq7Mn3v/+NVnfKFUEA0=
X-Google-Smtp-Source: ABdhPJw/S3Z7dnV11Drot99hLoXGQZ7WIjCbOVHUllBDHrXMmCogaKJRyFi391olBZG8zK+43iOzQh4y5eSs3se9xPk=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr9987219edx.122.1640451241078;
 Sat, 25 Dec 2021 08:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20211223025346.1236195-1-jiasheng@iscas.ac.cn>
 <CAHp75Vdh9x0Xj5zQN0WhZxDjusWi5ow4s3m6Vrg6_e8ngaEuxA@mail.gmail.com> <b6b7f31c-fe98-3129-d8a4-68ac050b570a@infradead.org>
In-Reply-To: <b6b7f31c-fe98-3129-d8a4-68ac050b570a@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:53:24 +0200
Message-ID: <CAHp75VcMf05FWJU+1tRvO8NrXhrw-CyG6Bi0wY73We3dDPdKJg@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Fix wrong comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 6:50 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 12/25/21 08:47, Andy Shevchenko wrote:
> > On Sat, Dec 25, 2021 at 2:02 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
> >>
> >> I notice that there is a 'WARN(ret == 0, "0 is an invalid IRQ
> >> number\n");' before 'return ret;', which means that it is possible to
> >> return 0 if fails.
> >> Therefore, it might be better to correct the wrong comment.
> >> And also there is reply sent by Damien Le Moal because I submitted a
> >> patch to remove the non-zero check of the platform_get_irq() previously.
> >> Damien Le Moal said that the comment for platform_get_irq() is wrond
> >> because it can actually return 0.
> >> Moreover, platform_get_irq() returns platform_get_irq_optional().
> >> As a conclusion, the comments of the platform_get_irq() and
> >> platform_get_irq_optional() should be fixed.
> >> Not only that, the comments of platform_get_irq_byname() and
> >> platform_get_irq_byname_optional() have the same error.
> >> This time I only submit one as an example.
> >> If the patch is right, I will submit another version to fix all.
> >> But, I also notice that the 'return 0' is removed intentionally in the
> >> fixed tag.
> >> I am not sure which one is right.
> >> Anyway, the success IRQ number should be 'postive' other than
> >> 'non-zero'.
> >> So the comment should be corrected.
> >> Here is the mail from Damien Le Moal.
> >
> > ...
> >
> >> Fixes: c2f3f755f5c7 ("Revert "driver core: platform: Make platform_get_irq_optional() optional"")
> >
> > How can it be a Revert?
>
> That's the "title" of that commit:
>
> commit c2f3f755f5c7
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Wed Apr 7 11:47:56 2021 +0200
>
>     Revert "driver core: platform: Make platform_get_irq_optional() optional"

My point is that the proposed change should fix a revert, how come?


-- 
With Best Regards,
Andy Shevchenko
