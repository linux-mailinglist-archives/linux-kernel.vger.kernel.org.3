Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0690F547A45
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiFLNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiFLNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:08:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E662C1;
        Sun, 12 Jun 2022 06:08:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e9so3341120pju.5;
        Sun, 12 Jun 2022 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AXjEz0ZJVP6RCJfwrLWHDoBIgeQ4dlHx7CyRl+zYPvk=;
        b=ReG7pBXLCgZg56XhjnEJOOhygmDATEs1X5XKmJOxTs7Rw4Wz7DJemFRikqI6KAOeL1
         pqtFdTnd7spZLjIJXXkWrTkqL0M3JKwu2i7iJewiBFPZee+2Kgy4p9Ni3vm+csZOcoFF
         NEzJNwujS1dxbe34HQoQnb32XElfemGKqTOjD03vA6saVW8JOjiAxbKgsqAm9oSS6K2I
         wDoiwJ13ILobSjDGhpxKig5Jqtb+CXTBLEIv2l6pWmkBN6nMSL4tPLyHC2IRakeeee47
         9Fw/RaMS7WHiadrcKXthHYQtz2Vvx0uVREiWlmGQJGu46rktTLETy6jKVaBzDYiMNdal
         eIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=AXjEz0ZJVP6RCJfwrLWHDoBIgeQ4dlHx7CyRl+zYPvk=;
        b=b4iOy3srS9ujUUV+MjwtpooagMybG1Apw+XzkxfeyUoTc8j2tuxGYBWrv3ye/T61vD
         gvarkPO5KaYFKnwiRdfJeO4TkuK3Ca/CxFA4k6WXtEiZq82tngx0sSzFF8o8RHUNRLck
         TXWKJDMPAI+HhdGdrjXTJ7ovvufrGYSKpCCgiqPXM16WljJbcw9AoAiWanQait1r5w9/
         tu/dp93FWO+c+HEm/NpjLJlG1gHRth63W+W2weeW1O1V2i+7zgtCk89ncMO6/SXMWeKZ
         X8Bq2p2I38a7QkNbRei3GR5iiWucG1s4QqXN5JPgYosXrigEBLIZ/s735iXlzSrhyacY
         SOQA==
X-Gm-Message-State: AOAM530bJW7S4JiY4GAevsIfgxkUDg3ZrrLVSUT/wYZfje+qbc1Mwx9k
        VYRc4dBGoI8+CmohFXa6KvU=
X-Google-Smtp-Source: ABdhPJxpR3XPXtwZX7CQg7M18tvgIDMCR7/pVE8gt2Hz/rE3Xm3aAiGlT8N2Ux1fxKmN8TLJXZm2dQ==
X-Received: by 2002:a17:902:cf05:b0:156:9d:ca01 with SMTP id i5-20020a170902cf0500b00156009dca01mr53435456plg.111.1655039307230;
        Sun, 12 Jun 2022 06:08:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0051bc44f26d9sm3234879pfg.23.2022.06.12.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 06:08:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Jun 2022 06:08:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell XPS 13 7390 to fan control
 whitelist
Message-ID: <20220612130823.GA515166@roeck-us.net>
References: <20220612041806.11367-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220612041806.11367-1-W_Armin@gmx.de>
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

On Sun, Jun 12, 2022 at 06:18:06AM +0200, Armin Wolf wrote:
> A user reported that the program dell-bios-fan-control
> worked on his Dell XPS 13 7390 to switch off automatic
> fan control.
> Since it uses the same mechanism as the dell_smm_hwmon
> module, add this model to the fan control whitelist.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 071aa6f4e109..16c10ac84a91 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1365,6 +1365,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell XPS 13 7390",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 7390"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
