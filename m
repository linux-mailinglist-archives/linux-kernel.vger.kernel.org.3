Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF347BFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhLUMiX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 07:38:23 -0500
Received: from aposti.net ([89.234.176.197]:59756 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhLUMiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:38:22 -0500
Date:   Tue, 21 Dec 2021 12:38:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dt-bindings: iio: Document "label" property
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guido =?iso-8859-1?q?G=FCnther?= <agx@sigxcpu.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <QRTG4R.GATAOJYEO97C@crapouillou.net>
In-Reply-To: <7718b4c6-59f8-c728-87ae-3c85e992e300@metafoo.de>
References: <20211221104354.35073-1-paul@crapouillou.net>
        <7718b4c6-59f8-c728-87ae-3c85e992e300@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar., déc. 21 2021 at 12:29:04 +0100, Lars-Peter Clausen 
<lars@metafoo.de> a écrit :
> On 12/21/21 11:43 AM, Paul Cercueil wrote:
>> All iio devices can have a label, which will be carried on to 
>> userspace
>> as a sysfs attribute. This is useful when having several iio devices
>> that represent different instances of the same hardware, as the name
>> attribute would then not be enough to differentiate between them.
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   Documentation/devicetree/bindings/iio/common.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/common.yaml 
>> b/Documentation/devicetree/bindings/iio/common.yaml
>> index f845b41d74c4..a90ad7718ecf 100644
>> --- a/Documentation/devicetree/bindings/iio/common.yaml
>> +++ b/Documentation/devicetree/bindings/iio/common.yaml
>> @@ -32,6 +32,14 @@ properties:
>>         considered 'near' to the device (an object is near to the
>>         sensor).
>>   +  label:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: |
>> +      All iio devices can have a label, which will be carried on to 
>> userspace
>> +      as a sysfs attribute. This is useful when having several iio 
>> devices that
>> +      represent different instances of the same hardware, as the 
>> name attribute
>> +      would then not be enough to differentiate between them.
>> +
> 
> The description has a lot of implementation details of the Linux 
> kernel. The devicetree bindings should be formulated operating system 
> agnostic.
> 
> Something like:
> 
> A descriptive label that allows to uniquely identify the device 
> within the system.

Alright. I'll V2 ASAP.

Cheers,
-Paul


