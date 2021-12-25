Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9436F47F3E5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhLYQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:48:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E64C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:48:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f5so44428655edq.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1aVcdP+7XTNYczNd1OV9UXJ1cQlAuUK2IZfW08hsgE=;
        b=PR55vDtYj3o32tnAXdqc8BixIJGUvrOkTbck9yaHt0KkeujvBlj2KlFxdyoqjzLEIr
         ut29GmZUQ2MAjiZJ3CQKgPLeTpdrmpZxUGmPiUHjYXMUuHKhTGxGi5Ra7fQVyVmHWTu3
         GVVrjAp0V95q0e4M9gUA/HJ5it2VCQbPOk+mlTL5kMzOJ9zskaj/SX4+Ljru8dioCpZy
         l6dUidoZZCTMks5Yh45c/+d+AvQuXSB+aeZi038+p8s6Zzb0QEXesh3OSQeuGemoeiZd
         O45thXfpIOGzFhfLoRqF42EcC7m5Mr21jM+X4mAWA6pmKR4Oi+UOel50n5/d6+IcBo6f
         Vx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1aVcdP+7XTNYczNd1OV9UXJ1cQlAuUK2IZfW08hsgE=;
        b=gBeMU1dD3tKnq4UKTm7KVhi40YZ/2UaL6CpUcIfDi011VyyU26HVJPPxritK0Pm2Re
         VbiTIxSlyYxWe89RUIJXRvxcGlc9BF1jVLcPwMnv9lWFSBuDr7rt+NqpQV3Bc8w1SHU6
         7wLLvRi6k+N7BrAcSEAMy8+09N+sxP/johko7dQFfTQgnCRlKVb0p40jCYDJzArMkohx
         j5WDfP+yfx0yRqpPQE7LM6lzbT5DQbdjuWt3HmIaGmj7z+CuuOTb9Vo9dgMBG+FFAh2w
         +z2fHgsKIxirr9WJuKs0z5xCB58zAExn0ar9Fu+3Vflkv9LRtksAD0s7KLda6aFR+hqH
         FjCA==
X-Gm-Message-State: AOAM531Xq5IaUkhmcr2h38P2xuYGfQae3rrmtYu0elGJOnyNANVHJvig
        RKzTohbrZ2XQNmpdc1GqslE1Xr4RRFLNxg4mYlo=
X-Google-Smtp-Source: ABdhPJyU+XUQg9lGA/70VMpAWTG3UMx1SB+q9rfvOZmzWXepIcWwRg4L6hNibMPhwn4K1TrVK2LeME1drZqSp9YZjB0=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr9125661edc.125.1640450883385;
 Sat, 25 Dec 2021 08:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20211223025346.1236195-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211223025346.1236195-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:47:27 +0200
Message-ID: <CAHp75Vdh9x0Xj5zQN0WhZxDjusWi5ow4s3m6Vrg6_e8ngaEuxA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Fix wrong comment
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 2:02 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> I notice that there is a 'WARN(ret == 0, "0 is an invalid IRQ
> number\n");' before 'return ret;', which means that it is possible to
> return 0 if fails.
> Therefore, it might be better to correct the wrong comment.
> And also there is reply sent by Damien Le Moal because I submitted a
> patch to remove the non-zero check of the platform_get_irq() previously.
> Damien Le Moal said that the comment for platform_get_irq() is wrond
> because it can actually return 0.
> Moreover, platform_get_irq() returns platform_get_irq_optional().
> As a conclusion, the comments of the platform_get_irq() and
> platform_get_irq_optional() should be fixed.
> Not only that, the comments of platform_get_irq_byname() and
> platform_get_irq_byname_optional() have the same error.
> This time I only submit one as an example.
> If the patch is right, I will submit another version to fix all.
> But, I also notice that the 'return 0' is removed intentionally in the
> fixed tag.
> I am not sure which one is right.
> Anyway, the success IRQ number should be 'postive' other than
> 'non-zero'.
> So the comment should be corrected.
> Here is the mail from Damien Le Moal.

...

> Fixes: c2f3f755f5c7 ("Revert "driver core: platform: Make platform_get_irq_optional() optional"")

How can it be a Revert?

-- 
With Best Regards,
Andy Shevchenko
