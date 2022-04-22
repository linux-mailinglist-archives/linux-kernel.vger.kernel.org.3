Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0550C473
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiDVWjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiDVWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C62435A4;
        Fri, 22 Apr 2022 14:48:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MJ2KjN024036;
        Fri, 22 Apr 2022 14:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650654140;
        bh=NCM8mzjQH8QiT4AT02wOLT4awLcH+bAUoX5oBTbp0nU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u46vFj9mgkxJ4kojRRWfpdLSGkE5WzS0UpENurVyP13TL1Prbq1ehfXLKC2JsrgZI
         CN8yGCDZMsDo9Q5MDoiT+CccPcK/wfsOeq5y/C9H3J7PIGxWROzdRA+vF8ZU9RgfxS
         ehcheVKVEuuRwfQ5Ifz1in/sGX8rYTtR/BNAUUdQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MJ2Kit005174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 14:02:20 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 14:02:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 14:02:20 -0500
Received: from [10.249.34.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MJ2Jlc051088;
        Fri, 22 Apr 2022 14:02:19 -0500
Message-ID: <ad47db06-7f5c-399f-0ad0-81f720e6f035@ti.com>
Date:   Fri, 22 Apr 2022 14:02:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] dt-bindings: ti,sci: Add ti,ctx-memory-region
 property
Content-Language: en-US
To:     Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
 <20220421203659.27853-2-d-gerlach@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220421203659.27853-2-d-gerlach@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 3:36 PM, Dave Gerlach wrote:
> Add documentation for the ti,ctx-memory-region property which is a
> phandle to a reserved-memory carveout to be used by the ti_sci driver
> storage of low power mode memory context. This is optional for normal
> system operation but required to enabled suspend-to-mem usage of Deep
> Sleep state.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>   .../devicetree/bindings/arm/keystone/ti,sci.yaml         | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index 34f5f877d444..ec88aa88a2a0 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -61,6 +61,15 @@ properties:
>     mboxes:
>       minItems: 2
>   
> +  ti,ctx-memory-region:
> +    description:
> +      Phandle to the reserved memory node to be associated with the
> +      ti-sci device, to be used for saving low power context. The
> +      reserved memory node should be a carveout node, and should
> +      be defined as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +    $ref: /schemas/types.yaml#/definitions/string
> +


Why does this have to be yet another reserved carveout region,
should be dynamically allocated.

Andrew


>     ti,system-reboot-controller:
>       description: Determines If system reboot can be triggered by SoC reboot
>       type: boolean
