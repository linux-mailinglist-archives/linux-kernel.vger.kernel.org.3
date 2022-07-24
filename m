Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7457F270
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiGXBVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGXBVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:21:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D565F5C;
        Sat, 23 Jul 2022 18:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658625642;
        bh=uFL6+U8Hy4U2hNuZJ5vwybxp4WehSY93d8pCiuwiF0Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EGW2TKaVswSwdR6UdjMa2/l8+xerg4iHUZ/RWGtXNEZOJ//IhwlsH6Er1vAPYCVk9
         RWTXVi/G8mCV8fG4P3GByci3am4YP9VLDmvWr4LEMFpdnCY8Nr//hIPfVFfOz/CNDb
         sg0iwkh8lq+5gjOTFgC4Jjv7qNNE83my4IQCbzBs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1nQUCL338R-018GVn; Sun, 24
 Jul 2022 03:20:42 +0200
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-2-W_Armin@gmx.de>
 <20220723141734.GC2979894@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <7f5c4c26-aa4d-eb97-2188-690c9e11f9a4@gmx.de>
Date:   Sun, 24 Jul 2022 03:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220723141734.GC2979894@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:vOmSp2La8i5BinCxneTCnBlethnvzTvgNQCo2uLOOK+Ep0Zx7cD
 U/h6vfq4FlRbVJuXAc3z6LBeboJvCnl6ViTQQPEFESGGIfC9ZnWFnMPTbuIeMuGIInbSz+s
 26MbYW+0GBbNpd21HNs3LdcZlIU8jSUpP3QaLSn+iDfug3Fu/pj9GE25XA0AN9GzU+arF6F
 a5mvVNYEgUfIGJe/WlloA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IsMdmv0EwUM=:O2s7TL4/c9e/ykHGriqBDC
 21mbHZEgvTGT4DOkML8PDrZ17zwizBB+Zj0NEhPq6nk78w8S0JxdAL2zR+IdEq0RJGNNfFocz
 2EYsI7qbhSl+oDpsjbAbpd+E2CBmxhsmQKBd821EjFUubFtHqhyb82p1IfUQq4cGhevVX8Qrm
 pFDwvooGj0UBadZeH0rdPdBdzahaaVCXeaXVhqhIM5rAma0JjRhiexaZCUVfBwrKkMrnE+3pD
 5+5afRj9ErmnMmGbqp/Ab6W95DHDGLo9M1YgWl0szMPhJXctsV4UeXyCJ32mbQdPKw+fS0z1C
 CGucq5Gs643fbBfThZwsDkjB5RzOfUsLdI4mKveAsVLdZpM5HlcWwj4NvW33dPX9OCXaFEJ3w
 MiMJWEzAHv/JkH0GNmXCQQgzg/kwClULXK0zIsTixiaDqSMt0oZ1RdwhHRyYPZgahTC/E+Gmv
 10pAnCLtysTUPOkuUOyrSIs+FR7eBGipUwwMmLyZfD02IZi5ib6ZOsnrN/oNhrIZfzieTkn/A
 deptvldqlQ8FzprNPuZLsRddSAIjalqSDmm3rbEyCuvqHfcWNwd3Gor1U+MPKsY4I+ZzszTV/
 Hddt6ByyYuicxz82/UfS1JtfiyK/jpRZW3K81i6KKwleorJdwqs3X43vUbfq5Le1ly/8/ZMTa
 ZXBa6jrGqkIurJj28RTATbpQpqWJxw5X/k8NPvH7sZ9J90iSSPimGmZPhmFYMtTx5saXSPGcw
 6biYpttheirBNhKpBagdHAIaz7Ik7S+1ltoyrWxNoVVN172xPAhwOtWho1eDlOm2nb5i6Djt4
 ARtLSRw84jV/ju53N2ECc+MMEyH7usnHt7q0FZTmbgEFAiraB/DUtaABd74Z2ITJ0GEgCuwKj
 9OVe/UKLi+4hx/KLZgjgf6idS7E8nxRWzaDpiHY82QdgbYAN6yAM2cj2RSkmONi8fbDhb/axO
 HBi+3pT9ldsLIDcHwiNqdl64pclEfjfDCadbz7lKBmlVOnV6BSp5chkESs0+aIXTCizWLDo9S
 //GXxNdsc+ekbNrRogs3vqlzzxLjuFL0sTS3U/0r8K0Tgt3YwCQ3YOPCV7sPp2RZxcltioqMT
 8qaAaV+8MzFPUcDNVxTKseQ3zN6tAFxUOlJ8JD1GaZgR6dkcwK/GERhJQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.07.22 um 16:17 schrieb Guenter Roeck:

> On Sat, Jul 23, 2022 at 05:38:19AM +0200, Armin Wolf wrote:
>> Until now, userspace software needs to guess which
>> PWM channel is associated with which fan channel by
>> probing each PWM output and watch for fan speed changes.
>> This proccess is error-prone and unreliable.
>>
>> Some hwmon chips, especially firmware-based ones, already
>> know which PWM output is associated with which fan channel.
>>
>> Allow such chips to export this knowledge to userspace.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> All of the chips I am aware of have a fixed association from pwm channel
> output to fan input. None I am aware of make this association configurable.
> I do not see the value of this attribute.
>
> Guenter

That is true, the association from pwm channel output to fan input is usually fixed.
However not all chips are able to discover which pwm channel output is associated with
which fan channel. For example most superio-based chips cannot know how the motherboard
manufacturer wired the fans, and thus userspace relies on pwmconfig for manually probing
each pwm channel.
In contrast, many firmware-based chips do know which pwm channel output controls which
fan channel. One example might be the dell-smm-hwmon driver and the gpio-fan driver.

In this case, making the attribute RO would indeed make sense.

Armin Wolf

>> ---
>>   Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>>   Documentation/hwmon/sysfs-interface.rst     | 3 +++
>>   drivers/hwmon/hwmon.c                       | 1 +
>>   include/linux/hwmon.h                       | 2 ++
>>   4 files changed, 14 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
>> index 7271781a23b2..f3d653bcf736 100644
>> --- a/Documentation/ABI/testing/sysfs-class-hwmon
>> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
>> @@ -315,6 +315,14 @@ Description:
>>
>>   		RW
>>
>> +What:		/sys/class/hwmon/hwmonX/pwmY_fan_channel
>> +Description:
>> +		Select which fan channel is controlled by this PWM output.
>> +
>> +		Valid fan channel/PWM output combinations are chip-dependent.
>> +
>> +		RW
>> +
>>   What:		/sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>>   Description:
>>   		Select which temperature channels affect this PWM output in
>> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
>> index 209626fb2405..17fcec03d3c5 100644
>> --- a/Documentation/hwmon/sysfs-interface.rst
>> +++ b/Documentation/hwmon/sysfs-interface.rst
>> @@ -209,6 +209,9 @@ PWM
>>   `pwm[1-*]_freq`
>>   		Base PWM frequency in Hz.
>>
>> +`pwm[1-*]_fan_channel`
>> +                Select which fan channel is controlled by this PWM output.
>> +
>>   `pwm[1-*]_auto_channels_temp`
>>   		Select which temperature channels affect this PWM output in
>>   		auto mode.
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index 2e2cd79d89eb..8c2d7574c461 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] = {
>>   	[hwmon_pwm_enable] = "pwm%d_enable",
>>   	[hwmon_pwm_mode] = "pwm%d_mode",
>>   	[hwmon_pwm_freq] = "pwm%d_freq",
>> +	[hwmon_pwm_fan_channel] = "pwm%d_fan_channel",
>>   	[hwmon_pwm_auto_channels_temp] = "pwm%d_auto_channels_temp",
>>   };
>>
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index 14325f93c6b2..9d40cc1e520f 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>>   	hwmon_pwm_enable,
>>   	hwmon_pwm_mode,
>>   	hwmon_pwm_freq,
>> +	hwmon_pwm_fan_channel,
>>   	hwmon_pwm_auto_channels_temp,
>>   };
>>
>> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>>   #define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
>>   #define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
>>   #define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
>> +#define HWMON_PWM_FAN_CHANNEL		BIT(hwmon_pwm_fan_channel)
>>   #define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)
>>
>>   enum hwmon_intrusion_attributes {
>> --
>> 2.30.2
>>
