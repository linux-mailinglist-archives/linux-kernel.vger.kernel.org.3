Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B062551806D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiECJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiECJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:04:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592CC17ABA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:00:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z19so19091111edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=j4CRxL9e7zZlh4b2P/p8FhUccprH7HKthusA0VBt+bM=;
        b=b/XeqkebSCbXODnHkCi2RqyjzoJ74d6kbuqoZYv3DO3OcaTbv/qeFWTURH2hoJ+2yT
         WGzeYXnB0WS7BN6GFadu3iQPdm9CuNhqzf1vrUZR5xRXgbPmT/eo+2ZSAXWNMcoHGmKz
         0qkBZFq9PrTHigehcs0ZjjD2RXid7n3okw3z/guesffeaexDfAmRuOwafPUHmi2zUAuc
         SlkA7fPdc2WFFX8N8bTNhp90GINnma8Ibkb8q6wZqFYyVz0tuQoBzY/0n8MgEYHKOiZR
         Ao57ZnmzizOktGk10i8wgkowf72pMbtLtMJQi9EwK7WL9ZRMpKzqc6m5b68Xot4jmkCf
         MiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j4CRxL9e7zZlh4b2P/p8FhUccprH7HKthusA0VBt+bM=;
        b=SWUkdgI6kKzbGrgsGzQH9mCWpjA16XEQmWTMkW3zNYYlm3GTOcMLlQeeWJT5edXbh6
         McsYRlEErtVniRBFI9lWhTuRQqTpX7JqtVAkbM6R402VBkr/vSwUNV6/zie1Ld2dh9ZB
         cih1gudnjWXzHioqZhhhXoBX3y4qlff2tjWopmzZWLNRBuSRw8/NoRhwinESUZpf+WAA
         eI8fHxqvjdSY/I04M/P5LYOTjKDnKcof7wU2uXaenX/cxqdW3tK0x7CTuX29QhAUtXdy
         42eWmWm7HAmDoOteT9paVlM94pOaK6Ju/1I5Gm7ovScEnL7/OCLAHQ3Z70bR0bMSW33V
         Du6g==
X-Gm-Message-State: AOAM531F/9KnUafFcFtVYMPo195KQ/ioRF9UDlX3AMDXTmJHogNLkGVv
        Y+cJ9pMSkOhLy53M5xIzr/OAEg==
X-Google-Smtp-Source: ABdhPJyX/ElrrxMX0/REfY3yLwKmEzVBenlQvKtFB9erYnqq+TRCxOFksTz3abIbzpybFPoFGhbplA==
X-Received: by 2002:a05:6402:2363:b0:425:bc13:4c8b with SMTP id a3-20020a056402236300b00425bc134c8bmr17084825eda.140.1651568422920;
        Tue, 03 May 2022 02:00:22 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jy10-20020a170907762a00b006f3ef214dc2sm4415617ejc.40.2022.05.03.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:00:22 -0700 (PDT)
Message-ID: <215254be-da27-2f3f-fa07-7520b38eff5c@linaro.org>
Date:   Tue, 3 May 2022 11:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 2/2] dt-bindings:thermal: Add Sunplus schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1651543731.git.lhjeff911@gmail.com>
 <e9f65ca9a2b3205b91210398d743415f6c799d90.1651543731.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9f65ca9a2b3205b91210398d743415f6c799d90.1651543731.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 04:13, Li-hao Kuo wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v8:
>  - Modify yaml file.
>    modify the setting compatible
>  - Change yaml file name.
>  - Modify driver.
>    mosdify and simply the nvmem setting and remove valiable
> 
>  .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
> new file mode 100644
> index 0000000..1ecf6f6
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
> +      - sunplus,thermal

This is a very surprising change and was never requested by me or other
reviewers. It is also not correct. Previous compatible was correct.

Best regards,
Krzysztof
