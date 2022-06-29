Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FF560DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiF2Xuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiF2Xux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:50:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A02127D;
        Wed, 29 Jun 2022 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656546616;
        bh=3fAg27+TCAw935xSDUf+S6VcS1ZLQuQxlwYS7A2za84=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iSY0fJxeUoYgeraRF5pU84ACgeNNYEIdDyIVDzPYoSK+S04RySZMwDCee0Y1XZ3fO
         QtGFsc4ok3UligJELeTtb7gdV1Ooop60fvJ3vEE7gf3MIzsptDYqrQakVR+O0yO19Q
         NhWenWfpcGtMD9PmpNRwL6Q7YLMSWp40wldGZjXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1nLVeX1rrB-00lmRo; Thu, 30
 Jun 2022 01:50:16 +0200
Message-ID: <c4186284-0e77-46b2-716b-1975255b8b34@gmx.de>
Date:   Thu, 30 Jun 2022 01:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-6-LinoSanfilippo@gmx.de>
 <YrSU4eL9hgISg3Y1@smile.fi.intel.com>
 <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
 <YrrR4hItCx56bpxI@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <YrrR4hItCx56bpxI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0QiSyAhlTJ7TDzjUjKCzFvaXoizpF1kJducC6AZQT6WWrjML4TL
 p27AQCym8UlP5l+kLh7vPVARmEuw10GVbP6LJL3fulDLklJj2EDsZI2ufG/XwJHB9QeAKO+
 XtedCi+uGIyVg0I3/LB+Tymw+f15Y2IlHLZgWP29q/6rD4RTR+R6iKXzRlztKM/n84oNt4u
 OlaT6AVb4VeiLIAzwmtLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Z39mh5f+gc=:NRImakE+xh6ZMGO4g8mZIF
 BQOmO9YwNeEohO618vMaD4rEIxoCeMORwkXq5SKz37KNV5vts/L8YvyU7vXKFTJXUk3gJQCpP
 qx53u6ZX0fHHkk1Xo8LEh7kUWaoQ4XVxFf+XqsKk8/A9MdPZRyCsaV4jd3vQz1UzK6nme74GZ
 LQfjfNN6DwjkFIrxuIxE+MG/LsHWzYO2+Hvw6dQse3Op+A9TPDtAsTNRxF5IOowsq5uYoxzq4
 07zfhFsvpAsHoxxdv6REQf7lr4IzK9yHybnu6CPbWne1WwzGA5WhssqWnoD1n83meTq9br0aP
 /VtzrSwsL0bc52RIxbYra0yPvGyZ77b3t4fVvK9d/HR6UcgPXSm7GIvgVGAp1/ogJFGOC/CFx
 9fkKTnw2mZiarjIKkr4isPlXkObv+fIVGGoyWZSfdHI0i14k7vH3dDLeIH2C8iQDUB3xe2p15
 ZguSys2lqwX5oo4rNj/68RGNwnnTQY82JXt04zJztaQsxGRXec9gz5vDLWYSzBq2TWYYmYhMc
 LQv2gwBOJ/i5U/7nNrDD7JbO2uk2JHVMzOlXvzMDbBV24vlptPjfQSo8KGdY/DuM3blGvlg0v
 gQnKRmkaMcl8J4W4iIDc1UVywekre+Y30+AW2xLlJh8kwwL4vcU1nqkEq/G1D+6XY2H1FgccM
 sOesmdikXtS5KFc0Lt/RVsrvZA72bsXQDMNWmSG7SjmGxghQ+xAz8dG/fDpkpyvvr6Ie/SwQA
 dFkgrDjYpd2PRhZb3pAWYqBzp8W9njY3CH7RL0liiXz+I4vCfbQJdiF1jO1nw5InYIF8OaH8w
 /uJlgX7p/ppM8nseFGjJC7LYZRt1xbr6A3WKzwD73N33Hn0ll7ZXE1tgShBHZui7zHFnNmQDn
 JMC1lamRVaseVyWUH/BvH5eGXkvlEItPymKZ0kQjm+z+Bwksvxu+0wD08nENjUTddv8lXVR7G
 VIxeHkjkKQWcrfq/EnR3qlPu3NxaCfRn8+y0IwoQpwH8s6BebzX8ekipWRey7kbfNUHvp1ZcJ
 fZt0dXCeHBvfRunjQNcszYT3cgpk3S0rT9Pamcs6iIb51vxvge+kKOQNBR0h4/pM0uMFg095p
 IEhuOVK28tPlA4+HiHkAlqnKgDrPVm+THmRB9qlxhhUlSBcsyGR+ONRtQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.06.22 12:03, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 10:17:06PM +0200, Lino Sanfilippo wrote:
>> On 23.06.22 at 18:29, Andy Shevchenko wrote:
>>> On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
>>>>
>>>> The maximum allowed delay for RTS before and RTS after send is 100 ms=
.
>>>> Adjust the documentation accordingly.
>>>
>>> Is it only documentation issue? If the code allows this to be set high=
er
>>> than 100, we may not change the documentation since this an ABI (from
>>> firmware <--> kernel perspective) we need to support old variants.
>>
>> Well currently the documentation claims that a maximum of 1000 msecs is=
 allowed but
>> nothing actually checks the values read from device tree/ACPI and so it=
 is possible
>> to set much higher values (note that the UART drivers dont check the de=
lays read from
>> DT/ACPI either, the only exception I found is max310x which clamps it t=
o 15 ms).
>>
>> We already have a maximum of 100 ms defined for RTS delays set via TIOC=
SRS485. To be
>> consistent with TIOCSRS485 the same limit is used for DT/ACPI values in=
 this patch.
>>
>> I am aware that this changes the firmware/kernel ABI. But we had a simi=
lar situation when
>> the sanity checks for TIOCSRS485 were introduced
>> (see https://lore.kernel.org/all/20220410104642.32195-2-LinoSanfilippo@=
gmx.de/)
>> since before we did not have those limits for all drivers (some drivers=
 clamped the
>> values itself but many did not care).
>> Furthermore 100 ms is already a very high value for RTS delays (which a=
re usually rather
>> in usecs range). So IMHO the risk is very low to break anything when va=
lues are clamped
>> that are higher than that.
>
> You need to elaborate all this in the commit message to justify the chan=
ge.
>

OK, I see. I will rewrite the commit message then to hopefully make the ra=
tionale behind
the time reduction more clear.

Thanks,
Lino
