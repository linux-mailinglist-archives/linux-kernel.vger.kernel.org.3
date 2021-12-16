Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96467477945
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhLPQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLPQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:35:45 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C5C061574;
        Thu, 16 Dec 2021 08:35:45 -0800 (PST)
Received: from [81.101.6.87] (port=52584 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxtjH-0006oe-Di; Thu, 16 Dec 2021 16:35:39 +0000
Date:   Thu, 16 Dec 2021 16:41:00 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <festevam@gmail.com>, <linux-imx@nxp.com>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailmap: Update email address for Cai Huoqing
Message-ID: <20211216164051.10225276@jic23-huawei>
In-Reply-To: <20211206025034.2729-1-caihuoqing@baidu.com>
References: <20211206025034.2729-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 10:50:34 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The caihuoqing@baidu.com would be deprecated and use cai.huoqing@linux.dev
> as the main email address.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Which maintainer wants to pick this one up?  I can take it via iio if that
is fine with others.

Thanks,

Jonathan


> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a83599921b1a..f82b0378df7c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -68,6 +68,7 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
>  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
>  Brian Avery <b.avery@hp.com>
>  Brian King <brking@us.ibm.com>
> +Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
>  Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
>  Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
>  Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>

