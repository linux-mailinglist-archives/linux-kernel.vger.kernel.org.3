Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0951A59BF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiHVMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiHVMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB332046;
        Mon, 22 Aug 2022 05:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB91FB81132;
        Mon, 22 Aug 2022 12:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C999BC433C1;
        Mon, 22 Aug 2022 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661170626;
        bh=oWVM7idOqW4dR8gZgi5tDWNec1Qi+DE4xGa4+wIhJ+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGnw2o5Mit1URHScHlF+Uf2BUBd3SEenSS5PaII1Ijo/TnhSrjb2HfXDQS7V8JCvM
         uEmZGyvhdJ0zegqac9UsdphxW2Iey8d/3F/eUuvFhTtD8ryQZae+YoU1/T+uB7mox0
         DjjiKBpVczWDCf/80lD5+7fVZ8Vya32iP1FoLEuU=
Date:   Mon, 22 Aug 2022 14:17:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] tty/serial: fix repeated words in comments
Message-ID: <YwNzv6GXPTG46D3r@kroah.com>
References: <20220822120901.17913-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822120901.17913-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:09:01PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'power'.
>  Delete the redundant word 'long'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/tty/serial/imx.c         | 2 +-
>  drivers/tty/serial/samsung_tty.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 30edb35a6a15..c72e0dad3544 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2069,7 +2069,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
>  		{	/*
>  			 * The next code provides exact computation of
>  			 *   baud_raw = round(((uartclk/16) * (ubir + 1)) / (ubmr + 1))
> -			 * without need of float support or long long division,
> +			 * without need of float support or long division,

The original is correct here.

>  			 * which would be required to prevent 32bit arithmetic overflow
>  			 */
>  			unsigned int mul = ubir + 1;
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d5ca904def34..af799b79ba25 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1353,7 +1353,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
>  	return ret;
>  }
>  
> -/* power power management control */
> +/* power management control */

Are you sure this isn't also correct?

greg k-h
