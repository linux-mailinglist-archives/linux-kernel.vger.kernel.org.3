Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A147B4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLTVCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLTVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:02:19 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D4C06173E;
        Mon, 20 Dec 2021 13:02:19 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t19so17678197oij.1;
        Mon, 20 Dec 2021 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IkO/tNWZaeS2Vxk1XDI6+YW5tksUF9B3U8MJxg8VTl0=;
        b=e80CwVHZEfIGXqP0IHbQ2xCxTEpKGwE6cLT5Dwo0v18zT9l0Am2jAExrOqtmgc9P8w
         BsLHvgXPwIEEYF0P1VWhvIBTIRS0bFzsLXWN8ThphBSM2xxTyshPYGjh7Z0TT/wBdfrd
         zdptURAgfcxSxoLJpt0deLzDAJv23yGxHXNzgui087ZgdryguCKcdJrnk0wBOmzRWtzV
         y94guDBENn73Ftv2q9eb20QoO3hAHa2Y2e8GCqqKKdvyFOF2d1q80jqoEdtsLoFd5cA0
         VwgJd7AzEhbqkR+B4nMJoKc50NuwiKD+zDUVQY81TuYay8wqZDO59l4f21aZUEPUfTwb
         XW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IkO/tNWZaeS2Vxk1XDI6+YW5tksUF9B3U8MJxg8VTl0=;
        b=YMOCztguq/wnis10qYNkRw/mapMSd7scRIWIKbpzmSlxtO5Mls4K87XucCd00HGAVu
         OqvH90k0StI11Kmcj1qxd0sE/RJ3tYakvBYLr5SmRaFZRLumsodhNiTiXwENKyI7whwc
         Kg2jPj6u3RWJMbIBlL/agUdRhosNKiDWqRbvh/yUqL513T0AlcqRun1rJI+fS2H+g/aR
         F2nYH23KY2ueACGuqEi328uV3D4Rnd44wfelg+SdGH/maqPrAxfJRwuI41T3Wuo3Pf9v
         Gx7hgcauvuxubDe3AuujbOltykPXxT89TDHsnr3V9N6RQQDz93zkl4mIWutQuwJak6Pd
         ZsKw==
X-Gm-Message-State: AOAM531A0aUwam+TeubXxJ6Bvzjf9eWDuesw9mblig2hhYN5oMOS3bkc
        5pXKC37gTyh11WQY2iBj3f1W9J7ZbUQ=
X-Google-Smtp-Source: ABdhPJzMua0TCdQNktopncQKHxqwNZMpp6Y29yYK/VUWS2ZKkNKkgiD7rSE/+f7Dw4KTTC6YDcX8Wg==
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr900oiw.154.1640034138475;
        Mon, 20 Dec 2021 13:02:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bj8sm3878007oib.51.2021.12.20.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:02:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Dec 2021 13:02:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon/pmbus: (ir38064): Fix spelling mistake
 "comaptible" -> "compatible"
Message-ID: <20211220210216.GA194595@roeck-us.net>
References: <20211220155527.179125-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220155527.179125-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:55:27PM +0000, Colin Ian King wrote:
> There is a spelling mistake in the module description, fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ir38064.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
> index 07bdbb16f216..0ea7e1c18bdc 100644
> --- a/drivers/hwmon/pmbus/ir38064.c
> +++ b/drivers/hwmon/pmbus/ir38064.c
> @@ -85,6 +85,6 @@ static struct i2c_driver ir38064_driver = {
>  module_i2c_driver(ir38064_driver);
>  
>  MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
> -MODULE_DESCRIPTION("PMBus driver for Infineon IR38064 and comaptible chips");
> +MODULE_DESCRIPTION("PMBus driver for Infineon IR38064 and compatible chips");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS(PMBUS);
