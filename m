Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6054618C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbiFJJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349189AbiFJJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:18:55 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA32FEBB5;
        Fri, 10 Jun 2022 02:17:09 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nzalB-005MfF-C8; Fri, 10 Jun 2022 19:16:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jun 2022 17:16:53 +0800
Date:   Fri, 10 Jun 2022 17:16:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com, Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: octeontx2: fix potential null pointer access
Message-ID: <YqMMBUzHTCOv9UzM@gondor.apana.org.au>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
 <6f772668877d2bd7dfdf7b45bb90cb56b3a6339b.1654070734.git.sthotton@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f772668877d2bd7dfdf7b45bb90cb56b3a6339b.1654070734.git.sthotton@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 01:38:59PM +0530, Shijith Thotton wrote:
> Added missing checks to avoid null pointer dereference.
> 
> The patch fixes below issue reported by klocwork tool:
> . Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
>   at line 1608 may be NULL and will be dereferenced at line 1608. Also
>   there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> v2:
> * Removed unwanted check for pcim_iomap_table.
> 
>  .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c   | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
