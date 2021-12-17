Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8563478661
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhLQIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:40:04 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58084 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhLQIkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:40:03 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1my8mW-00015Y-CC; Fri, 17 Dec 2021 19:40:01 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Dec 2021 19:40:00 +1100
Date:   Fri, 17 Dec 2021 19:40:00 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH 0/6] crypto: hisilicon/qm - handling abnormal interrupts
 event
Message-ID: <20211217084000.GI7018@gondor.apana.org.au>
References: <20211211112519.21201-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211112519.21201-1-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 07:25:13PM +0800, Weili Qian wrote:
> When the hardware reports abnormal interrupt event, the driver needs to
> handle it according to the error type, such as function reset and
> disable queue.
> 
> Weili Qian (6):
>   crypto: hisilicon/qm - remove unnecessary device memory reset
>   crypto: hisilicon/qm - code movement
>   crypto: hisilicon/qm - modify the handling method after abnormal
>     interruption
>   crypto: hisilicon/qm - use request_threaded_irq instead
>   crypto: hisilicon/qm - reset function if event queue overflows
>   crypto: hisilicon/qm - disable queue when 'CQ' error
> 
>  drivers/crypto/hisilicon/qm.c | 278 ++++++++++++++++++++++------------
>  1 file changed, 183 insertions(+), 95 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
