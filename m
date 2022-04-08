Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10634F90D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiDHId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiDHId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:33:56 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87034648;
        Fri,  8 Apr 2022 01:31:54 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nck1y-000SEc-NL; Fri, 08 Apr 2022 18:31:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Apr 2022 16:31:46 +0800
Date:   Fri, 8 Apr 2022 16:31:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, gilad@benyossef.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - test in-place en/decryption with two
 sglists
Message-ID: <Yk/y8i26b+b8h8mw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326071159.56056-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As was established in the thread
> https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/T/#u,
> many crypto API users doing in-place en/decryption don't use the same
> scatterlist pointers for the source and destination, but rather use
> separate scatterlists that point to the same memory.  This case isn't
> tested by the self-tests, resulting in bugs.
> 
> This is the natural usage of the crypto API in some cases, so requiring
> API users to avoid this usage is not reasonable.
> 
> Therefore, update the self-tests to start testing this case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> crypto/testmgr.c | 75 ++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 63 insertions(+), 12 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
