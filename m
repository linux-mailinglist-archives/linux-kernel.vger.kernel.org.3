Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A950D957
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbiDYGWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiDYGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:22:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8B2DCA;
        Sun, 24 Apr 2022 23:19:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23P6J6iU111789;
        Mon, 25 Apr 2022 01:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650867546;
        bh=F7ADQn60kfgRVAW03faSTjsksmw9WV/uDuMtxixSUJ4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dIEQFQ8lJ3L0w3zKvk6cVqq/wF20GbK8Z3T8/TL1z3ZFjjxGszl2mWGCMBQZrCewb
         xdgaeMoOV6BpI+CaR534CkyEcCNtB34Ne8I0LRQ1bkCm+qokHSq7uAG3OFjLEfHNS0
         KpncBRyNnxeu/JFgZb8Q8H7ZrsnMk6u9DM7AT1X0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23P6J6AF088268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Apr 2022 01:19:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Apr 2022 01:19:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Apr 2022 01:19:06 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23P6J2Uu069099;
        Mon, 25 Apr 2022 01:19:03 -0500
Message-ID: <9da52dd4-9162-3a23-05e6-b2b524ef4d4d@ti.com>
Date:   Mon, 25 Apr 2022 11:49:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-am654: Add flag to force
 setting to TESTCD bit
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220418102040.4993-1-a-govindraju@ti.com>
 <20220418102040.4993-2-a-govindraju@ti.com>
 <CAPDyKFrHi3-7FMfwRP5rtjSbTOnw73FvU5ZAz=eC8-XqQZYpsg@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAPDyKFrHi3-7FMfwRP5rtjSbTOnw73FvU5ZAz=eC8-XqQZYpsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 21/04/22 17:40, Ulf Hansson wrote:
> On Mon, 18 Apr 2022 at 12:21, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> The ARASAN MMC controller on Keystone 3 class of devices needs the SDCD
>> line to be connected for proper functioning. Similar to the issue pointed
>> out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
>> sdhci-of-arasan: Set controller to test mode when no CD bit").
>>
>> In cases where SDCD line is not connected, driver support has been added to
>> force the controller into test mode and set the TESTCD bit. In order to
>> implement this quirk the driver uses "ti,fails-without-test-cd" flag from
>> the device tree node. Therefore, update the bindings to document the above.
> 
> Would you mind rephrasing this a bit. DT bindings is about describing
> the HW, not about what the software should do.
> 

Sure, will rephrase it in the respin to remove the aspects that indicate
the sw support added.

> Otherwise, this looks good to me.
> 

Thank you for the review.

Regards,
Aswath

> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> index 0566493c4def..0ab07759b472 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> @@ -186,6 +186,13 @@ properties:
>>      description: Clock Delay Buffer Select
>>      $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> +  ti,fails-without-test-cd:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      When present, indicates that the CD line is not connected
>> +      and the controller is required to be forced into Test mode
>> +      to set the TESTCD bit.
>> +
>>  required:
>>    - compatible
>>    - reg
>> --
>> 2.17.1
>>
