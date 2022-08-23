Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8359E733
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244723AbiHWQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbiHWQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:26:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09D119100
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:51:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n24so11373145ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2CjazNJKWxawIRrAspwhPS6UmjSbXOY3YGzYB4E+Plc=;
        b=PPLvIhXyebaOzt5ZAgHRARuDpjE3QXcTZv8jgbNY3zvBxdR5T0KE8RXbL3ML0vLwwB
         utCyLkgq11HaiFzWK0PFjwBSeIkes+bOWEYJ3CaofriBJbCbD9Qhx0lN8j5/GtjKwYYb
         m2K9YR+tgW5R1pBYPlAQJkVPKATZjYOH/NCSBf2RhfXcTCWroHyMVa6FoWqCo3dP3inn
         CjTL8urZ46DjEbFoimD1Pr29eOLhWBHVc5d6dIC6RNja2OZ8AZ2wUPeQ61HgB2f6EfKk
         PETJTyGEGsqOX15mWMZcrVeKFaWM0VtdOfIdJzvG0XJ0xpUUwCviiqf1gi1dVUDnqb17
         Os5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2CjazNJKWxawIRrAspwhPS6UmjSbXOY3YGzYB4E+Plc=;
        b=tfHYSyzE328vfFeU92JPNpv0/qLdIvvbd8sQW0oP72sputJVRV6wkXQnwbKPLN0L5V
         HBMa64BTYXqnRnCR3aryOKHt0C45UqjH8J0XYukmPpn4DG8uyn0EU4cpYRZlcDypwQlR
         QN3zBf5yC6SAA5qzgoJuAH8aAmS7xunoeG9+gF9n29B6FW7qMV/ACw/gO9XlNhYx8zrT
         +u32G8ZX01ulZrL2JjDrZRopwtcLdTGVZhi7bKQdPvx6eaR+fWL2SBgWhMZInY5AR71S
         0Gc/YwU3JzUpI/YsQUmX+XdF4QMRWmik6MIbOkHwZIKgooFz40ik5dDs9j8C3dv0oZRB
         5f2g==
X-Gm-Message-State: ACgBeo200pIhqaCNz88nckAB3kd2K5DFUmQXPerD4AC9oyTdMsZasaQU
        PyGe1VaSq5NYwa6gDI+kpFkZSw==
X-Google-Smtp-Source: AA6agR58Hgvt7z3DYujhjrD2ZnvOcvvv4OymBiELF8Edk9l9F6qF62D2kPrhZN7V9Fcd3PvG3QDT+A==
X-Received: by 2002:a05:651c:b29:b0:261:d351:9dc4 with SMTP id b41-20020a05651c0b2900b00261d3519dc4mr1840748ljr.409.1661259099827;
        Tue, 23 Aug 2022 05:51:39 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id e9-20020a05651236c900b00492e148365fsm1234663lfs.294.2022.08.23.05.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:51:38 -0700 (PDT)
Message-ID: <05f99396-f6e9-a315-7264-c659e3ec507c@linaro.org>
Date:   Tue, 23 Aug 2022 15:51:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/4] dt-bindings: mediatek: modify VDOSYS0 device tree
 Documentations for MT8188
Content-Language: en-US
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        wsd_upstream@mediatek.com, lancelot.wu@mediatek.com
References: <20220822033213.15769-1-nathan.lu@mediatek.com>
 <20220822033213.15769-2-nathan.lu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822033213.15769-2-nathan.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 06:32, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> modify VDOSYS0 device tree Documentations for MT8188.

(...)

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> index 0882ae86e6c4..d0e6c0dd4dfb 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> @@ -30,6 +30,8 @@ properties:
>        - items:
>            - const: mediatek,mt8183-disp-rdma
>        - items:
> +          - enum:
> +              - mediatek,mt8188-disp-rdma
>            - const: mediatek,mt8195-disp-rdma

Why do you change existing bindings?

Best regards,
Krzysztof
