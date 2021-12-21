Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207347C924
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhLUWRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhLUWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:17:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F421C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:17:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a37so541266ljq.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsxFBdm2QviBZ29N5dveyQzOQKlgfiIrc+0yxADMNCQ=;
        b=NXGLxSCpObD2flRKPbCq9IFPdHnTLn2G9uiMQbiGfRWzwaeJ2bD8taKQdDhT7vmYJQ
         XKN0OrMjsTFtN4wpAuKb0rktrM3wvPlOc/x9PIKTiD8RUbXS7EVGu5eZV8Z593A+RmdE
         f/WyA0N9jfdkw5Fk7b/SMzwK11A0I6YzbkyPgQz1mxFDG+9fP4JmVDpjEC44R3vUzr8R
         Q3z5exdX1Y33rGrCOUViS3xHKetapJhi7PURL5aohZDHl9JqfMHvdqUGgZtD7eupsRMU
         4RT7vvBNqyV+J7FlzlcUCHul5Xo7HG73kaTCwJR/I68a5eFShE1J6AwN1ZfI4UMCSl/M
         SBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsxFBdm2QviBZ29N5dveyQzOQKlgfiIrc+0yxADMNCQ=;
        b=ASORgbWHWlihU5SiTuYOFCwHASvuun2exD2YAK8M1O4ysaITNPWxS1hrjw2+cRS9DU
         D3L9jr2YcjdVDeRZfzGV3hBmoY4QzKrQa5JHVJSO9n81hi1u2XVxj4ZdJ4mOKdbXzEto
         SvP2zsSYSHf0wSCPyQPGcgyU9gAx9ewiNeIWE/jJOwLOunCZO8BrrtLupoNVQc5FP4Y3
         J0KC0ta+krFZ3EhN/LPxT4hBZLR8qfmhjzMoQCGYWzXMAyKPQIeVZO57fcu9t/PmzrJH
         XSUCaw+5ZqepHpGjz/B0pZ9bMjKFMQl58RHjz8FxLZVCnkluC+IH/PvQbrppjjdYO5SZ
         TuhQ==
X-Gm-Message-State: AOAM533xycvTpnz4nPzzeRUmU28hCj+46SP0W4b0O+Ro+qk0TAOB78fg
        oer9tthvUZjh7jskDsRJ09gMXjlZKLOnvgjE2hyP3g==
X-Google-Smtp-Source: ABdhPJwwMIZzbtN/WFjr6/Ly3vHEn6ix3T31OaNoEmwDcGRQg/3sYZ7JNkTLTnzGEzM47tPaVs915sWc4CTh4BE+7YI=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr315614ljo.128.1640125072220;
 Tue, 21 Dec 2021 14:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20211221184501.574670-1-colin.i.king@gmail.com> <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
In-Reply-To: <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Dec 2021 14:17:41 -0800
Message-ID: <CAKwvOdnK2Zc72tw6CdQkz=VxoRC0voWpda8Tgo38LaiRukDfKA@mail.gmail.com>
Subject: Re: [PATCH][next] kernel/sysctl.c: remove unused variable ten_thousand
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Dec 21, 2021 at 06:45:01PM +0000, Colin Ian King wrote:
> > The const variable ten_thousand is not used, it is redundant and can
> > be removed.
> >
> > Cleans up clang warning:
> > kernel/sysctl.c:99:18: warning: unused variable 'ten_thousand' [-Wunused-const-variable]
> > static const int ten_thousand = 10000;
> >
> > Fixes: c26da54dc8ca ("printk: move printk sysctl to printk/sysctl.c")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Just double checking; I don't think I've seen someone supply someone
else's Acked by tag in a reply before. Was there some discussion off
thread that I missed? If so, do you mind linking to it?  Was this a
typo, perhaps, and you meant to supply your own Acked by tag? Are
"Luis Chamberlain" and "Andrew Morton" aliases? :^P

-- 
Thanks,
~Nick Desaulniers
