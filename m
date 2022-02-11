Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1494B2E75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbiBKUak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiBKUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:30:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7FB4;
        Fri, 11 Feb 2022 12:30:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9243C1F4733C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644611435;
        bh=3yq2tczZI1VXm7ISVhbpjGo8IldBCBgP06nrWQPErHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdkA5CNR0XjowQ6c1gFk0Z4JrNxigSNb5XBMBgbynWPvIsGOkaIGsVoIp2uB8VBE8
         IvnY8BagPaaM1RcH0jBkI1tFxBdUSuXkVD+yPmZqa2MrtMhBiGCJHZ6MFdpC5lEzy/
         Wm0v7wqj2y/pJP0NGEebSkb564/ZFacvwYVr9LZNDcrE+DTnQnx3zZ5ohnNbEAAR9c
         3VEwsU3okiXaGnciJ3sx6tWBXwK2JPav+T0z+Sjf9z1uh8FIm3EnzSxr1TzsmcKIef
         a5aPZ5sLMr9Gv5S9aQxpPOHd76rsqNM0VgeCrKvJhzjxea5Uf3Wi/v2nVb3bLintxf
         5wX18Mvhq0fMg==
Received: by mercury (Postfix, from userid 1000)
        id 1A6051060908; Fri, 11 Feb 2022 21:30:33 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:30:33 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cgel.zte@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: ab8500: remove unneeded variable
Message-ID: <20220211203033.zzfwg2mxq7xcerka@mercury.elektranox.org>
References: <20220107022602.622455-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107022602.622455-1-deng.changcheng@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 07, 2022 at 02:26:02AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
> index b0919a6a6587..3927f4ad7c38 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -3170,7 +3170,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
>  
>  static int ab8500_fg_remove(struct platform_device *pdev)
>  {
> -	int ret = 0;
>  	struct ab8500_fg *di = platform_get_drvdata(pdev);
>  
>  	component_del(&pdev->dev, &ab8500_fg_component_ops);
> @@ -3178,7 +3177,7 @@ static int ab8500_fg_remove(struct platform_device *pdev)
>  	ab8500_fg_sysfs_exit(di);
>  	ab8500_fg_sysfs_psy_remove_attrs(di);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(ab8500_fg_pm_ops, ab8500_fg_suspend, ab8500_fg_resume);
> -- 
> 2.25.1
> 
