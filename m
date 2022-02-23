Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71C4C0A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiBWDcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiBWDct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:32:49 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C584AE27;
        Tue, 22 Feb 2022 19:32:22 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nMiNy-0006wK-Uo; Wed, 23 Feb 2022 14:32:16 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Feb 2022 15:32:14 +1200
Date:   Wed, 23 Feb 2022 15:32:14 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree: don't attempt 0 len DMA mappings
Message-ID: <YhWqvg47iQXWveOr@gondor.apana.org.au>
References: <20220217192726.612328-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217192726.612328-1-gilad@benyossef.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:27:26PM +0200, Gilad Ben-Yossef wrote:
> Refuse to try mapping zero bytes as this may cause a fault
> on some configurations / platforms and it seems the prev.
> attempt is not enough and we need to be more explicit.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Fixes: ce0fc6db38de ("crypto: ccree - protect against empty or NULL
> scatterlists")
> ---
>  drivers/crypto/ccree/cc_buffer_mgr.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
