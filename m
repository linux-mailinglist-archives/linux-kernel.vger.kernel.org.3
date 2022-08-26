Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA55F5A2691
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344345AbiHZLHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbiHZLHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:07:21 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736542A96B;
        Fri, 26 Aug 2022 04:06:35 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oRXAH-00FQBv-SM; Fri, 26 Aug 2022 21:06:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Aug 2022 19:06:17 +0800
Date:   Fri, 26 Aug 2022 19:06:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 07/19] crypto: gemin: Fix error check for dma_map_sg
Message-ID: <YwipKfKJwNe5cQL8@gondor.apana.org.au>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-8-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819060801.10443-8-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 08:07:49AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error.
> 
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/crypto/gemini/sl3516-ce-cipher.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patches 7-12 applied.  Thanks. 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
