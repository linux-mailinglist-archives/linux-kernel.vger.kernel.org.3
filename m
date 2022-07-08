Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F017256B3F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiGHIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbiGHIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:00:30 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0C7E023;
        Fri,  8 Jul 2022 01:00:29 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9iuX-00Frrg-V4; Fri, 08 Jul 2022 18:00:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 16:00:26 +0800
Date:   Fri, 8 Jul 2022 16:00:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH v2] crypto: hisilicon - Kunpeng916 crypto driver don't
 sleep when in softirq
Message-ID: <YsfkGmti7GbwUe+J@gondor.apana.org.au>
References: <20220630124230.56265-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630124230.56265-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:42:30PM +0800, Zhengchao Shao wrote:
> When kunpeng916 encryption driver is used to deencrypt and decrypt
> packets during the softirq, it is not allowed to use mutex lock.
> 
> v1: use spin_lock will cause soft lockup
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec/sec_algs.c | 14 +++++++-------
>  drivers/crypto/hisilicon/sec/sec_drv.h  |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
