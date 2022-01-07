Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4539648713F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbiAGDd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:33:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59074 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345090AbiAGDd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:33:56 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n5g0n-0007Ai-AH; Fri, 07 Jan 2022 14:33:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jan 2022 14:33:53 +1100
Date:   Fri, 7 Jan 2022 14:33:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zizhuang Deng <sunsetdzz@gmail.com>
Cc:     tianjia.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] lib/mpi: Add the return value check of kcalloc()
Message-ID: <Yde0oUB6lPvIpkrW@gondor.apana.org.au>
References: <20211230070331.1046343-1-sunsetdzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230070331.1046343-1-sunsetdzz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 03:03:31PM +0800, Zizhuang Deng wrote:
> Add the return value check of kcalloc() to avoid potential
> NULL ptr dereference.
> 
> Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
> ---
>  lib/mpi/mpi-mod.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
