Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4037559645
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFXJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiFXJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:15:30 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E156FBF;
        Fri, 24 Jun 2022 02:15:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o4fPO-00Ai5b-Dq; Fri, 24 Jun 2022 19:15:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Jun 2022 17:15:22 +0800
Date:   Fri, 24 Jun 2022 17:15:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yoan Picchi <yoan.picchi@arm.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 0/2] crypto: qat - Remove x86 dependency on QAT drivers
Message-ID: <YrWAqhQTqgoo/Oup@gondor.apana.org.au>
References: <20220617095945.437601-1-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617095945.437601-1-yoan.picchi@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:59:43AM +0000, Yoan Picchi wrote:
> The QAT acceleration card can be very helpfull for some tasks like dealing
> with IPSEC but it is currently restricted to be used only on x86 machine.
> Looking at the code we didn't see any reasons why those drivers might not
> work on other architectures. We've successfully built all of them on x86,
> arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
> 
> We also have tested the driver with an Intel Corporation C62x Chipset
> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After the numa
> patch, it works with the AF_ALG crypto userland interface, allowing us to
> encrypt some data with cbc for instance. We've also successfully created some
> VF, bound them to DPDK, and used the card this way, thus showing some real
> life usecases of x86 do work on arm64 too.
> 
> Changelog v1 ... v2:
> - Add COMPILE_TEST to Kconfig
> 
> Changelog v2 ... v3:
> - Add the Crypto tag to the commit header
> 
> Andre Przywara (1):
>   crypto: qat - replace get_current_node() with numa_node_id()
> 
> Yoan Picchi (1):
>   crypto: qat - Removes the x86 dependency on the QAT drivers
> 
>  drivers/crypto/qat/Kconfig                     | 14 +++++++-------
>  drivers/crypto/qat/qat_common/adf_common_drv.h |  5 -----
>  drivers/crypto/qat/qat_common/qat_algs.c       |  4 ++--
>  drivers/crypto/qat/qat_common/qat_asym_algs.c  |  4 ++--
>  4 files changed, 11 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
