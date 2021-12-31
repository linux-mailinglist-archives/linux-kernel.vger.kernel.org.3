Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7E48234F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhLaKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:23:50 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:27687 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhLaKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:23:49 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 18:23:46 +0800
Message-ID: <f0a8cf69-bc51-1cb0-8c1a-6751a4d42eca@amlogic.com>
Date:   Fri, 31 Dec 2021 18:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 4/6] tty: serial: meson: The UART baud rate calculation
 is described using the common clock code. Also added S4 chip uart Compatible.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-5-yu.tu@amlogic.com> <Yc2lwhYKQ03pGho3@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <Yc2lwhYKQ03pGho3@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/30 20:27, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Dec 30, 2021 at 06:21:08PM +0800, Yu Tu wrote:
>> Using the common Clock code to describe the UART baud rate clock makes
>> it easier for the UART driver to be compatible with the baud rate
>> requirements of the UART IP on different meson chips
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
> 
> Your subject line is very odd, please fix up.
> 
I will correct.
> thanks,
> 
> greg k-h
> 
