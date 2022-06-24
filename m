Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245955947B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFXIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiFXIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:00:33 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC26B8C9;
        Fri, 24 Jun 2022 01:00:32 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o4eEO-00AgF9-Nt; Fri, 24 Jun 2022 17:59:58 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Jun 2022 15:59:57 +0800
Date:   Fri, 24 Jun 2022 15:59:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/crypto: Select AEAD2 for GHASH_ARM64_CE
Message-ID: <YrVu/T3saRzkh61I@gondor.apana.org.au>
References: <20220622142557.144536-1-quic_qiancai@quicinc.com>
 <YrSgH//ysOd/Qumo@sol.localdomain>
 <YrS6MIhv/ze4rbxy@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrS6MIhv/ze4rbxy@qian>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 03:08:32PM -0400, Qian Cai wrote:
>
> I am not sure about that. I chose CRYPTO_AEAD2 because that is in the
> Makefile.
> 
> obj-$(CONFIG_CRYPTO_AEAD2) += aead.o

As Eric said, AEAD2 is for internal use only and the correct option
for general use is CONFIG_CRYPTO_AEAD.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
