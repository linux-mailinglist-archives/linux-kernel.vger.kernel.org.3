Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9949F39D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbiA1G1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:27:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60622 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346464AbiA1G1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:27:47 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKjP-0001EQ-Bt; Fri, 28 Jan 2022 17:27:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:27:35 +1100
Date:   Fri, 28 Jan 2022 17:27:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     arno@natisbad.org, bbrezillon@kernel.org, sthotton@marvell.com,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com, schalla@marvell.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx2: select CONFIG_NET_DEVLINK
Message-ID: <YfOM1+ydDpsbV09r@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b2f0754d958e2659a88e4c8d005267ef428302.1642763325.git.sthotton@marvell.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shijith Thotton <sthotton@marvell.com> wrote:
> OcteonTX2 CPT driver will fail to link without devlink support.
> 
> aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_egrp_delete':
> otx2_cpt_devlink.c:18: undefined reference to `devlink_priv'
> aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_egrp_create':
> otx2_cpt_devlink.c:9: undefined reference to `devlink_priv'
> aarch64-linux-gnu-ld: otx2_cpt_devlink.o: in function `otx2_cpt_dl_uc_info':
> otx2_cpt_devlink.c:27: undefined reference to `devlink_priv'
> 
> Fixes: fed8f4d5f946 ("crypto: octeontx2 - parameters for custom engine groups")
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> drivers/crypto/marvell/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
