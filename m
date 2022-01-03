Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F144E482DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 04:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiACDpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 22:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiACDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 22:45:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5BC061761;
        Sun,  2 Jan 2022 19:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA7260E92;
        Mon,  3 Jan 2022 03:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF01C36AED;
        Mon,  3 Jan 2022 03:45:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QAPq1pDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641181513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjJdNg2jFUDWRJ0O5kcln1TCJTfp2GdDTdwrraH/S2M=;
        b=QAPq1pDKR/nU8HIKZo8ue6cXLNkXyLIUy48GFNI8oYid+29cPPmImUEAUn3FkpH5WLQevC
        wP95i3oi0fuHnfzdBS+HJujNPr1teL6SwnxUWCpDH/5WNDTCmPeGoZHvMEIjEwXDrhxin7
        FsWM9ADGoyuwMzpI85qPXx6U8gc1R4w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11500c86 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 3 Jan 2022 03:45:13 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id g80so51841408ybf.0;
        Sun, 02 Jan 2022 19:45:13 -0800 (PST)
X-Gm-Message-State: AOAM533mqksLMjg20lE3cXgnYD0xS9rR94myxpNt+FnUKpkCIiLXJqmR
        vPrpxzEOPTfK/Q9F+m0LzzOv2iGBNZsog/82gOc=
X-Google-Smtp-Source: ABdhPJyxCfl31jKkm2XycCZta7DP5A8SuXOyvK6e88cTSC5QY2T3Csdwi/6Vyi94D1K0D2ZRLxNdDPLP4uJn4ZHPyBQ=
X-Received: by 2002:a05:6902:150d:: with SMTP id q13mr13037133ybu.113.1641181511687;
 Sun, 02 Jan 2022 19:45:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Sun, 2 Jan 2022
 19:45:10 -0800 (PST)
In-Reply-To: <YdJsNrsXqPf0CNEc@gondor.apana.org.au>
References: <20220101155937.381821-1-Jason@zx2c4.com> <20220102204203.521148-1-Jason@zx2c4.com>
 <YdJsNrsXqPf0CNEc@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 04:45:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9p+-TMR4mywPH2wasY52fyBVGPpYmBwmn9aF0MF+14W8Q@mail.gmail.com>
Message-ID: <CAHmME9p+-TMR4mywPH2wasY52fyBVGPpYmBwmn9aF0MF+14W8Q@mail.gmail.com>
Subject: Re: [PATCH v6] lib/crypto: blake2s: include as built-in
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> At this point I think we should push this through crypto.  The
> changes are too invasive with respect to the crypto Kconfig files.

Ugh, can we please not? That will really make things much harder and
more annoying for me. I have an early pull planned, and you'll quickly
be able to rebase on top of it. It also doesn't appear to conflict
with anything you have queued up. Please, I would really appreciate
some straight forward linearity here, and I don't think my taking it
will negatively impact the flow.

>
>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>> index 285f82647d2b..b7a2e50dcbc8 100644
>> --- a/crypto/Kconfig
>> +++ b/crypto/Kconfig
>> @@ -702,7 +702,7 @@ config CRYPTO_BLAKE2S
>>  	  See https://blake2.net for further information.
>>
>>  config CRYPTO_BLAKE2S_X86
>> -	tristate "BLAKE2s digest algorithm (x86 accelerated version)"
>> +	bool "BLAKE2s digest algorithm (x86 accelerated version)"
>>  	depends on X86 && 64BIT
>>  	select CRYPTO_LIB_BLAKE2S_GENERIC
>>  	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
>
> This will break when CRYPTO is disabled because the x86 crypto
> glue code depends on the crypto subsystem.

That snippet is inside an 'if CRYPTO' block, so it can't be selected
without CRYPTO being enabled.
