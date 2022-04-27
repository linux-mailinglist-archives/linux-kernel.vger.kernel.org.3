Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1D5123A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiD0ULO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiD0UK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:10:59 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189E8D6B1;
        Wed, 27 Apr 2022 13:05:15 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 458971B3;
        Wed, 27 Apr 2022 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651089915;
        bh=AzzWe17kKgZeNsSnsRwYyjYR0RFU8QrYdE2Ktfuuz84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FY+xcXaWw3zGKKIyu1dm2aux8IMX2r0891MpmNdwga37mMnfzQQPk0IsR03Kf43EZ
         CTPVVjerFH7AhswXy+mw5OZO6+fwQswlO6HEi+To0u4VpTorqVc1WziVWqLH65JOrM
         nkUSd3AqgCkUFqrr5H9+ISEXb0uXmg/n9+DWQ2BA=
Date:   Wed, 27 Apr 2022 13:05:11 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Message-ID: <Ymmh93CW8nIGD0YI@hatter.bewilderbeest.net>
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <20220427010154.29749-2-zev@bewilderbeest.net>
 <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
 <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
 <5139dc9f-96c3-9f20-4c62-feee902cb5e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5139dc9f-96c3-9f20-4c62-feee902cb5e6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:37:20AM PDT, Krzysztof Kozlowski wrote:
>On 27/04/2022 08:44, Zev Weiss wrote:
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  nuvoton,tsi-channel-mask:
>>>> +    description:
>>>> +      Bitmask indicating which TSI temperature sensor channels are
>>>> +      active.  LSB is TSI0, bit 1 is TSI1, etc.
>>>
>>> Need a type/ref.
>>>
>>
>> Ack, thanks.
>
>Did you test the bindings after the changes? Using reviewers time
>instead of testing by yourself with an automated tool is quite a waste.
>

Yeah, sorry about that -- with uint32 $ref added it passes dt_binding_check;
I'll re-send with that change.


Zev

