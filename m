Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C68599A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiHSLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347979AbiHSLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:01:26 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8F8F618C;
        Fri, 19 Aug 2022 04:01:18 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOzkJ-00CpcI-S7; Fri, 19 Aug 2022 21:01:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 19:00:59 +0800
Date:   Fri, 19 Aug 2022 19:00:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     James Cowgill <james.cowgill@blaize.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwrng: arm-smccc-trng - fix NO_ENTROPY handling
Message-ID: <Yv9ta23samZEBgm1@gondor.apana.org.au>
References: <20220801200338.261264-1-james.cowgill@blaize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801200338.261264-1-james.cowgill@blaize.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 08:04:18PM +0000, James Cowgill wrote:
> The SMCCC_RET_TRNG_NO_ENTROPY switch arm is never used because the
> NO_ENTROPY return value is negative and negative values are handled
> above the switch by immediately returning.
> 
> Fix by handling errors using a default arm in the switch.
> 
> Fixes: 0888d04b47a1 ("hwrng: Add Arm SMCCC TRNG based driver")
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> ---
>  drivers/char/hw_random/arm_smccc_trng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
