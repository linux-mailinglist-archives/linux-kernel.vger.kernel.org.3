Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D7549195
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbiFMPrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiFMPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:47:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316896B0B1;
        Mon, 13 Jun 2022 06:24:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u2so5760588pfc.2;
        Mon, 13 Jun 2022 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1V6C8NyTzHg/Om906gtppGn2lvsjTetCEF70z2En2t4=;
        b=aGSgX4MUnUkGcnR+MN+tj4yKBOqTcPiw0EG8TvDp2yozH0hiNa36XXmRY4rC/7NwJO
         w1FNvG0XjeVAMSKpk/zAj0fKXQdL85WOOmd2yQGPClm3Eb83QtXtVhbtDYjas7FFXKTg
         Wt7CzZvwM+ILwsG+MBzE0Z6R8pD5nAMKjBhj2ubeeQwGYvG/fL5oPwiCcEiWuGjlxqqM
         jda2PLslabSaLCuycTs3Io9F/rvugmpO+kICxq9irqiu9DM7FRZEIHB4oTji8W9Q4HRl
         Gi8Ye4ptsFF7g8gVjq8jNhXK8y1LctgC3dO94p4V7Vf193gAKwsFhM6nuS42sdUO8RcE
         7Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=1V6C8NyTzHg/Om906gtppGn2lvsjTetCEF70z2En2t4=;
        b=yOEWoZSK6E9lZgvHICxIlaMWCmzNEre9sClBve1VIqkhgJVzwW4KJ540ZSLR8I2UjX
         hnHuvAKTd7aFcHQsT3CZr9YBd1+27f4U5N+pHkFve6AwmBK2Nbq15wyiIlW7HP7ea/Rb
         BdBP2aGT0XsDFyazndTpLS/jiQs5z09hvf19Aw2T+4dYvXgDteSepv3h7P2b04BlUENT
         Lmmcajpf5KxPwjpS6E8xhYXMZ7I3tz1pWsGU3z+Kz4zFHyksKP2szSH2i2KvtFWWUSWb
         ugFpNLk7YrOSqG+zcVpyY5AzqULA9TS1LPUpOQjNXbpeyqRKorg37q4vKIqy/erC4ZQw
         hShA==
X-Gm-Message-State: AOAM531RQ+qzvrP92YB2CP85PK261uBHZ7Amfqq+cIvne3SZMsqYvv+q
        7KJ2vioxeDQUgyFdgUYStUY=
X-Google-Smtp-Source: ABdhPJxBnf2CeWe+21KSDh0KTQcm1R/GP2/VmC9WQYLr27twxW3i4YwuWRqFxbCfC5AHsRzRGiHlYQ==
X-Received: by 2002:a63:80c8:0:b0:405:186f:fa39 with SMTP id j191-20020a6380c8000000b00405186ffa39mr10245958pgd.84.1655126663619;
        Mon, 13 Jun 2022 06:24:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090a639400b001ea75a02805sm7389065pjj.52.2022.06.13.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:24:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Jun 2022 06:24:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell G5 5590 to DMI table
Message-ID: <20220613132422.GA3805541@roeck-us.net>
References: <20220612232208.27901-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220612232208.27901-1-W_Armin@gmx.de>
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

On Mon, Jun 13, 2022 at 01:22:08AM +0200, Armin Wolf wrote:
> According to Bug 215983 at bugzilla.kernel.org,
> the Dell G5 5590 supports the SMM interface and
> can thus be loaded with ignore_dmi being set.
> Add the model the DMI table to allow for
> automatic loadig on this model.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied to hwmon-next.

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
> index 16c10ac84a91..d419885dd771 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1131,6 +1131,13 @@ static const struct i8k_config_data i8k_config_data[] __initconst = {
>  };
> 
>  static const struct dmi_system_id i8k_dmi_table[] __initconst = {
> +	{
> +		.ident = "Dell G5 5590",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5590"),
> +		},
> +	},
>  	{
>  		.ident = "Dell Inspiron",
>  		.matches = {
