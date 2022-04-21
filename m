Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E830A509CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387996AbiDUKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388042AbiDUKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:02:51 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870F559E;
        Thu, 21 Apr 2022 03:00:01 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nhTbO-005D0w-ND; Thu, 21 Apr 2022 19:59:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 21 Apr 2022 17:59:55 +0800
Date:   Thu, 21 Apr 2022 17:59:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/2] New compatible for sa3ul for AM62x
Message-ID: <YmErG35E5B2hqrEc@gondor.apana.org.au>
References: <20220412073016.6014-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412073016.6014-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 01:00:14PM +0530, Jayesh Choudhary wrote:
> This series add the new compatible for sa3ul in the bindings and
> driver file which will be used further in device tree nodes to
> enable crypto support in TI SoC AM62x.
> 
> I will post the patch to enable crypto accelerator once this series
> is merged.
> 
> Jayesh Choudhary (2):
>   dt-bindings: crypto: ti,sa2ul: Add a new compatible for AM62
>   crypto: sa2ul: Add the new compatible for AM62
> 
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 1 +
>  drivers/crypto/sa2ul.c                                 | 1 +
>  2 files changed, 2 insertions(+)
> 
> -- 
> 2.17.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
