Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A664BEE18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiBUXXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiBUXX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:23:27 -0500
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 15:23:02 PST
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C224BF0;
        Mon, 21 Feb 2022 15:23:02 -0800 (PST)
Received: from localhost (85-76-106-199-nat.elisa-mobile.fi [85.76.106.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id AB10420194;
        Tue, 22 Feb 2022 01:13:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1645485207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hE5cFqTXfOhA8LxujfvbIZTUsBs4n3EjQ6ZwLzEttuQ=;
        b=YH5U7O4Xv6JdQP64skUJchHFZKbi2mKxoCj2LR7ni7Ubi4jdpfLEJRWhhwA9qD1nGR0MeM
        ehdiYroKkaHgn4aJb9SBF8/AQApN+g7nx/YBxs/woUUyGuH+a8KGIHA7fIVJfGIvohQqRi
        eVbyVnSyGOinvzzqrK00nG8IWk7UrBQ=
Date:   Tue, 22 Feb 2022 00:14:05 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     trix@redhat.com
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dan.j.williams@intel.com, song@kernel.org,
        xni@redhat.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cleanup comments
Message-ID: <YhQcvQl/9MUKzXxO@iki.fi>
References: <20220221223118.3744238-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221223118.3744238-1-trix@redhat.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1645485207; a=rsa-sha256; cv=none;
        b=GeH0PBHQGrtAlqGnTqD3Ol7Z1cKhqKdj4ei1FjEV+CxzItDgcyIReP/Vsd4wGJSrhpDN4V
        FOKckSdpVH8mDqaQgfkUGaG5W6440b+nhgyjhiIHg5Bz6B1AtLXMWgAygLMIa3QPdBTQQL
        MPcz7unfmfq81PfaNsyor7tzD1KVtE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1645485207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hE5cFqTXfOhA8LxujfvbIZTUsBs4n3EjQ6ZwLzEttuQ=;
        b=tpUg1/j4r93UTGv/iUMo+Zwtg76MoLnjbsGNMHAruUFs+ZZeMH2kK7+V+0hMCHvjIuBb7H
        szDJJAVXhFYc1tUpErCVpsAqaaNJQHIHishe3sGWkalj4sMGS7u/QiV7J9d2sKV6/zK/eR
        hTPvhXZByqtO29+7LJoy0Zc7QKj50XY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 02:31:18PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx
> /* */ for *.h, // for *.c
> Space before spdx tag
> 
> Replacements
> paramenters to parameters
> aymmetric to asymmetric
> sigature to signature
> boudary to boundary
> compliled to compiled
> eninges to engines
> explicity to explicitly
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  crypto/asymmetric_keys/signature.c   | 2 +-
>  crypto/asymmetric_keys/x509_parser.h | 2 +-
>  crypto/async_tx/async_xor.c          | 8 ++++----
>  crypto/async_tx/raid6test.c          | 4 ++--
>  crypto/cfb.c                         | 2 +-
>  crypto/dh.c                          | 2 +-
>  crypto/sm2.c                         | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
> index 4aff3eebec17..2deff81f8af5 100644
> --- a/crypto/asymmetric_keys/signature.c
> +++ b/crypto/asymmetric_keys/signature.c
> @@ -35,7 +35,7 @@ void public_key_signature_free(struct public_key_signature *sig)
>  EXPORT_SYMBOL_GPL(public_key_signature_free);
>  
>  /**
> - * query_asymmetric_key - Get information about an aymmetric key.
> + * query_asymmetric_key - Get information about an asymmetric key.
>   * @params: Various parameters.
>   * @info: Where to put the information.
>   */
> diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
> index c233f136fb35..668f5c9f0b54 100644
> --- a/crypto/asymmetric_keys/x509_parser.h
> +++ b/crypto/asymmetric_keys/x509_parser.h
> @@ -22,7 +22,7 @@ struct x509_certificate {
>  	time64_t	valid_to;
>  	const void	*tbs;			/* Signed data */
>  	unsigned	tbs_size;		/* Size of signed data */
> -	unsigned	raw_sig_size;		/* Size of sigature */
> +	unsigned	raw_sig_size;		/* Size of signature */
>  	const void	*raw_sig;		/* Signature data */
>  	const void	*raw_serial;		/* Raw serial number in ASN.1 */
>  	unsigned	raw_serial_size;
> diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
> index d8a91521144e..1a3855284091 100644
> --- a/crypto/async_tx/async_xor.c
> +++ b/crypto/async_tx/async_xor.c
> @@ -170,8 +170,8 @@ dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
>   *
>   * xor_blocks always uses the dest as a source so the
>   * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma eninges is that they only
> - * use the destination buffer as a source when it is explicity specified
> + * the calculation.  The assumption with dma engines is that they only
> + * use the destination buffer as a source when it is explicitly specified
>   * in the source list.
>   *
>   * src_list note: if the dest is also a source it must be at index zero.
> @@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(async_xor_offs);
>   *
>   * xor_blocks always uses the dest as a source so the
>   * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma eninges is that they only
> - * use the destination buffer as a source when it is explicity specified
> + * the calculation.  The assumption with dma engines is that they only
> + * use the destination buffer as a source when it is explicitly specified
>   * in the source list.
>   *
>   * src_list note: if the dest is also a source it must be at index zero.
> diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
> index 66db82e5a3b1..c9d218e53bcb 100644
> --- a/crypto/async_tx/raid6test.c
> +++ b/crypto/async_tx/raid6test.c
> @@ -217,7 +217,7 @@ static int raid6_test(void)
>  		err += test(12, &tests);
>  	}
>  
> -	/* the 24 disk case is special for ioatdma as it is the boudary point
> +	/* the 24 disk case is special for ioatdma as it is the boundary point
>  	 * at which it needs to switch from 8-source ops to 16-source
>  	 * ops for continuation (assumes DMA_HAS_PQ_CONTINUE is not set)
>  	 */
> @@ -241,7 +241,7 @@ static void raid6_test_exit(void)
>  }
>  
>  /* when compiled-in wait for drivers to load first (assumes dma drivers
> - * are also compliled-in)
> + * are also compiled-in)
>   */
>  late_initcall(raid6_test);
>  module_exit(raid6_test_exit);
> diff --git a/crypto/cfb.c b/crypto/cfb.c
> index 0d664dfb47bc..5c36b7b65e2a 100644
> --- a/crypto/cfb.c
> +++ b/crypto/cfb.c
> @@ -1,4 +1,4 @@
> -//SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * CFB: Cipher FeedBack mode
>   *
> diff --git a/crypto/dh.c b/crypto/dh.c
> index 27e62a2a8027..be3138636726 100644
> --- a/crypto/dh.c
> +++ b/crypto/dh.c
> @@ -104,7 +104,7 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
>  /*
>   * SP800-56A public key verification:
>   *
> - * * If Q is provided as part of the domain paramenters, a full validation
> + * * If Q is provided as part of the domain parameters, a full validation
>   *   according to SP800-56A section 5.6.2.3.1 is performed.
>   *
>   * * If Q is not provided, a partial validation according to SP800-56A section
> diff --git a/crypto/sm2.c b/crypto/sm2.c
> index ae3f77a66070..f3e1592965c0 100644
> --- a/crypto/sm2.c
> +++ b/crypto/sm2.c
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * SM2 asymmetric public-key algorithm
>   * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
> -- 
> 2.26.3
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
