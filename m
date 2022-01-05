Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD0485B21
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiAEVxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiAEVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:53:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90AC061245;
        Wed,  5 Jan 2022 13:53:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD7461941;
        Wed,  5 Jan 2022 21:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE1EC36AEB;
        Wed,  5 Jan 2022 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641419601;
        bh=mQ/3HsG80cYdm5868lW6A5Jt9A4S+VlmnjhN5ANY1Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHUp9BiRs/WIFPw28K0+UzPPKP1OcOUGPmjo9z3smImearRcLq4rg1GmphZCpDGVT
         L/H4NGwWUzmKWmJKceEtUxbXeBGxA+xyKzGhZ+Rl/+1j0khIOib+cQNGbTaPDWDWFC
         sEcvTB7f2f7j0V65QemiTMHW5LhgyfJvYXf8gnT5Otks8r+5Dw2YSVfYEKBYiMWeot
         UYTZtxs3bIITCmppbIGUE/PwTX55ClNjp6XMVaZMu71b1MB3QzkqIwuBWqBQiggBD7
         qT7fuMjaPy6pgadBUVbG9YALMXMzIXDEcNHlQJppdQCO2hHrsilJda5yH3IN1J/FSB
         JvfEecYB/0Geg==
Date:   Wed, 5 Jan 2022 13:53:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v7] lib/crypto: blake2s: include as built-in
Message-ID: <YdYTUCR2GM/6CXmF@gmail.com>
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
> The only downside here is that the ARM/x86 accelerated shashes and the
> generic shash now use the same core transform, right?

I don't see how this is the case, given that crypto/blake2s_generic.c still uses
blake2s_compress_generic(), not blake2s_compress().

- Eric
