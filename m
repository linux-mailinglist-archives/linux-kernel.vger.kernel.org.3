Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555D56382D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGAQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGAQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:41:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB612443E5;
        Fri,  1 Jul 2022 09:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A171B830A9;
        Fri,  1 Jul 2022 16:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAAEC3411E;
        Fri,  1 Jul 2022 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693681;
        bh=eeQXTh7WPmxd9dx4v343UftFkAn8jUDbLp8jyyzAiRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P79kOXiq/CVVDiZ+3pXL3g9DKs8ufyWSCURqVfGuSuWl8xrmdVzB5l5X7sq3723hj
         DH7bFgw62Jpd3iEfRVm6ANsa2w9AvV+DyqT6oVf+UloGRqQioH1ztRW3tGmB6riccx
         j6Q4phzMHe9/MdK8NkwV3G2KQc6T6iNueF0D/8R7Yo1Ppnr4qAMrAyYtDEnHem0PR8
         HO5rDD2KBKJ5WYF5LKhw9tr7AYDDLVKtV+HdG0+YTDk1qF7+E5x9Oh7/P6vhsME3Jw
         E7gN1h9pvyd8pe0mlgiM0gwJ5lLnWh3HtooYxoJZwmw7MSNDVWfzPa/caiF7RQklk3
         DTTFdEEe2ZrSQ==
Date:   Fri, 1 Jul 2022 17:50:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-tsc2046: do not explicity set
 INDIO_BUFFER_TRIGGERED mode
Message-ID: <20220701175055.48ddd1b2@jic23-huawei>
In-Reply-To: <20220630050726.GB951@pengutronix.de>
References: <20220629203910.4836-1-marcus.folkesson@gmail.com>
        <20220630050726.GB951@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 07:07:26 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Jun 29, 2022 at 10:39:10PM +0200, Marcus Folkesson wrote:
> > The core sets INDIO_BUFFER_TRIGGERED as part of
> > devm_iio_triggered_buffer_setup().
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
Applied,

Thanks,

Jonathan

> Thank you!
> 
> > ---
> >  drivers/iio/adc/ti-tsc2046.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > index 55b35570ad8b..0d9436a69cbf 100644
> > --- a/drivers/iio/adc/ti-tsc2046.c
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -776,7 +776,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
> >  	priv->spi = spi;
> >  
> >  	indio_dev->name = TI_TSC2046_NAME;
> > -	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->channels = dcfg->channels;
> >  	indio_dev->num_channels = dcfg->num_channels;
> >  	indio_dev->info = &tsc2046_adc_info;
> > -- 
> > 2.36.1
> > 
> > 
> >   
> 

