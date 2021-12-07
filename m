Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1C46B2E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhLGGbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:31:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57512 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhLGGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:31:49 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1muTxD-0000Po-8T; Tue, 07 Dec 2021 17:27:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Dec 2021 17:27:55 +1100
Date:   Tue, 7 Dec 2021 17:27:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
Message-ID: <20211207062754.GA12622@gondor.apana.org.au>
References: <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
 <202112012304.973C04859C@keescook>
 <20211203022821.GA16082@gondor.apana.org.au>
 <YaqC1mkcyzO2WrI/@google.com>
 <20211207052029.GA12141@gondor.apana.org.au>
 <Ya7+L33dFnm0q+jm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya7+L33dFnm0q+jm@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:24:47PM -0800, Dmitry Torokhov wrote:
>
> That is what I am confused about: why can't it be a part of API? Users
> that are running in atomic contexts would not be able to use it, but we
> have a lot of precedents for it. See for example spi_sync() vs
> spi_async(). Callers have a choice as to which one to use, based on
> their needs.

We already have a helper in the form of crypto_wait_req.  If you
have any suggestions of making this easier to use then I'm more than
happy to consider them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
