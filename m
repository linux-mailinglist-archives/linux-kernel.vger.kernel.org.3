Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11B847A8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhLTLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:48:22 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:40802 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhLTLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:48:21 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2DC0020D565E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <4dcc204a-ba68-ebb8-021d-fd4b54be2729@omp.ru>
Date:   Mon, 20 Dec 2021 14:48:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Content-Language: en-US
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
 <d7974f16-74b1-4d8a-2c28-8acb710d6310@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <d7974f16-74b1-4d8a-2c28-8acb710d6310@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2021 14:25, Sergey Shtylyov wrote:

>> The return value of platform_get_irq() needs to be checked.
>> To avoid use of null pointer
> 
>    What null pointer, could you please clarify?
> 
>> in case that there is no irq.
>>
>> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

    This has already been addressed by this (yet unmerged) patch:

https://marc.info/?l=linux-usb&m=162854066430255

MBR, Sergey
