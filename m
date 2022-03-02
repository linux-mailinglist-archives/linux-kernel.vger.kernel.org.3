Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81C04CB39F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiCCAAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiCCAAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:25 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44749F97;
        Wed,  2 Mar 2022 15:59:40 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXur-0006BG-Kw; Thu, 03 Mar 2022 09:57:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:57:53 +1200
Date:   Thu, 3 Mar 2022 10:57:53 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mpm@selenic.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] hwrng: atmel - add runtime pm support
Message-ID: <Yh/2ca39ikM+pcTa@gondor.apana.org.au>
References: <20220221075928.563806-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221075928.563806-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:59:21AM +0200, Claudiu Beznea wrote:
> Hi,
> 
> This series adds runtime PM support for atmel-rng driver. Along with
> this some cleanup and fixes patches were added to the series.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (7):
>   hwrng: atmel - add wait for ready support on read
>   hwrng: atmel - disable trng on failure path
>   hwrng: atmel - rename enable/disable functions to init/cleanup
>   hwrng: atmel - move set of TRNG_HALFR in atmel_trng_init()
>   hwrng: atmel - use __maybe_unused and pm_ptr() for pm ops
>   hwrng: atmel - add runtime pm support
>   hwrng: atmel - remove extra line
> 
>  drivers/char/hw_random/atmel-rng.c | 148 ++++++++++++++++++-----------
>  1 file changed, 91 insertions(+), 57 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
