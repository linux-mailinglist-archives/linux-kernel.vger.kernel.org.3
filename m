Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E36493B87
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354956AbiASN7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiASN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:59:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1173C061574;
        Wed, 19 Jan 2022 05:58:59 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id o9so2911909iob.3;
        Wed, 19 Jan 2022 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr7tgwlXiamYqI5PxE8u9tBgpAgfCnbjmu6McQy+3E8=;
        b=c3k179Ess62+zL8DK0kvKFblLESFBULhH6EFR7mX2+AcPuR2SwZyXicsH5dMEaWH2F
         Gfk8gleCgX7ubWMNKXJrYx8YVQrjJbBLSM1SoSIwwvei1C0BhW+gFBPtgxlASpR56wU1
         aJfQbN1GAwMYFaa6xaMDDrgKOXY7UlaY2+g1hmJec4/3kkYXgQAahzOtH1RI8xgBgBJO
         0v9lVadrj6E5XrBuEQDWWFWsW40Ptp965MiGUH2D/oAMPZmxGlod1ii+XF6MFwcEU5o0
         XRTzfdirWhNT0xK5xrem/VBsRj71+ekH3lNQYaTBX591XRhnUQvjEl0CGRPniP2bERvU
         LVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr7tgwlXiamYqI5PxE8u9tBgpAgfCnbjmu6McQy+3E8=;
        b=6IEYNz7dksCRwo+viT8MvLDtNDyjBBrgfy19njn31fryadDkiGZW8p7kLkWZjGRCYL
         /wXtBSup3TzdN6g0ml9NDx1AtKYWBX97hRc6U7BkIbEQcOWqnBuGCoTMLaYcF8IXkTPC
         gBmeXSXgod80JLX1pwS6G3Jat9uyFsUWIo4NwyFiyaD+EfJt3LW2qvSstos+YJ8Fu5nG
         AMIwB6QnPw0Xja7LFNlZRIu1hkt0qMekDoqUVjJ1ZxpBa79gUckpb0BoaCqbZVBzMj6t
         D8tS2UdohcvHfWWlU1BYnFHD1OKyfkCWzxy7zxrmDAQ1LSTxHTmmYxORlTKmF/yHbo5l
         c1UA==
X-Gm-Message-State: AOAM531GfFTYHoYa9JqNCye7zhU4JIArbzk2KJtyx26YsWipTygY9H82
        Ha96YxnBS0JChsacJNutClKC351Z6KQjnrJt+xc=
X-Google-Smtp-Source: ABdhPJyAY7TZgjrBf0O71sttZA6g3GZXQCpe02yXMAJjfBCii8KQNrLKSMm4qfXNxx47PLyPl5wU7NQOXQxmIxC9PQM=
X-Received: by 2002:a05:6602:1502:: with SMTP id g2mr14280491iow.155.1642600739171;
 Wed, 19 Jan 2022 05:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20220117053349.6804-1-ojeda@kernel.org> <20220117053349.6804-15-ojeda@kernel.org>
 <87fspk1xoc.fsf@meer.lwn.net>
In-Reply-To: <87fspk1xoc.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Jan 2022 14:58:48 +0100
Message-ID: <CANiq72mXAgOL-ieNnF8CPMnLopeCyWY3aKA0Fx4t_P963ABGJg@mail.gmail.com>
Subject: Re: [PATCH v3 14/19] docs: add Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 11:33 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> We have really tried to keep binary files (like PNG images) out of the
> documentation tree.  If we really need these images, can they be
> provided in SVG form?

Yeah, they are not critical -- I can change them to a single SVG, or
use Tux, or drop them (although it is a nice way to tell one is not in
the Rust standard library docs).

Is there a preferred SVG version of Tux? (I cannot find one in the
tree, only the GIF one at `Doc/logo.gif`). If not, perhaps we could
ask permission to integrate one like https://github.com/garrett/Tux.

Cheers,
Miguel
