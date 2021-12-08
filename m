Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5646D031
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhLHJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLHJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:40:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC2C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:36:39 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id q74so4425035ybq.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPm+dTjnHwdhkwpeqXXKHK+8jP+V92TlA0pdYCtjgc4=;
        b=5NiKks9X6N3wtV2EzPaOijxtzMkOSS8xqs3L3Qw/zxylb0zSr6JLIlMc6sUBhmnyTH
         nxALszjExjdNola4XByxvW5ylXf9EN0LF/qXuNtAzVk2ZTy9iHEJmHJpaugEDGHKK9LB
         vBeTRuxXzHqiANkma6yLi6DSmJpGat3/Ab3oUgU8+cR4BGeEx9n73GlJrXhN8M1rbf/7
         5B8aCHdBll3xv/GgHnslTihhs6ZRlcWHI/XnVbq3YzLwmgO5hSXmD7CuFNedtHukCD8v
         HGWRG9TJ0kvUyw6E0aoilSzjNX1TibvU8yqt3v9iMKTq0KlQf/NM0+mjoA0Xz8tzrg3P
         bLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPm+dTjnHwdhkwpeqXXKHK+8jP+V92TlA0pdYCtjgc4=;
        b=ZWGz07QMAXabjZsurkk8b0vJ2bWeNWuDT0e1v3LKR0CiN6YgQEJXuJABP487XIXc79
         1pfFHLgLLYdZVmoYOaIMpMn+h4oGevDUfd0/SGFte/QXG3JPOqz8s4jP7u9ql/0pqFGz
         5W+X6sP73hPrTTG3wrlHZaC7W8qJGbcQxjmz64dYVaOUnuURQqAwdkNVSGTvWGuQW2J7
         3EDdQZrBdGNOrWRALz10FeTXxuMeWRs12drnily4fEKrg2NE8Y5k46ui0SIVRSuKtOM5
         R4Suz0DOEDeq5+SfX7Ch8OtvXf4qrwbQoXsCJ6h7Ta/1A4LzcFvcY/DQWP++A7d7ANQt
         6PFg==
X-Gm-Message-State: AOAM533B3iNCNMy86yWvKHi5RCdhU4Dc92Bm+u/4dyf/bSxwhEEtu3+W
        aeaKb55HVta5cHNqYlokbheABlAOV/CBs/ZDkL9OI7scwE3q1owX
X-Google-Smtp-Source: ABdhPJxMgb+OtpxF5KWb7A/mTGLUn9XZ8jb6VPe/XFjUtfgBUbVp6mtt56CqwClJezVdBbrguD5/tQxjvMyh914RpuU=
X-Received: by 2002:a25:ba0e:: with SMTP id t14mr58039245ybg.49.1638956198379;
 Wed, 08 Dec 2021 01:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20211207083222.401594-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211207083222.401594-1-chi.minghao@zte.com.cn>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 8 Dec 2021 17:35:37 +0800
Message-ID: <CAMZfGtUZw+rL8p86BQ82od_YUwzPX88587u_Yj-R8jgF42QdUg@mail.gmail.com>
Subject: Re: [PATCH] mm:remove unneeded variable
To:     cgel.zte@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 4:32 PM <cgel.zte@gmail.com> wrote:
>
> From: chiminghao <chi.minghao@zte.com.cn>
>
> return value form directly instead of
> taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
