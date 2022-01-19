Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D444940E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357013AbiASTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:31:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38692 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiASTbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:31:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20JJV6h2101100;
        Wed, 19 Jan 2022 13:31:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642620666;
        bh=pAX3RUzQNrm9de2Y67alfQtOMKhA0KGOzJ3AHk2k0IM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N/uIA8lE28swphABRaYLxIUNsobla5F2oUYYHzrnKBoRtW+WxJwckI82XVe84Km7p
         G0hsauG5ydbeY5qjrd3uyvnJLAEm+dAYh5XP/us5f1lxaFzWfYpblJnbq2c2GNwreW
         28Gq/jWuZdiBWlA1qVi3OgXTinfr42tcTR1x5a2c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20JJV61W125700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jan 2022 13:31:06 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 19
 Jan 2022 13:31:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 19 Jan 2022 13:31:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20JJV52b056260;
        Wed, 19 Jan 2022 13:31:06 -0600
Date:   Thu, 20 Jan 2022 01:01:05 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v3 2/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <20220119192758.z3lvlkaeyeiqi73a@ti.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
 <20220112100046.68068-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220112100046.68068-3-krzysztof.kozlowski@canonical.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/22 11:00AM, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
>  MAINTAINERS                                   |   2 +-
>  5 files changed, 224 insertions(+), 123 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> new file mode 100644
> index 000000000000..aa5a1f48494b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description:
> +  See spi-peripheral-props.yaml for more info.
> +
> +properties:
> +  controller-data:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      samsung,spi-feedback-delay:
> +        description: |
> +          The sampling phase shift to be applied on the miso line (to account
> +          for any lag in the miso line). Valid values:
> +           - 0: No phase shift.
> +           - 1: 90 degree phase shift sampling.
> +           - 2: 180 degree phase shift sampling.
> +           - 3: 270 degree phase shift sampling.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +
> +    required:
> +      - samsung,spi-feedback-delay

I am not quite sure if this required would work here. Let's say another 
controller also uses a controller-data node, but it contains a different 
set of properties. Won't this cause an error to be raised for that 
controller since this property is not there?

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
