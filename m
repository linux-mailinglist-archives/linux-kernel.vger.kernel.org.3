Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207C4480C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhL1Rci convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:32:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40006 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1Rch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BB3612DB;
        Tue, 28 Dec 2021 17:32:37 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 18D97C36AE8;
        Tue, 28 Dec 2021 17:32:32 +0000 (UTC)
Date:   Tue, 28 Dec 2021 17:38:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/23] counter: microchip-tcb-capture: Drop unused
 platform_set_drvdata()
Message-ID: <20211228173818.418ab922@jic23-huawei>
In-Reply-To: <20211227094526.698714-4-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-4-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:06 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> The driver doesn't ever use platform_get_drvdata, so drop this unused
> call.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
FWIW sanity checked it is indeed not used that I can see.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 0ab1b2716784..bb69f2e0ba93 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -307,8 +307,6 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, priv);
> -
>  	match = of_match_node(atmel_tc_of_match, np->parent);
>  	tcb_config = match->data;
>  	if (!tcb_config) {

