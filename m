Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E444153278C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiEXKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiEXKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:25:28 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2084A19;
        Tue, 24 May 2022 03:25:26 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ntRis-00H2IA-K7; Tue, 24 May 2022 20:25:08 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 24 May 2022 18:25:06 +0800
Date:   Tue, 24 May 2022 18:25:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: linux-next: manual merge of the tpmdd tree with the crypto tree
Message-ID: <YoyyghV5pEOJre4/@gondor.apana.org.au>
References: <20220520165701.14224ddb@canb.auug.org.au>
 <YovnISBB4Y3DGYiW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YovnISBB4Y3DGYiW@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:57:21PM +0300, Jarkko Sakkinen wrote:
>
> Herbert, so I pulled the whole patch set. How should we work out this?

Just send a note about the potential conflict to Linus when you
create the pull request.  He'll sort it out.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
