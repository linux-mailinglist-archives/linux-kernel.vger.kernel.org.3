Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8094D4823C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhLaLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:35:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58796 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhLaLfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:35:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n3GB5-0004sN-4E; Fri, 31 Dec 2021 22:34:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Dec 2021 22:34:30 +1100
Date:   Fri, 31 Dec 2021 22:34:30 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove duplicate context init function for sha
 algorithm
Message-ID: <Yc7qxrxxIMr5kPSj@gondor.apana.org.au>
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:23:13PM +0800, Tianjia Zhang wrote:
> This series of patches is mainly for repetitive code cleaning. The sha
> algorithm has provided generic context initialization implementation.
> The context initialization code in the optimized implementation of each
> platform is a repetitive code and can be deleted. The sha*_base_init()
> series of functions are used uniformly.
> 
> Tianjia Zhang (5):
>   crypto: sha256 - remove duplicate generic hash init function
>   crypto: mips/sha - remove duplicate hash init function
>   crypto: powerpc/sha - remove duplicate hash init function
>   crypto: sparc/sha - remove duplicate hash init function
>   crypto: s390/sha512 - Use macros instead of direct IV numbers
> 
>  arch/mips/cavium-octeon/crypto/octeon-sha1.c  | 17 +-------
>  .../mips/cavium-octeon/crypto/octeon-sha256.c | 39 ++-----------------
>  .../mips/cavium-octeon/crypto/octeon-sha512.c | 39 ++-----------------
>  arch/powerpc/crypto/sha1-spe-glue.c           | 17 +-------
>  arch/powerpc/crypto/sha1.c                    | 14 +------
>  arch/powerpc/crypto/sha256-spe-glue.c         | 39 ++-----------------
>  arch/s390/crypto/sha512_s390.c                | 32 +++++++--------
>  arch/sparc/crypto/sha1_glue.c                 | 14 +------
>  arch/sparc/crypto/sha256_glue.c               | 37 ++----------------
>  arch/sparc/crypto/sha512_glue.c               | 37 ++----------------
>  crypto/sha256_generic.c                       | 16 +-------
>  11 files changed, 41 insertions(+), 260 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
