Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A84DD605
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiCRIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiCRIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:23:39 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F342B8802;
        Fri, 18 Mar 2022 01:22:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id bt26so12949165lfb.3;
        Fri, 18 Mar 2022 01:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WdC+9kFtPRLU8Xr2VfJ9VNN957Q7szvm+WcyzHVVvCM=;
        b=ogYTvdJmrE50YCMN63x9iY9cKqES5AKjNptkcWxVQdxaJ5JRjL/P3X02JJD7SbbLXi
         BS06lh0wRyc1/RXhqTIb6ygH+d5XEpQhmpRsY5+xXdCrdv2gM0SXxUa772gKrsY5I1Xj
         Xx7BX1vbw/dEQtAhlY3Nwx8YnwbKViHvsdPinoBvzsf0q18ikRKcRgAJs4+omYBAr66H
         s8PudQuFx49KX7CTwy8YYrPvURJqCKjHe67PtCpol7tcZwvnet/UQt9ZYSTNpq9ozLQE
         xdZL3XufUMOVZvxHg4M0qfBO+N7fTKDL+Xebkzk+v2ecYL1B/B2Eg3M3xzw49GMvl527
         D57Q==
X-Gm-Message-State: AOAM5304pgv0Bs8wlliYs5bFP0HNAoWj/ll3AD1usBTfR3m1EqrZA9Mq
        Ruvw9XXvLJFQgJnNNKFCfi4=
X-Google-Smtp-Source: ABdhPJz5lbLQuVCD9p9A3FJwZ+IiYyxcDv4MnFzvf0qDcUGcB4EpfyR7zk6qTULeykX0YXOXi11BJg==
X-Received: by 2002:a05:6512:22c9:b0:448:9448:2b4f with SMTP id g9-20020a05651222c900b0044894482b4fmr5307745lfu.194.1647591739099;
        Fri, 18 Mar 2022 01:22:19 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f11-20020a056512322b00b00447ead80e8csm742202lfe.188.2022.03.18.01.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:22:18 -0700 (PDT)
Message-ID: <facf5551-bfc7-aeb4-daed-5bfcb8a36475@kernel.org>
Date:   Fri, 18 Mar 2022 09:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh
 on max17055
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> Unlike other models, max17055 doesn't require cell characterization
> data and operates on smaller amount of input variables (DesignCap,
> VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
> by max17042_override_por_values, however model refresh bit has to be
> set after adjusting input variables in order to make them apply.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
>  include/linux/power/max17042_battery.h  |  3 +
>  2 files changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index c019d6c52363..c39250349a1d 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -806,6 +806,13 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
>  	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
>  		max17042_override_por(map, MAX17047_V_empty, config->vempty);
>  	}
> +
> +	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
> +		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
> +		// VChg is 1 by default, so allow it to be set to 0

Consistent comment, so /* */

I actually do not understand fully the comment and the code. You write
entire model_cfg to MAX17055_ModelCfg and then immediately do it again,
but with smaller mask. Why?

> +		regmap_update_bits(map, MAX17055_ModelCfg,
> +				MAX17055_MODELCFG_VCHG_BIT, config->model_cfg);

Can you align the continued line with previous line? Same in other
places if it is not aligned.

> +	}
>  }
>  
>  static int max17042_init_chip(struct max17042_chip *chip)
> @@ -814,44 +821,54 @@ static int max17042_init_chip(struct max17042_chip *chip)
>  	int ret;
>  


Best regards,
Krzysztof
