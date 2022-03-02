Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070D74CB378
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiCCAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiCCAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:31 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC347AF9;
        Wed,  2 Mar 2022 15:59:46 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXwq-0006EU-Ps; Thu, 03 Mar 2022 09:59:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:59:56 +1200
Date:   Thu, 3 Mar 2022 10:59:56 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        hkalra@marvell.com
Subject: Re: [PATCH -next] crypto: octeontx2 - fix missing unlock
Message-ID: <Yh/27BwQ5W/6inj7@gondor.apana.org.au>
References: <20220225072724.82507-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225072724.82507-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:27:24PM +0800, Yang Yingliang wrote:
> Add the missing unlock before return from error path.
> 
> Fixes: 4363f3d3ce8f ("crypto: octeontx2 - add synchronization between mailbox accesses")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 4 +++-
>  drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
