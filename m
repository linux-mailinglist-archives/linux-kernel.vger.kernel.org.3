Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A384E734C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359074AbiCYM0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359077AbiCYM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:26:02 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD866F482;
        Fri, 25 Mar 2022 05:23:37 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id qa43so14981426ejc.12;
        Fri, 25 Mar 2022 05:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/NCc0lk1b1KTa9++MgfTsBv52wI1b6hGxJC/rOzJ4rY=;
        b=oskGHUqJ7gTyROGGUlbbRmpaUakYoT4+to7sisTF/MNuSufJVXbgz7Cihl3GHOLpK7
         YyLLdkQy+tp+/NKRTDFAzjxbsI2kx13NKHS0j+mS4+vT9MC+Z8V2slY7hHjhLIteG1He
         6suP9M5b4djIaf3hvsqzKfEQjVoC0v/QYXU6SESHeJADiKY2EvVQRtyscXZXB0hR9u7D
         0PbzdOrZ79KINhi9lZ20OzDS8F5FbqUfM22GUycqpDHmq5Nk7/tJGMJYWP9JQlIFe19E
         IBjd4+2nybP9XTlFJUtE0X1ciQR6GSdBPH5JwTzbwLYLSE/SMiSa+4AU/w4zbcBRBB0Q
         S9lQ==
X-Gm-Message-State: AOAM531cOxcA6KRn0/dMXrP6AXFpCrtKsSo2B9+zlTyz8jRfZZD5Jz9Q
        QKUq7cln0H+Cmo1+x0Y3Y9s=
X-Google-Smtp-Source: ABdhPJwpRGQV3zxIvBdun63IodT29z58hwO1LsLsiAE0mHo0OPUnaR+kMlLM3CJVKOokkq1l1l0WOQ==
X-Received: by 2002:a17:906:fc10:b0:6cd:84e:7248 with SMTP id ov16-20020a170906fc1000b006cd084e7248mr11080718ejb.281.1648211016114;
        Fri, 25 Mar 2022 05:23:36 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm2227447ejc.88.2022.03.25.05.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:23:35 -0700 (PDT)
Message-ID: <6bb758d7-7935-1ef3-2574-f4f7f1090b53@kernel.org>
Date:   Fri, 25 Mar 2022 13:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: Document ltrf216a light sensor bindings
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
 <20220325103014.6597-3-shreeya.patel@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325103014.6597-3-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 11:30, Shreeya Patel wrote:
> Add devicetree bindings for ltrf216a ambient light sensor

Full stop.

> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> new file mode 100644
> index 000000000000..275d86a0353a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTRF216A Ambient Light Sensor
> +
> +maintainers:
> +  - Zhigang Shi <Zhigang.Shi@liteon.com>
> +
> +description: |
> +  Ambient sensing with an i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - liteon,ltrf216a
> +      - ltr,ltrf216a

Make it oneOf and then you can add "deprecated" to "ltr", because I
assume it is deprecated since it is using deprecated vendor prefix and
you keep it only because there is a real world device with it.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +                compatible = "ltr,ltrf216a";

Don't use deprecated compatible/vendor prefix.

> +                reg = <0x53>;
> +        };
> +    };
> +...


Best regards,
Krzysztof
