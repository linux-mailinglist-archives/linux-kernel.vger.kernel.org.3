Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2A4782F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhLQCFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:05:54 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58044 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhLQCFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:05:54 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my2cr-000562-MQ; Fri, 17 Dec 2021 13:05:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 13:05:37 +1100
Date:   Fri, 17 Dec 2021 13:05:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH v1 1/1] crypto: Replace kernel.h with the necessary
 inclusions
Message-ID: <20211217020537.GA16999@gondor.apana.org.au>
References: <20211210143009.4770-1-andriy.shevchenko@linux.intel.com>
 <YbtVNKdrIKFsbIAc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbtVNKdrIKFsbIAc@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:03:16PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 10, 2021 at 04:30:09PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> 
> Any comments on this?

I'm happy with this patch and will be applying it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
