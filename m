Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA284E8952
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiC0SYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiC0SYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:24:14 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0FA403DB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:22:35 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 1B23915304
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:22:35 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YXX8nepvI9AGSYXX9nTTK5; Sun, 27 Mar 2022 13:22:35 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nPJz7RqGPn4MdhgfbThGWUpQI0/IZt0t+EKnHnBpjdc=; b=DQxn1+BTcIcM2u+ch1luwegYgV
        5UJjDL11O+YiXZmV2cIYzXEGoreMrC2fb7WtA5xm4DbKxAqcVkX3/C5bDnqYOW7A99uHe6NAfYjxs
        uzufoa+3Q7BwqMdP8Cjy+gAmN9bCJAJ9Uk28jf88TjukL6f1WBdev7crL6eLzDr3VK8NROWUZpwix
        0wp3hnswQJmcrTrOTwJL9XRCqQPL2DA74/oBsgKTm4l5O9uTrJdkz/nchsQV3DSGkqsyDkppnDefS
        v3UHk7BMO/PsbHdFayjswaJ5Q9EAMts5r9G7ECMPPF/z82wn3LiW9Ld9M8jcrKPtSKOCaDjq7h7z3
        Zxs4w0AQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54518)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYXX8-004LOP-Jh; Sun, 27 Mar 2022 18:22:34 +0000
Message-ID: <4455ca4c-1ebb-41df-5f04-72a48e8ca7dc@roeck-us.net>
Date:   Sun, 27 Mar 2022 11:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-5-michael@walle.cc>
 <2442b460-4c6d-0ac9-af08-ae4c25aed812@roeck-us.net>
 <9aab54bc48284c9e20cd76085cb9d83a@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
In-Reply-To: <9aab54bc48284c9e20cd76085cb9d83a@walle.cc>
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
X-Exim-ID: 1nYXX8-004LOP-Jh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54518
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/22 07:18, Michael Walle wrote:
> Am 2022-03-27 03:34, schrieb Guenter Roeck:
> 
>>> +    /*
>>> +     * Data is given in pulses per second. According to the hwmon ABI we
>>> +     * have to assume two pulses per revolution.
>>
>> The hwmon ABI doesn't make any such assumptions. It wants to see RPM,
>> that is all. Pulses per revolution is a fan property.
> 
> There is fanY_pulses according to Documentation/ABI/testing/sysfs-class-hwmon:
> 
>    Should only be created if the chip has a register to configure
>    the number of pulses. In the absence of such a register (and
>    thus attribute) the value assumed by all devices is 2 pulses
>    per fan revolution.
> 
> The hardware returns just the pulses per second. Doesn't that
> mean I have to divide that value by two?
> 

The above refers to hardware which reports RPM.

It is up to the driver to calculate and return RPM. How you do it is your
decision. Drivers should report the most likely correct RPM value to
userspace, one that rarely needs manual adjustment. Almost all fans
report two pulses per revolution, so normally that assumption is used
to convert PPM to RPM. That isn't mandated (or supposed to be mandated)
by the ABI. I would call it common sense.

I'll be happy to accept a patch clarifying this.

>>> +     */
>>> +    *val = FIELD_GET(FAN_CNT_DATA, data) * 60 / 2;
> 
> .. otherwise this should then be
> *val = FIELD_GET(FAN_CNT_DATA, data) * 60;
> 

If you really want to do this, make sure it is well documented that users
will need to adjust the fan speed via sensors3.conf to get the real fan speed.

> 
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int lan966x_hwmon_read_pwm(struct device *dev, long *val)
>>> +{
>>> +    struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>>> +    unsigned int data;
>>> +    int ret;
>>> +
>>> +    ret = regmap_read(hwmon->regmap_fan, FAN_CFG, &data);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    *val = FIELD_GET(FAN_CFG_DUTY_CYCLE, data);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int lan966x_hwmon_read_pwm_freq(struct device *dev, long *val)
>>> +{
>>> +    struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>>> +    unsigned long rate = clk_get_rate(hwmon->clk);
>>
>> Is that a dynamic frequency ? If not, it would be better to read it once
>> and store it in struct lan966x_hwmon.
> 
> yes it is configurable, actually. See lan966x_hwmon_write_pwm_freq().
> 

That is the pwm frequency, not the clock frequency. I don't see any
code which updates the clock frequency reported by clk_get_rate(hwmon->clk),
ie I don't see a call to clk_set_rate().

Thanks,
Guenter
