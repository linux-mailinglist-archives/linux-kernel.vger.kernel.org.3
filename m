Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A355667E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGEK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGEK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:27:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026ADD79;
        Tue,  5 Jul 2022 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657016854;
        bh=bBQ/GIqpW9tdRWLlrll/jb4LP/KTWOt9N2yCFgaxsxc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ShM8lC3lrkvqR8wM1djWPYB9t5zy5R8+G9B1E4mACOqjPWQiGdWUATv/6bdYSAi3p
         3kbWMbddNvfM1het19sKPWRgGlMPk3A7A33MtBeVibGCbhFCCceiTDr58CN0WVkZBJ
         l9VIuxVmL3lv/98dUA3NriJ9twWQWXpgGVdCdjs0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.214]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1ndiwD0Dgt-00fiH5; Tue, 05
 Jul 2022 12:27:34 +0200
Message-ID: <6216fed3-3a68-3de5-5cbf-9c2aebe68727@gmx.de>
Date:   Tue, 5 Jul 2022 12:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] serial: RS485 termination is supported if DT provides
 one
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
References: <20220704094515.6831-1-ilpo.jarvinen@linux.intel.com>
 <20220704094515.6831-3-ilpo.jarvinen@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20220704094515.6831-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kSmIYk9Pf41M5sZnq/hstsvxWY2S0VQ0kRdOrUmVQMRyK/yjOUE
 otFv0EIllAnwEfGd6mi+3tz7CXWrVlTxvcX+qdlIkU2UAPymm+NfUOVmst2nTpC5zibFKj6
 Sv9CD620rs6wQwPnFTknskqmKWFnWHlgaKsGwb5vl47bhkMsYNKzzXqmwSa2falbR2aJ0nE
 e6TU2JfXExHj5pM8rD8FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jXBEVTqfkOI=:T1D6KGwTQLuYD1hvHmv2KU
 rdAHTB6uY4fd5ShWfidEpJTsVi29uWC3zXeL0r+LPnHZtT2HFJ9Vv4DHdSsZUMFX0/Ay6o+l8
 72u69Ur5vVaFHPbA9eyICxM7f4RyvgxUri9F8rd5tKqXaxHaU2LoYVkTOIzbM5n2mqOjOb5Jv
 0jwqGZHE/AN/Qu0k7Krbj3cAENOW+qU02uJhcYNlwFy4DIdNoDraeTDN1AYpTVJuq11wfzOAn
 PBMgcRb56V4EYGyA+7ztmwDLMNUyPaL8vwScWBiP41l+Lan12Y4bd8d+GWBtkUPQE+5qplbRc
 3pNzrXstX4nWr4EtJ+VAwOZjRBt9xYvePI8A/Yiwf43bXKGt8cw+mE0ek9QmNQuZrQ2MCfwbT
 hUcaIdryKdejvKcbhC1uM2ew9fkwEBl1LqeFsOHElflEbu6da4kygJy0JQInor7RooERMpjx2
 q3o9HkgOA/N/HsA7fqal6J5QqArF4EJwjtRFokAKUsjXpBxZB0QJO3R9dWSqgjwVJEfGJtWov
 kC2r/ev6uCPEsfhErHYfJONrfju05eTFhlxgSOPtvyLNqgGfvGWKDHZ1t/1f4peBlM+C+qtPC
 G4g0OCj1Ip0BhARu1LG9JYOiSbMeMjZf/gI8wWhGbtNvSSjtFm6Pq3xQQ/RovPCuyWnq8fDV7
 2UzJCRIemR9ftISbD0a8tLfjdMINRyD2URVHatWk0ua2zWYW/+hpUAhjBBnpxNpeqSLtDblLN
 72Kc176gAzuUv48xWp8SAQgguBWWyRVGaBknfGKkqPy2pehIMWD7HL+7NGFYSt65eln6idJRS
 zc3X6fcy2Ft3CYrpYyCAxkM8Y4bdpb2XivEKTuOe7K4SX2OK6jeBplzzF1zdVftkdygNZoGmE
 loPyS2Qv6Z1sj4uQ1dmtLuGJlEhOKWBu5Y0ed2aTV7J/D8GfmnOlaFVL2M2QinZSV1R3XmfPb
 tNpRvJiFKg+fFb/2iz5Jrf+niWzN1ikwejDr6qLlqS1bQN7eYpEsdYMgDcciQFsz7DS9zlQMf
 TSNa8Zyw5FuELAUPDmHityrBZlZw1nF2w+giLE0GggoQY+g29wu+9GGHQBHdrqdZJlkgWhjOZ
 ygugWgdNPoKRw1Fu+CTbokliLT8oS5x6F+WIAXJS03jJ+PMKaouO9hffQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.07.22 11:45, Ilpo J=C3=A4rvinen wrote:
> When DT provides rs485-term, set termination flag as supported.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index a9cf1044a9fa..1db44cde76f6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3409,6 +3409,8 @@ int uart_get_rs485_mode(struct uart_port *port)
>  		port->rs485_term_gpio =3D NULL;
>  		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
>  	}
> +	if (port->rs485_term_gpio)
> +		port->rs485_supported.flags |=3D SER_RS485_TERMINATE_BUS;
>
>  	return 0;
>  }


FWIW:
Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>


Regards,
Lino
