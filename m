Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3148A278
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiAJWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:11:27 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37517 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAJWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:11:25 -0500
Received: by mail-ot1-f42.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so16642616otg.4;
        Mon, 10 Jan 2022 14:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nzkq2B9eNNRWXlj4SYuyqIRG0l9cbvXXEZWEm+ftko=;
        b=5c2SvhR9oD5P3t8Ip8deKjvJymcoISYH4iTn6ylwMKnfEip1VPzkukUr9sTQGuldSK
         l4jp7NvcdJPijk4m14pxrrmDOmRXfO6wte2ifAozF7jI/QuoJgU09XUSWiRUUCVrqCqE
         2aWr11I8/NgxTo2zNRqn8f742vZzhIysUnInmhHFkt6K/CtzGO5k5D+hNVmkoMXvKRFR
         VXUBEfe6EnzalclpOW/ot7Hg3IpVc42easkEcs+v9TAhpNeuMd/0fAgTD8oicVMBPIWj
         1D4wmQMs0mtP2g91/flvxenzb6QmwlV+7onsFABjUI91A4sFTqmmBqkUdq21mgaLioQr
         1zUA==
X-Gm-Message-State: AOAM532su2labUcMV8N0KTO/HClm1QuJnC9a05x2u8XH2fOclonfIJUL
        Y9gMiaaNy9QMaFqj/IA73g==
X-Google-Smtp-Source: ABdhPJznmAqhEaooXLArgvliGUn0BudXlfjZw40XQHQtxMM6Vg2sOzXpRiw3J15wCtqhEAa8C9raMg==
X-Received: by 2002:a9d:750a:: with SMTP id r10mr1391284otk.34.1641852685091;
        Mon, 10 Jan 2022 14:11:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 6sm1352508oif.16.2022.01.10.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:11:24 -0800 (PST)
Received: (nullmailer pid 1612948 invoked by uid 1000);
        Mon, 10 Jan 2022 22:11:18 -0000
Date:   Mon, 10 Jan 2022 16:11:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: clock: samsung: convert Exynos5410 to
 dtschema
Message-ID: <YdyvBtQhApv1LhwK@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-7-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:55 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5410 SoC clock controller bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/exynos5410-clock.txt       | 50 --------------
>  .../clock/samsung,exynos5410-clock.yaml       | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  1 -
>  3 files changed, 66 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
> 

Applied, thanks!
