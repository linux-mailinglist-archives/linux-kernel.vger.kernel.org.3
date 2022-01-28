Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6449F387
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiA1GYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:24:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60600 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237958AbiA1GYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:24:19 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKg1-00010v-JL; Fri, 28 Jan 2022 17:24:06 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:24:05 +1100
Date:   Fri, 28 Jan 2022 17:24:05 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ananth Jasty <Ananth.Jasty@cavium.com>,
        Omer Khaliq <okhaliq@caviumnetworks.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: cavium - HW_RANDOM_CAVIUM should depend on
 ARCH_THUNDER
Message-ID: <YfOMBRn+fYtj1sYD@gondor.apana.org.au>
References: <1c4148e1aaa4d89754ff810386dee8c22bcce4b1.1641996225.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4148e1aaa4d89754ff810386dee8c22bcce4b1.1641996225.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:05:03PM +0100, Geert Uytterhoeven wrote:
> The Cavium ThunderX Random Number Generator is only present on Cavium
> ThunderX SoCs, and not available as an independent PCIe endpoint.  Hence
> add a dependency on ARCH_THUNDER, to prevent asking the user about this
> driver when configuring a kernel without Cavium Thunder SoC  support.
> 
> Fixes: cc2f1908c6b8f625 ("hwrng: cavium - Add Cavium HWRNG driver for ThunderX SoC.")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/char/hw_random/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
