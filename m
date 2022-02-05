Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185B4AAA84
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380686AbiBERUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiBERUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:20:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CDCC061348;
        Sat,  5 Feb 2022 09:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DDF6112D;
        Sat,  5 Feb 2022 17:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B58C340E8;
        Sat,  5 Feb 2022 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644081614;
        bh=FPD+9Wbhuke+aGXCPGHLH+kq2cHplX8py2gleXSQSjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7CDB6dnMB0nVt5El2VZiXXb0U3xtZdoDjbCBT3oGOhYADQBwWwh/Pp/MMGzLOwHD
         YnHNiZcSASJruzgdHlKySYpTswq0+qpbMOwN4wffEqAnLPvuWDHS/LVtG2yeUmbOHO
         Oq6glVKlSfVWW/5arieUTojBDx2zZBOggQoUl5Aa9+JajlshI+W1cNpDPYAf1GNa8/
         FdufzL7LuTZUn23ACbtivECv9VnSzCDTmsxmEt3706T5CFs19J5jNC1LhLWp1q420I
         6c3gLMWYOHBxSLBzMzfm5/EZZDjPCt3LSSHoE/IUHaLrkDB+0+W9E0Juvh6Nce2ytw
         tFt73o32ZtNqQ==
Date:   Sat, 5 Feb 2022 17:26:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: humidity: dht11: Switch from of headers to
 mod_devicetable.h
Message-ID: <20220205172646.0d8f9ac3@jic23-huawei>
In-Reply-To: <20220202203420.56654-1-andriy.shevchenko@linux.intel.com>
References: <20220202203420.56654-1-andriy.shevchenko@linux.intel.com>
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

On Wed,  2 Feb 2022 22:34:20 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/humidity/dht11.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 9a7819817488..c97e25448772 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -11,10 +11,9 @@
>  #include <linux/kernel.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/sysfs.h>
>  #include <linux/io.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/wait.h>

