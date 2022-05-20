Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC352F1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352343AbiETRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiETRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:50:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43815E61B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:50:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f4so9492583iov.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R37OV7ShgquRh/X+TFtKwKQtzqTzGe6venU+Fs9c73M=;
        b=qVyB6piFbVe86Mw/DbazCXUwImv/IW5/h0kf3KhMOhXCzo2tf76ou8pxMWMG54Hy2E
         DTRKJTL1e6dQKrDzX6SUZO6wIiGL+X8/EZ6INLGrABq9mWLNvgBSbZT4ls754GA2nr+v
         bEGGX+d9ndnGoAe0nzbeiZBdCZp+liNvI9O0Ns6Qt3geG+UeWJbeEhF2uEcKwAgTnp1R
         f6PEsKXTkz8cP7kjJuv9i2A2mPFaNgonJD1BS39pbNDZus4i56xY5DKaineZa+4J0vgs
         sK2rdyZDZqx7TRiMwOy3e/UB2K3ktz81U9dGWWtpLNVbWqjDbAWzrRUVQpj4Nch/XKtj
         28XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R37OV7ShgquRh/X+TFtKwKQtzqTzGe6venU+Fs9c73M=;
        b=ky90k4nFzx5OCFY7BBs4GMb5ox7RNtEy8oMCFE/4IJEgzcDLfcEOSFHJMA08R+9VQo
         aHhpUZfkbBy8W6iIOKOgEPs1hR90XUtjmNOM59HdbzZUrVb/oOQJNXLn1PIrNFo8anqE
         kZiEYR8ybYD7o40dGeX/H1xjHgi/J3hshZRQP7y3ObvKMC7izJNxvE9SJU4v1OEkmlR+
         p3VJj5izzZL72dBhv0Wbg2HsSn3uKaS29jYrLboxFxRs+oHH6sbnM8ExjBMiYo61xwkm
         VQh9vE3JlmuPpqihQzU81AxdUFIkZEDKvrjkSN6+3cf1qIHbzDGBajFqD8tIWmFeDEE6
         t3Eg==
X-Gm-Message-State: AOAM531bt/q1c6EZVwoh+l9Jts1ZA7v+R2W/yKvo2BuaQY1irH9eN1WW
        Ljsoqky9bkVu8h8qAojFiCX4TClAGJo+WFvqfkHjyyyY3SU=
X-Google-Smtp-Source: ABdhPJwEnZn+xZyGODG/E6u6W2+Xypve0w+TBVt6sSbJ7Xo6cEEeIyS61pkQIMAJ8DiA8dljupPLTZ/VKpzZarwMDFo=
X-Received: by 2002:a05:6638:16d6:b0:32e:97e4:ac16 with SMTP id
 g22-20020a05663816d600b0032e97e4ac16mr2854637jat.199.1653069020035; Fri, 20
 May 2022 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <20220506160106.522341-5-mic@digikod.net>
 <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com> <5be32ddf7688db38408466315a80e03e9af7ac40.camel@perches.com>
In-Reply-To: <5be32ddf7688db38408466315a80e03e9af7ac40.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 19:50:09 +0200
Message-ID: <CANiq72=e9LMujmsk-mh8YHcGoKuLAnBttNz7JbiXH_2-hpvUvw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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

Hi Joe,

On Fri, May 20, 2022 at 7:24 PM Joe Perches <joe@perches.com> wrote:
>
> static inline void foo1(...) {}
> static inline void foo2(...) {}
> ...
> static inline void fooN(...) {}

Those are the non-wrapped-from-signature case, which are handled
before this option takes place, i.e. this option is about:

    void f()
    {}

vs.

    void f()
    {
    }

For putting everything on the same line, we could adjust
`AllowShortFunctionsOnASingleLine` from `None` to `Empty`, though.

Cheers,
Miguel
