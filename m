Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECB51D5B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390948AbiEFK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiEFK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:26:02 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933B5DBFD;
        Fri,  6 May 2022 03:22:19 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nmv6F-00AgIF-If; Fri, 06 May 2022 20:22:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 May 2022 18:22:15 +0800
Date:   Fri, 6 May 2022 18:22:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v5 1/1] crypto: caam/rng: Add support for PRNG
Message-ID: <YnT2142SXfPkZqG8@gondor.apana.org.au>
References: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
 <20220429114808.147108-1-meenakshi.aggarwal@nxp.com>
 <20220429114808.147108-2-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429114808.147108-2-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:48:08PM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> Add support for random number generation using PRNG
> mode of CAAM and expose the interface through crypto API.
> 
> According to the RM, the HW implementation of the DRBG follows
> NIST SP 800-90A specification for DRBG_Hash SHA-256 function
> 
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Reviewed-by: Horia Geant <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/Kconfig    |   8 ++
>  drivers/crypto/caam/Makefile   |   1 +
>  drivers/crypto/caam/caamprng.c | 235 +++++++++++++++++++++++++++++++++
>  drivers/crypto/caam/intern.h   |  15 +++
>  drivers/crypto/caam/jr.c       |   3 +-
>  5 files changed, 261 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/caam/caamprng.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
