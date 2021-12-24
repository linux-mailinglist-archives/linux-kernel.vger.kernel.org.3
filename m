Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1647EADC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbhLXDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:25:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58454 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234131AbhLXDZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:25:33 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n0bCy-0006JK-FF; Fri, 24 Dec 2021 14:25:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Dec 2021 14:25:28 +1100
Date:   Fri, 24 Dec 2021 14:25:28 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: omap: increase priority of DES/3DES
Message-ID: <YcU9qOSDl2v4eZHM@gondor.apana.org.au>
References: <20211215104239.800193-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215104239.800193-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:42:39AM +0000, Corentin Labbe wrote:
> Give the same priority of OMAP DES/3DES than OMAP AES for being sure it
> is picked before software implementation.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/omap-des.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
