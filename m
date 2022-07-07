Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012AB56A684
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiGGPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiGGPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:01:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665017068;
        Thu,  7 Jul 2022 08:01:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 267F1V9o066777;
        Thu, 7 Jul 2022 10:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657206091;
        bh=XOH9YNTfoGbrNEDgBlKe0BZK5m9Ciqon/unFihTQeyc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XSObTcqMqCA8aQ6Y4lTIxPb3yvtPGkbq78LY8lUiqK/K5FV0vt5dLtmjXwGYOT444
         bghT9SwGBC3G9tX9m5J/J/FaY1GHvz9SKMzTIKVKeJI36PQgS2/92jGUQJUA11TmC5
         u0purN4QsfoTTLLUko+/qDLsrfwE4hhk+XMO9YvI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 267F1Vdr052741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 10:01:31 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 10:01:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 10:01:31 -0500
Received: from [10.250.33.129] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 267F1UX6061311;
        Thu, 7 Jul 2022 10:01:30 -0500
Message-ID: <cb353a3c-96e7-f770-c8bd-17b8a4b4b3e0@ti.com>
Date:   Thu, 7 Jul 2022 10:01:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am65-main: Disable RNG node
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220706190838.26074-1-afd@ti.com>
 <20220707144400.tk3wmpeijdhuxpzv@bryanbrattlof.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220707144400.tk3wmpeijdhuxpzv@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 9:44 AM, Bryan Brattlof wrote:
> Hi Andrew
> 
> On July  6, 2022 thus sayeth Andrew Davis:
>> The hardware random number generator is used by OP-TEE and is access is
>> denied to other users with SoC level bus firewalls. Any access to this
>> device from Linux will result in firewall errors. Disable this node.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>
>> Changes from v1:
>>   - Added comment in dtsi file
>>
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index e749343accedd..9de5a8294acd6 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -127,6 +127,7 @@ rng: rng@4e10000 {
>>   			reg = <0x0 0x4e10000 0x0 0x7d>;
>>   			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&k3_clks 136 1>;
>> +			status = "disabled"; /* Used by OP-TEE */
> 
> Just curious about how we should document disabling nodes. I was
> assuming the reasoning should be described in the bindings?
> 
> I would like to start disabling nodes by default in our dtsi files and
> enabling them in our top dts file, making it easier for others to use
> our device tree for a more focused purpose than our dev boards. I just
> didn't know where I should document why I disabled the nodes :)
> 

This got push-back last time this was suggested, I'll have to lookup
the history. IIRC we landed on the other way around, all things should
be described by default, then the specific board can enable/disable
what is not used as needed.

I was worried this topic would come up with this patch series and was
almost just going to delete the whole RNG node instead of disabling it
to avoid that. My reasoning for disabling here anyway is that this device
*cannot* be used by *any* board, it is not just a board level configuration
decision like disabling I2C nodes by default or similar that was proposed
last time we had the "nodes disabled by default" discussion.

Andrew

> ~Bryan
