Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2857F63F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiGXRud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGXRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:50:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDC6309;
        Sun, 24 Jul 2022 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658685010;
        bh=Tuihtbx3exUoM1i8+J53uNcnXX8UMqBvF49qc6vAyXk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c7mPDbvDeYz5CVO9bVt/yBLRjd0t81ogXKkuIm1gWskNHSLpYg70lAYwpPeEG1HUj
         7E745Yum6jfQ+Nf5OwLhqSTkp9Eb9bWosLWdepbRRHnK1+pjIGKxEXzgB0TxeGa0GB
         iQFwfPe2wI8d7MqfmPMP7NkVkJFGvUj05acHsz8k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1oC6RT36XF-003hC9; Sun, 24
 Jul 2022 19:50:10 +0200
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-2-W_Armin@gmx.de>
 <20220723141734.GC2979894@roeck-us.net>
 <7f5c4c26-aa4d-eb97-2188-690c9e11f9a4@gmx.de>
 <4005c025-4722-53ab-116c-6bd1b37f4d41@roeck-us.net>
 <9d621e8c-6e62-b0e3-9a6a-c2e904b00971@gmx.de>
 <e948e1e7-88d4-954f-64c8-f0e5a83a3ee8@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <7bfab339-f374-99ba-54c0-0795c78008b8@gmx.de>
Date:   Sun, 24 Jul 2022 19:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e948e1e7-88d4-954f-64c8-f0e5a83a3ee8@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:0tbcHBNZSJs17lTjRv/2EY0bjo9cCE0h46Nkc4KyiwMfWCXBLyR
 zEu4bvVyNwXMX63CcoAhZiOdkMUzhDq3z7h4UPDO8W9R3OQwrnKZwJeJ0dtZRmJMfqjZSXJ
 tM0zLKyiilqW/1UqG+uxO8rSE60EHp+UsNskKEiRjH7GY43F/dWPvlcGgCSUq2gh19FUJ+t
 r4nOxEp6e+U38ikczai9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P4FxA4+fPos=:utcGN4QDlBirnVzXD85WQ0
 lF3A9GyeoF+E0OWVYF38MYcvLYy5mO7JbExR135CxpfaVtMnazkIjizC7W4DhKU5zNLV63xNf
 Y7kqKG7JAFkzNYwRLYH8Bf1XxwGyb+SX8aUYItMqk8SuLEtfdacCd+DlsOvGfu0mgkM4GDPOC
 zggcqvoSUJEKJzCiY60SYB28i5RJApxXfPVC0spihnwNAMiAodUSojj4H/cmSSOTt4oiBXLWE
 VJ5RGvrp+tDc+P+m7/hgCQQ9Bnxi39EW9fuX5p3ffwDWn7W4/y9r9VI4TtnpSc4AsU4E5TwEp
 wMq2LfjV+0pOMQIRmOokVDCSf/LWife530lI6L5ylN/2a97YCiX6Gmdg3eymjAcj93ff0BpNv
 gmOsEf7kR1zo6gYyLjp51VwyEj5KuGkXzGj+85wnlab6PyQy0flyDiYk12Gl98z4ozQxwB0Xl
 jGpNXYr+qfFfjDAg3HOnDTJ9cghURdsjDGWfp3eBy6xsPQ6GTOvmiT0o4XirYohkhw90VleAI
 5XF7cRx9F6B99kwzzES5l32H2OuRtq+5roivfNoNyE3gnrh9HaETmNzPgxWV3BQwQP7+3TyJc
 7wkJKnYO7Y3Bg5EkRjx+KoqazZcNS497Bi5SNJUD/EZe8mzcAz5/0u7VSrUpTIOJ1byl4/YRD
 EYF6Q26DeWL/KEW67fFpkEgQzD6AkNAoL8AK5f0v8ypN/ycdCnQz3bbQmJHCDk4/xbw9Wlw2K
 uSos9jhSRZsxBIG6ouBzbADCAIUHwb09vIuowdYUOQsOkk88Tc+QG8As/UtXMzJpwAHcdHyzJ
 zM93zE3eaFVyM/gnoO1Qt3V+hdWGIVW7NfGLPwZdbgwkvzmAnJ66q5vGcTRkoY1JJJTCgBuOI
 QQeWMaFI7uTlczxyGSs0QZBK/KNKpu4qU/UdWg1P9+L3U9a8/a2VwIzRLNGokF868Lh8QpgoJ
 v9Aej4TbphA/y6cfrJNdDgnqquNILqxOkH4CiUX4ML9CwuAEYIhiZZ52ZBIbPs2PHeqLimG+e
 mQbaWHhWBp90KXmZlKsHh7OB2Q/DBOoYrRSsaRsfQvsb/vJs36IWF78o8d/hAyJLIfN/f8zP4
 rJBoGO5FH7S5drXjH+qOXYPh2Zrk/yytse1wbQPO4T9vp/SjXyEuCxPDg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.07.22 um 18:30 schrieb Guenter Roeck:

> On 7/24/22 09:06, Armin Wolf wrote:
> [ ... ]
>> It would be indeed better if userspace software like pwmconfig would
>> use an internal list containing the names of all hwmon chips for which
>> the pwm to fan mappings are known.
>> I will add a note to the documentation of dell-smm-hwmon about the
>> pwm to fan mapping so userspace software knows about this.
>
> That is effectively the fancontrol configuration file. pwmconfig is
> supposed to assist in determining how that configuration file should
> look like. Having some file added to pwmcontrol to determine how the
> fancontrol configuration file should look like seems a bit off-track.
>
> What you are talking about is really the idea of providing a number of
> sample configuration files with the fancontrol (or lm-sensors) package,
> similar to the various sensors.conf files. That doesn't belong into
> the hwmon kernel documentation. It should be part of the lm-sensors
> package.
>
> Guenter
>
With "note" i meant some small text for users to read,
not a config file for pwmconfig.

Armin Wolf

>> Sorry for bothering you.
>>
>> Armin Wolf
>>
>>>> In contrast, many firmware-based chips do know which pwm channel
>>>> output controls which
>>>> fan channel. One example might be the dell-smm-hwmon driver and the
>>>> gpio-fan driver.
>>>>
>>>> In this case, making the attribute RO would indeed make sense.
>>>>
>>>
>>> Unless the attribute is used to configure the chip, it does not make
>>> sense
>>> in the first place. Also note that gpio-fan is usually configured usin=
g
>>> devicetree properties, _and_ it only has a single set of fan/pwm
>>> properties,
>>> so a sysfs attribute would always return 1 and make make even less
>>> sense there.
>>>
>>> Guenter
>>>
>>>> Armin Wolf
>>>>
>>>>>> ---
>>>>>> =C2=A0 Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>>>>>> =C2=A0 Documentation/hwmon/sysfs-interface.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 +++
>>>>>> =C2=A0 drivers/hwmon/hwmon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>>>>> =C2=A0 include/linux/hwmon.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>>>> =C2=A0 4 files changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon
>>>>>> b/Documentation/ABI/testing/sysfs-class-hwmon
>>>>>> index 7271781a23b2..f3d653bcf736 100644
>>>>>> --- a/Documentation/ABI/testing/sysfs-class-hwmon
>>>>>> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
>>>>>> @@ -315,6 +315,14 @@ Description:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW
>>>>>>
>>>>>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/class/hwmon/h=
wmonX/pwmY_fan_channel
>>>>>> +Description:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which fan channe=
l is controlled by this PWM output.
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Valid fan channel/PWM o=
utput combinations are
>>>>>> chip-dependent.
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW
>>>>>> +
>>>>>> =C2=A0 What: /sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>>>>>> =C2=A0 Description:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which=
 temperature channels affect this PWM
>>>>>> output in
>>>>>> diff --git a/Documentation/hwmon/sysfs-interface.rst
>>>>>> b/Documentation/hwmon/sysfs-interface.rst
>>>>>> index 209626fb2405..17fcec03d3c5 100644
>>>>>> --- a/Documentation/hwmon/sysfs-interface.rst
>>>>>> +++ b/Documentation/hwmon/sysfs-interface.rst
>>>>>> @@ -209,6 +209,9 @@ PWM
>>>>>> =C2=A0 `pwm[1-*]_freq`
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base PWM fre=
quency in Hz.
>>>>>>
>>>>>> +`pwm[1-*]_fan_channel`
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Select which fan channel is controlled by this PW=
M
>>>>>> output.
>>>>>> +
>>>>>> =C2=A0 `pwm[1-*]_auto_channels_temp`
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which=
 temperature channels affect this PWM
>>>>>> output in
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 auto mode.
>>>>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>>>>> index 2e2cd79d89eb..8c2d7574c461 100644
>>>>>> --- a/drivers/hwmon/hwmon.c
>>>>>> +++ b/drivers/hwmon/hwmon.c
>>>>>> @@ -604,6 +604,7 @@ static const char * const
>>>>>> hwmon_pwm_attr_templates[] =3D {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_enable] =3D "pwm%d_enable=
",
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_mode] =3D "pwm%d_mode",
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_freq] =3D "pwm%d_freq",
>>>>>> +=C2=A0=C2=A0=C2=A0 [hwmon_pwm_fan_channel] =3D "pwm%d_fan_channel"=
,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_auto_channels_temp] =3D "=
pwm%d_auto_channels_temp",
>>>>>> =C2=A0 };
>>>>>>
>>>>>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>>>>>> index 14325f93c6b2..9d40cc1e520f 100644
>>>>>> --- a/include/linux/hwmon.h
>>>>>> +++ b/include/linux/hwmon.h
>>>>>> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_enable,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_mode,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_freq,
>>>>>> +=C2=A0=C2=A0=C2=A0 hwmon_pwm_fan_channel,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_auto_channels_temp,
>>>>>> =C2=A0 };
>>>>>>
>>>>>> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>>>>>> =C2=A0 #define HWMON_PWM_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(hwmon_pwm_enable)
>>>>>> =C2=A0 #define HWMON_PWM_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(hwmon_pwm_mode)
>>>>>> =C2=A0 #define HWMON_PWM_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(hwmon_pwm_freq)
>>>>>> +#define HWMON_PWM_FAN_CHANNEL BIT(hwmon_pwm_fan_channel)
>>>>>> =C2=A0 #define HWMON_PWM_AUTO_CHANNELS_TEMP
>>>>>> BIT(hwmon_pwm_auto_channels_temp)
>>>>>>
>>>>>> =C2=A0 enum hwmon_intrusion_attributes {
>>>>>> --
>>>>>> 2.30.2
>>>>>>
>>>
>
