Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA94EABC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiC2K6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiC2K6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:58:31 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E7F1EAC3;
        Tue, 29 Mar 2022 03:56:48 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Mar 2022 19:56:48 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E2D292058443;
        Tue, 29 Mar 2022 19:56:47 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Mar 2022 19:56:47 +0900
Received: from [10.212.183.172] (unknown [10.212.183.172])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C5AB8B62B7;
        Tue, 29 Mar 2022 19:56:46 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: serial: uniphier: Add "resets" property as
 optional
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648430772-21786-1-git-send-email-hayashi.kunihiko@socionext.com>
 <eff14382-5ef7-8b84-8689-70f69c1521e9@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <97bfd9cd-6b7c-1e93-e63b-f32764a6f317@socionext.com>
Date:   Tue, 29 Mar 2022 19:56:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eff14382-5ef7-8b84-8689-70f69c1521e9@linaro.org>
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

On 2022/03/29 4:05, Krzysztof Kozlowski wrote:
> On 28/03/2022 03:26, Kunihiko Hayashi wrote:
>> UniPhier UART controller has a reset lines from system controller.
>> Add "resets" property to fix the following warning.
>>
>>    uniphier-ld11-global.dtb: serial@54006800: 'resets' does not match any
>> of the regexes: 'pinctrl-[0-9]+'
>>        From schema:
>> Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/serial/socionext,uniphier-uart.yaml    | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>> b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>> index d490c7c4b967..d14d8c9cfe4d 100644
>> ---
>> a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>> +++
>> b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
>> @@ -22,6 +22,9 @@ properties:
>>     clocks:
>>       minItems: 1
> 
> This should be fixed to maxItems as well (separate patch).

I see. In the case of one item, "maxItems" should be used.
I'll fix it in another patch.

>>
>> +  resets:
>> +    minItems: 1
> 
> maxItems

I'll fix it in this patch.

Thank you,

---
Best Regards
Kunihiko Hayashi
