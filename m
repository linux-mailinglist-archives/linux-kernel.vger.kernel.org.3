Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12404D7983
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiCNCzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiCNCzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:55:46 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BC3BA6D;
        Sun, 13 Mar 2022 19:54:33 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nTaqq-0003E3-GH; Mon, 14 Mar 2022 13:54:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 14 Mar 2022 14:54:28 +1200
Date:   Mon, 14 Mar 2022 14:54:28 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH] MAINTAINERS: update HPRE/SEC2/TRNG driver maintainers
 list
Message-ID: <Yi6uZFTwPNgrIwka@gondor.apana.org.au>
References: <20220309025244.25838-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309025244.25838-1-liulongfang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:52:44AM +0800, Longfang Liu wrote:
> Zaibo moved projects and is not looking into crypto stuff.
> I am responsible for checking the patches of these modules.
> so the maintainers list needs to be updated.
> 
> I take care of HPRE, Qian Weili take care of TRNG,
> Ye Kai and me take care of SEC2.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Signed-off-by: Kai Ye <yekai12@huawei.com>
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
