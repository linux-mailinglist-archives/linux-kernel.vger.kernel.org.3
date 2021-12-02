Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212D9466BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377128AbhLBVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbhLBVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:39:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A0C06174A;
        Thu,  2 Dec 2021 13:35:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0658EB7E;
        Thu,  2 Dec 2021 22:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638480958;
        bh=xM00oGjmavE1795OydjWevLFuRdGzmxd/C7idZ1aoRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUcfLsLTCZ7c7CJqbkMBnAviNMitAaguwgVicC6syOnC0D4mQD/caHdwDCjPbhPGW
         TpXhorRT8PPiHte9GL1XWp7dJiP9F6W7xzZB7qbViYt0uyuWWO7si6LIjHLZFhW7k+
         dqqzIqTPbFmWrTbSdvzxqao/uAl4Xi3jWCimTLn8=
Date:   Thu, 2 Dec 2021 23:35:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: i2c: max9286: Get rid of duplicate of_node
 assignment
Message-ID: <Yak8JNAyUIwhh+nt@pendragon.ideasonboard.com>
References: <20211202210335.78015-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202210335.78015-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the patch.

On Thu, Dec 02, 2021 at 11:03:35PM +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.
> 
> For the details one may look into the of_gpio_dev_init() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/max9286.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 7c663fd587bb..a662d3aa0641 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1055,7 +1055,6 @@ static int max9286_register_gpio(struct max9286_priv *priv)
>  	gpio->label = dev_name(dev);
>  	gpio->parent = dev;
>  	gpio->owner = THIS_MODULE;
> -	gpio->of_node = dev->of_node;
>  	gpio->ngpio = 2;
>  	gpio->base = -1;
>  	gpio->set = max9286_gpio_set;

-- 
Regards,

Laurent Pinchart
