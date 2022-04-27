Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72C5110D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357978AbiD0GHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiD0GHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:07:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9D580F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:04:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so1228730ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=27SXQOPVAdANNQCQJ4C3V7A5t8g68xh0r46tyDVmRxQ=;
        b=Y+ClKEHd1wAog5IoYY3pf0agZCvamFvLJJRWh+63FD3Va4L/gV5bKPrXggA6CVBuc0
         CUQpuZ36BefavI40ZgfscqtRl/Os2+FhhjeQVYA7NnKj5xae7sGtbcehw/F6Tw8T4lL6
         6CBOoOB+cjLA8LFuMLUB+jhkY9WedHACo5PHIo71xio/tehD9/sqYoT+SlSgHkPGoNo0
         gAhj4jX0hbwalsFgWOtuyo3tMCG9qAqZ/BDKH2bWApnpvHMqShdaET0Pa91yiPbIGEQQ
         J95OijOLMO/iV+v1ne9spHnUForaXEpWnY/U6XoLH3DV1IYtXkJClbCiYZS9NHVt+sbK
         STww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=27SXQOPVAdANNQCQJ4C3V7A5t8g68xh0r46tyDVmRxQ=;
        b=ZGt5/wHo6rsvkGzBQGmeJdG0rPhajv79ijB2eYfFa7/wpebqPZLs4sgT3fucmbqkMx
         A756g3dKvk1750LQX3f6FC27pJc7HTAyCizlxW4j8kRRkX5B+/lqu9p2L3tnN8LZExTP
         0+QbCxW0MV1kZQrLEJnNR+oY/7P9Tep432/GqZbQ9Y7BznVUVnrMQC/iI7Mc5O9u70FV
         5FeSO1lBQR4otiRuyR22Yylo38QyV2IAl1a+XCiD8D+isPHw2uoUOzMucYxNBswUrevi
         hlxMpWxIPMATKHd7xbuGq26QCDopLYXhDUIaypC6aPkvoJ/lElBwg0mwtC03s0z2i+P3
         Jzlg==
X-Gm-Message-State: AOAM530VA5KDscm75gDrc6ZmPuPyFANxh//ZP+bLKckR7OzIoRb57R/L
        CTEVmswkpMS5YfruKgB4Nqi3lw==
X-Google-Smtp-Source: ABdhPJwWDR9IhrmVQfKp1JkwSdivR59TpiJ9LC3ukLWrvDIX/tdF3PY94O0nR9+ygi9bDJsFjar41A==
X-Received: by 2002:a17:907:8a0b:b0:6f3:bbab:4ad1 with SMTP id sc11-20020a1709078a0b00b006f3bbab4ad1mr4453194ejc.135.1651039471996;
        Tue, 26 Apr 2022 23:04:31 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l3-20020aa7cac3000000b00422c961c8c9sm7564792edt.78.2022.04.26.23.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 23:04:31 -0700 (PDT)
Message-ID: <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
Date:   Wed, 27 Apr 2022 08:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <20220427010154.29749-2-zev@bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427010154.29749-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 03:01, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

I already reviewed it so I guess you did not include the tag because of
significant changes?

> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> new file mode 100644
> index 000000000000..418477374fdb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct6775.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT6775 and compatible Super I/O chips
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct6106
> +      - nuvoton,nct6116
> +      - nuvoton,nct6775
> +      - nuvoton,nct6776
> +      - nuvoton,nct6779
> +      - nuvoton,nct6791
> +      - nuvoton,nct6792
> +      - nuvoton,nct6793
> +      - nuvoton,nct6795
> +      - nuvoton,nct6796
> +      - nuvoton,nct6797
> +      - nuvoton,nct6798
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,tsi-channel-mask:
> +    description:
> +      Bitmask indicating which TSI temperature sensor channels are
> +      active.  LSB is TSI0, bit 1 is TSI1, etc.

Need a type/ref.

> +    maximum: 0xff
> +    default: 0

Since by default it is disabled, doesn't it make a required property?
IOW, if you add a node without this mask, will the device operate
properly and usefully?




Best regards,
Krzysztof
