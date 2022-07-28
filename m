Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97C584029
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiG1NjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiG1Ni7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:38:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4252E56
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:38:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a23so2872179lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZqCjcUOaHYpMK3vIolMQW2GaFwrdt4cxHDd7c/52CMQ=;
        b=ewLyss8Nb7G0W+LpmWKJgwSy6iF0SIcra7vXZLYHlcF4iHW3NfGdjfTe6ld3oDseIr
         Gb4DqETHEhjSc80YQTbNzo7IlvpCKFXDpp2R8hEZ22YRKiLIJDrffqAl3ZF2sfmZKird
         TeFU3DFzHI3t0STrHl1iR3u68MOGlkA3Wsdti3tvdLTrIpaDMnfq4A7iIsY5jFzUmuv+
         QJfrHyzXfoaReGhSW4qyj4WpybhFqitGt1ST+2FO4AUNnGhD4o5Jjil3Jk4aZmF8lrzq
         AGje+yNMhAzM7t9Ez6eL7jP+mdzhruFFS7sXIz0GmZCZsqNaByJ9ZBUUjp3KZmVAMW5d
         y3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZqCjcUOaHYpMK3vIolMQW2GaFwrdt4cxHDd7c/52CMQ=;
        b=1sRMJRwOj3JcN0SJVVWc4/kgB7BsBMtK6f0Z8G648qtS9NIFV4yuTqj/iFPPsB41lI
         ZpEPIB+A0DTr6XwnXJycStJmPTRO+EMzWIP5rOFyLLwMDxM6FffBIXpP34JCtss9m7vP
         lXXRg3xwy9FdVhVdBmsKTytcRG+WmOdagXoSd7NNAM6kcxyDbCiaA0X+aeNmbntqDMTg
         lCe7YheQ2YwCPZxyivlYobfX2H7z0cLg0p+ZwjoM3p6KnLutoJ3D4sxCxMxylRB3DFcd
         gveXiA8lCeeqlsTMUKTCYnggfL8LCfasPGTiQsnanrd8REgyG7/3lfmlTPIxTqINYeKW
         n9yQ==
X-Gm-Message-State: AJIora84VsL6cAqFQEzolH7EHMVwwttzgRosGyij6awI7+AimW0uZsjZ
        V7b/kESzoe6QTn1ymhr/8aBLFQ==
X-Google-Smtp-Source: AGRyM1vetL+cadr2N2pQZG8ARVschWpr3CdgphGyJxgv9v1jMyZiff6pTMD5ePZ4SqHqdIwWHJY2xw==
X-Received: by 2002:a05:6512:3a89:b0:48a:b9f5:be1d with SMTP id q9-20020a0565123a8900b0048ab9f5be1dmr2391240lfu.462.1659015536533;
        Thu, 28 Jul 2022 06:38:56 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id c6-20020a19e346000000b0048a82fec50esm197322lfk.305.2022.07.28.06.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:38:56 -0700 (PDT)
Message-ID: <6268ec8c-73f8-6517-c7a7-a6d3ede420ab@linaro.org>
Date:   Thu, 28 Jul 2022 15:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-binding: iio: time: add capture-tiecap.yaml
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728125212.76728-1-jpanis@baylibre.com>
 <20220728125212.76728-2-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728125212.76728-2-jpanis@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 14:52, Julien Panis wrote:
> This commit adds a YAML binding for TI ECAP used in capture operating mode.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../bindings/iio/time/capture-tiecap.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> new file mode 100644
> index 000000000000..5d66df90ba5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/time/capture-tiecap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

Still wrong file name.

Do not ignore comments you received. Either you implement them or you
keep the discussion going.


> +
> +title: Texas Instruments Enhanced Capture (eCAP) Module
> +
> +maintainers:
> +  - Julien Panis <jpanis@baylibre.com>
> +

(...)

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        bus@f0000 {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>;

A bit too many nodes. Just keep one, bus or soc. Look at other examples.


Best regards,
Krzysztof
