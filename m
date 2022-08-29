Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF95A4E96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH2NwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH2NwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:52:10 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18D93515;
        Mon, 29 Aug 2022 06:52:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x80so4175844pgx.0;
        Mon, 29 Aug 2022 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=CizzwTQDrBW1pzG8I/tvVZktSfPvWVpP3oiGosqePuM=;
        b=BFuBmpziPrpH+ToBnbBzhKoGCsrxb5bIPLToAdEtGFxp4a2CJe0pbvHqdAKBBI/To+
         3Vz/oanucLjuB0IB1SG7/tWbb9Jr6dnVvg5ZiQoM81uV0T8vvkqpyIIz/ukBGyvwz8ll
         TvQdHS3f0E2qE7qgyjRj4N46lzcrK+b+uCf5PnCnzxG6bxXzca5VEobpq1zCvtArYCXX
         wL6udQc9MKcF434cBqGqg00hTZ51j6JzrjDXACQ/TMp0Pq2maYUcKkykod2dBeMWqUBF
         7EFlG2kKKwgJcvBLvcxj3hSwr6X3KwYIAdxmM15EyIwQEoiRBQN337W/dO5F1bu4YlNC
         Re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=CizzwTQDrBW1pzG8I/tvVZktSfPvWVpP3oiGosqePuM=;
        b=j4T7bX1DXJzKwrjYdry7inlq4pyHXDKnqgCdnGubg92HvdUmripEkVcypnVFahJqgf
         1Uxmba0Zjy9KezNVwEE/0p1Negi73g00/RvPPHi3+IaIUzTjaIpV11M0Sqn7S3e7F1U3
         CCYxsh3FqQ/xHfGfGus4oMmpHHs89XDsqqn/NFgMbZ4CwOgej++NEgsbr+wYe9VoIO62
         AmnHlf1I6K+s7eaeYKF70GnQOArRG4NWM7temGEBKxQXvfsNBCBRFEXDJbT9vR2BlorZ
         zatHvOkeaPvfdsKnRz9enODri5+Cec1cQXPJK1VeudsL4y/C+4/qIBV7X7ChaVS+s7+2
         6WNg==
X-Gm-Message-State: ACgBeo3HwPVe3mwPIj1bvKd15ht4yM4Lqn4ye+/N78FwMOXFS0YT4yuj
        MA8bGZTUh6E2Md87AmUjadU=
X-Google-Smtp-Source: AA6agR6vjOINy9txTO5/r6fE4Ijqn5Ri8OWcJpnMGkzgilblB4k6WB0TZJhDvhXb8ECFZ+XSVmqt5w==
X-Received: by 2002:a05:6a00:1a93:b0:536:5dca:a685 with SMTP id e19-20020a056a001a9300b005365dcaa685mr16842223pfv.13.1661781127607;
        Mon, 29 Aug 2022 06:52:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id md10-20020a17090b23ca00b001f24c08c3fesm6852746pjb.1.2022.08.29.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:52:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:52:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (dell-smm) Improve warning messages
Message-ID: <20220829135206.GA168015@roeck-us.net>
References: <20220822174053.8750-1-W_Armin@gmx.de>
 <20220822174053.8750-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822174053.8750-3-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:40:53PM +0200, Armin Wolf wrote:
> When dell-smm-hwmon is loaded on a machine with a buggy BIOS
> with the option "force" being enabled, it wrongly prints
> that the buggy features where disabled. This may cause
> users to wrongly assume that the driver still protects them
> from these BIOS bugs even with "force" being enabled.
> 
> Replace the messages with two messages each which are depending
> on the value of the "force" parameter. The messages which are
> being printed when "force" is not set use dev_notice() instead
> of dev_warn() since they only serve as a notice.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 9cac80358072..01a94b62c2ab 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1356,15 +1356,21 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
> 
>  	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan support\n");
> -		if (!force)
> +		if (!force) {
> +			dev_notice(&pdev->dev, "Disabling fan support due to BIOS bugs\n");
>  			data->disallow_fan_support = true;
> +		} else {
> +			dev_warn(&pdev->dev, "Enabling fan support despite BIOS bugs\n");
> +		}
>  	}
> 
>  	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type call\n");
> -		if (!force)
> +		if (!force) {
> +			dev_notice(&pdev->dev, "Disabling fan type call due to BIOS bugs\n");
>  			data->disallow_fan_type_call = true;
> +		} else {
> +			dev_warn(&pdev->dev, "Enabling fan type call despite BIOS bugs\n");
> +		}
>  	}
> 
>  	strscpy(data->bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
