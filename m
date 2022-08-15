Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353C65951D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiHPFRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiHPFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDFCE05;
        Mon, 15 Aug 2022 14:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A795FB811BF;
        Mon, 15 Aug 2022 21:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D745C433D6;
        Mon, 15 Aug 2022 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660599388;
        bh=4/HG9B1vNLBzy1icJatyjocTnH3m+9Qg+3ewK5Z5ZBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxA09qoKSm98McIK2tJkQRwkPA3BvdnPutPlcPn+CBVsg1028OynKaSs2QkKQ2px7
         gWOcY7If19tLPW1f0pe2G2sLhxmmpQFiu2CMXNjTYfhNd8TvJAH7APBXdHUJz029Ex
         hc/isGNxr3dVuZbzs/dLq6F683CTfHU0T2qY+wyYvSdE45+6mDaXVBYOuCwgFcNSu1
         16mXIf3ZhCJ12cCJwG5Q+aE8cP6DmnqYJanTyCtxjSE6nPHvwoZcXHLG3qSYMYcrzB
         Qy9P48cTrzgiy8euo4hSzFSHpO8YyqVf4G51U0UDLQj21T1W4KtzoSuFYbzQYUr0jE
         2VMDI3wKO8/Cw==
Date:   Mon, 15 Aug 2022 14:36:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        toshi.kani@hpe.com
Subject: Re: [PATCH 8/8] crypto: Kconfig - sort the ciphers
Message-ID: <Yvq8Whax+i2jmQZJ@sol.localdomain>
References: <20220815190608.47182-1-elliott@hpe.com>
 <20220815190608.47182-9-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815190608.47182-9-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:06:08PM -0500, Robert Elliott wrote:
> Sort the entries in Ciphers by their displayed names.
> In particular, keep the optimized CPU implementations next to the
> generic implementations.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  crypto/Kconfig | 118 ++++++++++++++++++++++++-------------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index f5cfb73e2423..03f4e2d97ef9 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1500,6 +1500,65 @@ menu "Ciphers"
>  
>  	  Processes eight blocks in parallel.
>  
> +config CRYPTO_CHACHA20
> +	tristate "ChaCha"
> +	select CRYPTO_LIB_CHACHA_GENERIC
> +	select CRYPTO_SKCIPHER
> +	help
> +	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
> +
> +	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
> +	  Bernstein and further specified in RFC7539 for use in IETF protocols.
> +	  This is the portable C implementation of ChaCha20.  See
> +	  https://cr.yp.to/chacha/chacha-20080128.pdf for further information.
> +
> +	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
> +	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
> +	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
> +	  while provably retaining ChaCha20's security.  See
> +	  https://cr.yp.to/snuffle/xsalsa-20081128.pdf for further information.
> +
> +	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
> +	  reduced security margin but increased performance.  It can be needed
> +	  in some performance-sensitive scenarios.
> +
> +config CRYPTO_CHACHA20_X86_64
> +	tristate "ChaCha (x86_64 with SSSE3/AVX2/AVX-512VL)"
> +	depends on X86 && 64BIT
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_LIB_CHACHA_GENERIC
> +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> +	help
> +	  ChaCha stream cipher algorithms
> +
> +	  Architecture: x86_64 using:
> +	  * SSSE3 (Supplemental SSE3)
> +	  * AVX2 (Advanced Vector Extensions 2)
> +	  * AVX-512VL (Advanced Vector Extensions-512VL)
> +
> +config CRYPTO_CHACHA_MIPS
> +	tristate "ChaCha (MIPS32r2)"
> +	depends on CPU_MIPS32_R2
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> +	help
> +	  ChaCha stream cipher algorithms
> +
> +	  Architecture: MIPS32r2
> +
> +config CRYPTO_CHACHA_S390
> +	tristate "ChaCha20 (s390)"
> +	depends on S390
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_LIB_CHACHA_GENERIC
> +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
> +	help
> +	  ChaCha20 stream cipher (RFC 7539)
> +
> +	  Architecture: s390
> +
> +	  It is available as of z13.

Do we want to keep the architecture-specific options in crypto/Kconfig?  arm and
arm64 split them out into a separate file arch/$arch/crypto/Kconfig.  Perhaps
the other architectures should adopt that?

- Eric
