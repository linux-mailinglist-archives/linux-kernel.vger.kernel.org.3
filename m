Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460C57F5F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiGXQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:06:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61FD11143;
        Sun, 24 Jul 2022 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658678776;
        bh=oT6hchnlo/0bvfwaB06/7qgbhgzoMuSOaPA2WA0Y/ro=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KnBBws9td3qEi/hL71GWWxzXlpOvFTfdcPiMumU2XDVf1HQdTn9lJfZG6QCa35Tkf
         VyNhJ/vN+BVBfdP+CtHBongcuMDTI3hYAgrDWsc2Cf9mliMqj7SFAjc138Syahv6ap
         Z0VLq2nKEr9EYpEHj5D4shFCsUPA3eCnOeE7tPSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1oDzQb3f6A-002pfX; Sun, 24
 Jul 2022 18:06:15 +0200
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-2-W_Armin@gmx.de>
 <20220723141734.GC2979894@roeck-us.net>
 <7f5c4c26-aa4d-eb97-2188-690c9e11f9a4@gmx.de>
 <4005c025-4722-53ab-116c-6bd1b37f4d41@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <9d621e8c-6e62-b0e3-9a6a-c2e904b00971@gmx.de>
Date:   Sun, 24 Jul 2022 18:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4005c025-4722-53ab-116c-6bd1b37f4d41@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:SVULd6KKoRF5R9RbzKDuSn0ypdItBLq1GQFELMt4USTAAYl92LX
 Qpz0O39DUbsm0CUEuoDdKaSJK7kUog3OHHHzzGMXjo0vsIw6bjFigiwAXOFmiTl4j9PPznu
 CfxHP4B10vmcPn1oDVd0LdjaFFwCUDoNJ/LULAyX8SFS1NVZpRypoI/zZQWBBPxuuABiDjz
 BW3AO8XDUY1qN0N9Zt5vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CFLApJdwSBM=:2RJAwL8Iv5WtJG//Xczk1V
 IgPAi17QEwHKYu8/afBFkaw04j1420PO4eU4XPpGGrpEdJ0cXREbY90ohVilZJlyn8zchNLK6
 7I1phTk9zMbQJlnukQiUhLgBHqLwWDFfkuHBn2lJUbigGK394rL4vI7g02//yjm49IX8UQZBd
 ZBvKnNoTeieG8SeMpRL/abv2RCX4aqr3Gc7KkLKATjPLeOryhPZ9TqddoJ5YPpJNnN0JQXTMP
 vi15JGPfjRKdBwthcFKqrY/fvTfWg4F+5gj1PsBuPfaK1vlFckqVqKn6PmoGLVg6Mx1wPDheN
 X9pRTToIDyF1ogEG8NKRmfpu82bLbqPJ6Y9RRrlMPnBhxnge1R1rmSf06hmGdncPgB70BsU+c
 +akO85VDjeWMvo3fRmMNU+0wIzrVB38wFn49DSzSJGOZIxSIjxhZpzfySV7Rm4SWGDd4yChdx
 OQlOS/o30ax/jIwvz4vFGZ2efEtNwWu3eH8vYCm0EUxG+TbdRFMSOtfh45XiCuOYRxwoyf3Dg
 HBilDZhW1A0FXWUCScni3tQDf2dyBViU3Cc8oNZEBbj9XcYP9m3pePnq1Um2hTV+cK9KI85qN
 OnYcPEAgbhtVOZ0FtsnA/YTh/R7FGdFlc2SQqdVKJlrgUOGZ7U+/xI+87s+86fbUgo9QNNuxc
 sqyNah20EI3Ed1RYfLWyNiY6tUgpxugIAbYkr10/UpIuHdRiAtqwL1HnR4axmwkQS2ditgCgf
 qPr61nZWB0LFBfWHjerDWOb1Mb8K0rRAayVZ662ZvYJ0aPb2IHx5mpyckLXO4wOv1Re9Ixmne
 xJKOM4cO7YZTs0uquw3U2bQJoI/MNE7MEBygW2RtQcW0Z/Smj6rqrVYUtsqXxeoceZhntO91S
 MBOlEfttXqA7KE0QmI1FaPLTtiK6cAJTlzqwmKyylPwoD8Gjw3YGOZg1ucFCQA+1m5ES9t6dF
 EGY1zkH9m7a43zzcXlnT8ThrHK1dyOZrsKn7ptvdkSafedEkvPuF35YzTMTYosTi8d5uTl+cJ
 B4daFb0rg5c9qN2V93tFJJxAmYM561WwPx+UaAwEmtXrjDx96vja1zfOeNDpnnopuCYMMMIj4
 k2WeS0V2rYZcCEFOBys/O0UerScWtgsEFPVVllqgTna0dbUqaJbue9OJQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.07.22 um 16:44 schrieb Guenter Roeck:

> On 7/23/22 18:20, Armin Wolf wrote:
>> Am 23.07.22 um 16:17 schrieb Guenter Roeck:
>>
>>> On Sat, Jul 23, 2022 at 05:38:19AM +0200, Armin Wolf wrote:
>>>> Until now, userspace software needs to guess which
>>>> PWM channel is associated with which fan channel by
>>>> probing each PWM output and watch for fan speed changes.
>>>> This proccess is error-prone and unreliable.
>>>>
>>>> Some hwmon chips, especially firmware-based ones, already
>>>> know which PWM output is associated with which fan channel.
>>>>
>>>> Allow such chips to export this knowledge to userspace.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> All of the chips I am aware of have a fixed association from pwm
>>> channel
>>> output to fan input. None I am aware of make this association
>>> configurable.
>>> I do not see the value of this attribute.
>>>
>>> Guenter
>>
>> That is true, the association from pwm channel output to fan input is
>> usually fixed.
>> However not all chips are able to discover which pwm channel output
>> is associated with
>> which fan channel. For example most superio-based chips cannot know
>> how the motherboard
>> manufacturer wired the fans, and thus userspace relies on pwmconfig
>> for manually probing
>> each pwm channel.
>
> Alternatively, the user can figure it out based on board documentation
> and configure it directly. That is how it is. That doesn't mean that
> it makes
> sense to 'store' that information in a sysfs attribute. That is not
> what hwmon
> sysfs attributes are supposed to be used for.
>
Good point.
It would be indeed better if userspace software like pwmconfig would
use an internal list containing the names of all hwmon chips for which
the pwm to fan mappings are known.
I will add a note to the documentation of dell-smm-hwmon about the
pwm to fan mapping so userspace software knows about this.
Sorry for bothering you.

Armin Wolf

>> In contrast, many firmware-based chips do know which pwm channel
>> output controls which
>> fan channel. One example might be the dell-smm-hwmon driver and the
>> gpio-fan driver.
>>
>> In this case, making the attribute RO would indeed make sense.
>>
>
> Unless the attribute is used to configure the chip, it does not make
> sense
> in the first place. Also note that gpio-fan is usually configured using
> devicetree properties, _and_ it only has a single set of fan/pwm
> properties,
> so a sysfs attribute would always return 1 and make make even less
> sense there.
>
> Guenter
>
>> Armin Wolf
>>
>>>> ---
>>>> =C2=A0 Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>>>> =C2=A0 Documentation/hwmon/sysfs-interface.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 +++
>>>> =C2=A0 drivers/hwmon/hwmon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>>> =C2=A0 include/linux/hwmon.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>>> =C2=A0 4 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon
>>>> b/Documentation/ABI/testing/sysfs-class-hwmon
>>>> index 7271781a23b2..f3d653bcf736 100644
>>>> --- a/Documentation/ABI/testing/sysfs-class-hwmon
>>>> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
>>>> @@ -315,6 +315,14 @@ Description:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW
>>>>
>>>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/class/hwmon/hwm=
onX/pwmY_fan_channel
>>>> +Description:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which fan channel =
is controlled by this PWM output.
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Valid fan channel/PWM out=
put combinations are chip-dependent.
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RW
>>>> +
>>>> =C2=A0 What: /sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>>>> =C2=A0 Description:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which t=
emperature channels affect this PWM output in
>>>> diff --git a/Documentation/hwmon/sysfs-interface.rst
>>>> b/Documentation/hwmon/sysfs-interface.rst
>>>> index 209626fb2405..17fcec03d3c5 100644
>>>> --- a/Documentation/hwmon/sysfs-interface.rst
>>>> +++ b/Documentation/hwmon/sysfs-interface.rst
>>>> @@ -209,6 +209,9 @@ PWM
>>>> =C2=A0 `pwm[1-*]_freq`
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base PWM frequ=
ency in Hz.
>>>>
>>>> +`pwm[1-*]_fan_channel`
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Select which fan channel is controlled by this PW=
M
>>>> output.
>>>> +
>>>> =C2=A0 `pwm[1-*]_auto_channels_temp`
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select which t=
emperature channels affect this PWM output in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 auto mode.
>>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>>> index 2e2cd79d89eb..8c2d7574c461 100644
>>>> --- a/drivers/hwmon/hwmon.c
>>>> +++ b/drivers/hwmon/hwmon.c
>>>> @@ -604,6 +604,7 @@ static const char * const
>>>> hwmon_pwm_attr_templates[] =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_enable] =3D "pwm%d_enable",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_mode] =3D "pwm%d_mode",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_freq] =3D "pwm%d_freq",
>>>> +=C2=A0=C2=A0=C2=A0 [hwmon_pwm_fan_channel] =3D "pwm%d_fan_channel",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [hwmon_pwm_auto_channels_temp] =3D "pw=
m%d_auto_channels_temp",
>>>> =C2=A0 };
>>>>
>>>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>>>> index 14325f93c6b2..9d40cc1e520f 100644
>>>> --- a/include/linux/hwmon.h
>>>> +++ b/include/linux/hwmon.h
>>>> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_enable,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_mode,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_freq,
>>>> +=C2=A0=C2=A0=C2=A0 hwmon_pwm_fan_channel,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwmon_pwm_auto_channels_temp,
>>>> =C2=A0 };
>>>>
>>>> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>>>> =C2=A0 #define HWMON_PWM_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(hwmon_pwm_enable)
>>>> =C2=A0 #define HWMON_PWM_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(hwmon_pwm_mode)
>>>> =C2=A0 #define HWMON_PWM_FREQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(hwmon_pwm_freq)
>>>> +#define HWMON_PWM_FAN_CHANNEL BIT(hwmon_pwm_fan_channel)
>>>> =C2=A0 #define HWMON_PWM_AUTO_CHANNELS_TEMP
>>>> BIT(hwmon_pwm_auto_channels_temp)
>>>>
>>>> =C2=A0 enum hwmon_intrusion_attributes {
>>>> --
>>>> 2.30.2
>>>>
>
