Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B34FB1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiDKCp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbiDKCp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:45:56 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2E3F324;
        Sun, 10 Apr 2022 19:43:43 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so2536068oof.11;
        Sun, 10 Apr 2022 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oLgts9K7UmQuTCuGmocOEoqDhSlWF9Xa8QfC90inKE0=;
        b=K2F+wfG9CIyclOliTMc4jVzCzPnRoDTxDUkNENWyUMMBuzIdAHfgvviRSjjY94N6Zw
         RPx3brzZx5xwuItnvfnhJiXVnnpzeUVjdBCWrH70cq9kcd9lz6xj1ZbsJChXjLmgKNhY
         wtXaIVkYkvg9VW430ltpi4WDyOjEAqIyzfSE6LF9w2LQs1JmVGnNfP05bVU4suB0HTrQ
         B8dAadp2GmC8OJ987ewFL7Q3atg/ixMqTggM79XSXgcpe6oBqref8c0ibWbtm3mloSPD
         EGWhJipUIwWFpya0v84TIBekbKhVYn1OKjzY5zvqusWqSgyg0AjWXQoxiBnamjHF7TVM
         wFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oLgts9K7UmQuTCuGmocOEoqDhSlWF9Xa8QfC90inKE0=;
        b=0/KzHYVJT/6HqdjfJFmKBTJeOqkD0P0KrvxFhOIMT7YMBWRUEqNo/dGHvc1YjsCbq6
         t0+f/dlM2mo+ZK59Ye/tp2OdHurMCfuCi3h2spXqiy+VssDCKgefnTgBdXPXiPkTZMtO
         VvN/4geakvarMsyR0DalgFgPAA7GyZt/TtHBmXvWJ51RaAV31Co8gdRDJWrvMo47U9eb
         WxYefHBO0BbYjrRfAiPsZsG6FszKyiINoccGfliiac2kN+yTzy9/3Cf0wy88LIij6zMB
         omCsfnt6jEXm2MPHTOmJh7GQw2N+gTKyVA/qqazMtGJ2pMSc/RRd0r7BXdh0GEkuUybH
         JP/g==
X-Gm-Message-State: AOAM532lx0wXkSHxy9n5AElEcAqgUM9tEOcOYdea0pB/42R6QMMRHrHf
        EASDxC9POhyZCgVx4L5e0eEXVkclW/c=
X-Google-Smtp-Source: ABdhPJzIJGXWImyF68fpiDnlRuuK0sDOgGEUgb+42oDasRNYgDOUiLjmWyL/1m/8vLE5nun2zGwgCA==
X-Received: by 2002:a05:6820:820:b0:329:9fd3:915c with SMTP id bg32-20020a056820082000b003299fd3915cmr5336332oob.0.1649645023048;
        Sun, 10 Apr 2022 19:43:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm11851381otq.80.2022.04.10.19.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 19:43:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3d05a866-ea95-7fa3-13de-8baf54f31653@roeck-us.net>
Date:   Sun, 10 Apr 2022 19:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     wim@linux-watchdog.org, geert+renesas@glider.be,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220408200205.2833931-1-jjhiblot@traphandler.com>
 <20220408200205.2833931-3-jjhiblot@traphandler.com>
 <YlOJVzA49rTrBDH3@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YlOJVzA49rTrBDH3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 18:50, Tzung-Bi Shih wrote:
> On Fri, Apr 08, 2022 at 10:02:05PM +0200, Jean-Jacques Hiblot wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> 
> With a minor comment:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	wdt->wdtdev.timeout = DEFAULT_TIMEOUT;
>> +	ret = watchdog_init_timeout(&wdt->wdtdev, 0, dev);
> 
> Could it drop the assignment if `ret` is unused?

Good catch. Yes, that assignment is pretty pointless.

Guenter

