Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46E4B51BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiBNNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:37:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiBNNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:15 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93949F92;
        Mon, 14 Feb 2022 05:37:07 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id n5so12302982ilk.12;
        Mon, 14 Feb 2022 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0S222rJiXMXdLbL4sr8eXv1/RjuJqY7+BlIpDb0kXQU=;
        b=Y1grS4VlTpVrHPRcg3ogv2eoxW96xGbuQ0rNH+3v401Jh/WkzItBEU6E8rfh+flaDN
         5gAMiLYQUE0lQEqhJ9TeDJNcTKUlat+WvO0QuhzGZfLG0+4Y2EQTNNhisaoNrUeshGve
         /x0TTqGyLkY5CsZNkDvwejmmP9NX3qgHvTxWYaVXI+KWRfPR2uhIN8/ZiiT83TcNtcmY
         v1/u9il5hn12+4yKYW+rONaHHhdGAmZxWBuoa9rsm8oC1YU76D89FFKtZbIrCRowcCzo
         XrYaqiY/pjg0nkJp2xIAvKQ2BmvohlmqPifRnaz/jTW79L592OvQvLTELRaIarOO9+gG
         En4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0S222rJiXMXdLbL4sr8eXv1/RjuJqY7+BlIpDb0kXQU=;
        b=cFXV5Ne9tBw2OwSQbyrV+OSQ7TOHvpNVBAhFPNNUIB4rnPx4Y5StodHuc3DRTDNDq2
         EkbUl9CYfxXbsE1CVtppnfhyGiiPXvaZ6w4hCm2Psys0MqOMdHmwJjzG873LbjLrgNq5
         m0gKoGNu3vKmEiNaZaBn9bkkywVx0fqZ1qdMM4tPe2IBse6fqjTmMGag3dcjiIJ9EnvB
         2d6LZ2MndBVbfpayAXa/o38ZlAqH35AZAGWZPYIuKCfP1wBbUHSOHG0KWmdV+ADTV6GO
         tWFcsz28z8WVsxBhx4gK7PBapMWhlmBFI9QQYEPQHjkEj6ozNWsR5y5bKQ5Znj4x3r14
         M5gw==
X-Gm-Message-State: AOAM530Rg/kk+RjUz2FdRKFDp47rlaK1UWsfzsXijHKelCVGE9J405tX
        X0mkbJfsMH68QeS7Xt9+htDF+MemvOEYXpmrnG4=
X-Google-Smtp-Source: ABdhPJz8VaSVI48p0HfaAeJH24iGo5ubZOtP91p5DCwKGTBFJ/2NlAkHOJ6pNrXG85vdJz0h3BZQUlq6UU5id2h2hfA=
X-Received: by 2002:a05:6e02:1ba2:: with SMTP id n2mr8403067ili.5.1644845827109;
 Mon, 14 Feb 2022 05:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-11-ojeda@kernel.org>
 <YgnoJ97y3I2hE8UJ@google.com>
In-Reply-To: <YgnoJ97y3I2hE8UJ@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 14:36:56 +0100
Message-ID: <CANiq72mUBox2cbkHGP9=s=MZhRydY9Z2-vq8OVXjp6xHHifwyQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] rust: add `kernel` crate
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?Q?L=C3=A9o_Lanteri_Thauvin?= <leseulartichaut@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
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

Hi Sergey,

On Mon, Feb 14, 2022 at 6:27 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Is this flexible enough? Why not let user pass bindings::GFP_* bitmask,
> just like what the underlying kernel API does.

For particular kernel abstractions, they may know what they need; but
in general, yeah, we may need to allow for flexibility where needed
(see the `TODO` comment in the quoted code).

For collections that need to allocate, it is an open question how Rust
will handle it upstream, as there are several approaches (if you want
to take a look, see the `allocator_api` feature and the working group
at https://github.com/rust-lang/wg-allocators). But in order to be
able to experiment and see what is best for the kernel, we have an
in-tree fork of the `alloc` standard library crate (see
`rust/alloc/README.md`).

Cheers,
Miguel
