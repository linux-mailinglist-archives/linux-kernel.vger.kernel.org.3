Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819256B3FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiGHICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiGHICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:02:36 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8FA7E028;
        Fri,  8 Jul 2022 01:02:34 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9iwZ-00Fryj-B5; Fri, 08 Jul 2022 18:02:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 16:02:31 +0800
Date:   Fri, 8 Jul 2022 16:02:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Biggers <ebiggers@kernel.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] crypto: testmgr - populate RSA CRT parameters in RSA
 test vectors
Message-ID: <Ysfkl9gOIY9muhy9@gondor.apana.org.au>
References: <20220704103840.924-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704103840.924-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:38:40AM +0100, Ignat Korchagin wrote:
> Changes from v1:
>   * replace some accidental spaces with tabs
> 
> In commit f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem
> for faster private key operations") we have started to use the additional
> primes and coefficients for RSA private key operations. However, these
> additional parameters are not present (defined as 0 integers) in the RSA
> test vectors.
> 
> Some parameters were borrowed from OpenSSL, so I was able to find the
> source. I could not find the public source for 1 vector though, so had to
> recover the parameters by implementing Appendix C from [1].
> 
> [1]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Br1.pdf
> 
> Fixes: f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster private key operations")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  crypto/testmgr.h | 121 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 100 insertions(+), 21 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
