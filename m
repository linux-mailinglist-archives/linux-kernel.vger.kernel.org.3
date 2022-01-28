Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3049F19A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiA1C7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:59:36 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60572 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbiA1C7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:59:35 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDHTR-0006y2-9A; Fri, 28 Jan 2022 13:58:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 13:58:53 +1100
Date:   Fri, 28 Jan 2022 13:58:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        "David S. Miller" <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: encryption test failures since "crypto: mxs-dcp - Use
 sg_mapping_iter to copy data"
Message-ID: <YfNb7WMXWv1flCvM@gondor.apana.org.au>
References: <2126453.Icojqenx9y@localhost.localdomain>
 <414858de-f279-c5ce-83ca-5c28d6c847b1@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414858de-f279-c5ce-83ca-5c28d6c847b1@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:31:48PM -0500, Sean Anderson wrote:
> Hi Christian,
> 
> On 1/27/22 12:23 PM, Christian Eggers wrote:
> > SoC: i.MX6ULL
> > 
> > After upgrading from v5.10.65-rt53 to v5.10.73-rt54 I get two additional messages on boot:
> > 
> > ...
> > [ 3.786333] alg: skcipher: ecb-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> > [ 3.789020] alg: skcipher: cbc-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> > [ 3.793741] mxs-dcp 2280000.crypto: mxs_dcp: initialized
> > ..
> > 
> > After reverting the commit
> > 
> > 2e6d793e1bf0 ("crypto: mxs-dcp - Use sg_mapping_iter to copy data")
> > 
> > the error messages above disappear again.
> 
> Can you try applying the patch in [1] on top of your revert?

Please resubmit your patch with a proper Subject, otherwise it'll
be automatically discarded by patchwork.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
