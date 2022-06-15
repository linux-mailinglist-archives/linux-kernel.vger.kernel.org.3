Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F354C802
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiFOL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbiFOL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:58:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDC43EFD;
        Wed, 15 Jun 2022 04:57:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gd1so11050294pjb.2;
        Wed, 15 Jun 2022 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i636qZX1XUJL64KaFSEZhJIdXHSV4bN2JFKGrjkd9cw=;
        b=g0SKckdrJXJipUchvC6EH5Zqlze9ZyoA55jeu32NxP8oWaMzrN0OrPI2TZj/A+uPQh
         b+XuQzuRKFyzGLbdIUc2aAElCsUgNf4VirTSGGTUSjXL66RrG9QedelLoeb0ziHW6Cga
         EPry8muruUpAymHvukYyERRn5wRWBcjheHkq3UZ3ZcmIEEvY9s3ApXDxVd7L64NiI0SL
         HDo/mC5NIr4WpUwCiBCINPBPE+0glvgRZtydXk7P0UqXU1ZPrDKOJpLW53fUcz5Mh9HV
         R9ZfurUXR3Yq3CC/isP1KZlShgzogYeseZR4RAWsu8UELmLpZrgK0lQ7oauhofnvAyCo
         Ne8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i636qZX1XUJL64KaFSEZhJIdXHSV4bN2JFKGrjkd9cw=;
        b=F8JZfFpGtF5JGUG6unFyK76h2byQhQY75XZ9Pf8Dfk7TmveTwPqx15DGkKD6Bqps9R
         ycFOxBPAusTIO+Q1ypXhphaXthpT7Gc7f/nf/5dHveyxaafufd8lm8/8Df0bDPaWCEX3
         1KgFym0dLlcU32qsz1mo5VE2vXaxA5+FDSjn2OQBuBsLbLRdk1UmF0Vm1CQAtErtzue6
         MWEMhKYJazQjPyXhGN79Fw/TAhKSynB56porylVhHhCY1ypGLBiYPs3OfsWmkycvxEP3
         ZpczwtU/qxNHql6k8JkkUvXKxcfOJNbdf/Nkgevxc4fRoltIA++opuRlYjmKgBZEyFmv
         g+9Q==
X-Gm-Message-State: AJIora/KVMbu08SXeBjcdY4FGmbPHNSxgwLgrBoi/KerL6m4tO3iPcAN
        Xr8chkqpExj7NJF2rGU5V6s=
X-Google-Smtp-Source: AGRyM1umPHRM4uAZYg6+aQw1SXCjLeOnysP4L7Vv7YUu8PTQ3tt9953k/BflC6xS1kZT+q0CvrwoMA==
X-Received: by 2002:a17:90a:6941:b0:1e2:f37a:f889 with SMTP id j1-20020a17090a694100b001e2f37af889mr10017682pjm.160.1655294272665;
        Wed, 15 Jun 2022 04:57:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9152915plk.143.2022.06.15.04.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 04:57:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a6e1547-cdcb-81ae-79fd-b0e56fca2f76@roeck-us.net>
Date:   Wed, 15 Jun 2022 04:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add missing comma in board name
 list.
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615104520.35687-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220615104520.35687-1-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 03:45, Eugene Shalygin wrote:
> From: Michael Carns <mike@carns.com>
> 
> This fixes a regression introduced by commit 5b4285c57b6f
> ("hwmon: (asus-ec-sensors) fix Formula VIII definition")
> where coma lead to concatenating board names and broke module
> loading for C8H.
> 
> Signed-off-by: Michael Carns <mike@carns.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

We have a Fixes: tag for such purposes. Please use it.

Thanks,
Guenter

> ---
>   drivers/hwmon/asus-ec-sensors.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 886a71b4c64e..19d3ca71b360 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -268,7 +268,7 @@ static const struct ec_board_info board_info[] = {
>   	},
>   	{
>   		.board_names = {
> -			"ROG CROSSHAIR VIII FORMULA"
> +			"ROG CROSSHAIR VIII FORMULA",
>   			"ROG CROSSHAIR VIII HERO",
>   			"ROG CROSSHAIR VIII HERO (WI-FI)",
>   		},

