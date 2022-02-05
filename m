Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3504AAAA2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380756AbiBERel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiBERej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:34:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA331C061348;
        Sat,  5 Feb 2022 09:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844DC6115F;
        Sat,  5 Feb 2022 17:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558FDC340E8;
        Sat,  5 Feb 2022 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082477;
        bh=G6qYNGxsTHtnDJLwH2Sng96k7cgwnlIsdFT7VKuLk0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n58Q9lnswLG4bLF1AmxdhmXwfkLr2xTzEm71cpx18KnDNp/9ZGa7aP99nsxipeqTM
         fnZHZdfIUc4N/766KluWKygnYzpE67l4LPsSYsGLBDKslwpdSUQX+vnYdObo34cATQ
         9D/QzUmbwujbHthkSfftLTKtpaCd46LR+cZvF4KCz9TWxhYZ1Kbf4FwA4G9qun26om
         RXd7VWHQY8tfg5PSgcTY85GhcsbqJ+P1jCNkjVIOrSx4R4+ETaZv+TcFkgCIddd23t
         P6Sa09mEXaDTF6oooz5/BzTOGJOfphcWrPpQ8GaGkF1Mq322HtW2BaKSfy9PUKCeO8
         kSMFCFWDt8sZg==
Date:   Sat, 5 Feb 2022 17:41:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/1] iio: accel: adxl355: Replace custom definitions
 with generic from units.h
Message-ID: <20220205174108.094da325@jic23-huawei>
In-Reply-To: <20220202173723.8678-1-andriy.shevchenko@linux.intel.com>
References: <20220202173723.8678-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 19:37:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The units.h provides MEGA and TERA. Replace custom ones.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl355_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 4f485909f459..7023de888835 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -20,6 +20,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_irq.h>
>  #include <linux/regmap.h>
> +#include <linux/units.h>
> +
>  #include <asm/unaligned.h>
>  
>  #include "adxl355.h"
> @@ -60,9 +62,6 @@
>  #define ADXL355_PARTID_VAL		0xED
>  #define ADXL355_RESET_CODE		0x52
>  
> -#define MEGA 1000000UL
> -#define TERA 1000000000000ULL
> -
>  static const struct regmap_range adxl355_read_reg_range[] = {
>  	regmap_reg_range(ADXL355_DEVID_AD_REG, ADXL355_FIFO_DATA_REG),
>  	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_SELF_TEST_REG),

