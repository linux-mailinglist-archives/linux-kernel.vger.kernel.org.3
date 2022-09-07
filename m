Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA75AFC32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiIGGNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:13:12 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B477A9674C;
        Tue,  6 Sep 2022 23:13:08 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oVoIf-001tpI-S9; Wed, 07 Sep 2022 16:12:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Sep 2022 14:12:37 +0800
Date:   Wed, 7 Sep 2022 14:12:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] crypto: aspeed: fix format unexpected build warning
Message-ID: <Yxg2VSC2ud/lgjik@gondor.apana.org.au>
References: <20220907033431.402208-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907033431.402208-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:34:31AM +0800, Neal Liu wrote:
> This fixes the following similar build warning when
> enabling compile test:
> 
> aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
> 'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
> [-Wformat=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v3: Use "%pad" to print dma_addr_t type.
> v2: Use "%zu" format to print size_t.
> 
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
