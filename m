Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D7547678
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiFKQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiFKQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F2580FF;
        Sat, 11 Jun 2022 09:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B066114C;
        Sat, 11 Jun 2022 16:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7A9C34116;
        Sat, 11 Jun 2022 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654965100;
        bh=qCwIEMpnsRIufmi3vST+sz+tw/W8NyVbRjkNPScHWiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SLdsrzSbCA4DC5ou45xrOX+yffeUADxedHv4VEBvVZBc+dI13A9YQFvX95EBLAXQT
         UeSO9YqTNOkYKE2ok0357UrUzPb/MUGZs/GqA/vMXcNPHIY5TSe3if1QVyGf8HTIC2
         58DCXozHGyWXEnAmPZ96TVVIF4lM7vzlkI4IOcxIVqwPILXjDicK9aNxFsXlU2YTYZ
         vUSqR1OBw36vNP0u+/NDEJUSZiPXfNerKimsoJ82IOlkQ9fkvJwB6zFBJ6/XC4VvZU
         hnthPhQ99CrrGoHNCIJ/Oolm8IA7ahRwRuhj1iTI+xtT/xxMc7dsLEhCyffTduQwv2
         pBi4y0LrOf4pQ==
Date:   Sat, 11 Jun 2022 17:40:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/16] iio: adc: at91-sama5d2_adc: use pm_ptr()
Message-ID: <20220611174049.129df964@jic23-huawei>
In-Reply-To: <20220609083213.1795019-17-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-17-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:32:13 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Use pm_ptr() on the assignment of at91_adc_pm_ops to
> at91_adc_driver.driver.pm.

Squash this into the previous patch.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 5d9ad51d0920..221c09532b38 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2647,7 +2647,7 @@ static struct platform_driver at91_adc_driver = {
>  	.driver = {
>  		.name = "at91-sama5d2_adc",
>  		.of_match_table = at91_adc_dt_match,
> -		.pm = &at91_adc_pm_ops,
> +		.pm = pm_ptr(&at91_adc_pm_ops),
>  	},
>  };
>  module_platform_driver(at91_adc_driver)

