Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AD572F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiGMHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGMHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:50:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20568DB2ED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:50:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so17774147lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NYflSyzJGWVmdo/FfUNnh/uWyzXsbzDiU5Kfi3yNT/s=;
        b=T8PSBsSZ/kqgVoJWl1fOj4dHcsCxbJGi1zOLnZJzpdNI3O5NOJwql6sobP0r3Z1OQd
         oFnUu6Vr5VpQoaF5ZA2ltfQIhfhw0KOj0IC7ZY6BXomA+yv50aY2SHmUkNJi1T7t1iuK
         clsGR5WG4tBsWwsBQDdKv9WX3smAnXnZ1/NdCLShi1x1Aztc3iwzPdK2r7QbfLOgJ8SY
         Bsctvhnv3CXHSZT1zMF9vzwZ8fBXuRXU0B0dcBY8wsCLgCTsR3y5JEc9lYDqF74bBdJU
         ErJWwbjZs6rYngrmSRBQggbaEzWhRoPB6mj3QhoDpZVLZfjP5SK3mLs9nwpO/54HNeDt
         rd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NYflSyzJGWVmdo/FfUNnh/uWyzXsbzDiU5Kfi3yNT/s=;
        b=dELbrYEf7Azv4dHCsho7DkFMRxjQP764hnRpF2bRPYLAmv5IlKX/oxttBQQCGxkUOL
         vfGsGVMOnDN/gWR6r5Ol8e2CgVzp/h3spEuJ+eRW01k1dqYplNTSytM1gRJWNaWQilG7
         hMJfb96XsdGw5Fg+pr9H9w83ePlcIuerP1jMC6HQPetnvABY1ny2vsUS9BHfN17kWoYe
         7TwipF3huGqgmZacBghp+aetYqAgzZQe6493zO0zvITlBjn4MeKep41er2U21uKaF4KA
         DEYE18/700kM4x1hZXcDhuFZP4L+JIlfQrwD+5/YFARL56Y+Ti6nQIy+YNrGxtDXJxbO
         dZTw==
X-Gm-Message-State: AJIora+C0Il1NeoOUvAtDpa9FEcizJ8GHwI82CALtemH+AVFvKim0VCM
        KjKahSmaK2t6Op6c4Alm0CjFyA==
X-Google-Smtp-Source: AGRyM1uhLHRvLlcQa7QUDMxWa/Z5td7UZ9SmBf3XHNCP14Y3Qepv291ZjDvXremjm/dWmogsSMB6og==
X-Received: by 2002:a05:6512:150e:b0:481:60af:a5a5 with SMTP id bq14-20020a056512150e00b0048160afa5a5mr1161136lfb.524.1657698650422;
        Wed, 13 Jul 2022 00:50:50 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 3-20020a2e0503000000b0025d39993856sm2955769ljf.127.2022.07.13.00.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:50:50 -0700 (PDT)
Message-ID: <27cd6e98-50c6-14b2-aec0-b4bbd49a9da8@linaro.org>
Date:   Wed, 13 Jul 2022 09:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 2/2] dt-bindings: thermal: Add Sunplus schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com
References: <cover.1654660009.git.lhjeff911@gmail.com>
 <5d2c95959dd6efaa204bc80ca9b24a8be9293d2f.1654660009.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5d2c95959dd6efaa204bc80ca9b24a8be9293d2f.1654660009.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 09:30, Li-hao Kuo wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v10:
>  - Fix wrong indentation.
>  - Change the setting of compatible.
>  - Mosdify the setting of remove funciton.
> 
>  .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> new file mode 100644
> index 0000000..52094da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Thermal controller
> +
> +maintainers:
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: calib
> +
> +required:
> +  - compatible
> +  - reg
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal@9c000280 {
> +        compatible = "sunplus,sp7021-thermal";
> +        reg = <0x9c000280 0xc>;
> +        nvmem-cells = <&calib>;
> +        nvmem-cell-names = "calib";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23bde07..a8c44eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19107,6 +19107,7 @@ SUNPLUS THERMAL DRIVER
>  M:	Li-hao Kuo <lhjeff911@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml

Not a correct path anymore.

Around v7 I asked to name the file either sunplus,thermal.yaml or
sunplus,sp7021-thermal.yaml, but actually that was my mistake a bit
which I learnt later. The only recommended name is the latter, based on
compatible, so:
sunplus,sp7021-thermal.yaml

Please name the bindings "sunplus,sp7021-thermal.yaml", change the $id
and maintainers entry to new filename.

Best regards,
Krzysztof
