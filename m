Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EE478650
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhLQIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:38:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58068 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLQIi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:38:56 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my8l2-0000tv-20; Fri, 17 Dec 2021 19:38:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 19:38:27 +1100
Date:   Fri, 17 Dec 2021 19:38:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/des: remove redundant assignment of variable
 nbytes
Message-ID: <20211217083827.GA7018@gondor.apana.org.au>
References: <20211207185809.1436833-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207185809.1436833-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:58:09PM +0000, Colin Ian King wrote:
> The variable nbytes is being assigned a value that is never read, it is
> being re-assigned in the following statement. The assignment is redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/x86/crypto/des3_ede_glue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
