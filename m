Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583C0487141
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiAGDeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:34:22 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59076 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345090AbiAGDeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:34:20 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n5g16-0007Be-2y; Fri, 07 Jan 2022 14:34:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jan 2022 14:34:11 +1100
Date:   Fri, 7 Jan 2022 14:34:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     ebiggers@kernel.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: af_alg - check possible NULL pointer
Message-ID: <Yde0s8CAr30qrCoj@gondor.apana.org.au>
References: <20211231014036.1870631-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231014036.1870631-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 09:40:36AM +0800, Jiasheng Jiang wrote:
> Because of the possible alloc failure of the alloc_page(), it could
> return NULL pointer.
> And there is a check below the sg_assign_page().
> But it will be more logical to move the NULL check before the
> sg_assign_page().
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2
> 
> * Change 1. Move the previous check in front of sg_assign_page().
> ---
>  crypto/af_alg.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Patch applied with modified Subject line.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
