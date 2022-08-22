Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4759C3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiHVQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiHVQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:21:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42663F313;
        Mon, 22 Aug 2022 09:21:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f17so4662915pfk.11;
        Mon, 22 Aug 2022 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=UO2tpDseOUxSc2DoPMk1lJXbq9Ou2Xvd17vKqQ346TI=;
        b=NqoE5HM5tKCXP2Vk/Ulo+aX+pzqYFxcHdyfmJZ+IP0QSDf03mG4DTq3N/39NoWTGJg
         FbwoVOfAUMFbpEEGlXvx/UMEp7sbWV2o9UL+312ZVrBBO2vN9NmbniiGAZQaIJrcCJyg
         xfXi3KqTBmlGsDnplAZt/FN2eVAA23EtbNtTm4CKZG2xd+i2zYORImbV+l9MGmqJAkNX
         RR9iFJEqFJ/c1zFzcJavtjiRD9LN9GTYA/MId++OMO03GTucoDssLk12bBLFQmyeL1uS
         KI/l5nmhGuOURs67RBxve2JOVSKZuXWC80PaSuzUdS3JcDsxAvXmJZCMXenddHhlNExD
         2tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=UO2tpDseOUxSc2DoPMk1lJXbq9Ou2Xvd17vKqQ346TI=;
        b=tpZyvIvDe3WTPPBX7p865qyNdB5wt1Tl42yRutUSz408WT5dAKmyPAV4xKQWoetoq+
         qrtTr/rkjFDs9F6l7ZfBzDvuc4kcoJHjW3tUtUYtIWAs5gZLFLNKLuSZID7/4Vu3zkVg
         LaO+sHRa9BwQG6sRP4ChKGCKti/CTEGfrYXKCsHUGExRCkiKFa9Ju7GrFJ+sKIyuhl3p
         2x+ulP1EmxfK3G9AVPpjuuV3rMCRqh3BHkh2EROXkYdgDJIwW7hyaPuatRqD3O4cpIOc
         9SNRIe0nduCIT6AbsLDW91Gi/Km/jOQA1GlE5qSSozY6iUfNE//kB2dXo8jdmd4g7Usf
         I+TQ==
X-Gm-Message-State: ACgBeo1LZ6gbJlUkjz2iPdzG5P7kvTor0Dx9W2GeQFLfydd2O0V2POex
        vxAL3/mum5JnsAUBg3Z2iKg=
X-Google-Smtp-Source: AA6agR6hhRMJidekydr5ggwv0mneoGAsDNB5VGKTBZn71OieWRN04J8C+eMHmtns2YdEzwWx6THi5Q==
X-Received: by 2002:a63:4f4f:0:b0:429:f656:69a6 with SMTP id p15-20020a634f4f000000b00429f65669a6mr17515021pgl.287.1661185286112;
        Mon, 22 Aug 2022 09:21:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79552000000b00536e2ae5938sm618855pfq.213.2022.08.22.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:21:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 09:21:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (dell-smm) Improve warning messages
Message-ID: <20220822162124.GB4098765@roeck-us.net>
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821151713.11198-4-W_Armin@gmx.de>
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

On Sun, Aug 21, 2022 at 05:17:13PM +0200, Armin Wolf wrote:
> When dell-smm-hwmon is loaded on a machine with a buggy BIOS
> with the option "force" being enabled, it wrongly prints
> what the buggy features where disabled. This may cause
> users to wrongly assume that the driver still protects them
> from these BIOS bugs even with "force" being enabled.
> Change the warning message to avoid such a misunderstanding.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f7bab1a91b93..bf13852afe48 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1354,13 +1354,13 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
> 
>  	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan support\n");
> +		dev_warn(&pdev->dev, "BIOS has broken fan support\n");

I don't see that as improvement. It no longer mentions that fan support
is disabled if it is disabled.

>  		if (!force)
>  			data->disallow_fan_support = true;
>  	}
> 
>  	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
> -		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type call\n");
> +		dev_warn(&pdev->dev, "BIOS has broken fan type call\n");

Same as above.

>  		if (!force)
>  			data->disallow_fan_type_call = true;
>  	}
> --
> 2.30.2
> 
