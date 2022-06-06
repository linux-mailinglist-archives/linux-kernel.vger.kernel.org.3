Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDD53EE4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiFFTFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiFFTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:05:01 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C7A476;
        Mon,  6 Jun 2022 12:05:00 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id 134so6924919iou.12;
        Mon, 06 Jun 2022 12:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFI0oirldONXh9sCQOu3BipVplhmcMS1DY1jebePK3s=;
        b=0B3YdoGK4+CsvcI6uBS2YZIUC6ttxnSkcpKVF+kJPArHLfZDrhfAnDrcxbjSZHrYln
         JiJrvFWjX96qWXOY541yP9cNh9e8huHnmFa2lp9lqfT6sQdf6H7uNXkmYHTLtMD7Ca8z
         h2b08LP/GunIxG+/zN4NA2mD4V3gmUrGBE5a0weU8/yJ7w8k/XhTSJ4HIGwwLJRoQ3So
         KurGQ2VFvhCAo0hnwfROxllqCGDgnjZLJEuhgEEmi05tEk2dk8XMWpo2vTXEfBhjxBph
         gWOhXulY4jS67CCp7geyTgTC4dlpU+fgOpOMj0Ophy0fk/oqqAUV1t8P06qn8UIa6aHl
         Cl8Q==
X-Gm-Message-State: AOAM533SJTGfVTJHB6M9Qp5dpkMSCXlwcYOKyaWFpI9VRaHdCXGimoSC
        8/boW/F6tLDridlxoQDACw==
X-Google-Smtp-Source: ABdhPJxRWFIPW7RIod5NihetwQ+IN8G94Y2cNKYU2fnYdDfIrkQl366NcSIQ/u1nUxBSw9gOoqK6jA==
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id r14-20020a0566022b8e00b005e974e76b01mr12354222iov.127.1654542299526;
        Mon, 06 Jun 2022 12:04:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f12-20020a02a04c000000b0032e5205f4e7sm5854760jah.4.2022.06.06.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:04:59 -0700 (PDT)
Received: (nullmailer pid 1088702 invoked by uid 1000);
        Mon, 06 Jun 2022 19:04:57 -0000
Date:   Mon, 6 Jun 2022 14:04:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc: samsung,exynos-dw-mshc:
 document Exynos5420 SMU
Message-ID: <20220606190457.GA1088577-robh@kernel.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
 <20220605163710.144210-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605163710.144210-5-krzysztof.kozlowski@linaro.org>
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

On Sun, 05 Jun 2022 18:37:10 +0200, Krzysztof Kozlowski wrote:
> Document the compatible for Samsung Exynos5420 SoC Synopsys Designware
> MSHC with SMU, already used in DTS and driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
