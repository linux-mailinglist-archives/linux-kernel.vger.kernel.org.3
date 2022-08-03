Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5365890FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiHCRI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:08:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F2813F4D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:08:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv3so8400962wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QpNE/OTA2y3FCVQ++ZWd42iDZvbzHbcjtfx9k2S2BdQ=;
        b=PDkQ3db4VXtmtyzSrhG1O6hWhtnVOpAwHWwrXU6wyRLS9T8691LP+pTEXAh9dpb9P4
         hR5CqVlVOCrltu5OTZC3qQyLHosGfXE3WahI5ig0VHtuxSK6R1knqE6AsdDM10fgnS5t
         Aa5DqzdT1/x+A1BUFx2J1jYSJGPvmCMkFKd86FHJdjzJuhPES/Npl72J3HWAJdCN0pli
         1QktuGj4JjtNz2Sm23hh8jrc33z/zzAmE8dWvVUgeebL5mvt00CTC4BLaSkf2rWi5P04
         ASG88f3GLVZcNRpbTkxbrkqEUdiEXcLeBFbxgcUPzFMxn+8YXZPcztwnvQVodv5j/Y+a
         tZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QpNE/OTA2y3FCVQ++ZWd42iDZvbzHbcjtfx9k2S2BdQ=;
        b=GleSWcdDzYdhn84Q0y5K6oGr0cFyWaYQs/BN88gfHygr2JlibAA+NBKDyWwJeO30Kb
         6L2bwpNiFlL/ERRVRf07QSP6Z7j6YSTNB4VePQWUglVBO3Ett7AV/L8+sRU8nd8GYpBY
         yYCo5qY+btX8b7Y/Z7hWuo0TZDYCbWmJ/FNi+0ImDnCukrW2blP0OC2f8OpZZGiqb5dg
         +IjNgLiBMGIUTvyo9f3HNA6AAOUduUpqMqRoAspi1UYGIqjRTtxiekVI2pl96XmXEZbE
         Q2P+vs3dt5yoyT+TvjLxdebKlTcJPTYnGr8Feigb5ck5EtY6ONOz6T3X1VnPWymG1B4t
         1Fqw==
X-Gm-Message-State: ACgBeo23Zdxzt0Tu9BN9RmCtYHiUIKzmNyJMu3P5XDJNvb88EjP5tAM3
        axTfmPjHgrw7sDy3dZKygLPbBA==
X-Google-Smtp-Source: AA6agR7TlyquPlGS/d2FSZ99Iz6oxANEa3xjo78UxaVqYZM0HnetHj7oRSnfgid8tW7h0M8myG4Wmg==
X-Received: by 2002:a05:6000:1681:b0:21f:16a6:626f with SMTP id y1-20020a056000168100b0021f16a6626fmr14559490wrd.717.1659546503829;
        Wed, 03 Aug 2022 10:08:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6e48:fbdd:280d:6dac? ([2a05:6e02:1041:c10:6e48:fbdd:280d:6dac])
        by smtp.googlemail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm3497676wmc.34.2022.08.03.10.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:08:23 -0700 (PDT)
Message-ID: <31d5794f-de7d-373b-641e-e2fa62987138@linaro.org>
Date:   Wed, 3 Aug 2022 19:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal: Drop obsolete dependency on COMPILE_TEST
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Talel Shenhar <talel@amazon.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20220731141352.7caa1a69@endymion.delvare>
 <CAJZ5v0idi1+Rzgqgr0H3_d_SB6B41hoZ0TJ2h8j8iK9FQPNGbw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0idi1+Rzgqgr0H3_d_SB6B41hoZ0TJ2h8j8iK9FQPNGbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 19:05, Rafael J. Wysocki wrote:
> On Sun, Jul 31, 2022 at 2:13 PM Jean Delvare <jdelvare@suse.de> wrote:
>>
>> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
>> is possible to test-build any driver which depends on OF on any
>> architecture by explicitly selecting OF. Therefore depending on
>> COMPILE_TEST as an alternative is no longer needed.
>>
>> It is actually better to always build such drivers with OF enabled,
>> so that the test builds are closer to how each driver will actually be
>> built on its intended target. Building them without OF may not test
>> much as the compiler will optimize out potentially large parts of the
>> code. In the worst case, this could even pop false positive warnings.
>> Dropping COMPILE_TEST here improves the quality of our testing and
>> avoids wasting time on non-existent issues.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Cc: Talel Shenhar <talel@amazon.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Daniel, I can pick up this one if that's OK.  Any concerns?

No concerns, I'm fine with it

Thanks

>> ---
>>   drivers/thermal/Kconfig |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-5.18.orig/drivers/thermal/Kconfig     2022-05-22 21:52:31.000000000 +0200
>> +++ linux-5.18/drivers/thermal/Kconfig  2022-07-31 13:51:55.009394318 +0200
>> @@ -221,7 +221,7 @@ config THERMAL_EMULATION
>>
>>   config THERMAL_MMIO
>>          tristate "Generic Thermal MMIO driver"
>> -       depends on OF || COMPILE_TEST
>> +       depends on OF
>>          depends on HAS_IOMEM
>>          help
>>            This option enables the generic thermal MMIO driver that will use
>> @@ -496,7 +496,7 @@ config SPRD_THERMAL
>>
>>   config KHADAS_MCU_FAN_THERMAL
>>          tristate "Khadas MCU controller FAN cooling support"
>> -       depends on OF || COMPILE_TEST
>> +       depends on OF
>>          depends on MFD_KHADAS_MCU
>>          select MFD_CORE
>>          select REGMAP
>>
>> --
>> Jean Delvare
>> SUSE L3 Support


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
