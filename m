Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9B599A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348458AbiHSLDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348073AbiHSLDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:03:36 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9204E603;
        Fri, 19 Aug 2022 04:03:34 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOzmb-00Cpfj-GC; Fri, 19 Aug 2022 21:03:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 19:03:21 +0800
Date:   Fri, 19 Aug 2022 19:03:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     ebiggers@kernel.org, davem@davemloft.net, kernel@nfschina.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/drbg: remove unnecessary (void*) conversions
Message-ID: <Yv9t+Zmj3BYGf+0U@gondor.apana.org.au>
References: <YvKiRWzWyATdEwGP@gmail.com>
 <20220811071733.5145-1-chuanjian@nfschina.com>
 <20220811071733.5145-2-chuanjian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811071733.5145-2-chuanjian@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:17:33PM +0800, Dong Chuanjian wrote:
> remove unnecessary void* type casting
> 
> v2:
> Turn assignments less than 75 characters into one line.
> 
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
