Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13D568ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiGFQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiGFQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:16:46 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8080275D3;
        Wed,  6 Jul 2022 09:16:44 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r133so14460469iod.3;
        Wed, 06 Jul 2022 09:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzyTkDSXajruLqTE2xOuZnQbOGvVcuO7PmEw4yPs+sE=;
        b=UcKAlat+LBqkG3IHsZgH4mwzQqhzVEZ/dD+qSXAz4vwBhobkSrzn+/wpRhOw3nVzCZ
         IvRnmQnIrOMH/lo1HXZ2N7+MrZZa5v7LOaUfnaaKy+TnqttBf+RkVLgMSlKzkjrwbO64
         S0SpLEarRSGgQpJCiFlk7noHbxFUTQ7JQCb1SChr6Fftrb7yLZIa/xSn3i7ma2/Yvm6p
         ajOnVvLGKJ9izTfCRqcD9PedQo6fnHm/765cb+aZ6iJhwB8bH36q09IUZJpeCT2+ypoi
         EHqURO3fuvCDGT7sQOXrbeaO4pxua/FnmlcEHZgtdnh5tCGhS/Y3g/aUz8c5Aq7Rld4T
         waGg==
X-Gm-Message-State: AJIora+GJpoxV8aY0eCJv1qzJ0pjpFfv/GTHUx9KhQbHISk9OFotCLGy
        m9XetLg+LpVIJbzb/e/gNIClw/Ebgg==
X-Google-Smtp-Source: AGRyM1uDa4GL6K2rquloBK7cKl0fYOjHzpTx5KP1xd8XsypkXLrzvI4+d5FGPx37gauwr0rhO7or+Q==
X-Received: by 2002:a05:6638:2684:b0:33b:afc4:298d with SMTP id o4-20020a056638268400b0033bafc4298dmr26482105jat.49.1657124203923;
        Wed, 06 Jul 2022 09:16:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f11-20020a92cb4b000000b002dc1e44860fsm2560161ilq.87.2022.07.06.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:16:43 -0700 (PDT)
Received: (nullmailer pid 145417 invoked by uid 1000);
        Wed, 06 Jul 2022 16:16:42 -0000
Date:   Wed, 6 Jul 2022 10:16:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 3/3] dt-bindings: soc: samsung: exynos-pmu: add
 reboot-mode
Message-ID: <20220706161642.GA145360-robh@kernel.org>
References: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
 <20220706095037.78542-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706095037.78542-3-krzysztof.kozlowski@linaro.org>
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

On Wed, 06 Jul 2022 11:50:37 +0200, Krzysztof Kozlowski wrote:
> ExynosAutov9 gained a reboot-mode node, so document the property to fix
> warning:
> 
>   exynosautov9-sadk.dtb: system-controller@10460000: 'reboot-mode' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soc/samsung/exynos-pmu.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
