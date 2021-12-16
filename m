Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E44477676
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhLPP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:59:40 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:56382 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhLPP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:59:36 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 6001020F0316
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk
 property in dwc3
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Yaqin Pan <akingchen@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel@vivo.com>
References: <20211215130325.19017-1-akingchen@vivo.com>
 <20211215130325.19017-3-akingchen@vivo.com>
 <abede066-43a2-b61b-d152-c95ef3785934@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5eb92897-1ef9-3c1c-c068-7fef759ec9ad@omp.ru>
Date:   Thu, 16 Dec 2021 18:59:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <abede066-43a2-b61b-d152-c95ef3785934@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 11:26 AM, Sergey Shtylyov wrote:

>> Add snps,dis_split_quirk property for dwc3 controller
>>
>> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index 41416fbd92aa..e9615ca8f447 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -226,6 +226,12 @@ properties:
>>         avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>>       type: boolean
>>   +  snps,dis_split_quirk:
>> +    description:
>> +      When set, change the way host controller schedules transations for a Control transfer.
> 
>    Transactions.
> 
>> +      Needed to avoid emurate some devices fail.
> 
>    Avoid failing to enumerating some devices?

   Sorry. enumarate. :-)

[...]

MBR, Sergey
