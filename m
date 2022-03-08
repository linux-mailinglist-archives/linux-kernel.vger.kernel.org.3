Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0294D1EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349135AbiCHRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiCHRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:02 -0500
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.50.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99955BDD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:21 -0800 (PST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 03A32400D1902
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:21:01 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id RdUBnP8Uidx86RdUBnWAX7; Tue, 08 Mar 2022 11:19:00 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n+xx1pbdFLRmK4PKTak7SUu1MAbk2Q58/2NJuXtfPws=; b=qBNSIqNRUanAiK69b/cEFhaNKg
        sUlZjAWYfo8JsSLMXrav708oXpIWuoB2I3awTEeCa1vhqavbpXqA6HPJBU0P/D58awtLsU1L+EFjc
        NNh9pBpkChen0NTERIg0D7/YnzqQMxYUPIv8fdOFDj9GkuFKgYYCFFgBQx7acnrIEfpE7qOxdJa0/
        xlKklU342vpmixczXd0Ew1eJ+EJW4/IDzVaDYTZ38lK0yMA5QMwNJg6WEt7WmqByDhnZewpYhmD8Z
        m69e/PdyMIeyzLy0IGKCA5KfMrrAx5DlJOoqr/lCbptI36+LZFHRyy9erJv9iGOmtg9luR7+dl7OM
        U05up4hA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58900 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nRdUB-004MeX-97; Tue, 08 Mar 2022 17:18:59 +0000
Date:   Tue, 8 Mar 2022 09:18:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     cgel.zte@gmail.com
Cc:     jdelvare@suse.com, liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/hwmon: Use of_device_get_match_data()
Message-ID: <20220308171858.GA2582095@roeck-us.net>
References: <20220307033631.2075160-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307033631.2075160-1-chi.minghao@zte.com.cn>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nRdUB-004MeX-97
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58900
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 07, 2022 at 03:36:31AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

This is not the first patch from issues reported by Zeal Robot
with an inappropriate subject. "drivers/hwmon:" doesn't say anything.
The subject should either be "<subsystem>: <driver>: <description>" or,
as commonly used in hwmon, "hwmon: (driver) <description". I fixed
the subject and applied the patch, but don't expect me to do this
again in the future.

Guenter

> ---
>  drivers/hwmon/vexpress-hwmon.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
> index 44d798be3d59..2ac5fb96bba4 100644
> --- a/drivers/hwmon/vexpress-hwmon.c
> +++ b/drivers/hwmon/vexpress-hwmon.c
> @@ -207,7 +207,6 @@ MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
>  
>  static int vexpress_hwmon_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
>  	struct vexpress_hwmon_data *data;
>  	const struct vexpress_hwmon_type *type;
>  
> @@ -216,10 +215,9 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, data);
>  
> -	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
> -	if (!match)
> +	type = of_device_get_match_data(&pdev->dev);
> +	if (!type)
>  		return -ENODEV;
> -	type = match->data;
>  
>  	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
>  	if (IS_ERR(data->reg))
