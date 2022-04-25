Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF61A50DB66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiDYInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiDYImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:42:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76457305F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:39:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l18so1550904ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QU0P/yAfdxW/XnE/c78tJbGnzMjRbqhHEjthPCSj6z0=;
        b=uKKuhcN10zjj5rrz8Ng44AmhPCp+HTfJhDmESFQEvFhtKVvzut4wXwX+gFe1UkPydE
         DceCNtbPYwS752H65OcgKMSFq2nrvLuXT5AIKDXoJxZdLU2gBud7LG8tK4bemyaHh2Sx
         hVA1nWcqKkeKhybwvOxb2T0YoMX/C8Vmc2c3F4+BnxtF5N0H1uq1mANt8pFZb/h7ICqI
         TCUeSxdE//BYw5wO3XJiCnlOdH/ikEPfvSxZW1QXHf9isRRZszCz/llXTDqdUv2kStAt
         +fv58RIKjAwUx+2fVM4a6VAklPEnGQA0YNTHhTQ+ovu0QglGZvLMVNniUibZFu+h72BI
         w7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QU0P/yAfdxW/XnE/c78tJbGnzMjRbqhHEjthPCSj6z0=;
        b=6VMvS89n2IoYBceC3r23ptQO4VCTFmwTjj04Kw8GQDJji7pnEOxE1VsSKyuTe9VArE
         bvcgAH+vA/AgWoZ8LN+WldfOlvVpSmF6u/Lmtz1ZPS5GyTDHUNzeHK3rwiaSSp6L2vB9
         yGk8PBlxpiZTc5COclirHFt23vb19jEEEq/Yxv9f5+fomJr7o2wZN4fSlGtJ+SCyj85k
         3jX6NrCprZyzELDbxOh1g2ZSzRtJmOpo21goeL40/CHhc3MZI8HAkZ17KczYizE+/vWB
         rDK0eEI1DsnpbpTGCZqzP6IJhliN60No+4DrNpAta9d3rYzx+Xn+v6gGQ6mv2llCiXIN
         ZDkg==
X-Gm-Message-State: AOAM531Z/+w5NwNUd8La8JtEoHsV4BF83mylEKdToeNF5Q9e82vwhOkO
        oob+qFAjHAOdK4ikUvwXd5sWZw==
X-Google-Smtp-Source: ABdhPJyQUNqDfJDw3xSJNGHEn0eczeJmWdHT3pf53j2e9iW+bgV4YOfUt0x2JDGAg5L2QzbRAANsJg==
X-Received: by 2002:a17:907:6e18:b0:6e8:c408:1bfe with SMTP id sd24-20020a1709076e1800b006e8c4081bfemr15347193ejc.467.1650875978503;
        Mon, 25 Apr 2022 01:39:38 -0700 (PDT)
Received: from [192.168.0.240] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o1-20020a170906774100b006efef41ac0dsm3360787ejn.215.2022.04.25.01.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:39:38 -0700 (PDT)
Message-ID: <925fbd8c-d6a7-04a4-c5a3-ae9d84883749@linaro.org>
Date:   Mon, 25 Apr 2022 10:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: apmixedsys: Convert to
 DT schema
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
 <20220424084647.76577-3-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424084647.76577-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 10:46, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert apmixedsys bindings to DT schema format. MT2701, MT7623 and
> MT7629 device trees currently have the syscon compatible without
> it being mentioned in the old DT bindings file which introduces
> dtbs_check errors when converting to DT schema as-is, so
> mediatek,mt2701-apmixedsys and mediatek,mt7629-apmixedsys are placed
> in the last items list with the syscon compatible, and syscon is
> added to the mediatek,mt7623-apmixedsys list.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      | 35 -----------
>  .../bindings/clock/mediatek,apmixedsys.yaml   | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
