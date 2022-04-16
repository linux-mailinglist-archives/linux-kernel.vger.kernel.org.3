Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADA503602
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiDPKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDPKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2838BFE;
        Sat, 16 Apr 2022 03:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EB2BB81222;
        Sat, 16 Apr 2022 10:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3572C385A3;
        Sat, 16 Apr 2022 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650106065;
        bh=ayWVjgMQVwQiim7mTS+3SSj+9Zm9lrh28mu0c+2on5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPC7+OmI8zpTtDEHA923/gul7YswKDrLdxjaZ45ocltS5fQQ6g6vUdqY/VHrboaVt
         2rzL7v2hQxJ+MvEPvNgBpay+uah6yp71IJHOQL6mqROkBz8K8z1RQPyUmyPrwmxj9O
         2yvhLbM9GVYtUhx/R5GpI0AHZkPomhj/K+Ik0wCOntghjRHF7CDyydicAx5F8Xxoo1
         Q3z2/vFK2sMF7rpT3WBUhO4hWEI11vJ1TWa6gPK6mfBz6y2XuqK2vQXl5fYa9Z2Lrr
         7B2GbmNKQ6TX00GiYrf9Athj6eMaZm8VqWUPfzmu+hp1kUOBuWFs9ev+1miL+8gpdq
         lfMdsVnSj6TGQ==
Date:   Sat, 16 Apr 2022 11:55:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: light: cm3605: Drop dependency on OF
Message-ID: <20220416115541.5e522c7f@jic23-huawei>
In-Reply-To: <20220413184627.21125-1-andriy.shevchenko@linux.intel.com>
References: <20220413184627.21125-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 21:46:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed.

Note I amended the description to not mention headers seeing as the
patch doesn't make that sort of change.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a62c7b4b8678..8537e88f02e3 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -155,7 +155,6 @@ config CM3323
>  
>  config CM3605
>  	tristate "Capella CM3605 ambient light and proximity sensor"
> -	depends on OF
>  	help
>  	  Say Y here if you want to build a driver for Capella CM3605
>  	  ambient light and short range proximity sensor.

