Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA9484663
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiADREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiADREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D57C061761;
        Tue,  4 Jan 2022 09:04:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B3E61532;
        Tue,  4 Jan 2022 17:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B96C36AED;
        Tue,  4 Jan 2022 17:04:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X3bARv48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641315886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/o++/iKrFHJpzJR56EnHerKt1+g/uBW9pbf7o4rP70=;
        b=X3bARv48+8YzKIvmOKIlOgvi0oSVcFpHDazytEqvlKJAiaxmBRHWiBmky1vv9X+XJB7q0k
        HUKd1nJwiIzs5hdj1i8CMnGfEdrTmA0OFM8iMxM5NpMgdYKc9uf7R2RNATDDZj4NBhNvKS
        IVg9dQZRqhmCKRQdzgTLjatViSMsujI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17c9c4aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 4 Jan 2022 17:04:46 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id g80so66044277ybf.0;
        Tue, 04 Jan 2022 09:04:46 -0800 (PST)
X-Gm-Message-State: AOAM530Z9humRVVLPrAuFQui7SQOTbA3K6qUrPFR69P/k47KGQY1dxnK
        5h4myvz/dWri94O/n8JLHHOxSvFeeNdam3uyud8=
X-Google-Smtp-Source: ABdhPJwXjVHuBiqVFVPB8qF1Cv2eBNUgbN8fxufOKh6//foPnGUSVKa+OQc4TVgqOOHhHGLJwZ322Ag28sYY5nzodDA=
X-Received: by 2002:a25:938d:: with SMTP id a13mr48767794ybm.457.1641315885519;
 Tue, 04 Jan 2022 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com> <YdOhMPwL9sXllm8X@gondor.apana.org.au>
 <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 4 Jan 2022 18:04:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9quP2W3WQzM1ZRSMPiinD=2bz3sxFv2mOFYT9U-+aPhLA@mail.gmail.com>
Message-ID: <CAHmME9quP2W3WQzM1ZRSMPiinD=2bz3sxFv2mOFYT9U-+aPhLA@mail.gmail.com>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jan 4, 2022 at 6:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> The only downside here is that the ARM/x86 accelerated shashes and the
> generic shash now use the same core transform, right? Given that the
> generic blake2s shash is never used for anything in the kernel, the
> only reason for its existence was to be able to use the randomized
> crypto testing infrastructure to test the arch code.
>
> Ergo, there is no point in retaining the blake2s shashes and we can
> simply remove all of them. (Note that blake2b is used as an shash via
> the crypto API by btrfs, but blake2s is only used via the library API)

That makes sense and is fine with me. Let's do that in a separate
commit later. I've got a bunch of things I'd like to fix up in the
general lib/crypto vs crypto split that are kind of interrelated.

Jason
