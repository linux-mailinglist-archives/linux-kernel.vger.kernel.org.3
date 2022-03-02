Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB34CB345
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiCCABS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiCCAA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:58 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716D4E392;
        Wed,  2 Mar 2022 16:00:11 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXvq-0006D3-JT; Thu, 03 Mar 2022 09:58:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:58:54 +1200
Date:   Thu, 3 Mar 2022 10:58:54 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     trix@redhat.com
Cc:     dhowells@redhat.com, davem@davemloft.net, dan.j.williams@intel.com,
        song@kernel.org, xni@redhat.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cleanup comments
Message-ID: <Yh/2rshgAKcKY7Wx@gondor.apana.org.au>
References: <20220221223118.3744238-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221223118.3744238-1-trix@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
