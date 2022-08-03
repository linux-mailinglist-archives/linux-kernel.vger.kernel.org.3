Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980C58879B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiHCGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiHCGzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:55:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F4B859
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:55:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q7so17897276ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S4Cm3Xm7ps86QO+wm8sMu2JPYe6mqNw8F3bEMQJUUhc=;
        b=O7q9zOMb+keix+65PNkbZrdMdNg8RruiIN6i52bJ3/4G61fat0QiJGihLnJBYb6rJe
         JWLeQ53j3H5kjZv+9dsR/1/CtI+3O7jm2y1o4vLT6j/eTIidl8SKFoeTN6E68/metBV+
         k8o9ZUPTqRaDEWCXCwRUunKub/t+fTDIxvVNQRvJIIp9cDOfz8vpWPuBPBDRBN5X2eZl
         ntZ5aSlzBv00BVHlE0EUlYMBVYhayrKg8PZM04hryugMFw1z5w/BJ+F2lD/BAFiqjzC2
         //qDr2s2bex7w//+mom1Q1MseoxDP6T89LFAQeMK/V1nv9lj/Qm79cUECHgXAGgCS5kz
         CxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S4Cm3Xm7ps86QO+wm8sMu2JPYe6mqNw8F3bEMQJUUhc=;
        b=4O8LsCdKFVzOV5T7sm0a7K9kcBcKkglAWhj7pVxgWgtjQVQGVy71ZjuQdgwUrhiGsH
         ZmUfZhp8V2qhsMmyjEYCEL1uhnIurdD7EoujxYlOOvG9TGuT6KPsj2jV0LsaHUrorFuf
         Q7xtynRgkCxFuRPwN5vuBmSLuimfgK41tLfrWbGsBnLrWgyZY9ug4AHnm/mbWYlIe0cA
         izWBkpssZom1old9KnSWamYc0VVNiNOER/7IBUYGZhbou32Oik+m8Ev0iQwhVJlLk4Ko
         jdAI16buzrPvS+jiXw7XPmf7vg4z5vLoTcTZ/ErSE5uO+uvk+iJIM8ACcvgn5sEpTcvN
         dXGQ==
X-Gm-Message-State: AJIora9EXLIpEnLZxx/eC9Ul8dVg6s0BsHHETY+zTVxlUPu4swEXIFJ7
        +J7NUyIuAWyOJvTPj8srLZkFRw==
X-Google-Smtp-Source: AGRyM1vEph3Ifvfbkg3uzqoCf0YQ14siBIj60BQr+NpQKcVngPKmsRZhSFDXn+Ia8zp9GK8enrJ02A==
X-Received: by 2002:a05:651c:2208:b0:25d:ef2a:f092 with SMTP id y8-20020a05651c220800b0025def2af092mr8199475ljq.84.1659509746457;
        Tue, 02 Aug 2022 23:55:46 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id f12-20020a05651c03cc00b0025e4474df71sm1457524ljp.135.2022.08.02.23.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:55:45 -0700 (PDT)
Message-ID: <297ddf1f-8ddc-902c-ff3d-06b9d19c6a7b@linaro.org>
Date:   Wed, 3 Aug 2022 08:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add IBM OCC bindings
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org
References: <20220802194656.240564-1-eajames@linux.ibm.com>
 <20220802194656.240564-2-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802194656.240564-2-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 21:46, Eddie James wrote:
> These bindings describe the POWER processor On Chip Controller accessed
> from a service processor or baseboard management controller (BMC).
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/hwmon/ibm,occ-hmwon.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
> new file mode 100644
> index 000000000000..8f8c3b8d7129
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ibm,occ-hwmon.yaml#

typo here

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM On-Chip Controller (OCC) accessed from a service processor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |
> +  This binding describes a POWER processor On-Chip Controller (OCC)

s/This binding describes a//
But instead describe the hardware. What is the OCC?

> +  accessed from a service processor or baseboard management controller
> +  (BMC).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,p9-occ-hwmon
> +      - ibm,p10-occ-hwmon
> +
> +  ibm,inactive-on-init:
> +    description: This property describes whether or not the OCC should
> +      be marked as active during device initialization. The alternative
> +      is for user space to mark the device active based on higher level
> +      communications between the BMC and the host processor.

I find the combination property name with this description confusing. It
sounds like init of OCC and somehow it should be inactive? I assume if
you initialize device, it is active. Or maybe the "init" is of something
else? What is more, non-negation is easier to understand, so rather
"ibm,active-on-boot" (or something like that).

> +    type: boolean
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    occ-hmwon {

just "hwmon"

> +        compatible = "ibm,p9-occ-hwmon";
> +        ibm,inactive-on-init;
> +    };


Best regards,
Krzysztof
