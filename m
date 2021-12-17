Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0293478654
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhLQIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:39:23 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58072 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhLQIjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:39:21 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my8lm-0000wA-Nl; Fri, 17 Dec 2021 19:39:15 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 19:39:14 +1100
Date:   Fri, 17 Dec 2021 19:39:14 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     George Cherian <gcherian@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: cavium - Use kcalloc() instead of kzalloc()
Message-ID: <20211217083914.GC7018@gondor.apana.org.au>
References: <20211208012459.GA145349@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208012459.GA145349@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 07:24:59PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/cavium/cpt/cptvf_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
