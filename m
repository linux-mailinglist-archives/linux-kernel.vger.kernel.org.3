Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4333529F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiEQKiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiEQKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:37:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A32AC74;
        Tue, 17 May 2022 03:37:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 34CDB1F4449B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652783869;
        bh=/dsxBc72kvp9HLcx8a+NKXyzgg9ikDWp61IyWUXJyrE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZrDlo/lcb+N1riezflUawdelj07yo7FSY4S8D+aDjfeCqCdeEdjSp/VgaO189eyZ9
         YdJu3PFqjWzKD+qwcYaUyiEkM2Xf/wS8HRqTlNJk8ccdQuq1fEPFOOKdj6aWy7MkdD
         wxM8o6J5FZUcSJvZhkD5E42oZN6zfEAQSQLqnitdsTUTQDWv59bEZXqo7Js/YXh3IR
         1FJXtHTx/vIgKx14x/yNgamDhBVf6pTHOEax7xTj5xW/njXLArkMqX0spDgfEpQq1f
         B4m5Bx1Qen1xyuvXsLZ++sc/lG6J/fpTKmr0sIb8XIYO69Unp/UePqITul2od325fF
         xQ7V8l+bTJfug==
Message-ID: <83907dd2-2a53-2448-576b-ae26462d432a@collabora.com>
Date:   Tue, 17 May 2022 16:07:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as
 deprecated vendor prefix
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-2-shreeya.patel@collabora.com>
 <20220516170058.GA2825626-robh@kernel.org>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220516170058.GA2825626-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/05/22 22:30, Rob Herring wrote:
> On Wed, May 11, 2022 at 03:10:22PM +0530, Shreeya Patel wrote:
>> 'liteon' is the correct vendor prefix for devices released by
>> LITE-ON Technology Corp. But one of the released device which uses
>> ltr216a light sensor exposes the vendor prefix name as 'ltr' through
>> ACPI.
> ACPI? NAK.
>
> There are no cases of 'ltr' for DT, so fix ACPI.

Hi Rob,

Yes, we understand there are no cases of 'ltr', but we have released devices
which uses this string for probing the ltrf216a light sensor driver ( 
x86 with DT )

If we don't document this in vendor-prefixes.yaml, then the following 
warning
is generated.

WARNING: DT compatible string vendor "ltr" appears un-documented -- 
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: 
FILE: drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },


Can you suggest us what would be the right way to fix this warning if 
not documenting
in vendor-prefixes.yaml?



Thanks,
Shreeya Patel

>
>> Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
>> following warning in case the compatible string used in ltrf216a driver
>> is "ltr,ltrf216a"
>>
>> WARNING: DT compatible string vendor "ltr" appears un-documented --
>> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>> 364: FILE: drivers/iio/light/ltrf216a.c:313:
>> +    { .compatible = "ltr,ltrf216a" },
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>
>> Changes in v2
>>    - Add vendor prefix name as per the alphabetical order.
>>
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 01430973ecec..02f94fba03b6 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -716,6 +716,9 @@ patternProperties:
>>       description: Loongson Technology Corporation Limited
>>     "^lsi,.*":
>>       description: LSI Corp. (LSI Logic)
>> +  "^ltr,.*":
>> +    description: LITE-ON Technology Corp.
>> +    deprecated: true
>>     "^lwn,.*":
>>       description: Liebherr-Werk Nenzing GmbH
>>     "^lxa,.*":
>> -- 
>> 2.30.2
>>
>>
