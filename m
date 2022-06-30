Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7859561EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiF3PFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiF3PFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03411150;
        Thu, 30 Jun 2022 08:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B8BB82B67;
        Thu, 30 Jun 2022 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F07C34115;
        Thu, 30 Jun 2022 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656601536;
        bh=HvXSmXzD95176SF4fVwzCKayvFOi0/Ha9nsK2bd/zx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dA7tdaVSAAbPDCbZ1O4ZrIks8KR44X+EUZUD5pPDYQNmuuJ9JtfjrIcn4TZx3tWkg
         in0sLdDRq5NayTw9nMa37od7Kq6+P4jV3ainNHRATJ9AH3k2pKF/2jOM3SwKBu7CXc
         v4iH4yqWehvP2xFRmNb0XDcpYofYSrOTerAUbzL8=
Date:   Thu, 30 Jun 2022 17:05:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Sort headers alphabetically
Message-ID: <Yr27viU1mHyp/JmE@kroah.com>
References: <20220630093816.28271-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630093816.28271-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:38:16PM +0300, Andy Shevchenko wrote:
> For the sake of better maintenance, sort included headers alphabetically.

How does that make anything easier to maintain?

> While at it, split the serial group of headers which makes clear the
> subsystem the driver belongs to.

Where did you do that?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index d5df17455f1d..86762593579f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -9,26 +9,27 @@
>   * LCR is written whilst busy.  If it is, then a busy detect interrupt is
>   * raised, the LCR needs to be rewritten and the uart status register read.
>   */
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/serial_8250.h>
> -#include <linux/serial_reg.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
> -#include <linux/workqueue.h>
> -#include <linux/notifier.h>
> -#include <linux/slab.h>
> -#include <linux/acpi.h>
> -#include <linux/clk.h>
>  #include <linux/reset.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/byteorder.h>
>  
> +#include <linux/serial_8250.h>
> +#include <linux/serial_reg.h>

Is this the "split"?

Anyway, it's just code churn, I'll apply it...

thanks,

greg k-h
