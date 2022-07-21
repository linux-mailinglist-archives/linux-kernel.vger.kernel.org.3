Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957957C567
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGUHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiGUHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:36:53 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC667C1AD;
        Thu, 21 Jul 2022 00:36:51 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oEQjn-002spR-Bb; Thu, 21 Jul 2022 17:36:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 21 Jul 2022 15:36:47 +0800
Date:   Thu, 21 Jul 2022 15:36:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2 3/3] crypto: lib - move crypto_simd_disabled_for_test
 into utils
Message-ID: <YtkCDzwswTZSbr1q@gondor.apana.org.au>
References: <20220716062920.210381-1-ebiggers@kernel.org>
 <20220716062920.210381-4-ebiggers@kernel.org>
 <YtMEFyH8WyPS/vJB@zx2c4.com>
 <YtY0T4qASnYOIjIW@sol.localdomain>
 <Ytj5244/eVaDZ7Bz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytj5244/eVaDZ7Bz@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric:

On Thu, Jul 21, 2022 at 12:01:47AM -0700, Eric Biggers wrote:
>
> Herbert, any thoughts on this?

I'm happy to drop the simd patch for now as there are no users
under lib/crypto.

> Note: I forgot to put a MODULE_LICENSE in the new module, so I'll need to resend
> this patchset even if there are no other issues.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
