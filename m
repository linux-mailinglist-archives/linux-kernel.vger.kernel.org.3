Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9064A3C31
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348001AbiAaAUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:20:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60732 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbiAaAUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:20:13 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nEKQL-0004gL-E4; Mon, 31 Jan 2022 11:20:02 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 31 Jan 2022 11:20:01 +1100
Date:   Mon, 31 Jan 2022 11:20:01 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shijith Thotton <sthotton@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <YfcrMYJOK17xW04s@gondor.apana.org.au>
References: <20220131093406.4200546c@canb.auug.org.au>
 <YfceGSj+h+Iir0nU@gondor.apana.org.au>
 <20220131111111.36510e25@elm.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131111111.36510e25@elm.ozlabs.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:15:31AM +1100, Stephen Rothwell wrote:
>
> Are you intending to send that to Linus soon (as it fixes a commit that
> was merged in v5.17-rc1)?  I would have expected to see it in the
> crypto-current tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git#master)
> in which case it would have been merged before the kspp tree.

You're right Stephen.  I will push this to the crypto tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
