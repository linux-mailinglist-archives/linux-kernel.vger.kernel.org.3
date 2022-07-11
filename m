Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC456F99D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGKJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiGKJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:06:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F50220F5;
        Mon, 11 Jul 2022 02:06:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26B96XxH054462;
        Mon, 11 Jul 2022 04:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657530393;
        bh=Jsfv6F5djTNvrM+DmDKOJgOO8ViuBYqVPEjeLGyCQVQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c4C1U6oloKqe42eo+R9Da3UpkD1s0H6yZqOi+qoDgz4NixzilHQGo3U8xPnDAj6Pd
         Od8yMAExRoj6WMHnwZ0uwvN89yGW1f/yioIcwirnieQaPp6fFZNjUgTezXQNjehe99
         qtuELmgoMUNTRTX/NWJFUJIM2pq2RNCBdiX/TLzk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26B96XYV073090
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 04:06:33 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Jul 2022 04:06:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Jul 2022 04:06:33 -0500
Received: from [172.24.145.60] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26B96TYq017843;
        Mon, 11 Jul 2022 04:06:30 -0500
Subject: Re: [PATCH] dt-bindings: crypto: ti,sa2ul: drop dma-coherent property
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <vigneshr@ti.com>, <davem@davemloft.net>, <robh+dt@kernel.org>,
        <herbert@gondor.apana.org.au>, <j-keerthy@ti.com>
References: <20220707110756.16169-1-j-choudhary@ti.com>
 <1657315922.470955.1508205.nullmailer@robh.at.kernel.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <5d9c0f44-efb6-7a1a-e9e4-51a060701ec3@ti.com>
Date:   Mon, 11 Jul 2022 14:36:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1657315922.470955.1508205.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09/07/22 3:02 am, Rob Herring wrote:
> On Thu, 07 Jul 2022 16:37:56 +0530, Jayesh Choudhary wrote:
>> crypto driver itself is not dma-coherent. It is the dmaengine
>> that moves data and the buffers are to be mapped to the
>> dmaengine provider. So this property should be dropped.
>>
>> Fixes: 2ce9a7299bf6 ('dt-bindings: crypto: Add TI SA2UL crypto accelerator documentation')
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>  .../devicetree/bindings/crypto/ti,sa2ul.yaml        | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> crypto@4e00000: 'dma-coherent' does not match any of the regexes: '^rng@[a-f0-9]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
> 	arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
> 	arch/arm64/boot/dts/ti/k3-j721e-sk.dtb
> 

These warnings are expected. dt-node fixes need to be there.
I will send the dt-node fixes once this patch gets in due to
dependency. Or should I proceed any other way?

Thanks,
Jayesh
