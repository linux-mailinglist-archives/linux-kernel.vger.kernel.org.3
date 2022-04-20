Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF86B50818E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbiDTHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbiDTHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:01:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08336176
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:58:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u15so1481492ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=33oNGjsyzbbJJxqb3bfQQZjjh/w5lxTRnomNHvvUqU4=;
        b=ZcC3aoCsfQbOoc1cErTSMczgGpJa0Pbv34AteNKyB5gmUZl4i7240D1aYuTMRQVG/z
         um5HwzvgMVcTOFhmTEjQ4xxyA2IMEJitboFIgrfnIB5EmSv7/+rbBO6T8UaboHOPLjKz
         jS+Ps25YDbbdakYUitxzDcQWXNta53T96IYueZs3dY2AXGRz8hc9DlHvX6nDDQc2Hzuf
         YwPfbqLHEKQXozYsyyfMrJcbIQEM0Qtdn/aCxeRoO4aD+4r7EGEWSzj0SFWpzg4NuFfT
         SDsVkQ+SVv1wjbZFfUunqaVo/8oT9cnC8F3F92750/D1hm+Z/7dTj+DU6HqlLu3/pr6N
         MmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=33oNGjsyzbbJJxqb3bfQQZjjh/w5lxTRnomNHvvUqU4=;
        b=phloS07DpgrvGkaqVUJ8nXhoM/LTHWneE11Njubs9fC1koewPAb7BPdI5LpQgEh6qJ
         k8TiwmAxgMiSP7/BJdsj2MdMszuLGidarZ3OKiDhJz0DuBdCt0UiWTfp5SJ04t2oxgCN
         sgZQFd5jid+yFUHrScs5hJIJCaBjPjx7QNtwNwfPJvjhT7aba/afF6aJtgA6SyAeQoKk
         mVpn8VWkC45EbUZQXpxqWY/JZHQdQ3nVTAeUvKlll3P2PUPS9rSWZoEkbCQ1WqRfhhmB
         pQSCmRg8wnRe7hKAgtTmMDPf+TN6Z9T2xvZngW/3CcqV/u/CS9fH/BMs5XQX3Mzlyw/H
         1yRw==
X-Gm-Message-State: AOAM533mrF8lPl6XhcVyIkHlWTftT7yQ848h6jth4wKih0Dpfuj2V301
        ViheqX+/EZ4rqyhEwnczuCMa6g==
X-Google-Smtp-Source: ABdhPJz+YLZgxsZ8woz0si2sCw225f3/SoHbprqyRXC43LXutjFR1DWY4/pGsH9BeF8nQjAKechCWw==
X-Received: by 2002:a17:906:3707:b0:6e8:6bfe:da0e with SMTP id d7-20020a170906370700b006e86bfeda0emr17364717ejc.78.1650437901968;
        Tue, 19 Apr 2022 23:58:21 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709061b5800b006e88dfea127sm6375729ejg.3.2022.04.19.23.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 23:58:21 -0700 (PDT)
Message-ID: <4971b5f4-9a4f-40c9-ac32-a62b2e655544@linaro.org>
Date:   Wed, 20 Apr 2022 08:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2 v3] dt-bindings: dspi: added for semtech sx1301
Content-Language: en-US
To:     Changming Huang <jerry.huang@nxp.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20220420035045.33940-1-jerry.huang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420035045.33940-1-jerry.huang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 05:50, Changming Huang wrote:
> Add DT Binding doc for semtech sx1301
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v3:
>   - add the dt-bindings
> 
>  .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> new file mode 100644
> index 000000000000..f65fb5809218
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/semtech,sx1301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech sx1301 devicetree bindings

Remove "devicetree bindings" and add instead short description (type) of
the device (SPI controller?).

> +
> +allOf:
> +  - $ref: "spi-controller.yaml"

allOf after maintainers.

> +
> +maintainers:
> +  - Changming Huang <jerry.huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: semtech,sx1301
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  fsl,spi-cs-sck-delay: true
> +
> +  fsl,spi-sck-cs-delay: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mikrobus@0 {

Isn't MikroBUS more than SPI, but you implement here only it's part? If
so, name it just "spi".


Best regards,
Krzysztof
