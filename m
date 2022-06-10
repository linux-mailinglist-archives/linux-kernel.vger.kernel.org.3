Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA15461AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiFJJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiFJJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:18:31 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7400E8BA4;
        Fri, 10 Jun 2022 02:16:17 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nzakJ-005Mct-RQ; Fri, 10 Jun 2022 19:16:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jun 2022 17:16:00 +0800
Date:   Fri, 10 Jun 2022 17:16:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: octeontx2: add firmware version in devlink info
Message-ID: <YqML0PX4GbignSK4@gondor.apana.org.au>
References: <421b1fbe94a82e678887260f768478c11daa1e32.1653589007.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421b1fbe94a82e678887260f768478c11daa1e32.1653589007.git.sthotton@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 01:24:48PM +0530, Shijith Thotton wrote:
> Added running firmware version information of AE, SE and IE components
> in devlink info.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  .../marvell/octeontx2/otx2_cpt_devlink.c      | 40 ++++++++++++++++++-
>  .../marvell/octeontx2/otx2_cptpf_ucode.c      |  2 +-
>  .../marvell/octeontx2/otx2_cptpf_ucode.h      |  3 ++
>  3 files changed, 42 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
