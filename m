Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92B5035F9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiDPKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiDPKjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACC22516;
        Sat, 16 Apr 2022 03:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F111560E97;
        Sat, 16 Apr 2022 10:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1958C385A3;
        Sat, 16 Apr 2022 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650105442;
        bh=wwQ2KXLmqbrL8x9yOhEPgpWxlE6/ANc23oINIAYBWFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i9VenvH+J3jal44BpmmzyaoKF6o14szrhFaM3uLaTzK/8zM6T+FZTzu91yqBa/3YF
         9gRGufeeB1J0Acf4JRzUO/iMfE/c2cbJoIEjkoCEhj3lO/92oHAT/gT08qX4KxoBVp
         bjY1bA4SRJa5sl8qRmx6nM2gUANMfxNgvi6xZWmcqIDnIEAK1boQpgkmuraDGB8mNK
         EToSJ8mxFrMD28uLMd+so1ok/qphy4py9p5DEZmPBN+DZOgkwAFR4xtccES6W7V4ux
         RL3Kj4ahOh5iu7VP0J1oMriNKni5C0tgCz0r9uJUAGxQzl25/m59ZJT+OiT9jJwppq
         u64TH94mHgzLw==
Date:   Sat, 16 Apr 2022 11:45:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: dmard06: Drop dependency on OF
Message-ID: <20220416114519.4745b04f@jic23-huawei>
In-Reply-To: <20220413190327.30054-1-andriy.shevchenko@linux.intel.com>
References: <20220413190327.30054-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 22:03:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
Applied. Note I amended the patch descriptions where relevant to drop
reference to headers when they weren't touched in a given patch.
Hopefully I caught all the cases of that.

Jonathan

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index eac3f02662ae..b53f010f3e40 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -290,7 +290,6 @@ config DA311
>  
>  config DMARD06
>  	tristate "Domintech DMARD06 Digital Accelerometer Driver"
> -	depends on OF || COMPILE_TEST
>  	depends on I2C
>  	help
>  	  Say yes here to build support for the Domintech low-g tri-axial

