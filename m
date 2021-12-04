Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F276146862A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355137AbhLDQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:27:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35672 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhLDQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:27:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72D7BB80D19;
        Sat,  4 Dec 2021 16:23:49 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 4C82CC341C2;
        Sat,  4 Dec 2021 16:23:45 +0000 (UTC)
Date:   Sat, 4 Dec 2021 16:28:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <festevam@gmail.com>, <linux-imx@nxp.com>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Update i.MX 8QXP ADC info
Message-ID: <20211204162853.2ebcfa55@jic23-huawei>
In-Reply-To: <20211201083100.1587-1-caihuoqing@baidu.com>
References: <20211201083100.1587-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 16:31:00 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> Update my email address to use developer mail address,
> because the old address will be dropped soon.
> 
> And change the status from 'Supported' to 'Maintained' for me
> to look after this code without any payment now.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Good luck with whatever you do next and thanks for continuing to look after
this driver.

You may also want to send a patch for .mailmap so that scripts
etc can get your updated email address.

Applied to the togreg branch of iio.git. It's behind some other stuff that
0-day will poke at so currently just pushed out as testing.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9331225b7162..79b89056ecd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13774,9 +13774,9 @@ F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
>  F:	drivers/gpu/drm/imx/dcss/
>  
>  NXP i.MX 8QXP ADC DRIVER
> -M:	Cai Huoqing <caihuoqing@baidu.com>
> +M:	Cai Huoqing <cai.huoqing@linux.dev>
>  L:	linux-iio@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
>  F:	drivers/iio/adc/imx8qxp-adc.c
>  

