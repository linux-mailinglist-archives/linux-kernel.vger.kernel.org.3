Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E2510698
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353700AbiDZSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350986AbiDZSVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:21:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66382111149;
        Tue, 26 Apr 2022 11:17:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QIHfUG107944;
        Tue, 26 Apr 2022 13:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650997061;
        bh=xSgEDekT0PvWJkeK2+Mu6QdLHYKX+DJVubgCLn879gU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tYSREcFd9GHON91PHp36abjRi0ec7tlNV6v3QiX1raeGxqlUghIioCV0S0ZZeyqFE
         xH/d1YnxGgERozCGDWnj4EC/6yka9ol82sdm/88sIR0OBSmCAfFWv4xCt6qL3ng5s1
         5fboemnf+xW7Rw7htKJH3cmvY41JHroQZVzXsZjU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QIHf7R096607
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 13:17:41 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 13:17:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 13:17:41 -0500
Received: from [10.250.235.181] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QIHaCM015788;
        Tue, 26 Apr 2022 13:17:37 -0500
Message-ID: <64d6e4c9-419a-eb31-36cb-ec9faadf6088@ti.com>
Date:   Tue, 26 Apr 2022 23:47:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable on board
 peripherals
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220422065002.387753-1-vigneshr@ti.com>
 <20220422065002.387753-3-vigneshr@ti.com>
 <c40a2dad-c7aa-f778-f1ac-971185691950@linaro.org>
 <8517d504-af9c-53f5-a51b-3bcdbb86d09f@ti.com>
 <c50819cb-8234-670f-c7c0-0507af2f96df@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c50819cb-8234-670f-c7c0-0507af2f96df@linaro.org>
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



On 26/04/22 12:32 am, Krzysztof Kozlowski wrote:
> On 25/04/2022 11:22, Vignesh Raghavendra wrote:
>>>> +		/* TPS22918DBVR */
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vdd_mmc1";
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +		regulator-boot-on;
>>>> +		enable-active-high;
>>>> +		vin-supply = <&vcc_3v3_sys>;
>>>> +		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
>>>> +	};
>>>> +
>>>> +	vdd_sd_dv: gpio-regulator-TLV71033 {
>>>
>>> The same + do not mix cases, so regulator-1 or regulator-tlv71033
>>
>> I have fixed this in v3. But had one question though:
>>
>> Per DT spec, 2.2.3 Path Names seems to indicate node-name-N when N is
>> 1,2,3.. So, is it valid to have regulator-tlv71033 as node-name -> does
>> not strictly seem to fit into node-name-N format ?
> 
> No, "regulator-tlv71033" does not match DT spec. Indeed better to have
> some generic suffix, e.g. regulator-vbatt, but strictly speaking DT spec
> asks for just "regulator-[0-9]".
> 
> However several people prefer such descriptive suffix instead of
> "regulator-[0-9]" because it makes their life easier when extending DTSI
> (when both DTSI and DTS provide some of such regulators). Therefore I
> don't think it's that important to keep with the spec. Rob for example
> does not complain here, so probably I am stricter than him.
> 
> In any case it would be good to have only suffix or only prefix, e.g.
> "regulator-foo-bar" or "foo-bar-regulator", so DT schema can match
> against it. Several other types of devices already require such naming.
> 


Understood, thanks for the clarification!

Regards
Vignesh
