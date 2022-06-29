Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7D560B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiF2VDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiF2VDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:03:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24F642C;
        Wed, 29 Jun 2022 14:03:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jb13so15205823plb.9;
        Wed, 29 Jun 2022 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xwpQXUEl+HIc/77UUZOA2WAll//OpFtxFNmOLiyfHBg=;
        b=iENS8Zl6SX7dkqmJwkNAtBuQSZPN30yw3n1JhcKVAL6+dHGjt8ruJldyF0K9QYu761
         97GlLemD5kpxa5nd/PDzwrszkXJR60DWUewQMl8bqyzZBgo67yI1Rgf76FLJchvWWDmx
         kcz9DdqPGEE+FkSFiRoA1Aly2AB4Im/99IOl/5fghLSXwwAjQhLV1o6WGX6JMJ4Fjwzu
         6moNd6toveCcaJqURZucMLNs/jgm5fZno8XSC6vJXx3lUwMKq9r49wSPtCwpci1y2JJl
         DrwdfYVcYygoEvnFCCZPAFawsqVP2PG/r7LLycFA6VzQcfIPNi0h7a2Y40XtOA41fLO/
         /1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xwpQXUEl+HIc/77UUZOA2WAll//OpFtxFNmOLiyfHBg=;
        b=10Z/vvl9SjefmXrUabSlTQ9xqcuP4zVXwuZn4XRFEfha7/sjMvjH15ro+6OP7n3nth
         3umGX7eBWxKV5y50gpfL1OkCmcXt6G8tBmxoBOoSuLNDQ9YJtUhbH6FpL9IH2ZNYdDpt
         VPnMW4mdIpAXkZ8HFohbuuPQKqz2O17dOwuCMHB0S2VJoZlsShJU8s0IKCW0g0s9FIzx
         +ohjSpwambPZ/D2y/3ejwgo1TJvIzRF0cirebF2x2zTZl/vB5NlILab9hOl+VdTjGOkl
         PbhtMAsHeWHBQ8xjqbNOu7/OcrBuBZzkgEKY/lZR3Gv+brjrq6ncxwb9D15+AG8fkKZJ
         vVaQ==
X-Gm-Message-State: AJIora+0iH9kxEPX3AOzIPHk91FUOM//uB8Rbhwc8vsYaraSGC3h5qTD
        uK3x1U1LB8wAVyPNqDFrbxg=
X-Google-Smtp-Source: AGRyM1ui7YAq3pY3jgvkel8XoPY38FvKJhAyQ8qwCITonWRAhWSWrft+wL7Vy6qB6FXmxwnuQ5ZmIw==
X-Received: by 2002:a17:902:bb8c:b0:16a:7492:1c0 with SMTP id m12-20020a170902bb8c00b0016a749201c0mr11207674pls.54.1656536596230;
        Wed, 29 Jun 2022 14:03:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709029a9400b0015e8d4eb231sm11882556plp.123.2022.06.29.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:03:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Jun 2022 14:03:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/ucd9200): fix typos in comments
Message-ID: <20220629210314.GA3936416@roeck-us.net>
References: <20220622063231.20612-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622063231.20612-1-jiangjian@cdjrlc.com>
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

On Wed, Jun 22, 2022 at 02:32:31PM +0800, Jiang Jian wrote:
> Drop the redundant word 'the' in the comments following
>     /*
>      * Set PHASE registers on all pages to 0xff to ensure that phase
>      * specific commands will apply to all phases of a given page (rail).
>      * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
>      * READ_IOUT will return the sum of currents of all phases of a rail,
>      * and READ_TEMPERATURE2 will return the maximum temperature detected
>      * for the [the - DROP] phases of the rail.
>      */
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ucd9200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
> index 6bc3273e31e7..3ad375a76f3e 100644
> --- a/drivers/hwmon/pmbus/ucd9200.c
> +++ b/drivers/hwmon/pmbus/ucd9200.c
> @@ -148,7 +148,7 @@ static int ucd9200_probe(struct i2c_client *client)
>  	 * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
>  	 * READ_IOUT will return the sum of currents of all phases of a rail,
>  	 * and READ_TEMPERATURE2 will return the maximum temperature detected
> -	 * for the the phases of the rail.
> +	 * for the phases of the rail.
>  	 */
>  	for (i = 0; i < info->pages; i++) {
>  		/*
