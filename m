Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3BD4FB51A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245550AbiDKHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbiDKHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:42:57 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE7559B;
        Mon, 11 Apr 2022 00:40:43 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ndoey-001IZv-1k; Mon, 11 Apr 2022 17:40:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 11 Apr 2022 15:40:28 +0800
Date:   Mon, 11 Apr 2022 15:40:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 00/19] crypto: allwinner: lots of fixes
Message-ID: <YlPbbM7RurahUMn/@gondor.apana.org.au>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
 <Yk/xNIjjINj9Hvki@gondor.apana.org.au>
 <YlPasmjElADX+7u5@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlPasmjElADX+7u5@Red>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:37:22AM +0200, LABBE Corentin wrote:
>
> Coul you give me more details ?
> I do not have any sparse error.

Did you compile with C=1? Anyway, for a start hash_pad is broken as
it tries to store an le32 value into a u32.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
