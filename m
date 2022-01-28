Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9949F38D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbiA1GZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:25:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60604 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242551AbiA1GZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:25:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKgf-000147-JZ; Fri, 28 Jan 2022 17:24:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:24:45 +1100
Date:   Fri, 28 Jan 2022 17:24:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     James Guilford <james.guilford@intel.com>,
        Sean Gulley <sean.m.gulley@intel.com>,
        Chandramouli Narayanan <mouli@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86 - Convert to SPDX identifier
Message-ID: <YfOMLVH6n3aii4bw@gondor.apana.org.au>
References: <20220115001719.1040897-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115001719.1040897-1-nhuck@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 06:17:19PM -0600, Nathan Huckleberry wrote:
> Use SPDX-License-Identifier instead of a verbose license text and
> update external link.
> 
> Cc: James Guilford <james.guilford@intel.com>
> Cc: Sean Gulley <sean.m.gulley@intel.com>
> Cc: Chandramouli Narayanan <mouli@linux.intel.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  arch/x86/crypto/aes_ctrby8_avx-x86_64.S | 63 ++++---------------------
>  1 file changed, 10 insertions(+), 53 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
