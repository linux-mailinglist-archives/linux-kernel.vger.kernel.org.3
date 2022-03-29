Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2F4EABB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiC2K5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiC2K5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:57:44 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F9111D317;
        Tue, 29 Mar 2022 03:56:01 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Mar 2022 19:56:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 8B7AF2058443;
        Tue, 29 Mar 2022 19:56:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Mar 2022 19:56:00 +0900
Received: from [10.212.183.172] (unknown [10.212.183.172])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D8F11B62B7;
        Tue, 29 Mar 2022 19:55:58 +0900 (JST)
Subject: Re: [PATCH 3/3] dt-bindings: phy: uniphier-ahci: Fix missing
 reset-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648433152-23126-4-git-send-email-hayashi.kunihiko@socionext.com>
 <2e0be70f-f800-e3f8-363e-6598468fa091@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <54a88acd-49ed-01f6-4108-b74bc653a612@socionext.com>
Date:   Tue, 29 Mar 2022 19:55:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2e0be70f-f800-e3f8-363e-6598468fa091@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for reviewing.

On 2022/03/29 3:58, Krzysztof Kozlowski wrote:
> On 28/03/2022 04:05, Kunihiko Hayashi wrote:
>> Add missing "phy" reset-names to fix the following warning:
>>
>>    uniphier-pro4-ace.dtb: ahci-phy@10: resets: [[26, 28], [26, 12], [26,
>> 30], [36, 0], [36, 1], [36, 2]] is too long
>>        From schema:
>> Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>    uniphier-pro4-ace.dtb: ahci-phy@10: reset-names: 'oneOf' conditional
>> failed, one must be fixed:
>>        ['link', 'gio', 'phy', 'pm', 'tx', 'rx'] is too long
>>        From schema:
>> Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> 
> There is no ahci-phy in current sources...

Oops, I'm going to add ahci controller to the existing devicetree,
but not yet. I shouldn't write the future warning in the commit message,
so I'll fix it.

>>
>> Fixes: 34f92b67621f ("dt-bindings: phy: uniphier-ahci: Add bindings for
>> Pro4 SoC")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml   | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> index 3b400a85b44a..14f7579e7daa 100644
>> ---
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> +++
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>> @@ -43,13 +43,14 @@ properties:
>>
>>     resets:
>>       minItems: 2
>> -    maxItems: 5
>> +    maxItems: 6
>>
>>     reset-names:
>>       oneOf:
> 
> As a separate commit, this oneOf should be converted into allOf:if:then:
> cases which will enforce the resets per compatible.
> 
> Can you do that as well?

Ok, I've found some examples using "allOf:if:them:" cases,
so I'll try to convert it with another commit.

Thank you,

---
Best Regards
Kunihiko Hayashi
