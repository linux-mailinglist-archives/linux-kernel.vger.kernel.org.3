Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2A4ED2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiCaEQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCaEQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:16:27 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35C3B82CA;
        Wed, 30 Mar 2022 20:59:24 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nZlIw-0003JX-6d; Thu, 31 Mar 2022 14:16:59 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 31 Mar 2022 15:16:58 +1200
Date:   Thu, 31 Mar 2022 15:16:58 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.18
Message-ID: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
References: <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjE5yThYIzih2kM6@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 0e03b8fd29363f2df44e2a7a176d486de550757a:

  crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST (2022-03-14 14:45:45 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.18-p1

for you to fetch changes up to aa8e73eed7d3084c18dd16d195748661c7e881b5:

  crypto: x86/sm3 - Fixup SLS (2022-03-30 16:33:11 +1200)

----------------------------------------------------------------
This push fixes the following issues:

- Missing Kconfig dependency on arm that leads to boot failure.
- x86 SLS fixes.
- Reference leak in the stm32 driver.

----------------------------------------------------------------
Herbert Xu (1):
      crypto: arm/aes-neonbs-cbc - Select generic cbc and aes

Peter Zijlstra (3):
      crypto: x86/chacha20 - Avoid spurious jumps to other functions
      crypto: x86/poly1305 - Fixup SLS
      crypto: x86/sm3 - Fixup SLS

Zheng Yongjun (1):
      crypto: stm32 - fix reference leak in stm32_crc_remove

 arch/arm/crypto/Kconfig                       |  2 ++
 arch/x86/crypto/chacha-avx512vl-x86_64.S      |  4 +--
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl | 38 +++++++++++++--------------
 arch/x86/crypto/sm3-avx-asm_64.S              |  2 +-
 drivers/crypto/stm32/stm32-crc32.c            |  4 ++-
 5 files changed, 27 insertions(+), 23 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
