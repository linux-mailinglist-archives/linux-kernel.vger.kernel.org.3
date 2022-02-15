Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215F4B79C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbiBOVBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:01:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBOVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:01:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87227FE3;
        Tue, 15 Feb 2022 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644958834;
        bh=U3sk/L7rPW55lszY/oDSdWjZxhCFG7WnfrTgjrNjoFU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=a6i3fXavsMyHNg1+fbswobS1CYS/w2qo/C3Wx6jpcNlccwT1J5/KaWhhg0DqyVuNp
         8xagrL9Q5qxS9CETTnsNeTHS6k3w34GfBUI+Da/hTASdJy9WLK8FyIVwDssmYVPeaM
         f/Y1DiLwe4OjTinivvtXJoSdkGyymkrcz19OlZfs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1oO1Pp2Ait-0169kl; Tue, 15
 Feb 2022 22:00:34 +0100
Message-ID: <84f0c52f-38ec-a2f3-cf1d-09f412f9542c@gmx.de>
Date:   Tue, 15 Feb 2022 22:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] hwmon: (dell-smm) Allow for specifying fan control
 method as module parameter
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-2-W_Armin@gmx.de>
 <20220215191941.azk5gpcn42ahcnna@pali>
 <a450a2b6-92d3-d2cd-db63-b578480ff385@gmx.de>
 <20220215194909.py62gbsfwe2qxq2i@pali>
 <6c9a1f7a-004e-1991-abef-181cc117907e@gmx.de>
 <20220215203151.kajdh6uezx5mzyal@pali>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20220215203151.kajdh6uezx5mzyal@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+y2dkE+hNcgTo/lvVXQnWTbNb0D8Cd7F5T7sCktHc35V7nipsY
 UOequoIUBSpvoaa1SvZspZOp0yAhdx4WGEDANOna4Mk4b6lUikwlqQs4f9+aLLBTaq5Osxo
 3PLckQ/AD3RO1pZtX7UayHO952O4ZeHbl3fXekBAhBvajNLtzVku2wW4FQwDGdRFPZBSb0F
 enqCZp8phMOnfsbJ/qGhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LCWKVZiinHc=:sxcH7inHjPP66XT9zHNtDb
 UKmgdKwqXXqddo3JBK0qvE0NaseG5RZW6uO087M2Pb5KOPSbKv1h3A6rBj1rTcsJlH5TI5xdT
 7jVpH59WJbaU/by6l+ks+G4eiIUUfVWUppAwND4vYLYQnBTdSGI90RbyAF6cH6VCfi2UOcgXa
 aZNyq5tLHqNXkYULXR2lqX3tByQAqu3IR0fos1kzcLn6UY21FfY/OLBz1PxFZ/d6PEbgSra8+
 gidr1xDULK2aRQyZzKbDhi2Vv+/SqQu/eEovVHeDn4n5wCumFIvCnl2QG8k0gO3LW0nbhRKVb
 lnA2baLPkxlzI8stFgm2fj2ps2ZyBfaQS+N2Gk/QSt689kUOPPocmrja5X4S+UO6xmQVaMIZz
 S962imxXuiUOLNIJ2X4qOXbnG75jK1e2JfBxVUxdIiWnSxJtQCqW93gG4VAs95vMkdHqnLv7+
 9BHmLeMVarVHMs0mvwb7xYg4lI6YzWzeXp5r3OAta+12vTlpy5XNFqu9xGZxpqauqudBuzbXE
 Sgwica463f8Ree86ONeNSIKzisj1RD0ktXArZlKKCSs5hbyKHaCEmdGVdHdvK5OVfAD1bYkPL
 TQ9mGsIzWTXQaIpvIRkBYzku5/yK8EH1xGyvf5I4a9FDYOSoIo8kmvtih+n3ixwoPTFtAB8t+
 VkGLjhu6m4ItawGFMDqLFmiNr7ELVcVaYU9Oa2qIoA+K7z7LQ8tb/ehtR2oWYVrTHAk4v0fNN
 yW6MnPZuELlzGhUGZyahl0tSjNVobTlbktmdcoX6prchSDCNmAau4RlIICVwpsXKIC74djbNP
 DEkEFjrUBUltKk+IPGKdqXjKusmIiv4vuig6vTmcZA8stdyRgCyY+sXtJZT9Wk+RE+qFwnOBL
 L/iuY78LechQjIe4ekqFMwYunG1haMjF/Kwv6aWCufVa/mFL0bbJ6k5wU6wc3jhvG5zFavfxV
 IdiYjEKa6fnBVk92Ox1Xj+XMxGcjVe91tw/ELh1n8hfo1vVP3BgvNBKWmv8sQfmdHFNVyI8g2
 nESzwi+BSV1jD7P0KWJhVsiGTsVAqhcFYmhPJZd0d29u4TXZw4H+lwS1fiaN4gKvbQNnZs15L
 Cee2P+Z8KSnmoQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.02.2022 um 21:31 schrieb Pali Roh=C3=A1r:
> On Tuesday 15 February 2022 21:19:17 Armin Wolf wrote:
>> Am 15.02.22 um 20:49 schrieb Pali Roh=C3=A1r:
>>> On Tuesday 15 February 2022 20:44:20 Armin Wolf wrote:
>>>> Am 15.02.22 um 20:19 schrieb Pali Roh=C3=A1r:
>>>>> On Tuesday 15 February 2022 20:11:07 Armin Wolf wrote:
>>>>>> Right now, the only way to test if setting manual/auto fan control =
works
>>>>>> is to edit and recompile the module, which may be too cumbersome fo=
r
>>>>>> the average user.
>>>>> There is also another way suitable for testing purposes which do not
>>>>> requires any kernel patch. Call iopl(3) syscall which changes I/O
>>>>> privilege level to 3 and which allows to poke I/O registers.
>>>>>
>>>> This is not possible under kernel lockdown/Secure Boot.
>>> Under Secure Boot it should be still possible.
>> Afaik, access to iopl() and ioperm() is blocked in this mode too.
>> This for example causes dell-bios-fan-control to fail when
>> the machine is booted in Secure Boot mode.
> Well, then it is the cost of the usage of Secure Boot. If you need
> additional functionality then disable it.
>
>>> With kernel lockdown, no kernel testing/debugging at HW level is
>>> acceptable due to security reasons, as it is against what kernel
>>> lockdown should achieve.
>>>
>> That is the reason i limited the number of selectable code pairs to
>> two which are known to work on a wide range of machines.
>> So users are unable to specify SMM commands, which are controlled by
>> the driver. If this still is to much, then we may drop this patch.
> This kernel driver dell-smm-hwmon should use same security model as
> other parts in kernel. So if kernel disallow user to specify custom
> parameters for io ports (those which are not provided by platform data)
> then it should be disabled also in this driver.
>
> It is really _bad_ practice to trying invent a security hole to the
> existing security model.

Understandable, i will drop this patch(es) then.

>>>>>> Allow for specifying the desired fan mode control method when loadi=
ng
>>>>>> the module, but taint the kernel if so since there is the possibili=
ty
>>>>>> for strange side effects on non-whitelisted models.
>>>>>> Also update docs and kernel-parameters.txt accordingly.
>>>>>>
>>>>>> Tested on a Dell Inspiron 3505.
>>>>>>
>>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>>>> ---
>>>>>>     .../admin-guide/kernel-parameters.txt         |  3 +++
>>>>>>     Documentation/hwmon/dell-smm-hwmon.rst        | 21 ++++++++++--=
----
>>>>>>     drivers/hwmon/dell-smm-hwmon.c                | 25 ++++++++++++=
+------
>>>>>>     3 files changed, 35 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
>>>>>> index d68053db21cc..4f1b6c2b7ed1 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -968,6 +968,9 @@
>>>>>>     	dell_smm_hwmon.fan_max=3D
>>>>>>     			[HW] Maximum configurable fan speed.
>>>>>>
>>>>>> +	dell_smm_hwmon.fan_mode_method=3D
>>>>>> +			[HW] Method to use for changing fan mode.
>>>>>> +
>>>>>>     	dfltcc=3D		[HW,S390]
>>>>>>     			Format: { on | off | def_only | inf_only | always }
>>>>>>     			on:       s390 zlib hardware support for compression on
>>>>>> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation=
/hwmon/dell-smm-hwmon.rst
>>>>>> index beec88491171..564d99cda869 100644
>>>>>> --- a/Documentation/hwmon/dell-smm-hwmon.rst
>>>>>> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
>>>>>> @@ -67,13 +67,16 @@ for your hardware. It is possible that codes th=
at work for other
>>>>>>     laptops actually work for yours as well, or that you have to di=
scover
>>>>>>     new codes.
>>>>>>
>>>>>> -Check the list ``i8k_whitelist_fan_control`` in file
>>>>>> -``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree: as a first
>>>>>> -attempt you can try to add your machine and use an already-known c=
ode
>>>>>> -pair. If, after recompiling the kernel, you see that ``pwm1_enable=
``
>>>>>> -is present and works (i.e., you can manually control the fan speed=
),
>>>>>> -then please submit your finding as a kernel patch, so that other u=
sers
>>>>>> -can benefit from it. Please see
>>>>>> +As a first step, you can load the module with the module parameter
>>>>>> +``fan_mode_method`` set to 1 to test if your hardware works with
>>>>>> +an already know method for disabling automatic BIOS fan control.
>>>>>> +If ``pwm1_enable`` is now present and works (i.e., you can
>>>>>> +manually control the fan speed), then please submit your finding
>>>>>> +as a kernel patch, so that other users can benefit from it.
>>>>>> +Just add your model to the list ``i8k_whitelist_fan_control`` in
>>>>>> +file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
>>>>>> +the already known code pair.
>>>>>> +Please read
>>>>>>     :ref:`Documentation/process/submitting-patches.rst <submittingp=
atches>`
>>>>>>     for information on submitting patches.
>>>>>>
>>>>>> @@ -120,6 +123,10 @@ Module parameters
>>>>>>                        Maximum configurable fan speed. (default:
>>>>>>                        autodetect)
>>>>>>
>>>>>> +* fan_mode_method:uint
>>>>>> +                   Method to use for changing fan mode (default:
>>>>>> +                   from whitelist)
>>>>>> +
>>>>>>     Legacy ``/proc`` interface
>>>>>>     --------------------------
>>>>>>
>>>>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-sm=
m-hwmon.c
>>>>>> index 9949eeb79378..1c4cc516c8b2 100644
>>>>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>>>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>>>>> @@ -111,6 +111,10 @@ static uint fan_max;
>>>>>>     module_param(fan_max, uint, 0);
>>>>>>     MODULE_PARM_DESC(fan_max, "Maximum configurable fan speed (defa=
ult: autodetect)");
>>>>>>
>>>>>> +static uint fan_mode_method;
>>>>>> +module_param_unsafe(fan_mode_method, uint, 0);
>>>>>> +MODULE_PARM_DESC(fan_mode_method, "Method to use for changing fan =
mode (default: from whitelist)");
>>>>> No, please really do not introduce another kernel parameter for this
>>>>> driver. There are already many and we do not need to extend this lis=
t.
>> Since there are two code pairs, i could not reuse the force param for t=
hat.
>> Since the newly added pair is unused, should i remove it and reuse the
>> force param?
> For such things like this there is debugfs, if you really need to
> specify / provide custom values.
>
>>>>>> +
>>>>>>     struct smm_regs {
>>>>>>     	unsigned int eax;
>>>>>>     	unsigned int ebx;
>>>>>> @@ -677,7 +681,7 @@ static umode_t dell_smm_is_visible(const void *=
drvdata, enum hwmon_sensor_types
>>>>>>
>>>>>>     			break;
>>>>>>     		case hwmon_pwm_enable:
>>>>>> -			if (data->auto_fan)
>>>>>> +			if (data->auto_fan && data->manual_fan)
>>>>>>     				/*
>>>>>>     				 * There is no command for retrieve the current status
>>>>>>     				 * from BIOS, and userspace/firmware itself can change
>>>>>> @@ -1282,14 +1286,21 @@ static int __init dell_smm_probe(struct pla=
tform_device *pdev)
>>>>>>     	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be=
 0 */
>>>>>>     	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);
>>>>>>
>>>>>> -	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>>>>>> -	if (fan_control && fan_control->driver_data) {
>>>>>> -		const struct i8k_fan_control_data *control =3D fan_control->driv=
er_data;
>>>>>> +	/* value specified via module param overrides whitelist */
>>>>>> +	if (fan_mode_method > 0 && fan_mode_method <=3D ARRAY_SIZE(i8k_fa=
n_control_data)) {
>>>>>> +		data->manual_fan =3D i8k_fan_control_data[fan_mode_method - 1].m=
anual_fan;
>>>>>> +		data->auto_fan =3D i8k_fan_control_data[fan_mode_method - 1].aut=
o_fan;
>>>>>> +	} else {
>>>>>> +		fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
>>>>>> +		if (fan_control && fan_control->driver_data) {
>>>>>> +			const struct i8k_fan_control_data *control =3D fan_control->dri=
ver_data;
>>>>>>
>>>>>> -		data->manual_fan =3D control->manual_fan;
>>>>>> -		data->auto_fan =3D control->auto_fan;
>>>>>> -		dev_info(&pdev->dev, "enabling support for setting automatic/man=
ual fan control\n");
>>>>>> +			data->manual_fan =3D control->manual_fan;
>>>>>> +			data->auto_fan =3D control->auto_fan;
>>>>>> +		}
>>>>>>     	}
>>>>>> +	if (data->manual_fan && data->auto_fan)
>>>>>> +		dev_info(&pdev->dev, "enabling support for setting automatic/man=
ual fan control\n");
>>>>>>
>>>>>>     	if (!fan_mult) {
>>>>>>     		/*
>>>>>> --
>>>>>> 2.30.2
>>>>>>
