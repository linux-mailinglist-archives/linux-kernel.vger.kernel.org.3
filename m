Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7019147CE91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbhLVJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:01:04 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:42666 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhLVJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:01:02 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 22 Dec
 2021 17:01:00 +0800
Message-ID: <04a4768a-5136-8b6e-baa2-b6ac21afe14f@amlogic.com>
Date:   Wed, 22 Dec 2021 17:01:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/3] tty: serial: meson: meson_uart_shutdown omit clear
 AML_UART_TX_EN bit
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
 <20211221071634.25980-3-yu.tu@amlogic.com> <YcGC8hlOEbzH8rc8@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <YcGC8hlOEbzH8rc8@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/21 15:32, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Dec 21, 2021 at 03:16:33PM +0800, Yu Tu wrote:
>> The meson_uart_shutdown function should have the opposite operation to
>> the meson_uart_startup function, so the shutdown of AML_UART_TX_EN is
>> logically missing.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> 
> What commit does this fix?  Should it go to stable kernels?  Please put
> that in here if needed.
> 
It has not yet been revealed that this is a bug. The reason I changed it 
was because I thought it was an improvement and it might be a hidden 
bug.The AML_UART_TX_EN bit is conspicuously missing when comparing the 
meson_uart_shutdown and meson_uart_startup functions.So I think it's 
best to add.
> thanks,
> 
> greg k-h
> 
