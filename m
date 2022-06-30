Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069A561761
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiF3KMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiF3KMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:12:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F464477E;
        Thu, 30 Jun 2022 03:12:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k7so2043210wrc.12;
        Thu, 30 Jun 2022 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yfRhc61AaTPZtvRzR5+PiNxgCQLaNl/GoBV3ZT0U/Kk=;
        b=CgGSeJLtgWTyVFl5LsMtYnk3B70jFGkUfunpef5C3bazlwFaV4tdFXBcUtjODuTb97
         Wqv4mzyTSpeNz/uYNG/HGKW1yyc9XoPHWF843v9Pn0RqlE5PrqtDyzW7loq8DUKhZXY6
         vrHTEnVSMxUjvm/3dcVSpZLhHfz89YxjIiiRCR7WiTNR6M4gG4+aeS3WQjZ4ggGbsMJN
         Uclu+2248rNdGNnpmovnZbE4Wt0zjBpd7WnxQ/zzMQmONRhQ0uLrWSUAZu/3xJ0xeTRr
         4ghRhBOzrGcAPKDsVYyheX+dSWWcL8FZXfIovAGPNPOjRbGSBB9m6u+dTmxCsz41qaiN
         SLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yfRhc61AaTPZtvRzR5+PiNxgCQLaNl/GoBV3ZT0U/Kk=;
        b=VuDl56rCnhuT6Rq+Ll4SkbVqxFAxgi/8qwO73YdXVUiSLIJ0hU+GOxTfH4SXtFs9b6
         EbmiabLewm5Sh4RICJ9H/P5mTAzYvknIfclzBtNmn8MtNXFhkqToiuhgJL/QmB4zuXE8
         KSbGx5iKkOSTIveFKobmgw3neP4UZzk94pAxl83Di9F870YJBhCzWB8dXeDMJQ+EUhdT
         m/LEmY6ooGeFl9c4b284fZd2WnUUzH13O8Vs6Wk2CECaqyHQJB/IslWZfqc72kIyQeOB
         1UuDc/BNZeUqbjW5FfxBlHOTAv2+kfetNiDWnIUPQQAmQ+7kW6jpTfJ8NE7kGq9yrWNy
         brdA==
X-Gm-Message-State: AJIora8T4XajnWmmkfUkcMv0+4JvBdeBYkNKZo3s5xJaUJys7n+tbd+/
        XxIIOsMTHXoxK/TQAO/9O4bTPovrtfQ=
X-Google-Smtp-Source: AGRyM1vKNOKnLz3Q6RDe43DYq252Bjx/HQViG2Gr3/Qa7uxJ6oLQjXabb/BYvPemLRNNjZFVyF+DPw==
X-Received: by 2002:a5d:6a03:0:b0:21b:9cc1:d5dd with SMTP id m3-20020a5d6a03000000b0021b9cc1d5ddmr7863856wru.450.1656583953814;
        Thu, 30 Jun 2022 03:12:33 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id p12-20020adfcc8c000000b0020d0c9c95d3sm19522129wrj.77.2022.06.30.03.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:12:33 -0700 (PDT)
Message-ID: <4ad28210-0827-c86e-b2a3-b7ed49a191d3@gmail.com>
Date:   Thu, 30 Jun 2022 11:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 6/6] media: ov5693: add ov5693_of_match, dts support
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-7-tommaso.merciai@amarulasolutions.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220630074525.481790-7-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 30/06/2022 08:45, Tommaso Merciai wrote:
> Add ov5693_of_match. Device tree support
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
> Changes since v2:
>  - Change patch order 7 -> 6 as suggested by Sakari
>  - Add missing signed-off as suggested by Jacopo
>
> Changes since v3:
>  - Add reviewed-by tags, suggested by Jacopo, Krzysztof
>
>  drivers/media/i2c/ov5693.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 3c805a5a5181..5930207193c7 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -1532,10 +1532,17 @@ static const struct acpi_device_id ov5693_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, ov5693_acpi_match);
>  
> +static const struct of_device_id ov5693_of_match[] = {
> +	{ .compatible = "ovti,ov5693", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ov5693_of_match);
> +
>  static struct i2c_driver ov5693_driver = {
>  	.driver = {
>  		.name = "ov5693",
>  		.acpi_match_table = ov5693_acpi_match,
> +		.of_match_table = ov5693_of_match,
>  		.pm = &ov5693_pm_ops,
>  	},
>  	.probe_new = ov5693_probe,
