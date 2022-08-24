Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3DB59F612
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiHXJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiHXJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:15:29 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B07672B4C;
        Wed, 24 Aug 2022 02:15:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27O9FD1g035097;
        Wed, 24 Aug 2022 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661332513;
        bh=WL57j794lsG1Gsidcwzg0R3eWNfeztOCOjYZm3tN5z0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eQP93xRKandMoyGGnD6WDWsbnzfK21h9gxf8Ft+Z7lVZVGUgktXsXO98rVWAwoesV
         0m6kc1e1p29xLPtp+sJywU8H9BQQVSlMgpqiG6QBH/AodfpYSyHIYkeqDl+YrAZVpV
         /t58C5TRb4oU6wO9NJBqbBh5Zm+wBcmrwb2pyN0Q=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27O9FDwR027544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Aug 2022 04:15:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 24
 Aug 2022 04:15:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 24 Aug 2022 04:15:12 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27O9F8JG022180;
        Wed, 24 Aug 2022 04:15:09 -0500
Message-ID: <8871faad-5785-62c3-5afa-8c248ac79e9a@ti.com>
Date:   Wed, 24 Aug 2022 14:45:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] arch: arm64: ti: Add support for J784s4 EVM board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-5-a-nandan@ti.com>
 <6c89f254-185a-4046-2bf0-a9f85713858e@linaro.org>
 <20220824050627.nh7d4blrsfbxrvuh@clicker>
 <734b1e1c-2416-0684-287e-a96b86a416a2@ti.com>
 <81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/22 12:42, Krzysztof Kozlowski wrote:
> On 24/08/2022 08:33, Vignesh Raghavendra wrote:
>> Hi Krzysztof,
>>
>> On 24/08/22 10:36, Nishanth Menon wrote:
>>> On 13:21-20220823, Krzysztof Kozlowski wrote:
>>>>> +
>>>>> +/ {
>>>>> +	compatible = "ti,j784s4-evm", "ti,j784s4";
>>>>> +	model = "Texas Instruments J784S4 EVM";
>>>>> +
>>>>> +	chosen {
>>>>> +		stdout-path = "serial2:115200n8";
>>>>> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
>>>>
>>>> earlycon is not a property of hardware. Console is defined in
>>
>> earlycon is helpful for debugging early crashes. How is it any different
>> from "console =" property as described in
>> Documentation/devicetree/usage-model.rst?
> 
> choice of console is needed for basic operation and is chosen based on
> current hardware setup. earlycon is purely for debugging and should be
> enabled only when debugging is intended, not on mainline wide-available
> sources.
> 
>>
>>>> stdout-path, so please drop entire bootargs.
>>>
>>> We will probably have to cleanup elsewhere as well - point noted.
>>>
>>
>> Whats the alternative to pass default bootargs to kernel if bootloader
>> does not pass bootargs via cmdline? I see quite a few dts file use
>> bootargs = "earlycon" at least
> 
> Uboot, your own out-of-tree testing patches? What's the point to have
> earlycon available for every user which does not want to debug?
> 
> Sorry, but bootargs are not accepted in DTS. We have several discussions
> around it over time...

Understood, just wanted to make sure what the latest stance is, as I see
lot of files in arm64 dts folder still use bootargs and earlycon. Thanks
for the clarification!

-- 
Regards
Vignesh
