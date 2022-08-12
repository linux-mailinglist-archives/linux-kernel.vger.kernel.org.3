Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859EB590FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiHLKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHLKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:55:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB35DF44
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:55:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a9so818368lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=aaNl+ijT1LjwDfHOCxRP8aD4iO5jOkHMfS/PbY8NG5o=;
        b=vxyPj+cWREDjzPfHlMEI4ETGGS++oBpkkT/Z8ItZIeGbY/auOJ9VffjXi3vILLOXOD
         Mo4fOrJX19n83rdKW55y3kMoxJXPsW3VNDMufG/BYD9YgGQXmwHnmVezKLYcSGjilxPr
         uTtUnjgaFRPTeCuer2xpXcUcR4Iw1HiDwKfM5sin/m7ISRpv1gn7LOs3dkOCFjorV73C
         ICUKRGn9+UdbtjCNfViIond8iPgwL+QYjeZNWrAKBWo1QSEULnQppVROKOfORzgCTplG
         9Igbk9lj21TDOx4yUz2dBCthY4WnoQWvta6ymrNWlz2t6jYvzUu865fqNAfTrbZsVquO
         Ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=aaNl+ijT1LjwDfHOCxRP8aD4iO5jOkHMfS/PbY8NG5o=;
        b=q5I/rARL56lmo9cqrAYwOZh8xoBlYBYKxqZFDjKTrtgxU5nXcvUjS2jcPyVxenGpNT
         fnN6g3IhEdYS4BHY+2pZuPpOuQ9JfWsprZLI6X8oItXJC1djniVZn/55TwMrCTzZmfCe
         tw5rYkWAmt9HN8Fl3iSwebJhOix3a6jZ5QT1gybX5lovhyc8nDvgpmTnmwOH3V/CYtaC
         0+oVtU+SATkXSGv/Yt49BqhklMNw9ztW7GGeXU4eQoFKKAJ2USARzfkqUvebJPCoxMEF
         yeMAai4ZxBuUzi08xeChghiZy7wSKVxNR33EWaQCJus07MZsyvfD05+yAlrcV4JJM6eF
         qhmg==
X-Gm-Message-State: ACgBeo3y+XXA7nixnyHmtvSsizNjO2XM1j7xVjRRgOyPKGWvkkZvutie
        TjJh2BfItlKxUy/xDW0YVUvrLQ==
X-Google-Smtp-Source: AA6agR6nxVAvP/ztJ9CWdcMb5byQai/Ut0mSg3vYquS5IM5ugPUQ8jhyJXPddJBUAd9gQCzcpJbNfA==
X-Received: by 2002:a05:6512:2313:b0:48a:e615:289b with SMTP id o19-20020a056512231300b0048ae615289bmr1069198lfu.201.1660301716964;
        Fri, 12 Aug 2022 03:55:16 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l9-20020a056512110900b0048af3154456sm173419lfg.146.2022.08.12.03.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:55:16 -0700 (PDT)
Message-ID: <cbe761af-5011-83a2-0509-2b3c4fe0a79c@linaro.org>
Date:   Fri, 12 Aug 2022 13:55:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/1] regulator: dt-bindings: mediatek: add mt6366
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220812092901.6429-1-zhiyong.tao@mediatek.com>
 <20220812092901.6429-2-zhiyong.tao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812092901.6429-2-zhiyong.tao@mediatek.com>
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

On 12/08/2022 12:29, Zhiyong Tao wrote:
> Add mt6366 regulator document
> 

> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6366-regulator
> +
> +  regulators:
> +    type: object
> +    description: List of regulators and its properties
> +
> +    patternProperties:
> +      "^buck-v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
> +        type: object
> +        $ref: regulator.yaml#

You miss unevaluatedProperties in most of the places.


Best regards,
Krzysztof
