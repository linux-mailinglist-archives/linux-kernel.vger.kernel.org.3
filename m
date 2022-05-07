Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37351E366
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445293AbiEGCGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiEGCGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:06:30 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DA5FF3B;
        Fri,  6 May 2022 19:02:43 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nn9mG-00Av3f-0V; Sat, 07 May 2022 12:02:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 07 May 2022 10:02:36 +0800
Date:   Sat, 7 May 2022 10:02:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] crypto: vmx - Align the short log with Makefile cleanups
Message-ID: <YnXTPPXRlCpUvoKz@gondor.apana.org.au>
References: <20220501130749.1123387-1-masahiroy@kernel.org>
 <YnT3GtU975OsXVuN@gondor.apana.org.au>
 <CAK7LNASkQ_14NYu7K_eEOG4boBMpKEXyrOzDJMOjcT5paC7E1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASkQ_14NYu7K_eEOG4boBMpKEXyrOzDJMOjcT5paC7E1A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 12:25:32AM +0900, Masahiro Yamada wrote:
>
> Sorry, I just noticed the 0day bot had reported the error.
> 
> I sent v2.    (CONFIG_LITTLE_ENDIAN  --> CONFIG_CPU_LITTLE_ENDIAN)
> 
> https://lore.kernel.org/lkml/20220506150820.1310802-1-masahiroy@kernel.org/
> 
> 
> Could you replace it, or fix it up, please?

Please send me an incremental patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
