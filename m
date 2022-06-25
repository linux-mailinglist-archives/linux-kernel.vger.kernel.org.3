Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E855A936
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiFYLFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiFYLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:05:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF433E10;
        Sat, 25 Jun 2022 04:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A0AB80818;
        Sat, 25 Jun 2022 11:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ED9C3411C;
        Sat, 25 Jun 2022 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656155134;
        bh=Nuw7iA5FbucHB8v39wnH93gwIuOj7VzTuulMPNJqA5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GcSQpLPQ4oGSvFUme/HNaaSM6PxUuxczPISdCPhdNIjRdfZp0Q+hSlC7NE0JGTZ1x
         KoasdYfUMv/1j15hr1r8FbtVURGZUw9+PwVU1iwxxQmbcUdyUajfRBS//gZe2Vpl4i
         qvIfLg75CVtp2gzu9EWk6JYjcjcSOmcA2+56OjQ46ntSH+Nkhn6gfuYUnjWRewuA0V
         o3gOE1GZ1gCrVb8aemjlMGwBWbj2Gibz+KTu3Md3qGptUdVzXAnVflCL6RqvD6uIxP
         QwmeGhSwbrfBNIUimapylSOBXwMRoiqubJ+VSzjxKuxCUk26GROmnWVf3C4IDDiQGE
         xSLOU4/wdiQZQ==
Date:   Sat, 25 Jun 2022 12:15:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] iio: dac: mcp4922: add support to mcp4921
Message-ID: <20220625121500.4dc35578@jic23-huawei>
In-Reply-To: <20220624095619.1415614-1-kory.maincent@bootlin.com>
References: <20220624095619.1415614-1-kory.maincent@bootlin.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 11:56:17 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add support to mcp4921 which has only one output channel.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Obviously not been on the list long, but as it 'seems' totally trivial
and has already gottten some review I'll queue it up now anyway.

Series applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4922.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index cb9e60e71b91..0d41c0f25515 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -17,10 +17,12 @@
>  #include <linux/bitops.h>
>  
>  #define MCP4922_NUM_CHANNELS	2
> +#define MCP4921_NUM_CHANNELS	1
>  
>  enum mcp4922_supported_device_ids {
>  	ID_MCP4902,
>  	ID_MCP4912,
> +	ID_MCP4921,
>  	ID_MCP4922,
>  };
>  
> @@ -105,9 +107,10 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
> +static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
>  	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
>  	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
> +	[ID_MCP4921] = { MCP4922_CHAN(0, 12),	{} },
>  	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
>  };
>  
> @@ -154,7 +157,10 @@ static int mcp4922_probe(struct spi_device *spi)
>  	indio_dev->info = &mcp4922_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = mcp4922_channels[id->driver_data];
> -	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
> +	if (id->driver_data == ID_MCP4921)
> +		indio_dev->num_channels = MCP4921_NUM_CHANNELS;
> +	else
> +		indio_dev->num_channels = MCP4922_NUM_CHANNELS;
>  	indio_dev->name = id->name;
>  
>  	ret = iio_device_register(indio_dev);
> @@ -185,6 +191,7 @@ static void mcp4922_remove(struct spi_device *spi)
>  static const struct spi_device_id mcp4922_id[] = {
>  	{"mcp4902", ID_MCP4902},
>  	{"mcp4912", ID_MCP4912},
> +	{"mcp4921", ID_MCP4921},
>  	{"mcp4922", ID_MCP4922},
>  	{}
>  };

