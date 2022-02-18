Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD04BB06B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBRD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:56:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBRD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:56:06 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E92E59DC;
        Thu, 17 Feb 2022 19:55:49 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nKuMu-0003r4-4Z; Fri, 18 Feb 2022 14:55:41 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Feb 2022 14:55:39 +1100
Date:   Fri, 18 Feb 2022 14:55:39 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccree: fix xts-aes-ccree blocksize
Message-ID: <Yg8Yu/YgCEKeQy44@gondor.apana.org.au>
References: <20220209070608.985213-1-clabbe@baylibre.com>
 <CAOtvUMfhgJBNhDfotkxW0wMyJK-3y4-QGTCKFxG+8oc3EQDKAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMfhgJBNhDfotkxW0wMyJK-3y4-QGTCKFxG+8oc3EQDKAg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:36:41PM +0200, Gilad Ben-Yossef wrote:
> Hi Again,
> 
> Thank you for taking the time to look into this!
> 
> However, this is an old topic that has been discussed before and the
> answer really is that the selftests are wrong. They are looking at the
> wrong thing. Yes, I know...
> 
> See the discussion here:
> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg40576.html
> 
> I also also point out this is actually documented in the code:
> 
> +               /* See
> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg40576.html
> +                * for the reason why this differs from the generic
> +                * implementation.
> +                */

Indeed.  We should instead change the generic algorithm as well
as the other drivers that implement XTS.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
