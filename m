Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235E35776B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGQOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC8DF66;
        Sun, 17 Jul 2022 07:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F924611F3;
        Sun, 17 Jul 2022 14:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9773C3411E;
        Sun, 17 Jul 2022 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658068987;
        bh=rSYGCNWt4Kt0l0jVJFBLoCaO694/yd9H93E7Sw+YISM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lwpAIUZotFJOE2Nc+CWt88j7/IpHkx8IKO4ixE0GNkc3izQnbnYfNdZLmvbqDDRIh
         PfC5KxYEhK887dhTgDh+9orRPwgQPql33iTUcHmRefzeq33E906oru7OBNhEWAyBnq
         NAtqY2f5/Q5Ro2Gl77bSZosv+J4zwLsm2RdO2tCX0L/E9vPpBxiW+k4gmVvdvAxp8P
         aZtfWHyOGavKILouYBazE/Bx0uyAtAHhKDCe8hYcmJua0T3s0mShLKqzaw2GPAVHte
         i0N25tRjZscURl4NT7k+iCaELCzfZRuWZhcQ73H5krPD0frKahXHoTsfrTyNNcf/Yo
         DbzKgZZPNBw6w==
Date:   Sun, 17 Jul 2022 15:53:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: pressure: Kconfig: Add references to BMP380
Message-ID: <20220717155301.1ba10d8d@jic23-huawei>
In-Reply-To: <20220710091618.15890-1-ang.iglesiasg@gmail.com>
References: <20220710091618.15890-1-ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2022 11:16:17 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds reference to BMP380 in bmp280 driver descriptions and symbols
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

This should be combined with the patch that adds support for the new part
which looks to be patch 4.

The rule of thumb is that, at any point in a series the state of the tree
should make sense.  Hence you shouldn't claim support for the BMP380 until
it is present.  This change is just part of adding that support.

Jonathan


> ---
>  drivers/iio/pressure/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 0ff756cea63a..c9453389e4f7 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -17,14 +17,14 @@ config ABP060MG
>  	  will be called abp060mg.
>  
>  config BMP280
> -	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
> +	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
>  	depends on (I2C || SPI_MASTER)
>  	select REGMAP
>  	select BMP280_I2C if (I2C)
>  	select BMP280_SPI if (SPI_MASTER)
>  	help
> -	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
> -	  pressure and temperature sensors. Also supports the BME280 with
> +	  Say yes here to build support for Bosch Sensortec BMP180, BMP280 and
> +	  BMP380 pressure and temperature sensors. Also supports the BME280 with
>  	  an additional humidity sensor channel.
>  
>  	  To compile this driver as a module, choose M here: the core module

