Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006694E6D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbiCYEYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiCYEYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:24:23 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51806C626C;
        Thu, 24 Mar 2022 21:22:50 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nXbT3-0003VS-7e; Fri, 25 Mar 2022 15:22:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Mar 2022 16:22:29 +1200
Date:   Fri, 25 Mar 2022 16:22:29 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: fix reference leak in stm32_crc_remove
Message-ID: <Yj1DhXpNbVLe6/Lo@gondor.apana.org.au>
References: <20220317131613.53628-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317131613.53628-1-zhengyongjun3@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:16:13PM +0000, Zheng Yongjun wrote:
> pm_runtime_get_sync() will increment pm usage counter even it
> failed. Forgetting to call pm_runtime_put_noidle will result
> in reference leak in stm32_crc_remove, so we should fix it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/crypto/stm32/stm32-crc32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
