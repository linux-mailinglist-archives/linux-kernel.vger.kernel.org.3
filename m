Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3B47A970
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhLTMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:22:58 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:55142 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhLTMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:22:56 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 21B8120F2E48
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <3da4130b-4412-6ae7-11ee-00245a02286a@omp.ru>
Date:   Mon, 20 Dec 2021 15:22:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
 <d7974f16-74b1-4d8a-2c28-8acb710d6310@omp.ru>
 <4dcc204a-ba68-ebb8-021d-fd4b54be2729@omp.ru> <YcBzrN2Y7++Iephs@kroah.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <YcBzrN2Y7++Iephs@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2021 15:14, Greg KH wrote:

[...]
>>>> The return value of platform_get_irq() needs to be checked.
>>>> To avoid use of null pointer
>>>
>>>     What null pointer, could you please clarify?
>>>
>>>> in case that there is no irq.
>>>>
>>>> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
>>>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>>
>>     This has already been addressed by this (yet unmerged) patch:
>>
>> https://marc.info/?l=linux-usb&m=162854066430255

> Why not wait until that patch is actually merged?  Otherwise all of this
> work is moot.

    Wait, it has been merged back in August. Then this patch is just 
outdated... :-)

> greg k-h

MBR, Sergey
