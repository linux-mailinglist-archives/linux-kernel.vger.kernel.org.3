Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48EB588F22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiHCPLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiHCPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:11:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F1E105;
        Wed,  3 Aug 2022 08:11:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 273FBU04064031;
        Wed, 3 Aug 2022 10:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659539490;
        bh=peLk7igHpDJqfv6EMWNdPZHTWycmcc3LsA19pplDeQE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=f0eDlCIB2spYCffXhw7qTXkkXpFUl1v2u2jtBUQBWQLwCJ59BchBhByJQe/XJBT4t
         E7wNe7lypugCCXSjDoi7z/M/nP30FKv8nciQMcb1czYFc+DQPmMeGquRIwxer3BwZK
         24P3taMPVx6EPbSUfgZ0d0ZR3QYxwAb4sxDmiJbg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 273FBUAI079389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Aug 2022 10:11:30 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 3
 Aug 2022 10:11:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 3 Aug 2022 10:11:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 273FBTMV002223;
        Wed, 3 Aug 2022 10:11:29 -0500
Date:   Wed, 3 Aug 2022 10:11:27 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Message-ID: <20220803151127.23tmkvobrh5so46v@uda0497096>
References: <20220802214811.29033-1-j-luthra@ti.com>
 <7effc23b-b61a-9887-3875-d102b8fa270e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7effc23b-b61a-9887-3875-d102b8fa270e@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review.

On 08:29-20220803, Krzysztof Kozlowski wrote:
> On 02/08/2022 23:48, Jai Luthra wrote:
> > Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
> > 
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml b/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml
> > new file mode 100644
> > index 000000000000..6efb1d459543
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/tlv320aic3x.yaml#
> 
> Filename with vendor prefix, so ti,tlv320aic3x.yaml
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments TLV320AIC3x Codec Device Tree Bindings
> 
> s/Device Tree Bindings//
> 
> > +
> > +maintainers:
> > +  - Jai Luthra <j-luthra@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,tlv320aic3x
> > +      - ti,tlv320aic33
> > +      - ti,tlv320aic3007
> > +      - ti,tlv320aic3106
> > +      - ti,tlv320aic3104
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: i2c slave address
> 
> Skip description.
> 
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specification for the active low RESET input.
> > +
> > +  ai3x-gpio-func:
> > +    description: AIC3X_GPIO1 & AIC3X_GPIO2 Functionality
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minItems: 3
> 
> uint32-array. Old bindings say about two items only. Mention any changes
> to binding in cover letter.

My bad, that should still be 2 items.

> 
> > +    maxItems: 3
> > +
> 
> You lost gpio-reset property. Also not explained in commit msg.
> 
> > +  ai3x-micbias-vg:
> > +    description: MicBias required voltage. If node is omitted then MicBias is powered down.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    oneOf:
> > +      - const: 1
> > +        description: MICBIAS output is powered to 2.0V.
> > +      - const: 2
> > +        description: MICBIAS output is powered to 2.5V.
> > +      - const: 3
> > +        description: MICBIAS output is connected to AVDD.
> > +
> > +  ai3x-ocmv:
> > +    description: Output Common-Mode Voltage selection.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    oneOf:
> > +      - const: 0
> > +        description: 1.35V
> > +      - const: 1
> > +        description: 1.5V
> > +      - const: 2
> > +        description: 1.65V
> > +      - const: 3
> > +        description: 1.8V
> > +
> > +  AVDD-supply:
> > +    description: Analog DAC voltage.
> 
> New properties?
> 

These regulator properties were mentioned in the txt as well.

> > +
> > +  IOVDD-supply:
> > +    description: I/O voltage.
> > +
> > +  DRVDD-supply:
> > +    description: ADC analog and output driver voltage.
> > +
> > +  DVDD-supply:
> > +    description: Digital core voltage.
> > +
> > +  '#sound-dai-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +#The pins can be used in referring sound node's audio-routing property.
> > +
> > +#CODEC output pins:
> > +  # LLOUT
> > +  # RLOUT
> > +  # MONO_LOUT
> > +  # HPLOUT
> > +  # HPROUT
> > +  # HPLCOM
> > +  # HPRCOM
> > +
> > +#CODEC input pins for TLV320AIC3104:
> > +  # MIC2L
> > +  # MIC2R
> > +  # LINE1L
> > +  # LINE1R
> > +
> > +#CODEC input pins for other compatible codecs:
> > +  # MIC3L
> > +  # MIC3R
> > +  # LINE1L
> > +  # LINE2L
> > +  # LINE1R
> > +  # LINE2R
> 
> All this goes to top level description.
> 
> 
> Best regards,
> Krzysztof

Fixed rest of the comments in v2.

Thanks,
Jai
