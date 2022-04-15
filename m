Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415F5026E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbiDOInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbiDOInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:43:07 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023DF2FFDF;
        Fri, 15 Apr 2022 01:40:38 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nfHVK-003EZS-7x; Fri, 15 Apr 2022 18:40:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Apr 2022 16:40:34 +0800
Date:   Fri, 15 Apr 2022 16:40:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     conor.dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/1] hwrng: mpfs - add polarfire soc hwrng support
Message-ID: <Ylkvgo8Lcpmi09x1@gondor.apana.org.au>
References: <20220408100911.1638478-1-conor.dooley@microchip.com>
 <20220408100911.1638478-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408100911.1638478-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:09:12AM +0000, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a driver to access the hardware random number generator on the
> Polarfire SoC. The hwrng can only be accessed via the system controller,
> so use the mailbox interface the system controller exposes to access the
> hwrng.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/char/hw_random/Kconfig    |  13 ++++
>  drivers/char/hw_random/Makefile   |   1 +
>  drivers/char/hw_random/mpfs-rng.c | 104 ++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 drivers/char/hw_random/mpfs-rng.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
