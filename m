Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E154CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbiFOPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349368AbiFOPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:19:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A13FBE2;
        Wed, 15 Jun 2022 08:19:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d129so11656934pgc.9;
        Wed, 15 Jun 2022 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dohva7PorvnI7E7DeyPN96L7EkJ7Yhh9+jaMImkrHmo=;
        b=MOyWaJhbJODvnd5BwdZEz+3fHzkpKWmX6730tstRY3pzObGb225GFsPkwRu3LVGfYD
         Ki+7Y8i+9b1vYNyDy7OvlJvaRvgyFdLVG9NlZyUzMANXqBnoJZ1Qi1GTuR0GGiGJVT1M
         BOpdPnAs3wOVzRW6bL0bmEgBlyKMf58ULJbzc/tZsNN0IrhWj7S2WunQtOaHVxP2ihnb
         xxE2qmf58aDnI10yZSq81SiH3G4lzD/8mPQsThsp40SVHMmC32TMzhkDwZkRRRSO7978
         9NWfvYJvwImYUDEsfrJANRyc+jS1kHKl2lOgdW928YArljXRoYIgQRVA/SK9eQbbm/5t
         tbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Dohva7PorvnI7E7DeyPN96L7EkJ7Yhh9+jaMImkrHmo=;
        b=xQ7/x7TaL0tGpOBVxEPcbIQZeNQaNQnCUGW52goaIlYcz4sxJpyYQE5W9lnBIFUDAH
         liCjnbft9PwhP8Qg81PGd2bSEhH5R31X0WNTOt0kdk1uCyZNuIxXBWk+rGesm/Z3vLOB
         OjU4o+uVDmpToZ8YOKZkXXXBw9oaj7yKv8C+XZ1MUYsT+qtwJEB0Q4DYgWh74gVJaqJh
         tzNLUDnV6lNHTZKUjnfFpjQlW8fiHy7vXEgL7zGLKBsJJXkL1H2LVWfeM+56MfQdyaha
         sKu78AcPPQRYADsh6juy17sF3amkvNIHYBPamcccZAxfYiciN2MtUwU7NLVFZgk5S48p
         7MPw==
X-Gm-Message-State: AJIora9KUH7xsoRC6ruDhnqp7Zn9kn1EpoI7c6Um4bOXKXG7hPjqBznh
        6YtM2OQQBawRZaIIHCYTop+Uiii5Ow0=
X-Google-Smtp-Source: AGRyM1uEvL8+wHYpdUUxctUgmvtYTfPNqGaeVWKqOxb+9UDRsiTTExLwelFgNSNWY2qG38AmCF6Pjw==
X-Received: by 2002:a05:6a00:2918:b0:512:e4b5:60fb with SMTP id cg24-20020a056a00291800b00512e4b560fbmr135924pfb.50.1655306366092;
        Wed, 15 Jun 2022 08:19:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 199-20020a6300d0000000b003f24d67d226sm9957420pga.92.2022.06.15.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:19:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Jun 2022 08:19:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add missing comma in board
 name list.
Message-ID: <20220615151924.GA3230585@roeck-us.net>
References: <20220615122544.140340-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615122544.140340-1-eugene.shalygin@gmail.com>
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

On Wed, Jun 15, 2022 at 02:25:44PM +0200, Eugene Shalygin wrote:
> From: Michael Carns <mike@carns.com>
> 
> This fixes a regression where coma lead to concatenating board names
> and broke module loading for C8H.
> 
> Fixes: 5b4285c57b6f ("hwmon: (asus-ec-sensors) fix Formula VIII definition")
> 
> Signed-off-by: Michael Carns <mike@carns.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 886a71b4c64e..19d3ca71b360 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -268,7 +268,7 @@ static const struct ec_board_info board_info[] = {
>  	},
>  	{
>  		.board_names = {
> -			"ROG CROSSHAIR VIII FORMULA"
> +			"ROG CROSSHAIR VIII FORMULA",
>  			"ROG CROSSHAIR VIII HERO",
>  			"ROG CROSSHAIR VIII HERO (WI-FI)",
>  		},
