Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F38575DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiGOIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiGOIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:47:08 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172E814B2;
        Fri, 15 Jul 2022 01:47:07 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oCGyS-000nsb-6M; Fri, 15 Jul 2022 18:47:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Jul 2022 16:47:00 +0800
Date:   Fri, 15 Jul 2022 16:47:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yuan Can <yuancan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, gilad@benyossef.com
Subject: Re: [PATCH -next] crypto: ccree: Add missing clk_disable_unprepare()
 in cc_pm_resume()
Message-ID: <YtEphJCnOOkh8pDf@gondor.apana.org.au>
References: <20220704130145.103520-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704130145.103520-1-yuancan@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 01:01:45PM +0000, Yuan Can wrote:
> Add clk_disable_unprepare() on error path in cc_pm_resume().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/crypto/ccree/cc_pm.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
