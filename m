Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A5A8D65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiIAFck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiIAFce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:32:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C202110DAE;
        Wed, 31 Aug 2022 22:32:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2815WHOV021229;
        Thu, 1 Sep 2022 00:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662010337;
        bh=W25JfjrCAiPwVHAFytuREQrGr+gUDpaeUHw3vRbkoIw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AGtHyU/B1nz2PYo3ruo4+Uuz/+E47PYgWKYFPZWfzYTBqHFl2N8QpPUbMHAmPzIEp
         zfrYHUaiIheRr6Z3Nq3cp/cJ5nzev8tDxH3XMHyso1eMw4JPvSZZkeGKLt9LZQJYxF
         MRuX6v5IagXO/vs8wI7ZRJ7BgC08O61YcPBvSdsQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2815WHwx008628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 00:32:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 00:32:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 00:32:17 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2815WDD3021810;
        Thu, 1 Sep 2022 00:32:14 -0500
Message-ID: <528ea531-dd6b-c147-8e22-3a4e41d97fe4@ti.com>
Date:   Thu, 1 Sep 2022 11:02:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for AM62A
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
 <20220829082200.241653-3-vigneshr@ti.com>
 <4001e0eb-f370-7bf4-89d0-ceed6d22e492@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <4001e0eb-f370-7bf4-89d0-ceed6d22e492@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/22 15:23, Krzysztof Kozlowski wrote:
> On 29/08/2022 11:21, Vignesh Raghavendra wrote:
>> Add pinctrl macros for AM62AX SoCs. These macro definitions are similar
>> to that of previous platforms, but adding new definitions to avoid any
>> naming confusions in the SoC dts files.
>>
>> checkpatch insists the following error exists:
>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> However, we do not need parentheses enclosing the values for this
>> macro as we do intend it to generate two separate values as has been
>> done for other similar platforms.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  include/dt-bindings/pinctrl/k3.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
>> index a5204ab91d3e..97cd2e39efa4 100644
>> --- a/include/dt-bindings/pinctrl/k3.h
>> +++ b/include/dt-bindings/pinctrl/k3.h
>> @@ -44,4 +44,6 @@
>>  #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>>  #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>>  
>> +#define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>> +#define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> 
> Alphabetical order, so maybe before AM642?
> 

These macros are ordered chronologically, will add a patch to reorder
alphabetically to avoid confusion.

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof

-- 
Regards
Vignesh
