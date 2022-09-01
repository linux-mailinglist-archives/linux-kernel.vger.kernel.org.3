Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555B5A91B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIAIKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiIAIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:10:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF3A186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:09:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q7so23260513lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fM5UpDaTCSjvdkSI0jA5SowrmiPDlL5FAgH8a3MemNc=;
        b=iq3P1czd9c7an2qaZYMX7o/v1L0mzVZHeDIvRyOQIsRzjQOmXBzXB1LQKX7NF1+3rr
         xVcvZMALabx8+jG+Mf7bUQ6sNZtAEM+nVoTYFQ+Caco1T6sLlxvNKnO6q41iP2Xsm8gJ
         7zyjA07TWdvXhnjj37Xj4UDRPqjZnHHsAe3OXqNQO1zM3tL5OdnVr0R0sePNW6bktK38
         ukBIQ9Hl9eEsyO7ICsUeIi/vb2aeE9gzUZQQ+40yOAxzF8EXfrpLm3N/sKzRSfcS9TPz
         XoOmuHS8NsB0Q0UWknkkVXt7kPQqlnegPVj3pXOTg6ip0lS0t1TGCZqBBuEH2lHc65L+
         bjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fM5UpDaTCSjvdkSI0jA5SowrmiPDlL5FAgH8a3MemNc=;
        b=30seWVdojG1wA7tebb3kjdbohis7MdZFCmIVhjgezrbPCQQQoO+oXR5d3RWYkt7D1G
         67UoLc3YAJYGLVpWchPx+tiDBVfif6QbUbHEj/OmGQeXAJscaNdPfcQ066bdRPKOptwS
         RrY0auvQw/pkKqFO8ekQ9UnHc+/OsgwyOn+6tcai7/ZxyliUi/i7zaYLPRucj+zZWEl3
         vGXM2E4zgUPdUNPKlLq5W8IkPFUjGwggRDynytvB69cwGWvSTademmp4i2TLMiIoVCyR
         tejiP9XZotxdXbM0vhhNIIbaNbttD1l/vbNi8YUIMBu82ImoMjZkww2+JlLyml1I1k/e
         SLUw==
X-Gm-Message-State: ACgBeo2qSEA8XHM/rPnequht1g6nvHnnfqyHDk1y03o1zvTgMf2V+Hsz
        oWH7lApBuzjs04hEgsIsprstpg==
X-Google-Smtp-Source: AA6agR6jWq6HOE1LTVGTeTJTCV2ptJS8BuUV5HsLJmWB/3kIAlo0Ty0u2Rn1JajEPg8N+X2hZ/APvg==
X-Received: by 2002:a05:6512:1293:b0:494:96ee:80c1 with SMTP id u19-20020a056512129300b0049496ee80c1mr1377828lfs.417.1662019787907;
        Thu, 01 Sep 2022 01:09:47 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id g9-20020a19ac09000000b004949c445165sm136099lfc.122.2022.09.01.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:09:46 -0700 (PDT)
Message-ID: <5df7a781-72c6-374f-1517-328ec2740cad@linaro.org>
Date:   Thu, 1 Sep 2022 11:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: mmc: renesas,sdhi: Add iommus property
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220831214314.7794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831214314.7794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On 01/09/2022 00:43, Lad Prabhakar wrote:
> The SDHI blocks on Renesas R-Car and RZ/G2 SoCs make use of IOMMU.
> 
> This patch fixes the below dtbs_check warnings:
> arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb: mmc@ee100000: Unevaluated properties are not allowed ('iommus' was unexpected)
> 	From schema: Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
