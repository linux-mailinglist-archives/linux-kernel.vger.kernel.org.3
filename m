Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B2568ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiGFQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiGFQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:15:38 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2A217AA2;
        Wed,  6 Jul 2022 09:15:37 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id m13so14500119ioj.0;
        Wed, 06 Jul 2022 09:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqwPeASgq8Ck61KKG7ZQ6xuN6LlxqesyJP6i5jJ+hUE=;
        b=JdfucwQjqVfESUdPuY6mnyzHJ7X1r4TYOzUyO6MlyEvMbU2LnTYQqWH0ZnZcxlKDTG
         VV7u1sWYn8LXUWnnHAzE0tTNqSgZAgeLEoNCw6jJyuHLUcap1ryar1m4/li3DeRJ+0tq
         Tr31igb9KwpK1cu/2f4zQITG8pnmVdKknDl6tb033yHkkH2XU3XtjcixQN0lUI37HBz6
         +w99nBOmbIx6NCQxK31KRGBh9ioLtnHX+yDQ7uZ7mS9U5FVLoq8l0WNU7NgIPkfV62dw
         9VZ2w1NIcsZCWGtdyG8qZJImF7IcAxofJHGorC1PWUEQcg0oNp1aYMCwqTMJ1sfIWOZv
         Yh3A==
X-Gm-Message-State: AJIora+n/JG5vnqfgwAfOVJ+Qq6+hn6vodRIlcrFmNjCnKPjIinGrB1s
        2E5Um45e3tiE3Xh+T7Apkg==
X-Google-Smtp-Source: AGRyM1vq96g0mAOFDc75jPsJy4dBNXMiVi4BB4nOr6vHvSl7ikPvSlrSrva1qAVQ/n29ZcOU2I6uOg==
X-Received: by 2002:a05:6602:2769:b0:675:6995:b22d with SMTP id l9-20020a056602276900b006756995b22dmr20922715ioe.26.1657124136801;
        Wed, 06 Jul 2022 09:15:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d8041000000b00674f9fb1531sm16569634ior.30.2022.07.06.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:15:36 -0700 (PDT)
Received: (nullmailer pid 143646 invoked by uid 1000);
        Wed, 06 Jul 2022 16:15:35 -0000
Date:   Wed, 6 Jul 2022 10:15:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: soc: samsung: exynos-pmu: cleanup
 assigned clocks
Message-ID: <20220706161535.GA143590-robh@kernel.org>
References: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2022 11:50:35 +0200, Krzysztof Kozlowski wrote:
> "assigned-clocks" are not needed in the schema as they come from DT
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
