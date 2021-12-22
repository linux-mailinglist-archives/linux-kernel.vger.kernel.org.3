Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9168F47CDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhLVITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:19:47 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:19988 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbhLVITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:19:46 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 22 Dec
 2021 16:19:41 +0800
Message-ID: <92993ded-c15b-ce2e-6fb6-f4ee846cbcf1@amlogic.com>
Date:   Wed, 22 Dec 2021 16:19:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] the UART driver compatible with the Amlogic Meson S4
 SoC
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <YcGCs1LYqXNnQwsF@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <YcGCs1LYqXNnQwsF@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg K-H,
	Thank you very much for your reply.I'll amend it as you suggest.

On 2021/12/21 15:30, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Dec 21, 2021 at 03:16:31PM +0800, Yu Tu wrote:
>> The UART driver compatible with the Amlogic Meson S4 SoC on-chip, change the
>> UART interrupt interface function while adding IRQF_SHARED flag. And add clear
>> AML_UART_TX_EN bit in meson_uart_shutdown funtion.
>>
>> Yu Tu (3):
>>    tty: serial: meson: modify request_irq and free_irq
>>    tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
>>    tty: serial: meson: add UART driver compatible with S4 SoC on-chip
>>
>> Link:https://patchwork.kernel.org/project/linux-amlogic/patch/20211206100200.31914-1-xianwei.zhao@amlogic.com/
> 
> What is this link for?
> 
> And why patchwork?
> 
> Please just use lore.kernel.org links for mailing list threads.
> 
> thanks,
> 
> greg k-h
> 
I will change the address you suggested as follows,
Link: 
https://lore.kernel.org/linux-amlogic/20211206100200.31914-1-xianwei.zhao@amlogic.com/
