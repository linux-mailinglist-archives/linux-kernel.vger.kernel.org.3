Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EB5185D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiECNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiECNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:47:41 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132591D30A;
        Tue,  3 May 2022 06:44:08 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so11332075otk.1;
        Tue, 03 May 2022 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekpWvS+anWeQlrfaKFCOj8G7h2lMxD37gWeltGp8A3Y=;
        b=B9CokLn1GX1NrOT++Z880iU//nFlWlXXo2tNl30LjEVcwWHziZUoAUVc94Lcg6+t+Y
         Bxxa0s1V44+ZQdZjvgKe1IrEEr0bdT/2jLe/R8LLSvfg2OZFNNPhul5LaF3i7jlGyeso
         Zv6v9le40JUjZIlPNdWHgtz4Jbl2KPrbOhGhvFBE4m5pCyWjEGhfR6N/iFEvZ0enz+Wu
         QArbtal9F9MmErL4LtXcwv9nUDOB+rQKANBKz98tVfIpnCxaP4KpQ5LpeoRlitb34oLX
         AU+pFdcPfN5wkUMAEnnAzqtZPnK6v9Fi6JglZvF6A6f1sruFEdLtVplJkpC2A8ZiT8wQ
         bC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ekpWvS+anWeQlrfaKFCOj8G7h2lMxD37gWeltGp8A3Y=;
        b=sk6BU/XEta3Q7CCXjX47hXwrhJuUXRZFqYN9Wz8xFKXqdgOeyhH/AA/bFffsLveMNH
         VHlVj+z9ZACXqUVIQArMY3ArBqiO5sYM43nPrUmR8k+B6/vqwsNEjbxLF9vAfkcmVA/2
         7Yj5EF7NqrrlD/6sx9jJmXsSbx2ifo5VMs6OXH/pxp085kGcyP7W3C3rnlvqBDkRrisY
         Ipf6yq/X8uSpylaqOjNhJW9wdT8rgQMDTqcRDIkBJG9QsKBSHMhdM3Sc7eiPVeV+f8NK
         MUsXcGUzQgACK5P4ynf93+wMk0fD1qpsI/9P8jcskrbP6OY8XMny5ZFz9pdrbyY/PJVx
         n1FA==
X-Gm-Message-State: AOAM532q2Dnoxgt4kbXPpTuskSssSJ+MjPYg4Hr+Rk1KtAT7nESXqZLJ
        X5qOc3vkIoqX4hejrSNl21M=
X-Google-Smtp-Source: ABdhPJzaXApsk6xgltsIrs7WaOqrd8bF+onKCwGjUKGxWnOlJRJN4qz1KpS5vVV7UWo2NCYk7m/ubQ==
X-Received: by 2002:a05:6830:25cd:b0:605:c92c:967a with SMTP id d13-20020a05683025cd00b00605c92c967amr5949673otu.306.1651585447382;
        Tue, 03 May 2022 06:44:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8-20020a056870124800b000e686d13888sm7213907oao.34.2022.05.03.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:44:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 May 2022 06:44:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Camel Guo <camel.guo@axis.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v4] hwmon: (tmp401) Add OF device ID table
Message-ID: <20220503134405.GA3208573@roeck-us.net>
References: <20220503114333.456476-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503114333.456476-1-camel.guo@axis.com>
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

On Tue, May 03, 2022 at 01:43:33PM +0200, Camel Guo wrote:
> This driver doesn't have of_match_table. This makes the kernel module
> tmp401.ko lack alias patterns (e.g: of:N*T*Cti,tmp411) to match DT node
> of the supported devices hence this kernel module will not be
> automatically loaded.
> 
> After adding of_match_table to this driver, the folllowing alias will be
> added into tmp401.ko.
> $ modinfo drivers/hwmon/tmp401.ko
> filename: drivers/hwmon/tmp401.ko
> ......
> author:         Hans de Goede <hdegoede@redhat.com>
> alias:          of:N*T*Cti,tmp435C*
> alias:          of:N*T*Cti,tmp435
> alias:          of:N*T*Cti,tmp432C*
> alias:          of:N*T*Cti,tmp432
> alias:          of:N*T*Cti,tmp431C*
> alias:          of:N*T*Cti,tmp431
> alias:          of:N*T*Cti,tmp411C*
> alias:          of:N*T*Cti,tmp411
> alias:          of:N*T*Cti,tmp401C*
> alias:          of:N*T*Cti,tmp401
> ......
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Signed-off-by: Camel Guo <camel.guo@axis.com>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     v4:
>      - Rewrite commit message due to improper description in old one
>     v3:
>      - Copy commit message from commit 72fc64c68decf119466 ("hwmon: (tmp103)
>        Add OF device ID table")
>      - Add Fixes tag
>     v2:
>      - Put evidence and circumstances in commit message
> 
>  drivers/hwmon/tmp401.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> 
> base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index b86d9df7105d..52c9e7d3f2ae 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -708,10 +708,21 @@ static int tmp401_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
> +	{ .compatible = "ti,tmp401", },
> +	{ .compatible = "ti,tmp411", },
> +	{ .compatible = "ti,tmp431", },
> +	{ .compatible = "ti,tmp432", },
> +	{ .compatible = "ti,tmp435", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
> +
>  static struct i2c_driver tmp401_driver = {
>  	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "tmp401",
> +		.of_match_table = of_match_ptr(tmp4xx_of_match),
>  	},
>  	.probe_new	= tmp401_probe,
>  	.id_table	= tmp401_id,
