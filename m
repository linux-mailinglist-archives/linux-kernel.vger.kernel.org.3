Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259053DEA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbiFEWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiFEWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:33:05 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F682B187;
        Sun,  5 Jun 2022 15:33:04 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id j8so6561758qtn.13;
        Sun, 05 Jun 2022 15:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5FUZEWgXid+UZNLuv9VmImCB9UvWlmhwwsZUeJ7GNY=;
        b=nwPsOTiK9KTL+060k68UeuOwvQV621w7cfxtDD8xa879cBLHwWbJlXnbzyChkTK2oZ
         qcoCewDO1uqlPM44rXVTCBDRe9XfJKfYJBnLbE30B9kvZSiMAXQWLCUiGcaeI98Fv/PL
         4L3DWjfqxo2ycSaHsX7XkditnOKjuWx2UHsD38pen0ft3aEHrvDpLoByJTopQDPiS07O
         eavRRu3ehx9ij8l3W1u9GS30wBLGD9YX1k0ySUiOrzAiTS/zv8wfDdvDtrKdji+PIx5w
         QhyciIrvA415wcFjqO2kNLODk1y47vtdLZ8ekOi/OGPdSMMRvzERLHKtA6IR7bp5Asif
         6M3w==
X-Gm-Message-State: AOAM530tyiNLVcYj4+0FPmPv/OYzWGnAV/tFIkHKU5BXGxCrbeQJOKDy
        IJKmLJ47mbLZKo5K/43iAQ==
X-Google-Smtp-Source: ABdhPJyf/HnFKPiL1MDwfz7fZQGkf6Qkiq528FYnixbNgRMJrs7mUo0ftMLRcq395U6d8NnXC+KWeQ==
X-Received: by 2002:a05:622a:13c7:b0:2f3:aff5:f58c with SMTP id p7-20020a05622a13c700b002f3aff5f58cmr16203033qtk.511.1654468383642;
        Sun, 05 Jun 2022 15:33:03 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id u3-20020a372e03000000b006a323e60e29sm9944425qkh.135.2022.06.05.15.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:33:03 -0700 (PDT)
Received: (nullmailer pid 3649150 invoked by uid 1000);
        Sun, 05 Jun 2022 22:33:01 -0000
Date:   Sun, 5 Jun 2022 17:33:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: document deprecated
 Atheros
Message-ID: <20220605223301.GA3649070-robh@kernel.org>
References: <20220601135222.205035-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601135222.205035-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 01 Jun 2022 15:52:22 +0200, Krzysztof Kozlowski wrote:
> Two old boards use "atheros" prefix instead of already documented "qca".
> Document it as deprecated to fix warnings like:
> 
>   at91-gatwick.dtb: atheros@0: 'atheros,board-id' does not match any of the regexes
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Rebase on Rob's dt/next branch.
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
