Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307904EF714
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbiDAPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353640AbiDAPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:50:35 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.61.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66D301
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:23:21 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 45006400E28B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:23:21 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id aJ7RnX2U1XvvJaJ7Rne6aI; Fri, 01 Apr 2022 10:23:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=us+dnlysbc7Q3Qvt0JVnL+wmstazMUpPbiUvh87DKYQ=; b=E4S9V9nXDBy1+pXjy9gIRIqFUN
        PacMyGS98VVMpJJ7VwS3fXGPgb975C20Jcs0oTqBkoaWiZgb5ocRO+URmHR9wu1XB1O2+cqoTD7d+
        YXMfTo/WmU0lyvFtdz0LPDNBjB4qle0J89GODt3LgnOn0NlwQvOOXZSdOvQWgr2a/GoCcpv/SPza2
        Ubmz7ki9VtRQLhiCnsOO2UI01PC22lr7tUoP+7gyg67wbEIu5nowYzamYFUnt/yA/dFRh3uSMYmFT
        5N+MI4c2oYIiWDBLqxuoCE7fE5VBBxtQn8nKNJJYWSzg6WmPZuoiem5t+yHeVfxpuuvYIKckrrzoG
        oHq+JzEg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54650)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1naJ7Q-0042Nx-Qk; Fri, 01 Apr 2022 15:23:20 +0000
Message-ID: <e4267787-4e71-6122-db3e-ce34110cccbb@roeck-us.net>
Date:   Fri, 1 Apr 2022 08:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] hwmon: add driver for the Microchip LAN966x SoC
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220331162431.3648535-1-michael@walle.cc>
 <20220331162431.3648535-5-michael@walle.cc>
 <06ff3ca0-9d2b-205f-064d-24bcb86e5362@roeck-us.net>
 <415334e3278a610bc603b316d4af6502@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <415334e3278a610bc603b316d4af6502@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1naJ7Q-0042Nx-Qk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54650
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 15
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 05:57, Michael Walle wrote:
> Am 2022-03-31 19:28, schrieb Guenter Roeck:
> 
>>> +static int lan966x_hwmon_write_pwm_freq(struct device *dev, long val)
>>> +{
>>> +    struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>>> +
>>> +    val = DIV_ROUND_CLOSEST(hwmon->clk_rate, val);
>>
>> I must have looked at this for an hour, but I didn't see the problem.
>> Sorry for that. Try writing "0" as new pwm frequency.
> 
> Ohh, and negative values..
> 
> I'll add a
> 
> if (val <= 0)
>      return -EINVAL;
> 
>>> +static int lan966x_hwmon_enable(struct lan966x_hwmon *hwmon)
>>> +{
>>> +    unsigned int mask = SENSOR_CFG_SAMPLE_ENA |
>>> +                SENSOR_CFG_START_CAPTURE |
>>> +                SENSOR_CFG_CONTINIOUS_MODE |
>>> +                SENSOR_CFG_PSAMPLE_ENA;
>>> +    unsigned int val;
>>> +
>>> +    /* enable continuous mode */
>>> +    val = SENSOR_CFG_SAMPLE_ENA | SENSOR_CFG_CONTINIOUS_MODE;
>>> +
>>
>> I am curious: Why not as part of the assignment, similar to 'mask' ?
> 
> There was code to set the clock divider, but I've removed
> it as the hardware has a sane default. That left just that one
> line, but moving the comment above the declaration looked
> weird.
> 
> Now thinking about it again, it might make sense to bring
> back the code to set the clock divider in case someone
> will fiddle around with it before the driver is probed.
> 
> #define LAN966X_PVT_CLK 1200000 /* 1.2 MHz */
> 
> /* set PVT clock to be between 1.15 and 1.25 MHz */
> div = DIV_ROUND_CLOSEST(hwmon->clk_rate, LAN966X_PVT_CLK);
> val |= FIELD_PREP(SENSOR_CFG_CLK_CFG, div);
> 

Yes, that would be a good idea.

Thanks,
Guenter

>>> +static int lan966x_hwmon_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct lan966x_hwmon *hwmon;
>>> +    struct device *hwmon_dev;
>>> +    int ret;
>>> +
>>> +    hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
>>> +    if (!hwmon)
>>> +        return -ENOMEM;
>>> +
>>> +    hwmon->clk = devm_clk_get(dev, NULL);
>>> +    if (IS_ERR(hwmon->clk))
>>> +        return dev_err_probe(dev, PTR_ERR(hwmon->clk),
>>> +                     "failed to get clock\n");
>>> +
>>> +    ret = lan966x_clk_enable(dev, hwmon);
>>> +    if (ret)
>>> +        return dev_err_probe(dev, ret, "failed to enable clock\n");
>>> +
>>> +    hwmon->clk_rate = clk_get_rate(hwmon->clk);
>>> +
>>> +    hwmon->regmap_pvt = lan966x_init_regmap(pdev, "pvt");
>>> +    if (IS_ERR(hwmon->regmap_pvt))
>>> +        return dev_err_probe(dev, PTR_ERR(hwmon->regmap_pvt),
>>> +                     "failed to get regmap for PVT registers\n");
>>> +
>>> +    hwmon->regmap_fan = lan966x_init_regmap(pdev, "fan");
>>> +    if (IS_ERR(hwmon->regmap_fan))
>>> +        return dev_err_probe(dev, PTR_ERR(hwmon->regmap_fan),
>>> +                     "failed to get regmap for fan registers\n");
>>> +
>>> +    hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>>> +                "lan966x_hwmon", hwmon,
>>> +                &lan966x_hwmon_chip_info, NULL);
>>> +    if (IS_ERR(hwmon_dev))
>>> +        return dev_err_probe(dev, PTR_ERR(hwmon_dev),
>>> +                     "failed to register hwmon device\n");
>>> +
>>> +    return lan966x_hwmon_enable(hwmon);
>>
>> Since I am nitpicking: It may make sense to call this function before
>> registering the hwmon device, and it may make sense to disable sampling
>> when unloading the driver (you could trigger that by calling
>> devm_add_action_or_reset() from lan966x_hwmon_enable).
> 
> sure
> 
> -michael

