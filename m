Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5057DCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiGVIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiGVIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:47:23 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833435F7D;
        Fri, 22 Jul 2022 01:47:22 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oEoJa-003HWP-Fw; Fri, 22 Jul 2022 18:47:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jul 2022 16:47:18 +0800
Date:   Fri, 22 Jul 2022 16:47:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: testmgr - some more fixes to RSA test vectors
Message-ID: <YtpkFnJf2CAxFpg9@gondor.apana.org.au>
References: <20220717133746.918-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717133746.918-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 02:37:46PM +0100, Ignat Korchagin wrote:
> Two more fixes:
> 
>   * some test vectors in commit 79e6e2f3f3ff ("crypto: testmgr - populate
>     RSA CRT parameters in RSA test vectors") had misplaced commas, which
>     break the test and trigger KASAN warnings at least on x86-64
> 
>   * pkcs1pad test vector did not have its CRT parameters
> 
> Fixes: 79e6e2f3f3ff ("crypto: testmgr - populate RSA CRT parameters in RSA test vectors")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  crypto/testmgr.h | 102 +++++++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 39 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
