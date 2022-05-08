Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48251EF3A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiEHTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiEHR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F3DFEA;
        Sun,  8 May 2022 10:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6846461295;
        Sun,  8 May 2022 17:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA49C385A4;
        Sun,  8 May 2022 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652032424;
        bh=yJPX175r8pvytkUmcDbH5hMaqjBtCATCSaDdEMwa2IQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hp79yaL4qI6PvDBH7yU5WthuS86G4hkqP2zY+E/O5qqGE2V6ebZh69X/9c2wOStuv
         BGAquKs2hyhD6hRePX54dTHilMTBC4+qdZkDIo7iaLRe/Oe11v8+H5SG8aUI4Tz++W
         YvaXLzEgVWj94qMpV/EIzgMlkhxeAq/VGpRVlkpB2nN9iQ2I3QbxJDxfBIQUwNmOpC
         8pws1hrUyxUO3m+urjcuCTaTTZsHkf+d1IJaUUxUZpiyE8mpmSYmK7Cz7nJ889hV2U
         tYJ/jtzZeJ2mUrIoEnk6otfTk3mJXVwKP2nPJgl9dBqPgK9SdWYFD1OcLIi9ynYKAl
         j1V74AsHiE6EA==
Date:   Sun, 8 May 2022 19:02:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: imu: st_lsm6dsx: Switch from of headers to
 mod_devicetable.h
Message-ID: <20220508190212.3fc02a3f@jic23-huawei>
In-Reply-To: <20220507173440.29053-1-andriy.shevchenko@linux.intel.com>
References: <20220507173440.29053-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Sat,  7 May 2022 20:34:40 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal boring reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> index 8d4201b86e87..35556cd04284 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -6,11 +6,11 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/i3c/device.h>
>  #include <linux/i3c/master.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #include "st_lsm6dsx.h"

