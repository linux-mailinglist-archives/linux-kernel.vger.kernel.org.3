Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D11480C19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhL1Rbc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:31:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32850 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1Rbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:31:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39626B8125E;
        Tue, 28 Dec 2021 17:31:30 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BDC36AE8;
        Tue, 28 Dec 2021 17:31:24 +0000 (UTC)
Date:   Tue, 28 Dec 2021 17:37:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 02/23] counter: ftm-quaddec: Drop unused
 platform_set_drvdata()
Message-ID: <20211228173709.326b3a2a@jic23-huawei>
In-Reply-To: <20211227094526.698714-3-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-3-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:05 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> The driver doesn't ever use platform_get_drvdata, so drop this unused
> call.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/ftm-quaddec.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 5ef0478709cd..9272f7b58beb 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -269,8 +269,6 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  	if (!ftm)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, ftm);
> -
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
>  		dev_err(&pdev->dev, "Failed to get memory region\n");

