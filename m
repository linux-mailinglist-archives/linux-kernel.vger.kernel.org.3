Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE0484BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiAEA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:28:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58966 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236750AbiAEA2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:28:49 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n4uAQ-0006EQ-Qg; Wed, 05 Jan 2022 11:28:39 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 05 Jan 2022 11:28:38 +1100
Date:   Wed, 5 Jan 2022 11:28:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
Message-ID: <YdTmNqpGxRKZTPsw@gondor.apana.org.au>
References: <CAHmME9oPcEjRnqDesPNKJNOsT+i9vmWRxy9c62t+Xu9Nohsi2A@mail.gmail.com>
 <20220103123152.1043972-1-Jason@zx2c4.com>
 <YdOhMPwL9sXllm8X@gondor.apana.org.au>
 <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFhygHnB12g9MD0wMo_deZ6xd7FMEzbrvEvKVtqYdskAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 06:02:52PM +0100, Ard Biesheuvel wrote:
>
> The only downside here is that the ARM/x86 accelerated shashes and the
> generic shash now use the same core transform, right? Given that the
> generic blake2s shash is never used for anything in the kernel, the
> only reason for its existence was to be able to use the randomized
> crypto testing infrastructure to test the arch code.
> 
> Ergo, there is no point in retaining the blake2s shashes and we can
> simply remove all of them. (Note that blake2b is used as an shash via
> the crypto API by btrfs, but blake2s is only used via the library API)

I have no objections to removing blake2s.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
