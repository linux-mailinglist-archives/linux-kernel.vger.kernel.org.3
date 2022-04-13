Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30F4FF1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiDMIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiDMIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:35:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B54E39D;
        Wed, 13 Apr 2022 01:33:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23D8X59m108346;
        Wed, 13 Apr 2022 03:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649838785;
        bh=HOPOflYBcnV/LFPZgAip1/IVvOFdFr6KgIKVx26qgnc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RJoo7a9f/wiR5560OR2zPXmctcbRR3mjI7HNzOuXQcjEWcaEQeB+Enj6flVMvt8+m
         dMQEOEF8h8jbZ8Cs9trBqUrKzq8BnY6G1pw/cGNhczYuS4qqxJo9x5AwtRIf4P9xia
         Al9vcAZGh5GujZKnwbc5t9CENnlDcHeuN9SMH0jI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23D8X4Kj019983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 03:33:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 03:33:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 03:33:04 -0500
Received: from [172.24.147.118] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23D8X12W013738;
        Wed, 13 Apr 2022 03:33:02 -0500
Subject: Re: [PATCH 1/2] dt-bindings: crypto: ti,sa2ul: Add a new compatible
 for AM62
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-crypto@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
References: <20220412073016.6014-1-j-choudhary@ti.com>
 <20220412073016.6014-2-j-choudhary@ti.com>
 <aeff85cb-45b2-c7d6-5ce8-edd6776fbfe4@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <60fd105f-9263-0afd-a489-a289fc414189@ti.com>
Date:   Wed, 13 Apr 2022 14:03:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <aeff85cb-45b2-c7d6-5ce8-edd6776fbfe4@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 12/04/22 5:33 pm, Krzysztof Kozlowski wrote:
> On 12/04/2022 09:30, Jayesh Choudhary wrote:
>> Add the AM62 version of sa3ul to the compatible list.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
>> index a410d2cedde6..02f47c2e7998 100644
>> --- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
>> @@ -15,6 +15,7 @@ properties:
>>        - ti,j721e-sa2ul
>>        - ti,am654-sa2ul
>>        - ti,am64-sa2ul
>> +      - ti,am62-sa3ul
>>  
> 
> Just to be sure - dma-coherent is not required for this device (see
> final "if:" in the bindings)?
> 

Yeah that's right.
dma-coherent is not required for this device.

Regards,
-Jayesh
