Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441E5A7F73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiHaOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:02:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871BD344C;
        Wed, 31 Aug 2022 07:02:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27VE1xrv079120;
        Wed, 31 Aug 2022 09:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661954519;
        bh=KmT4WpWjy3SGTdU5bphSJO9ZMv/OV6OBVyOabkIOzWM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DmZwKUi4MeE/6rDFX0U+aV7bCre1ncEdTyy9egdecYHSJewRNTl8L6pru+37YVMyK
         hZrPT4zxu1gS+gYGA2rC/sAj5969dJCruX3NJTwGAgGFauHC1TcPhkoes2Kw1ryx2W
         Ej9PDP0dcC7B4LEL8tT5mJ2kt00ixm7sWEBh0cu0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27VE1xZq058640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Aug 2022 09:01:59 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 31
 Aug 2022 09:01:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 31 Aug 2022 09:01:59 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27VE1uxd100773;
        Wed, 31 Aug 2022 09:01:57 -0500
Message-ID: <ab68f577-a47b-dfe1-d66f-a0dc098faca9@ti.com>
Date:   Wed, 31 Aug 2022 19:31:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: k3: Sort the am654 board enums
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220830160507.7726-1-nm@ti.com>
 <20220830160507.7726-2-nm@ti.com>
 <6d558914-2667-9e48-b662-980b9c7ca094@linaro.org>
 <20220830173812.knnavya6uud56wsa@unrefined>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220830173812.knnavya6uud56wsa@unrefined>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/22 23:08, Nishanth Menon wrote:
> On 19:50-20220830, Krzysztof Kozlowski wrote:
>> On 30/08/2022 19:05, Nishanth Menon wrote:
>>> Use alphabetical sort to organize the am654 board names.
>>>
>>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> It's not a bug, so it should be rather "Suggested-by".
>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof
> 
> Thanks - Vignesh: let me know if you'd like a v2 with
> s/Reported-by/Suggested-by update.
> 

No need, I can take care of this locally before applying.

-- 
Regards
Vignesh
