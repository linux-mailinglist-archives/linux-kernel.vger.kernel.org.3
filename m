Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA620561077
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiF3FHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF3FHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:07:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495B18E30
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:07:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1o6mOl-0002hu-Am; Thu, 30 Jun 2022 07:07:27 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1o6mOk-0004lg-5s; Thu, 30 Jun 2022 07:07:26 +0200
Date:   Thu, 30 Jun 2022 07:07:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-tsc2046: do not explicity set
 INDIO_BUFFER_TRIGGERED mode
Message-ID: <20220630050726.GB951@pengutronix.de>
References: <20220629203910.4836-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220629203910.4836-1-marcus.folkesson@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:39:10PM +0200, Marcus Folkesson wrote:
> The core sets INDIO_BUFFER_TRIGGERED as part of
> devm_iio_triggered_buffer_setup().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  drivers/iio/adc/ti-tsc2046.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 55b35570ad8b..0d9436a69cbf 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -776,7 +776,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  	priv->spi = spi;
>  
>  	indio_dev->name = TI_TSC2046_NAME;
> -	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = dcfg->channels;
>  	indio_dev->num_channels = dcfg->num_channels;
>  	indio_dev->info = &tsc2046_adc_info;
> -- 
> 2.36.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
