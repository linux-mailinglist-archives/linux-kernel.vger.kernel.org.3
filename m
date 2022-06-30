Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64E560E14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiF3Adu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF3Ads (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:33:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D822B26;
        Wed, 29 Jun 2022 17:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656549204;
        bh=6lMtPAGrUriFxRzqDiaMwPvLBe2jbc2oorL+KRQ6G0E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OTfO9M329EBUUJzlZ1kbot16CJAYzs5ESaOYQyePWGapX3napQEOrHhH7cKml2QQ/
         yIgsiGzNOB4dIvRKTFL1sn18+xH2wDYOedTHKmXxKV/NZzbYt4gtSpsf+jRgT+FmgI
         MvL1/vex3OQvuxQOnMwOSZifdykD17XemB3nxQjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1npSBa1f4k-00rWrE; Thu, 30
 Jun 2022 02:33:24 +0200
Message-ID: <16841959-42c9-cbd7-e767-39050134b070@gmx.de>
Date:   Thu, 30 Jun 2022 02:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/8] serial: ar933x: Remove redundant assignment in
 rs485_config
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-8-LinoSanfilippo@gmx.de>
 <f7beef4-c422-cae3-8e22-8652b407434@linux.intel.com>
 <df19d91d-371b-f0e9-e37c-2bde00d2b840@gmx.de>
 <033c8d2-3f2e-afe6-2e98-14a61c872b4b@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <033c8d2-3f2e-afe6-2e98-14a61c872b4b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fymyF5SOHTcLkP7SEfj64ke4xtX230O6VAwEagenoFcJ803fosw
 wkg5UGVaEOg6mVKNvQrFLo8N9QdLAqIzLyznEhSbCt4CfIOaGpRfpcT2jTa/dFg/21oLz6p
 krFyF6418nG9fkDLq6N6SGQmMORLvyhEuWF5knUEIyvYIEOe5HGI8I6nw8l1WOqTVyioAkZ
 /SC596f1UWyQ3Du22z4Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:51DN12aZLlc=:3sUM85SzIBq78Pf0cH/jpZ
 Ff/FgiAP9iq/TGsKaU2CVbxwuvh2qU9ccFYq4RvM/H9Szz+FUBDyknuam+NCMMrvEVHfpsila
 2o/e6UWmIcVXThNt/6x2d5hsJojpWVJlR1GKe/EjPRKej4ke4dIqtuqyJ6pktJQ90m+YhZ68n
 2K4/glejULVCiwiJHgxfPzkR3FS/rawy0oNz11xbpQvELDmrNA3zqQt7Y3pDqhs/vsq89rN1W
 pzo9Z2WQ5cTlVgrSnGsK14Oqc4S+QZ0HuJp9I58GoQXRevss4nfbQEbgvCHn4oupbTZe2lI/6
 MgokvufMg02+ZmYV62KzPADovBJe0Fl+F7feC8Bw0RGg9oFiSKiDmpqcTcwTwXRwhEaG09A3H
 0rovTr+3LTmF1FujvCyKNc75Yt9LzIpLp9wLvwsmC+QEcAKTe9z2bV66zj7f/lFX9T0TLpEoA
 oCoBP8PBUxn4CHXuXfYE4uGOl2oB7Iw4hi2Ozx+JVE9t2sejxw3iS50svgJ+ZtgweUYc+PoFH
 vlW6yTgHGyXEu76bJMs1gRcalZcoUZBqJxadnEv89l+p5Z8WDa8RjKOg+ocDbpa7l49sAFgdH
 vll/9sLnhHSXSREYxfW7+qXqjqpn3j3UqMoh3Qnhs/KG4+AlEkYtJ+jco6VamT+Kt5xrCdHPZ
 vJODztbVUAw+ExqmVbALP6vu+st3rFHoEyYxcvdCdVDiAkS7LFgCvqxQ2E17dh6BLDz+9o+fq
 Td9hAqJigYZSvtAXF7Urp185ZUpk3UWzSb9jRnM+NeoOiVfDAeY7H2iylUgKLWbGbnceJZb+J
 R+/gD6wRWezhyRpIi1TFr57PC3DCj/a/YX8IO/+kIpUZUzVy07XPQmi+JFG2kNzCRwrAqhpI0
 qOWavPFe8OuQBn2fA/BxuCzXczlUOGX8whbS7m8x7K/gtogfeonF67/4PuTHXSv91ZM88RjwV
 SX8Ek6DzIBrtBvp8tl1rbmeuGx78g75ovVKjK1KrYFfryg5qUPXOvD4r5XXJ+kH/UJ9n0jcGU
 AYkTAOEa4RFKz7JVHWSq194siH6Ch8XkzpEZpNh4o7g3iu+HfJzytOAcDbuK9UDXq1O2Ff6Pk
 t1n2/gCvleNT5e6BkAIA7exqLvxSZsrmbBpn5X4jCKZJ/aaQnPO1gALFg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.06.22 10:14, Ilpo J=C3=A4rvinen wrote:
> On Sun, 26 Jun 2022, Lino Sanfilippo wrote:
>
>> On 25.06.22 at 12:14, Ilpo J=C3=A4rvinen wrote:
>>> On Wed, 22 Jun 2022, Lino Sanfilippo wrote:
>>>
>>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>
>>>> In uart_set_rs485_config() the serial core already assigns the passed
>>>> serial_rs485 struct to the uart port.
>>>>
>>>> So remove the assignment in the drivers rs485_config() function to av=
oid
>>>> redundancy.
>>>>
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>> ---
>>>>  drivers/tty/serial/ar933x_uart.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar=
933x_uart.c
>>>> index ab2c5b2a1ce8..857e010d01dc 100644
>>>> --- a/drivers/tty/serial/ar933x_uart.c
>>>> +++ b/drivers/tty/serial/ar933x_uart.c
>>>> @@ -591,7 +591,6 @@ static int ar933x_config_rs485(struct uart_port *=
port,
>>>>  		dev_err(port->dev, "RS485 needs rts-gpio\n");
>>>>  		return 1;
>>>>  	}
>>>> -	port->rs485 =3D *rs485conf;
>>>>  	return 0;
>>>>  }
>>>
>>> Hmm, I realize that for some reason I missed cleaning up this particul=
ar
>>> driver after introducing the serial_rs485 sanitization. It shouldn't n=
eed
>>> that preceeding if block either because ar933x_no_rs485 gets applied i=
f
>>> there's no rts_gpiod so the core clears SER_RS485_ENABLED.
>>
>> I think we still need that "if" in case that RS485 was not enabled at d=
river
>> startup (no rs485-enabled-at-boot-time) and no RTS GPIO was defined but=
 then
>> RS485 is enabled via TIOCSRS485.
>>
>> Maybe in ar933x_uart_probe()
>>
>> 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
>> 	    !up->rts_gpiod) {
>> 		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
>> 		port->rs485.flags &=3D ~SER_RS485_ENABLED;
>> 		port->rs485_supported =3D &ar933x_no_rs485;
>> 	}
>>
>> should rather be
>
> I think it would be better (and what I should have done while moving the
> check there in the first place but I missed it). In addition, however, i=
t
> would be useful to not print unnecessarily:
>
>> 	if (!up->rts_gpiod) {
>
> if (port->rs485.flags & SER_RS485_ENABLED) {
>
>> 		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
>> 		port->rs485.flags &=3D ~SER_RS485_ENABLED;
>
> }


Right. I will send a fix for this with the new version of my series.

Regards,
Lino


