Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A624DE3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiCRWN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCRWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:13:57 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D030A89C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:12:38 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 9046942D9E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:12:38 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id VKpqns9Sm22u3VKpqnNDZJ; Fri, 18 Mar 2022 17:12:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GRPVpTHvVEeX6p+AEuSP52hez17GUKK9iaB30l27MG8=; b=2XjXDVBSRkdiz3LnzBXfQfZP04
        NhS71MvfXMszSgdmaOFTwU4/AUhEzMgpHGY9BljziOCfjmSscosBl5f9E3t2x5T1aH6wEw0iyqKu/
        oeyZcySmK4Ua/9u0dj7EEkUQ6CMunjJno6+05HNwLgtIPKCr4kE131O32RKv8WP7/oPL+wJ3HbXUy
        LJrBXMrNo943BlCkPTW0TE2YZS5wLRHMWaxweFJyxooLYrYZFbaxAAYN1jjPw6s1a/kwKlU+Q+RKp
        Ntcq5v9jK1rL1uC85IHjwW4EEXBsYRdjBJ6SncGL8+Y25DKbp4gzrheOeSdCvAnBRmsOxVUoKObRX
        dWEdX+FQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57550 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nVKpp-003sFy-VY; Fri, 18 Mar 2022 22:12:38 +0000
Date:   Fri, 18 Mar 2022 15:12:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Inspiron 3505 to fan type blacklist
Message-ID: <20220318221236.GA703928@roeck-us.net>
References: <20220318183408.13286-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318183408.13286-1-W_Armin@gmx.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nVKpp-003sFy-VY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57550
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
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

On Fri, Mar 18, 2022 at 07:34:08PM +0100, Armin Wolf wrote:
> Sadly, while firmware 1.5 fixed temperature labels on my
> Inspiron 3505, it also caused fan type calls to take
> ca. 4 seconds with the fan being at full speed.
> Fix the resulting delays by adding the model to the
> blacklist.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index a14e810f5598..c34342253d6e 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1165,6 +1165,13 @@ static const struct dmi_system_id i8k_blacklist_fan_type_dmi_table[] __initconst
>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Inspiron 580 "),
>  		},
>  	},
> +	{
> +		.ident = "Dell Inspiron 3505",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Inspiron 3505"),
> +		},
> +	},
>  	{ }
>  };
