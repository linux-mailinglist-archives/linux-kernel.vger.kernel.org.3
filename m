Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA7527F79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiEPITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiEPITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:19:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507873700C;
        Mon, 16 May 2022 01:18:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y12so6748138ior.7;
        Mon, 16 May 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCT9SZxbUAetmWuf3pk6YIhFQG9M9FNclZ/4QgcwxV8=;
        b=a/bdnw1IqPtXiw1fih/+BYezIE0/Jq7/r4EyNIMu86NVl+0ySxnPYJmHwoK3CHksO/
         lvDpHIVpVz7+E7BwFAMrykx6XxZ6VTmAEQHphiZ70xgxfRWUSFvNgtqZ3/boQCfnTdk0
         +2X/njuIomYruELvtR5eMnBGuHUm/OgoiaBmMVhGnJBRkuyg7mK/pMlBU1jwvWQ5yQzy
         CRgTpQDhtoGLa6stGMYlpdHOmp7ZrZMie/QSx8/QVpnBQGg/8P+QaFXERoZoOcU0Tkxh
         c45/jFRtLq5RmQFRrCGmH34Yunq4hqrNLB+Ik9S9CFboyMqalXXmG7pfnNSXR9fjtbFV
         Vzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCT9SZxbUAetmWuf3pk6YIhFQG9M9FNclZ/4QgcwxV8=;
        b=236RKnudaTu6I2m+D9+3FsF4K5YLNPzKgOPR2QNjPhw1wzwvdmhVPYcAU2Aii89CNO
         mQ+BVdmgWV08dxsBd6sYtgOBJZIqJ6AI4au92+up5DcZhI9v2JopS7fgqgdDGWbba1MM
         BLjmSfUqL2yJzfw+DTGcPILdRe0LPFglaPaM+3rsTcHzyiV4+LPqmuYsTkAZ+BybJfIf
         j4CRr6FjirApHWCywCQ0cfRSEFurUa1gJDXQ0eHTT0X906X2kJFE2nBo1D04I+OqL8px
         2Vq6H6ZX47f9vyMy9RI7oA7wKjaxOh294x6IeIh8FHsHGHtUMemrtRweyOp8GOnq4//C
         DXkg==
X-Gm-Message-State: AOAM532+mp1bvm3MbJ4IS8GTgQa1wFnVDbYZ4x97rTTpBkVVASKG14DO
        yuPTZ8OAcCAHDo4FOlOlc81IEeNf7gCZqm7vGeo=
X-Google-Smtp-Source: ABdhPJyAKWR3S9ULvFDIYESPh0CRsptKrv/IhdA3tpGnUbi7OWK8GTciJxnudA2woMHWRkWykGb00FalObPcHO3v0dg=
X-Received: by 2002:a5e:c643:0:b0:657:b1b0:8e2d with SMTP id
 s3-20020a5ec643000000b00657b1b08e2dmr7285283ioo.64.1652689136547; Mon, 16 May
 2022 01:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220516171329.6b10e4e5@canb.auug.org.au> <YoIB8WCdgHr6Cp+z@kroah.com>
In-Reply-To: <YoIB8WCdgHr6Cp+z@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 May 2022 10:18:45 +0200
Message-ID: <CANiq72mtirFqVr9eHnh9Y=nAbBZcNxspdLoWKzvwmvjHfvBQ4w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the char-misc tree
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
        Carlos Llamas <cmllamas@google.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

Hi Greg,

On Mon, May 16, 2022 at 9:49 AM Greg KH <greg@kroah.com> wrote:
>
> Odd, why does the Rust binder implementation require the IOCTL
> definitions to be in an enum instead of a #define?

It is because bindgen (the tool which generates the "raw" C bindings)
only works with simple C `#define`s. Thus there are two options when
one hits something like this: either copy-paste them manually into the
Rust side (which adds maintenance), or change them into real
objects/identifiers in the C side.

There may be support in the future for expanding macros that end up in
a numeric one: https://github.com/rust-lang/rust-bindgen/issues/753.

Stephen: the resolution looks fine, thanks!

> If that's required, I can take that type of change now to prevent merge
> issues in the future.

We have two so far: this one (for the RFC Android patch) and another
small one in include/linux/spinlock.h (for the `sync` module).

So far I have put those changes in their respective patches, but if
you prefer I can send them independently too (like the prerequisite
patches).

Cheers,
Miguel
