Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B855863A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiHAEu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiHAEu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:50:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0545FB863;
        Sun, 31 Jul 2022 21:50:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2714oiOI065412;
        Sun, 31 Jul 2022 23:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659329445;
        bh=8Lr8tAgVWICX0AhenALNmgpmwS+V4Lzh+IMEWbghyDc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iml3PDN/V87l14FsnWoi/XUKn0qJ1HL30pOko8rCaKaubuk7pEvE8sb6A/1Nmf/lG
         O6KX1NpRH1bSi1HKoe09NToDdGSoQtqjGQew1sFbCTV7Xej5EFTpI/bnUiLsSquw63
         ApMigCVfP95TZCmJMd9iuFK8qbC0yd4KFZ3Vb6ts=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2714oiQ5030237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 31 Jul 2022 23:50:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 31
 Jul 2022 23:50:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 31 Jul 2022 23:50:44 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2714ofqa063483;
        Sun, 31 Jul 2022 23:50:41 -0500
Message-ID: <1896bceb-2c0d-4c87-4fb6-1e418bf5cef1@ti.com>
Date:   Mon, 1 Aug 2022 10:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: crypto: ti,sa2ul: drop dma-coherent property
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     Rob Herring <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <herbert@gondor.apana.org.au>, <j-keerthy@ti.com>
References: <20220707110756.16169-1-j-choudhary@ti.com>
 <1657315922.470955.1508205.nullmailer@robh.at.kernel.org>
 <5d9c0f44-efb6-7a1a-e9e4-51a060701ec3@ti.com>
In-Reply-To: <5d9c0f44-efb6-7a1a-e9e4-51a060701ec3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

On 11/07/22 14:36, Jayesh Choudhary wrote:
> Hi Rob,
> 
> On 09/07/22 3:02 am, Rob Herring wrote:
>> On Thu, 07 Jul 2022 16:37:56 +0530, Jayesh Choudhary wrote:
>>> crypto driver itself is not dma-coherent. It is the dmaengine
>>> that moves data and the buffers are to be mapped to the
>>> dmaengine provider. So this property should be dropped.
>>>
>>> Fixes: 2ce9a7299bf6 ('dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation')
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> ---
>>>   .../devicetree/bindings/crypto/ti,sa2ul.yaml        | 13 -------------
>>>   1 file changed, 13 deletions(-)
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/
>>
>>
>> crypto@4e00000: 'dma-coherent' does not match any of the regexes: '^rng@[a-f0-9]+$', 'pinctrl-[0-9]+'
>> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
>> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
>> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
>> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
>> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
>> 	arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
>> 	arch/arm64/boot/dts/ti/k3-j721e-sk.dtb
>>
> 
> These warnings are expected. dt-node fixes need to be there.
> I will send the dt-node fixes once this patch gets in due to
> dependency. Or should I proceed any other way?
> 
> Thanks,
> Jayesh



This patch is ACKed and there are no other comments.
Can this patch be merged so that I can move forward with dt node
fixes or do you have any other comments on this?

Regards,
Jayesh
