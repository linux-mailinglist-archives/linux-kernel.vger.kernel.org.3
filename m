Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1955FA36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiF2IRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2IRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:17:47 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7723BBC8;
        Wed, 29 Jun 2022 01:17:46 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 981CD240006;
        Wed, 29 Jun 2022 08:17:42 +0000 (UTC)
Date:   Wed, 29 Jun 2022 10:17:41 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] media: ov5693: add ov5693_of_match, dts support
Message-ID: <20220629081741.mmgqr756i57y544x@uno.localdomain>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-7-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627150453.220292-7-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, Jun 27, 2022 at 05:04:52PM +0200, Tommaso Merciai wrote:
> Add ov5693_of_match. Device tree support
>
> Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Missing Signed-off-by

> ---
>  drivers/media/i2c/ov5693.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 273caef467fe..0854226dc140 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -1532,10 +1532,17 @@ static const struct acpi_device_id ov5693_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, ov5693_acpi_match);
>
> +static const struct of_device_id ov5693_of_match[] = {
> +	{ .compatible = "ovti,ov5693", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ov5693_of_match);
> +
>  static struct i2c_driver ov5693_driver = {
>  	.driver = {
>  		.name = "ov5693",
>  		.acpi_match_table = ov5693_acpi_match,
> +		.of_match_table = ov5693_of_match,
>  		.pm = &ov5693_pm_ops,
>  	},
>  	.probe_new = ov5693_probe,
> --
> 2.25.1
>
