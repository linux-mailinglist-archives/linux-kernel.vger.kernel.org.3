Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3553DD66
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbiFERmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiFERmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:42:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2707021272;
        Sun,  5 Jun 2022 10:42:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a21-20020a9d4715000000b0060bfaac6899so488361otf.12;
        Sun, 05 Jun 2022 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M83SyTxPwptuBRI/TcXfSCy3PAtbpLoDDYJMUpnbI+Q=;
        b=LPpPGRLnb2kknlOrlPzdjsP6EoUVAGCPS7515uGwBb0yBK2tDV4uX9gWs2P2BoFDIi
         8RF6vTw+H/lO9/xloKrAIpTuv2PduWYtgWEeiCXmYbP6NrQa/b9IQLI+zQuA78LaXVwG
         6/BMH5BbqSCc/ZXDc5LUjYxygYBQesyg8gVpNn6Z/YBvxTCo839IhlqQPr6sgceYx18k
         J20A7+BNyFfsKZuiGRk50wupfILTfh0ULtWXYCb+uIb9vKMBlI/NhyF6NW/C9NaKezPm
         vM7wBtbkQ/IH4AXz5kE5WlehvJEVaEIk14YuWAUwA6jv7czd67jbzmzwNi8TGHepVjHh
         hrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M83SyTxPwptuBRI/TcXfSCy3PAtbpLoDDYJMUpnbI+Q=;
        b=rGFbE4LAtcGmFD2+NtbMW+FHjE7LF5OX9OaOnDuiSm9hhoRVlv8pnKsKRd6Lh/6SKl
         xDCfntIWlPAuP07hG4pf64D9jO9J7awXB8UihyczUgyxyTSNXSJUuix/kK0poXTuPHkK
         USuFCQ/kudWVMT7OnwwH7W8PFK97tj7zUAZztlGqt50e/a8iJxhiqrLKA2oTnLDyzsBQ
         uEVCue54o5I71+GH8IaPuNTcfHWBfDwdbhM+sN2Bj6FHL/vaFIhOyIwYl65sRFJsM04v
         wJi7QmaqejKdlMvEGPW4M/wTbpbw3gkIQa+fKGi5908TNAVu4DIxqWp9+AQOoyPEmwsD
         hjBw==
X-Gm-Message-State: AOAM533B2Yh4NpuKRjjOYVmOBgGCsphiRyc++dQvVqtgdJUtDADKrhrJ
        D818YV+pMbtY6HVAb79klM+uq9FUZto=
X-Google-Smtp-Source: ABdhPJy21cidTd6EOnNTgbpC66oAN9uXiF9AuLkdDjfS207bFqXnMPZNkHy4QTPHTjlT8UHvdYgvSQ==
X-Received: by 2002:a05:6830:2002:b0:60a:df8c:18f8 with SMTP id e2-20020a056830200200b0060adf8c18f8mr8216871otp.184.1654450950472;
        Sun, 05 Jun 2022 10:42:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o15-20020a4a84cf000000b0035eb4e5a6cesm6614459oog.36.2022.06.05.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:42:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Jun 2022 10:42:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sch56xx-common) Add DMI override table
Message-ID: <20220605174228.GA3144764@roeck-us.net>
References: <20220604220200.2567-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604220200.2567-1-W_Armin@gmx.de>
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

On Sun, Jun 05, 2022 at 12:02:00AM +0200, Armin Wolf wrote:
> Some devices like the Fujitsu Celsius W380 do contain
> a working sch56xx hardware monitoring device, but do
> not contain the necessary DMI onboard device.
> 
> Do not check for the presence of an suitable onboard device
> on these machines. The list of affected machines was created
> using data collected by the Linux Hardware Project.
> 
> Tested on a Fujitsu Esprimo P720, but sadly not on a affected
> machine.
> 
> Fixes: 393935baa45e (hwmon: (sch56xx-common) Add automatic module loading on supported devices)
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 3ece53adabd6..de3a0886c2f7 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -523,6 +523,28 @@ static int __init sch56xx_device_add(int address, const char *name)
>  	return PTR_ERR_OR_ZERO(sch56xx_pdev);
>  }
> 
> +static const struct dmi_system_id sch56xx_dmi_override_table[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS W380"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO P710"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO E9900"),
> +		},
> +	},
> +	{ }
> +};
> +
>  /* For autoloading only */
>  static const struct dmi_system_id sch56xx_dmi_table[] __initconst = {
>  	{
> @@ -543,16 +565,18 @@ static int __init sch56xx_init(void)
>  		if (!dmi_check_system(sch56xx_dmi_table))
>  			return -ENODEV;
> 
> -		/*
> -		 * Some machines like the Esprimo P720 and Esprimo C700 have
> -		 * onboard devices named " Antiope"/" Theseus" instead of
> -		 * "Antiope"/"Theseus", so we need to check for both.
> -		 */
> -		if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
> -		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
> -		    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
> -		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
> -			return -ENODEV;
> +		if (!dmi_check_system(sch56xx_dmi_override_table)) {
> +			/*
> +			 * Some machines like the Esprimo P720 and Esprimo C700 have
> +			 * onboard devices named " Antiope"/" Theseus" instead of
> +			 * "Antiope"/"Theseus", so we need to check for both.
> +			 */
> +			if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
> +			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
> +			    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
> +			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
> +				return -ENODEV;
> +		}
>  	}
> 
>  	/*
