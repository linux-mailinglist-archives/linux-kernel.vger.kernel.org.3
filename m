Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425B44830C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiACL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:57:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41336 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:57:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 247DFCE1067;
        Mon,  3 Jan 2022 11:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E7C36AEE;
        Mon,  3 Jan 2022 11:57:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YYtVsh7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641211033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NjiQWhI2VRYAqjTE3GPohUBLVPfMZKC3yRGvItaRVQ=;
        b=YYtVsh7OTMwXDMYEOAmDX97XJcb/M6Rt3a0hoZAwGmz4sy0I+6xZYnYlNIB/X0o34SBgTf
        v8LLveloZeL60VeKNCv5NE0J7cYg7beDi81HsFLATfG4Z34mgQuX/z4ZxhFS1HzP9/Il9r
        FIcelO84b/0xhNWm/3RhBksN2bGmDDI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a78f2f63 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 3 Jan 2022 11:57:13 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id d1so77820891ybh.6;
        Mon, 03 Jan 2022 03:57:13 -0800 (PST)
X-Gm-Message-State: AOAM531heZ1ZIC4HjMwCynqXoKOvCzgLHun6looiSX/pHLWizHjHoZRK
        rV1poKv0cFgJYNUD0jVQ+Hl4w2gHLete+3gVS8M=
X-Google-Smtp-Source: ABdhPJwZD9ptgnwHx6tW9y+0upOq4teKu3cL5RaOr55n0gx1m5qVbOvNTAfIxqKJFd/149qNa9EAyuYn60b8sgjPMtw=
X-Received: by 2002:a25:e6c5:: with SMTP id d188mr43366794ybh.638.1641211031821;
 Mon, 03 Jan 2022 03:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20220101155937.381821-1-Jason@zx2c4.com> <20220102204203.521148-1-Jason@zx2c4.com>
 <YdJsNrsXqPf0CNEc@gondor.apana.org.au> <CAHmME9p+-TMR4mywPH2wasY52fyBVGPpYmBwmn9aF0MF+14W8Q@mail.gmail.com>
 <YdJ2X+aEOTmRCq1w@gondor.apana.org.au>
In-Reply-To: <YdJ2X+aEOTmRCq1w@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 12:57:01 +0100
X-Gmail-Original-Message-ID: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
Message-ID: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
Subject: Re: [PATCH v6] lib/crypto: blake2s: include as built-in
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Mon, Jan 3, 2022 at 5:07 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jan 03, 2022 at 04:45:10AM +0100, Jason A. Donenfeld wrote:
> >
> > Ugh, can we please not? That will really make things much harder and
> > more annoying for me. I have an early pull planned, and you'll quickly
> > be able to rebase on top of it. It also doesn't appear to conflict
> > with anything you have queued up. Please, I would really appreciate
> > some straight forward linearity here, and I don't think my taking it
> > will negatively impact the flow.
>
> Your patches as they stand will break the crypto tree.  So
> that's why they should not go in without the proper changes.

Okay, I'll try to fix them up so that they don't break the crypto
tree, and given below, I think I should be able to do this with fewer
changes to some of the Kconfig, which will hopefully address your
concerns and enable me to take this patch so that things are a bit
more straightforward.


>
> > That snippet is inside an 'if CRYPTO' block, so it can't be selected
> > without CRYPTO being enabled.
>
> No CONFIG_CRYPTO is not the issue.  This depends on specific
> bits of the Crypto API such as CRYPTO_HASH.  Simply selecting
> it is also not acceptable because you will be forcing all of the
> Crypto API into vmlinux even though none of it is required by
> /dev/random.

Thanks, I think I see what your concern is now. I'll take a stab at
addressing that.

Jason
