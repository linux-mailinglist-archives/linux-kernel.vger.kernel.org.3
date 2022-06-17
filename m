Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59554F433
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380098AbiFQJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381058AbiFQJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:25:26 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17906007D;
        Fri, 17 Jun 2022 02:25:25 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o28Dw-008C24-Gl; Fri, 17 Jun 2022 19:25:06 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jun 2022 17:25:04 +0800
Date:   Fri, 17 Jun 2022 17:25:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] crypto: sun8i-ss - fix infinite loop in
 sun8i_ss_setup_ivs()
Message-ID: <YqxIcHQn+nD+Lsuj@gondor.apana.org.au>
References: <1654885635-32290-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654885635-32290-1-git-send-email-khoroshilov@ispras.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 09:27:15PM +0300, Alexey Khoroshilov wrote:
> There is no i decrement in while (i >= 0) loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
> ---
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
