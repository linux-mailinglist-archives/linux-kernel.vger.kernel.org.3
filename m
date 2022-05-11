Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4284523C31
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbiEKSDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiEKSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:03:10 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5587981487;
        Wed, 11 May 2022 11:03:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so1006236oty.3;
        Wed, 11 May 2022 11:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=JjnAsshK1ygLfpmwHJL1Gf52yDOmz4G85Y+2UEczzWM=;
        b=Imbdmkg5KSJtTH5nK8osWpMvPlAYu9ZbyqpjaIZW6rsjI51uMNSlCvy6QqTgqhUBfW
         T2qwHBgCC5ieR7Mx/NX8LidOhgBXZ8IIozWnEUgqrt30U5rPG+7zKH7xfz7t6Fh23gqb
         wPKRQcO67rFu/u22t3YheQjC+VP16bfJ13DrQbGHaifY1wo6udnVLbP4f08PITxioKTS
         yOrG3MV44VxCrCbSMFj5Of7gkCfu+Mx2DyI+7CM1tj6Q/yuwhl6CZe1kgvioWJe8Sq9L
         XY+cHCZa3YiGV6Y3iWnhaUFqWh2RX/gqURewf/OaifB5t29yGpox0Po9RgOOx+ImP9eh
         Fplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=JjnAsshK1ygLfpmwHJL1Gf52yDOmz4G85Y+2UEczzWM=;
        b=tRiEV+6WVhAsBY85+rA2T7FSCRx2NrX+gsHtkKd4XipdzvorD38KEIec5Oraq+1W6u
         TQEEDe/uBacZ4xvDw6aQwlnEtJ945lqPXaJzEh7gNGX7rUF5iLAt0k7uyZCSeMr90wat
         TsNTVx9/MjQQcmctXXSeq6sysmmsQPe8kUpnsRSmFJPvlZd2PUGxf14aRR444FvRLDUB
         DXoD0UfoMlqf1kVC6MGda+l+xlpKEoZTWrh1PQi6BAh3bU1COrqlSu8rkCxjvMMEGRm6
         wL1OqYGJiG2D0gan0euhDqYzNH+HGdvlNA6xaHCWMcDaVUliec/Wm08S04nziw7Ps2yQ
         l22g==
X-Gm-Message-State: AOAM532PwmvHZzwmmsledRoWVL2/+gZ1h4dEpaFEwo5wzPt/YC94gWJf
        L9j3BM2oEShyWfSKPG1lnfA3YVv6/B0OlQ==
X-Google-Smtp-Source: ABdhPJyp2MnsekH53L9TKdKVuTrjPVVSJ1KPE+AEhk8vuCmKSk4MzvytyrHsLQ1B0qqk/pPjH+7dXg==
X-Received: by 2002:a05:6830:1303:b0:606:4e64:4c6c with SMTP id p3-20020a056830130300b006064e644c6cmr9949566otq.42.1652292188682;
        Wed, 11 May 2022 11:03:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b20-20020a9d6b94000000b0060603221234sm1052568otq.4.2022.05.11.11.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:03:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c458add-a496-6b3a-a04f-e6b68865daf4@roeck-us.net>
Date:   Wed, 11 May 2022 11:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20220511153905.13980-1-henning.schild@siemens.com>
 <20220511153905.13980-3-henning.schild@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB
 accessor
In-Reply-To: <20220511153905.13980-3-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 08:39, Henning Schild wrote:
> Since we have a common P2SB accessor in tree we may use it instead of
> open coded variants.
> 
> Replace custom code by p2sb_bar() call.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>   drivers/watchdog/Kconfig           |  1 +
>   drivers/watchdog/simatic-ipc-wdt.c | 15 ++++++++-------
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c4e82a8d863f..643a8f5a97b1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1628,6 +1628,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>   	tristate "Siemens Simatic IPC Watchdog"
>   	depends on SIEMENS_SIMATIC_IPC
>   	select WATCHDOG_CORE
> +	select P2SB if X86

Why "if X86" ? SIEMENS_SIMATIC_IPC already depends on it.

Also, I just noticed that P2SB is neither in mainline nor
in linux-next, meaning this code won't even compile right now.
That should be mentioned in the introduction e-mail (the use
of "introduced" suggests that it is already there; you could
just use "will be introduced" instead).

Thanks,
Guenter
