Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9558584EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiG2KkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiG2KkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:40:04 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF08212B;
        Fri, 29 Jul 2022 03:40:03 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oHNPJ-005ohf-IE; Fri, 29 Jul 2022 20:39:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Jul 2022 18:39:49 +0800
Date:   Fri, 29 Jul 2022 18:39:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: hisilicon/zip: Use the bitmap API to allocate
 bitmaps
Message-ID: <YuO49YudyXyK2o5x@gondor.apana.org.au>
References: <456a8b00720d603221c8329c19e38b9f4d96d15a.1658437112.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456a8b00720d603221c8329c19e38b9f4d96d15a.1658437112.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:58:53PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the semantic.
> 
> While at it, add an explicit include <linux/bitmap.h>.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2
> - add the missing include <linux/bitmap.h>
> ---
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
