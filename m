Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAA4F874C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbiDGSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiDGSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:47:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F2194780
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:45:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q26so7457915edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+8rPNKnLfR6UpydjUZMq2BlBGQud00Gc98TA7d84v0=;
        b=mHdbnkYUV7qoA7mUvCkZ6vtiJA4XI765mmOtA0TOn15pRL+yKSEwJ4XYnpTe4umwsM
         9h5refKEhX/Pjvykm/rHItmP9W3l2D2qyuJAap6zJUWbm4GKbWXerwr7ib65FuD8A1d2
         SeK3BFglrn4t6xbV/1SAZMw+cR/xW87vIIQec8zWAKD+/d5U2vVCpaBNPfEm4C/h1Hx8
         xie4qY8xMzntYrH0avFX5ev7sqcF68h71lj6MU0u59Ls116Mu9yXI1QmbBVyP4JQGH+H
         rabreLoJ9CbqyGYCAbyq1NxHmhnL3uTUiwvY6MWyPo7vyJEVjuevqdXHA2mQ/f625RY3
         xzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+8rPNKnLfR6UpydjUZMq2BlBGQud00Gc98TA7d84v0=;
        b=Lq2prJun4h2XnKlfubRc2TY5aiIYEJpLvsItaT2XX2DFQmZVmWuxHu7XAulWAb0g9X
         5s5vXHx7AGb2awR4jKIdvKOr6qLcnQcY/uljo+urKLbxW8rUHTEfjrIMntz6Xn5a161l
         KE/CmO0pkIRy/+rbKD3jpS1Cy++OHU4dxSIdDLX7NfsWgCZschaxJrCu1A3tFX5AlN/6
         j3Fz13KUNGZun3vTohrFN6K2A4AYgLwdJ68pF4R00/9WozsDqHatUjHo46W5jMyIhFFr
         IVzWC9D0U1pkfhYsL+VmgAUybH/4DQ6a6RvfwvIlQWz+HoUQkIDAMmHOlBYX5r7xC/WQ
         DhEw==
X-Gm-Message-State: AOAM530yyT/oc/modZfr2sjg65P1VbtZXeJIWwsJ6PlWrOyXoDbZ8inJ
        mMQRU6+uJ3V73x+jUdrUXk+tmw==
X-Google-Smtp-Source: ABdhPJzzYTjExY7X2ZcWLPtIkr6f2qBYOma5eTVpOhgyjcbA6/L9HysH+GpGTNG8OZp2neDCUzltJw==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr15701582ede.327.1649357109799;
        Thu, 07 Apr 2022 11:45:09 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm9846078edx.97.2022.04.07.11.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:45:09 -0700 (PDT)
Message-ID: <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
Date:   Thu, 7 Apr 2022 20:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Document the compatible for Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add description and board compatible

That's a bit confusing... the subject is for v1.

> 
>  .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> new file mode 100644
> index 000000000000..61225f2d6ce5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#

I propose just pensando.yaml, unless there is going to be hundreds of
different families of SoC from Pensando?

This patch should be after adding the vendor prefix.

Best regards,
Krzysztof
