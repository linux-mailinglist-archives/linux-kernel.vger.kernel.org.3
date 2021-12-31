Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64005482333
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhLaKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:18:53 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:18546 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLaKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:18:52 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 31 Dec
 2021 18:18:49 +0800
Message-ID: <0f447686-b0d7-aed7-8c17-88111693ba29@amlogic.com>
Date:   Fri, 31 Dec 2021 18:18:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3 3/6] dt-bindings: serial: meson: Support S4 SoC uart.
 Also Drop compatible = amlogic,meson-gx-uart.
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
 <20211230102110.3861-4-yu.tu@amlogic.com> <Yc2l0Rp3lrfYr6PP@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <Yc2l0Rp3lrfYr6PP@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
	Thank you for your reply.

On 2021/12/30 20:28, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu, Dec 30, 2021 at 06:21:07PM +0800, Yu Tu wrote:
>> Deprecated, don't use anymore because compatible = amlogic,meson-gx-uart
>> don't differentiate between GXBB and GXL which have different
>> revisions of the UART IP. So it's split into GXBB and GXL.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Again, your subject line is way too long.
> 
I will correct.
> thanks,
> 
> greg k-h
> 
