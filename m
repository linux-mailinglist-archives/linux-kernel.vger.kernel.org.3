Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F381548A23C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbiAJVzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:55:06 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46846 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbiAJVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:55:05 -0500
Received: by mail-oi1-f170.google.com with SMTP id y128so14108374oia.13;
        Mon, 10 Jan 2022 13:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibH96/TSKICVU4X5gL1f5xl54raErpDQg8IypccovFA=;
        b=YEwIf6OjqDz4yuR7w6C1gcwqB5ok1UKzjoIFbI9d829+V3oZu9/MiQM4rXzyhP+mm1
         CtUzuhM9seB+v6YFoYdHO8UFxMCGfxOYOTYW7Lh/xJYybZoFgbRffBhJP4kt5len508R
         FJGKIgU/M/A2OshKvlKHC3ryH/yZnqeXj/UtqjWqAWbi+8yThrRI62JcOdPI7qtGM8nQ
         K6g2kYE9RYdAKQyBQlGnjEGOZ+oHRVorkUmNUszzgwAPvTUglBMSuTVP77JnV+N4PCjk
         dPR4AEcZrEWmAxm0Emc7iePhgKYbuXx59BsmzfYuSwaUpi6b76Ngz25G8DrY40x7XC4K
         pEFQ==
X-Gm-Message-State: AOAM531hsxRL3W14aOChV66aCLCNGP/+9NZEZm7I13JS6pL9eKBBQhGc
        MlvymFkIc41l0Ab2XS3Jlw==
X-Google-Smtp-Source: ABdhPJwCROu92cIX39O/03JiC9nasKDJP081eZeaA7oR2oT/a1IW8Io4AWMiWQQfgx4gV+11+SQAVg==
X-Received: by 2002:aca:ad57:: with SMTP id w84mr19167184oie.69.1641851704641;
        Mon, 10 Jan 2022 13:55:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e19sm1731317otk.47.2022.01.10.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:55:03 -0800 (PST)
Received: (nullmailer pid 1584617 invoked by uid 1000);
        Mon, 10 Jan 2022 21:55:02 -0000
Date:   Mon, 10 Jan 2022 15:55:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 6/8] dt-bindings: clock: samsung: convert Exynos5260 to
 dtschema
Message-ID: <YdyrNv79Eepm31ty@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:54 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5260 SoC clock controller bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/exynos5260-clock.txt       | 190 ---------
>  .../clock/samsung,exynos5260-clock.yaml       | 382 ++++++++++++++++++
>  2 files changed, 382 insertions(+), 190 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
> 

Applied, thanks!
