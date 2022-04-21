Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1D509D09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387884AbiDUKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388037AbiDUKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:05:01 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569B24BEA;
        Thu, 21 Apr 2022 03:02:12 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nhTdV-005D4X-SB; Thu, 21 Apr 2022 20:02:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 21 Apr 2022 18:02:06 +0800
Date:   Thu, 21 Apr 2022 18:02:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH 0/4] crypto: hisilicon/qm - misc fixes
Message-ID: <YmErnlAIW01ooKk4@gondor.apana.org.au>
References: <20220416104559.10826-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416104559.10826-1-qianweili@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 06:45:55PM +0800, Weili Qian wrote:
> This patchset removes some unused functions and sets the unused outside
> qm.c functons to static.
> 
> Weili Qian (4):
>   crypto: hisilicon/qm - remove unused function declaration
>   crypto: hisilicon/qm - set function with static
>   crypto: hisilicon/qm - replace hisi_qm_release_qp() with
>     hisi_qm_free_qps()
>   crypto: hisilicon/qm - remove hisi_qm_get_free_qp_num()
> 
>  drivers/crypto/hisilicon/qm.c             | 37 ++++++++---------------
>  drivers/crypto/hisilicon/zip/zip_crypto.c |  2 +-
>  include/linux/hisi_acc_qm.h               |  5 ---
>  3 files changed, 13 insertions(+), 31 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
