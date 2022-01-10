Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED348A234
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbiAJVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:54:35 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37678 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbiAJVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:54:33 -0500
Received: by mail-oi1-f171.google.com with SMTP id i9so20508967oih.4;
        Mon, 10 Jan 2022 13:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxelY0/Zsgn/ka0yUEn/Hi/1kWKctpk1tm8SeqdiNM8=;
        b=aev2b3AoGn7KGR/99/DpfQVVTRPFfDdYEqhlWpQrg+nR+pkbX5MjvCnglihvFosZTf
         rS3tIbDLNllUq5819TQDvvWdXZAtwv5qQ0WHCQItlEH7A4ZhJSqBi4UbTtkniMvcgHkn
         4zwGeSsxgsE3AXs/GwjuAwSbevQuAuASgtkmAFi0wqDEApzqsOikUlBwaG5bbntGJIz8
         lT3zYTaW+EgwvQJ+0r1i2vlS7w2xdeYpWmxOUgkH6reTq9RTaw3OkxafzzcGag+tK3yf
         LUtwZS4RRFgzkplu3jg5aNFzZ6D8Xe1FR3781WQMbXPzh4elqXeT2Obw8yGkgnizYB9s
         iiNg==
X-Gm-Message-State: AOAM533JfQQ7g2NVtOWl9SgBs6hSoN5iA6SEQg+tRvK7l+1488UWXGmC
        IQ+OQrdXpe9ynTb0carhAA==
X-Google-Smtp-Source: ABdhPJykQLO3oDRFcIuFsHdl41tspllip2iStxe9d+8Sa+HsTsMYxJ75HvPJRRBTGfL/YRwjGwde1g==
X-Received: by 2002:a05:6808:4d0:: with SMTP id a16mr20285094oie.93.1641851671062;
        Mon, 10 Jan 2022 13:54:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm1341262oib.1.2022.01.10.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:54:30 -0800 (PST)
Received: (nullmailer pid 1583449 invoked by uid 1000);
        Mon, 10 Jan 2022 21:54:29 -0000
Date:   Mon, 10 Jan 2022 15:54:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] dt-bindings: clock: samsung: convert Exynos7 to
 dtschema
Message-ID: <YdyrFYwgViOaEX5h@robh.at.kernel.org>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
 <20220102115356.75796-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102115356.75796-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jan 2022 12:53:52 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos7 SoC clock controller bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/clock/exynos7-clock.txt          | 108 -------
>  .../bindings/clock/samsung,exynos7-clock.yaml | 269 ++++++++++++++++++
>  2 files changed, 269 insertions(+), 108 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
> 

Applied, thanks!
