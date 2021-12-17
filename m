Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8AA478B84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhLQMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:37:50 -0500
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:43878 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLQMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:37:49 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.324405|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0232552-0.00197139-0.974773;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MHTlNGI_1639744666;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MHTlNGI_1639744666)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 17 Dec 2021 20:37:46 +0800
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add bindings for new Ingenic
 SoCs.
To:     Rob Herring <robh@kernel.org>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1639068516-5577-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1639068516-5577-2-git-send-email-zhouyanjie@wanyeetech.com>
 <Ybo/Ygixmmn9FPkx@robh.at.kernel.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <c74478fd-cbdb-e592-f166-61550152e28e@wanyeetech.com>
Date:   Fri, 17 Dec 2021 20:35:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <Ybo/Ygixmmn9FPkx@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/16 上午3:17, Rob Herring wrote:
> On Fri, Dec 10, 2021 at 12:48:34AM +0800, 周琰杰 (Zhou Yanjie) wrote:
>> Add the OST bindings for the X1600 SoC, the X1830 SoC,
>> the X2000 SoC and the X2500 SoC from Ingenic.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>   Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> index 98648bf..a3b1429 100644
>> --- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> @@ -20,7 +20,12 @@ properties:
>>     compatible:
>>       enum:
>>         - ingenic,x1000-ost
>> -      - ingenic,x2000-ost
> Removing this is not a compatible change.


Sure, I will split it into new patch.


Thanks and best regards!


>
>> +      - ingenic,x1600-ost
>> +      - ingenic,x1830-ost
>> +      - ingenic,x2000-ost64
>> +      - ingenic,x2000-ost32
>> +      - ingenic,x2500-ost64
>> +      - ingenic,x2500-ost32
>>   
>>     reg:
>>       maxItems: 1
>> -- 
>> 2.7.4
>>
>>
