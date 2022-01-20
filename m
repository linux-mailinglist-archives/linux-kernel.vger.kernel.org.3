Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0C494B61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359743AbiATKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:08:30 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33530 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiATKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:08:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20KA8AeK089861;
        Thu, 20 Jan 2022 04:08:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642673290;
        bh=P8kUbe5/YmBgjhlSIALuH98FF7Q+bim6i3lUmmhpXw0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OaKUR5QJC36GGclJkX7U1qVq0LmyB5T97mfvnCsYnvLApIwDDcATAnCQfZCM4TY1p
         0j1DR+RA2e0aUw9KOUNBN83JJf0ZxkwB+4McleWspaYySA/abS888S6f/Tuix2rtte
         DZlX7E1Jvq7qsqd3rfdHRnce2tRA/zZ+e8SVrzyA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20KA8Aqw028403
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jan 2022 04:08:10 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 20
 Jan 2022 04:08:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 20 Jan 2022 04:08:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20KA89ip037887;
        Thu, 20 Jan 2022 04:08:10 -0600
Date:   Thu, 20 Jan 2022 15:38:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v3 2/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <20220120100809.mfe2eqkgpjjfpt3c@ti.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
 <20220112100046.68068-3-krzysztof.kozlowski@canonical.com>
 <20220119192758.z3lvlkaeyeiqi73a@ti.com>
 <5f912896-0635-fbe7-4fda-f4cb569190d9@canonical.com>
 <20220120070620.wyeosdstbfcsaplt@ti.com>
 <0c0a22ed-2c4b-374c-4f4c-06afd4e8681d@canonical.com>
 <20220120090002.hg4jmb7q2s25k64y@ti.com>
 <20220120092459.gbaoief77p2tynaf@krzk-bin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220120092459.gbaoief77p2tynaf@krzk-bin>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/22 10:24AM, Krzysztof Kozlowski wrote:
> On Thu, Jan 20, 2022 at 02:30:02PM +0530, Pratyush Yadav wrote:
> > On 20/01/22 08:36AM, Krzysztof Kozlowski wrote:
> > > On 20/01/2022 08:06, Pratyush Yadav wrote:
> > > > On 19/01/22 08:49PM, Krzysztof Kozlowski wrote:
> > > >> On 19/01/2022 20:31, Pratyush Yadav wrote:
> > > >>> On 12/01/22 11:00AM, Krzysztof Kozlowski wrote:
> > > >>>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> > > >>>> controller bindings to DT schema format
> > > >>>>
> > > >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > >>>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > >>>> ---
> > > >>>>  .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
> > > >>>>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
> > > >>>>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
> > > >>>>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
> > > >>>>  MAINTAINERS                                   |   2 +-
> > > >>>>  5 files changed, 224 insertions(+), 123 deletions(-)
> > > >>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > > >>>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
> > > >>>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> > > >>>>
> > > >>>> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > > >>>> new file mode 100644
> > > >>>> index 000000000000..aa5a1f48494b
> > > >>>> --- /dev/null
> > > >>>> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> > > >>>> @@ -0,0 +1,35 @@
> > > >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > >>>> +%YAML 1.2
> > > >>>> +---
> > > >>>> +$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
> > > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >>>> +
> > > >>>> +title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
> > > >>>> +
> > > >>>> +maintainers:
> > > >>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > >>>> +
> > > >>>> +description:
> > > >>>> +  See spi-peripheral-props.yaml for more info.
> > > >>>> +
> > > >>>> +properties:
> > > >>>> +  controller-data:
> > > >>>> +    type: object
> > > >>>> +    additionalProperties: false
> > > >>>> +
> > > >>>> +    properties:
> > > >>>> +      samsung,spi-feedback-delay:
> > > >>>> +        description: |
> > > >>>> +          The sampling phase shift to be applied on the miso line (to account
> > > >>>> +          for any lag in the miso line). Valid values:
> > > >>>> +           - 0: No phase shift.
> > > >>>> +           - 1: 90 degree phase shift sampling.
> > > >>>> +           - 2: 180 degree phase shift sampling.
> > > >>>> +           - 3: 270 degree phase shift sampling.
> > > >>>> +        $ref: /schemas/types.yaml#/definitions/uint32
> > > >>>> +        enum: [0, 1, 2, 3]
> > > >>>> +
> > > >>>> +    required:
> > > >>>> +      - samsung,spi-feedback-delay
> > > >>>
> > > >>> I am not quite sure if this required would work here. Let's say another 
> > > >>> controller also uses a controller-data node, but it contains a different 
> > > >>> set of properties. Won't this cause an error to be raised for that 
> > > >>> controller since this property is not there?
> > > >>
> > > >> The controller-data is Samsung SPI specific (does not exist in any other
> > > >> binding), so why would controller-data get added to a different controller?
> > > > 
> > > > It does not as of now, but the name is fairly generic and some 
> > > > controller in the future might use it. I do not think it is a good idea 
> > > > to list required properties in X-peripheral-props.yaml in general since 
> > > > all those will be collected by spi-peripheral-props.yaml and so will 
> > > > apply to _all_ controllers that reference it.
> > > 
> > > Right, but have in mind this is merely a bindings conversion. These were
> > > made like this long time ago.
> > 
> > Yes, but the bindings infrastructure is not capable of handling these 
> > required properties as of now. So even if your next patch was _not_ 
> > making it optional, I would still say you should drop the "required:". 
> > Even though the property is actually a required one, we currently do not 
> > have the means to express that.
> > 
> > > 
> > > I think we can drop the "required:" entirely with the commit 3/4 which
> > > makes it optional.
> > 
> > I would prefer you never add it in the first place.
> 
> If I understand correctly, you propose to squash next patch making it
> optional to this conversion? I believe there is a value in splitting
> conversion of existing bindings from making changes to the bindings, but
> I don't mind squashing them if that is desired.

No, I don't want you to squash the next patch. I want you to just drop 
the "required:" property and call it a lossy conversion since there is 
no way as of now to express that. In the ideal world you would have kept 
it, and removed it in the next patch.

> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
