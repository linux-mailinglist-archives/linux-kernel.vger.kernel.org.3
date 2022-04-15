Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD850200A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiDOBRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDOBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:17:31 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D70941FB4;
        Thu, 14 Apr 2022 18:15:03 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Apr 2022 10:15:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BBCD32058B50;
        Fri, 15 Apr 2022 10:15:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 Apr 2022 10:15:02 +0900
Received: from [10.212.183.90] (unknown [10.212.183.90])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9E59EB6389;
        Fri, 15 Apr 2022 10:15:01 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: thermal: uniphier: Use unevaluatedProperties
 and common bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1649317533-21139-1-git-send-email-hayashi.kunihiko@socionext.com>
 <YlccxAQ9adSZh22F@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <c16ca6b1-0363-7ddc-6736-3de738d7e5a5@socionext.com>
Date:   Fri, 15 Apr 2022 10:15:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YlccxAQ9adSZh22F@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/04/14 3:56, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 04:45:33PM +0900, Kunihiko Hayashi wrote:
>> This adds common bindings thermal-sensor.yaml and this is preferred for
>> unevaluatedProperties instead of additionalProperties.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../bindings/thermal/socionext,uniphier-thermal.yaml         | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git
> a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yam
> l
> b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yam
> l
>> index c5b25ce44956..537c93da1397 100644
>> ---
> a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yam
> l
>> +++
> b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yam
> l
>> @@ -14,6 +14,9 @@ description: |
>>   maintainers:
>>     - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>   
>> +allOf:
>> +  - $ref: "thermal-sensor.yaml#"
> 
> No advantage to adding this as this schema still has to define the value
> for "#thermal-sensor-cells".
I see. Certainly it's not time to add the common schema yet.
I withdraw this patch.

Thank you,

---
Best Regards
Kunihiko Hayashi
