Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611FF47BC80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhLUJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhLUJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:06:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA2C061574;
        Tue, 21 Dec 2021 01:06:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mj19so11908556pjb.3;
        Tue, 21 Dec 2021 01:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N643qODObMfL9L1/g/1n2bseGjAXlA8RjjI6V7Orn/I=;
        b=I0IIjepgJAWMRIJPwNK02TWa7KuObVxcCG70vJYLzc2FdpQzktOtzZ6mSyeoJh3Gad
         9BnK+ubuQsbLRee8XEZ9cw0K8grIhEae9vP9nuYfRjNejViywbTIEl5B7y3R4CyM81Yn
         bIiz5MEQhyDAlgv8xfuvRFv//fngmH/Gu/PDnS0qnLlHs+Qw798keqD4uzoMz784GTFo
         NcjVWUOf/gLx+CgIQPZ/xtS6kCl5PJlipOqf+D/O8QZcjoJacvqe+6X87lI3tSXHtBpa
         wQl0WYFQzAxdEff3tsWbCsHLNYVhk5wIfh9Bkm7GlyhaeUclc5TEiUkeXzHIka8yHJm7
         ZApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N643qODObMfL9L1/g/1n2bseGjAXlA8RjjI6V7Orn/I=;
        b=R8oKxKZABBTBS4GHAYEQHAFCoJ5v8pK88U7ZDGdMcjakMcAcYCQqb7W+MNSpIfUNAZ
         p1+qNzL5cMXuYSCP+Ui+O4+s7Z+5aOy44dUnN/XWS+KkZNa8mSfiyMMqQE3BV3fkEDjJ
         TQV9ZSzz+w5lhpcr7oTDPLpl0uIMm7SAjONQEfSn3RR4Q/C217lKF8rOAi9xzqejvJLf
         2+YY+1TQv1sO1Mw5+9CtNfAqhWfGxh+cKjyE0T+7iN1bFkfyULy0VxRh/hOGXQO9ESg+
         BFa+zvuzjTLeMtQjPLiw65U5V9sEIljOtYX92grbVpxN3r1xtB2ZquoaHAKe8BzDYPJe
         77JA==
X-Gm-Message-State: AOAM5318qkCLdMGPhHENW8vW4u9m2sxN2Fp4iQNyjDpzNIAw/LflgJhH
        Yw8N8EV8wI+BMpmfKjlvSgLiK7I5SgqiFHDP3OC0zevPHmoMZA==
X-Google-Smtp-Source: ABdhPJzgw0XSQ0PEbFId/kW5N00d2Ow9tUj/8cxC4EWUKabTG+exkL3QzuOJmR3BHIW8rwSPpIk7oPcc5DD+uZiwfeA=
X-Received: by 2002:a17:902:ea03:b0:148:ea19:557 with SMTP id
 s3-20020a170902ea0300b00148ea190557mr2290853plg.129.1640077618944; Tue, 21
 Dec 2021 01:06:58 -0800 (PST)
MIME-Version: 1.0
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com> <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
 <DB2D69B2-B523-4626-BDCE-CE7DEFCD9268@sophos.com> <YbJpvT/zRBuyuNxT@bombadil.infradead.org>
 <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com> <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
In-Reply-To: <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 21 Dec 2021 14:36:48 +0530
Message-ID: <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace for
 stripped modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vimal Agrawal <Vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Please see https://github.com/crash-utility/crash/commit/03e3937ec7d1b356039433137cc6e531379ca454
( function store_module_symbols_v2  in file symbols.c). This was one
of the initial commit for crash utility.

I will work on linux-next and update you.

Vimal

On Tue, Dec 21, 2021 at 12:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 20, 2021 at 08:57:46AM +0000, Vimal Agrawal wrote:
> > Hi Luis,
> >
> > Sorry for goof up with inline replies. I found that gmail supports bottom-posting so I will be replying inline from gmail next time. I will send the next patch using git send-email.
> >
> > Looks like it has been there in crash source for very long.
> >
> > store_module_symbols_v2
> >         sprintf(buf2, "%s%s", "_MODULE_START_", mod_name);
> >             sprintf(buf3, "%s%s", "_MODULE_INIT_START_", mod_name);
>
> Can you point to the commit that added it? Preferably if you can have
> a URL I can just use to see the change?
>
> > I will test it first on latest ubuntu which has kernel version 5.13.0-22.
>
> No, that's not sufficient, I really want you to use either Linus' latest
> tree or linux-next.
>
>   Luis
