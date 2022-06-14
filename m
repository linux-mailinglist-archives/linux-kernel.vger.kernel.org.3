Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1754BC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbiFNU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358020AbiFNU6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:58:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B84FC4F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:58:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so9533741pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UDsOFLddT7JI3MY9amnekfXssOa8lE99LyN4VJ+GI5Q=;
        b=HLyQxB/vhxqwX8dv4nCCRMMJmV6YyxGoUccXlaScuHaHZ81Z+2W1DIZXCS/TDp6AlH
         XW7KGiieBSkB01yZ3jsUUgR9VL0mcv9v/tnsavE4Sz9q3lgtqH6e1ZRXfFCNo7ZIib6r
         QB4keemPVwSkME5HYki1rNfp0aBIEmMzOHZr919acoQRChGvd4o8VUH6CnRfqvhIvCVc
         PKQcy5cQcYiKdXqkoaXPjeiPjt3n7CjXPav5gaN2GrPReugP+zhnMjTLjh8wiBqB4XI3
         xsM1uJ0lEh9dMRy+sUWGmZKunougrqwxMUdAIOMXcLOyhWr5ytHTqFQuQP0xZJzYjQDQ
         9Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UDsOFLddT7JI3MY9amnekfXssOa8lE99LyN4VJ+GI5Q=;
        b=uUZyMI6rIAEK6211pxC99OVR0/Wfa2qUaRnqZzVlfZXRY6Y7H/s3ZFIJfdFH0susCZ
         oG8kUO+/XntlBsfHgUm84aBNw/e1zvgABHNaJXiqyfAniWCm1llCoKYQQ26cz8WGxmhp
         t2G91gZSTpNhXZy1GnCKVNkjbwKBsG8yTXH1FEOq/327fDfCmezViyQkOQv8qltp16o6
         8XAWl6SOyL/Q/+sVxThgUnB9tlBLBUow0EqYH9hDi0/07wDLRQ47Fk0W15Fgt5L5Ey9r
         uFpYuZi476Sr5uYAfbWCF76volQLWjRqQVFJ9BzwBSQCJ5C93zFQQaMQVWSSYObSkA9F
         lwOw==
X-Gm-Message-State: AJIora8gfUQL1WbPBF75bUa0yXMod6UY842Clp9riNBCL2zuUY9afVJZ
        AjSZKqgEpjamOnp5z24PfhADEmYwgh4MenJm
X-Google-Smtp-Source: AGRyM1tV0SRfhdN1umKaypC/rq2/eKssDHjhJ0VmHHVnzLIdc9PbTycuBpqOcLayksUHHkOporLGzw==
X-Received: by 2002:a17:90b:1d06:b0:1e6:7a84:3c6e with SMTP id on6-20020a17090b1d0600b001e67a843c6emr6502103pjb.202.1655240306825;
        Tue, 14 Jun 2022 13:58:26 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b001635c9e7f77sm7668254plk.57.2022.06.14.13.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:58:26 -0700 (PDT)
Date:   Tue, 14 Jun 2022 21:58:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] mfd: da9062: enable being a
 system-power-controller
Message-ID: <Yqj2cHuhjRhSIbDt@google.com>
References: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca76e2bb2f5d47ad189fa1a40bb6dd8a5dc225d2.1650606541.git.helmut.grohne@intenta.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Helmut Grohne wrote:

> The DA9062 can be the device used to power the CPU. In that case, it can
> be used to power off the system. In the CONTROL_A register, the M_*_EN
> bits must be zero for the corresponding *_EN bits to have an effect. We
> zero them all to turn off the system.
> 
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/mfd/da9062-core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> This series effectively is a rebased resend. The earlier posting was
> https://lore.kernel.org/all/20200107120559.GA700@laureti-dev/. At that time,
> Adam Thomson critisized the use of regmap and i2c inside a pm_power_off hook
> since irqs are disabled. He reached out to Lee Jones, who asked Mark Brown and
> Wolfram Sang, but never got any reply. I noted that a fair number of other
> drivers do use regmap and i2c despite this issue. In the mean time, more
> instances were added:
>  * drivers/mfd/acer-ec-a500.c uses i2c
>  * drivers/mfd/ntxec.c uses i2c
>  * drivers/mfd/rk808.c uses regmap and i2c
> Given that we proceeded with accepting the use of i2c and regmap inside
> pm_power_off hooks, I think we can proceed with this patch as well.
> 
> Helmut
> 
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 2774b2cbaea6..e7af5b5f16e0 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -620,6 +620,23 @@ static const struct of_device_id da9062_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, da9062_dt_ids);
>  
> +/* Hold client since pm_power_off is global. */

Please drop this comment.

> +static struct i2c_client *da9062_i2c_client;
> +
> +static void da9062_power_off(void)
> +{
> +	struct da9062 *chip = i2c_get_clientdata(da9062_i2c_client);
> +	const unsigned int mask = DA9062AA_SYSTEM_EN_MASK |
> +		DA9062AA_POWER_EN_MASK | DA9062AA_POWER1_EN_MASK |
> +		DA9062AA_M_SYSTEM_EN_MASK | DA9062AA_M_POWER_EN_MASK |
> +		DA9062AA_M_POWER1_EN_MASK;
> +	int ret = regmap_update_bits(chip->regmap, DA9062AA_CONTROL_A, mask, 0);

This is messy.  Please separate declarations and assignments here.

The top one is passable.

> +	if (ret < 0)
> +		dev_err(&da9062_i2c_client->dev,
> +			"DA9062AA_CONTROL_A update failed, %d\n", ret);

You're talking to the user here.

Please use language that is more user-friendly.

> +}
> +
>  static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
> @@ -720,6 +737,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> +		if (!pm_power_off) {
> +			da9062_i2c_client = i2c;
> +			pm_power_off = da9062_power_off;
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");

Do we really mind/care?

Is there anything we can do about it?

Thus, do we really need to warn() about it?

> +		}
> +	}
> +
>  	return ret;
>  }
>  
> @@ -727,6 +753,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  {
>  	struct da9062 *chip = i2c_get_clientdata(i2c);
>  
> +	if (pm_power_off == da9062_power_off)
> +		pm_power_off = NULL;
> +	if (da9062_i2c_client)
> +		da9062_i2c_client = NULL;
> +
>  	mfd_remove_devices(chip->dev);
>  	regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
