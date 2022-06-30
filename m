Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DA561493
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiF3ISF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiF3IRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:17:00 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD042A3A;
        Thu, 30 Jun 2022 01:14:41 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o6pJq-00Cy6S-1o; Thu, 30 Jun 2022 18:14:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Jun 2022 16:14:34 +0800
Date:   Thu, 30 Jun 2022 16:14:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     davem@davemloft.net, gcherian@marvell.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangjian@cdjrlc.com
Subject: Re: [PATCH] crypto: cavium - fix typos in comments
Message-ID: <Yr1basEPH0z8lJTw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622160222.10753-1-jiangjian@cdjrlc.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiang Jian <jiangjian@cdjrlc.com> wrote:
> Replace 'is' with 'it'
> 
> file: drivers/crypto/cavium/cpt/cpt_hw_types.h
> line: 268
> 
> *       which if the line hits and is is dirty will cause the line to be
> 
> changed to:
> *       which if the line hits and it is dirty will cause the line to be
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
> drivers/crypto/cavium/cpt/cpt_hw_types.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
