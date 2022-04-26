Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E6C5101D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbiDZP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbiDZP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:27:30 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532921276;
        Tue, 26 Apr 2022 08:24:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k29-20020a056830243d00b006040caa0988so13281342ots.6;
        Tue, 26 Apr 2022 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYXm4HllCtexuvgFMApfVlKDzVuzeVoO2qrfRKxSgO0=;
        b=hCGKAiDGdjkGu7z108Dk4YCzPvsV/pxh7Y3jPM+J8mvCt0LNzvRoSZAfCIhTxOqrur
         Vr+BJRmNNz45Ee1WuMjRpOR+LMEzayq3eD7lWmv2CnnlHT7c48TD0iex3GxbER2g1x7E
         b2TOv1H7zSCkGaN5yB8/MDQBlcRU+85XWJv2l9ZCCla7Qp1YAfvOUlFskrqbF7He8Pz/
         zsx8NIQ4dyTsS4fg7E8scbg0YAwp9Y2dn6wi5zulPGKi9K/tQKgBwJIymZbs4lrWL+3Q
         5PpoConDbfRSWsXnKvZReLzSQ6zl6nIon1yFO6H+zBLLiGD/955oYsvv3Rrl7XOUWuxz
         l34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aYXm4HllCtexuvgFMApfVlKDzVuzeVoO2qrfRKxSgO0=;
        b=PYfY8kBAYF8bl9G2VGb2DoxqS47qPGuISsULG+sgyDuFV7hE3H/K4kbmEKWGLFPGD1
         gV+ElRsB7hvtwc1iVaQnXZs38yd00h15N4Wz0tyEnmLEATvjHAClqatXUBxzQIgH+lQz
         Z2DGmf997sJ0TpZiB6M3fNS7BAO3OLMPdUoCdP78cwb1WC9p0eqI/qcMdp4kpnoAGgZz
         6lo48B95R7aYigYd5AFHcLpJqhkA3+dRF6K2ZHwi929RqpAR3UTYZhhp+bIrNfbFA2qF
         owq0hehkTPY1QdAq5/LuIdAgM3hJ/uqHpVS6N8/4UZ8/NGKP8i5AUdJv4004JgZrVhZw
         u2HA==
X-Gm-Message-State: AOAM533tBw2T+NQMr/KLA1GKS0qv6uVYFwdT2zSkQy/6FccDYq+RKIWa
        bZMzGRL3xJIHB435gOqmAFubhKk2gCw=
X-Google-Smtp-Source: ABdhPJyWaDXWVj1MtzMuxIOkJsSsH3zu16j1ov7CAkY8E/fJ0YsrFebYK9NNcNo4b1Na9Q1MfOcBcw==
X-Received: by 2002:a9d:4705:0:b0:605:4f63:8ae0 with SMTP id a5-20020a9d4705000000b006054f638ae0mr8384348otf.256.1650986661617;
        Tue, 26 Apr 2022 08:24:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a056870440700b000e686d1387asm913069oah.20.2022.04.26.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:24:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 08:24:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: (asus-ec-sensors) add support for board
 families
Message-ID: <20220426152418.GA3344789@roeck-us.net>
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-4-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426092340.495704-4-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:23:39AM +0200, Eugene Shalygin wrote:
> DSDT code for AMD 400-series chipset shows that sensor addresses differ
> for this generation from those for the AMD 500-series boards.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>  drivers/hwmon/asus-ec-sensors.c | 39 ++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 7267682de191..b52e3679476a 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -135,8 +135,12 @@ enum ec_sensors {
>  #define SENSOR_TEMP_WATER_IN BIT(ec_sensor_temp_water_in)
>  #define SENSOR_TEMP_WATER_OUT BIT(ec_sensor_temp_water_out)
>  
> +enum board_family {
> +	family_amd_500_series,

The default enum value is 0. This means that specifying nothing
for .family matches in the structure below always matches the first
enum, which doesn't make much sense and might cause trouble in the
future. I would suggest to explicitly select a value != 0 as first
entry, such as 

enum board_family {
	family_amd_500_series = 1,
	...
};

to avoid that problem.

Guenter
