Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48544AA674
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379327AbiBEEaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 23:30:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34018 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379317AbiBEEaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 23:30:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nGCi2-0001xt-4e; Sat, 05 Feb 2022 15:30:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Feb 2022 15:30:02 +1100
Date:   Sat, 5 Feb 2022 15:30:02 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/6] hw_random: explicit ordering of initcalls
Message-ID: <Yf39ShK5r7TXXdac@gondor.apana.org.au>
References: <20220124202951.28579-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124202951.28579-1-linux@dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 09:29:46PM +0100, Dominik Brodowski wrote:
> hw-random device drivers depend on the hw-random core being
> initialized. Make this ordering explicit, also for the case
> these drivers are built-in. As the core itself depends on
> misc_register() which is set up at subsys_initcall time,
> advance the initialization of the core (only) to the
> fs_initcall() level.
> 
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
