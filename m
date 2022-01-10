Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2DF489551
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiAJJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:36:19 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:6280 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiAJJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:35:55 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Jan
 2022 17:35:51 +0800
Message-ID: <a19771e6-d1d4-d1ef-9819-21e2147aad16@amlogic.com>
Date:   Mon, 10 Jan 2022 17:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V4 0/5] the UART driver compatible with
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110085604.18042-1-yu.tu@amlogic.com>
 <1f4b9288-c7ff-c895-425c-187d058642b9@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1f4b9288-c7ff-c895-425c-187d058642b9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
	Thank you very much for your reply.

On 2022/1/10 17:27, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 10/01/2022 09:55, Yu Tu wrote:
>> Using the common Clock code to describe the UART baud rate
>> clock makes it easier for the UART driver to be compatible
>> with the baud rate requirements of the UART IP on different
>> meson chips. Add Meson S4 SoC compatible.
>>
>> Yu Tu (5):
>>    dt-bindings: serial: meson: Drop compatible = amlogic,meson-gx-uart.
>>    tty: serial: meson: Request the register region in meson_uart_probe()
>>    tty: serial: meson: The UART baud rate calculation is described using
>>      the common clock code.
>>    tty: serial: meson: Make the bit24 and bit [26,27] of the UART_REG5
>>      register writable
>>    tty: serial: meson: Added S4 SOC compatibility.
> 
> Weird, the subjects are fine in the cover letter but are all truncated in the email thread:
> [PATCH V4 0/5] the UART driver compatible with
> [PATCH V4 1/5] dt-bindings: serial: meson: Drop
> [PATCH V4 2/5] tty: serial: meson: Request the register
> ...
> Only the last one is OK.
> 
I saw the subject was a little long, I changed it manually, do I need to 
regenerate and send?
> 
>>
>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
>> discussed in the email
>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
>> the DTS before it can be deleted
>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>> in the email.
>>
>> Link:https://lore.kernel.org/linux-amlogic/20211230102110.3861-4-yu.tu@amlogic.com/
>>
>>   .../bindings/serial/amlogic,meson-uart.yaml   |  10 +-
>>   drivers/tty/serial/meson_uart.c               | 244 ++++++++++++------
>>   2 files changed, 177 insertions(+), 77 deletions(-)
>>
> 
