Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA749F37E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbiA1GXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:23:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60590 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346336AbiA1GXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:23:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKes-0000uQ-3s; Fri, 28 Jan 2022 17:22:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:22:54 +1100
Date:   Fri, 28 Jan 2022 17:22:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Ensure psp_ret is always init'd in
 __sev_platform_init_locked()
Message-ID: <YfOLvtlyXxir/wBc@gondor.apana.org.au>
References: <20220110211837.1442964-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110211837.1442964-1-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 01:18:37PM -0800, Peter Gonda wrote:
> Initialize psp_ret inside of __sev_platform_init_locked() because there
> are many failure paths with PSP initialization that do not set
> __sev_do_cmd_locked().
> 
> Fixes: e423b9d75e77: ("crypto: ccp - Move SEV_INIT retry for corrupted data")
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/crypto/ccp/sev-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
