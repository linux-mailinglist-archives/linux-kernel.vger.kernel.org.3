Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6155B266
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiFZOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiFZOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:10:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EADF9588;
        Sun, 26 Jun 2022 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656252590;
        bh=yTusrjLOKRKwRvbd8R+ykK/3/JvyRwhEMn0DfEPv1UQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OEFvmYruw9c/MQw0Bb57+QhL/P3LfieAzofQsvHzfZU4qHFtZ6YCY8fGF49l0nlN7
         d91HEORwKcv5+VjBO7JThNTMwrXuURI0wsAnEPtqyY2qup8tlyKEsWkJ4ssvDt+5UI
         zowxewehHN5/BKy76GTg0uolk6B6+T4mtj0AoFvw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1nLMYg0rea-00kNyS; Sun, 26
 Jun 2022 16:09:50 +0200
Subject: Re: [PATCH 7/8] serial: ar933x: Remove redundant assignment in
 rs485_config
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
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <df19d91d-371b-f0e9-e37c-2bde00d2b840@gmx.de>
Date:   Sun, 26 Jun 2022 16:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7beef4-c422-cae3-8e22-8652b407434@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPs9BkINPOugQ76QtMRekLInNgNbeZHcwpIRkgAQ+/3JpS8T0E5
 na8Gv2u7zhVw+/nGBiNBdETNueMeS2z0KYd8T+thup1HRX8cPEQWHJCRUme+sLjOVrY9j/v
 HGcmWJriW/REC6uIJyGdMquWHsEvzy69rHxqpAYt9v/R5gyUAza+rlq5uqy7XN/wV2Lgtdk
 vRA0qQqnky+Ef3Gyj9OZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0M5kIdMhVrk=:srVvd9zQL+xSR57YuedoOV
 /klAYSy3rvIMzmA00If2+O4UcMWsOhuIcPzEln880XwVg6Y45DlNZbRfjjT31dPXqvdzb8edr
 DqkggG9E11HTUgKrHMvl+zNrkd6B5STjmN4B5ApRWcta0kz5TcyaDndDYHh7HH9ytgM0JSFjS
 jLgPGGM9A9zzfi2kz4N+dcXgHAagTGwhxgYU+1scp7M6qsXGVv2Z5mOtitep1jMYajpZ643ek
 L+gM5O/J39AHGSHMaS2+YS2i4ley2UnoIUOhG8gb8QW+XmGYHAT8hR9p+3opzut2JT4hH27W+
 NwBeHqNfN+wDP9HnGwIufJRrYw1OaNcS3zotqpRIYeNf0zSzGgdRBg1kbElmD5JKY6N+ePIK7
 BwHjI/Sh/OOYxShROfH+airEgIlq2E1P+jC5YM19MFhJi0yb+DLtgXKQWziVQ3F+AYexp9FhG
 YQVM59n1577iA7LSKWdR90/P3trIpAn3QGdHBXMs6sReNShW1yPmpMK5SzTrK0sidY0MQddb5
 zPE44nmHBqceHQFGwpLTL5/S03oMo24+BFb7XAIZoa5mtINsVnN07oUkUUAtRY7fLXX98sa3g
 JvvtASfBu5+OKrlMoSJ9t4kp/bKPDcUbSla/Ar8+Lk0edH/zqswF27WVb6FKK4wj4EspC5w2F
 c77ZUt8MuJZ+f5QO+KP88UxrcnHlIZAp6L2W6hpjDclzIPNfPhDALw+S4jclNRAm9G5G9pkBu
 HfAU3VcEEh5PKS6zfkrDr/Wp3FrJnKDyR1QoHtsCjYwJrjT5D1nNfLLQTbuvMzVTnoX8q+ZKU
 xO9r3a7e1WOdqLE6dW15E9lerGP26whbH6uMdePSU5WHnErLNgd60EmRqkruUfUViCipkI3Az
 ON7noMgBcVNDapFc0YeKr0bEKtlkuC+F035YTYAi+oeVSIw0kTIK1xYwIayFY8wrvTuIGSjwc
 cz4wXmFxGI/UgqL0sXvTQb/R0lRAwaMtmo4hpfLlbjeldAFHLliY9p7Z+yXFEFwX7azljTmAp
 PkAutccHGbPK82e4mOOsstpwmh0K74VrAizX2IGTo72I8CDF5czBic0XQBrEPXpOZWAcBZp/P
 hZrP9muQ960wbyBcKxKfZtxKyDt/F5TJtG/VlEkRrA9qGIgA1s23EPv/Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.22 at 12:14, Ilpo J=C3=A4rvinen wrote:
> On Wed, 22 Jun 2022, Lino Sanfilippo wrote:
>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In uart_set_rs485_config() the serial core already assigns the passed
>> serial_rs485 struct to the uart port.
>>
>> So remove the assignment in the drivers rs485_config() function to avoi=
d
>> redundancy.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/ar933x_uart.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar93=
3x_uart.c
>> index ab2c5b2a1ce8..857e010d01dc 100644
>> --- a/drivers/tty/serial/ar933x_uart.c
>> +++ b/drivers/tty/serial/ar933x_uart.c
>> @@ -591,7 +591,6 @@ static int ar933x_config_rs485(struct uart_port *po=
rt,
>>  		dev_err(port->dev, "RS485 needs rts-gpio\n");
>>  		return 1;
>>  	}
>> -	port->rs485 =3D *rs485conf;
>>  	return 0;
>>  }
>
> Hmm, I realize that for some reason I missed cleaning up this particular
> driver after introducing the serial_rs485 sanitization. It shouldn't nee=
d
> that preceeding if block either because ar933x_no_rs485 gets applied if
> there's no rts_gpiod so the core clears SER_RS485_ENABLED.
>

I think we still need that "if" in case that RS485 was not enabled at driv=
er
startup (no rs485-enabled-at-boot-time) and no RTS GPIO was defined but th=
en
RS485 is enabled via TIOCSRS485.

Maybe in ar933x_uart_probe()

	if ((port->rs485.flags & SER_RS485_ENABLED) &&
	    !up->rts_gpiod) {
		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
		port->rs485.flags &=3D ~SER_RS485_ENABLED;
		port->rs485_supported =3D &ar933x_no_rs485;
	}

should rather be

	if (!up->rts_gpiod) {
		dev_err(&pdev->dev, "lacking rts-gpio, disabling RS485\n");
		port->rs485.flags &=3D ~SER_RS485_ENABLED;
		port->rs485_supported =3D &ar933x_no_rs485;
	}




Regards,
Lino



