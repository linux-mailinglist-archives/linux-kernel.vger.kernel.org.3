Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D3470C90
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbhLJVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:31:55 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:45643 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhLJVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:31:54 -0500
Received: by mail-oo1-f51.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so2703094oog.12;
        Fri, 10 Dec 2021 13:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEGxhPGSJ0DPsy5LNBN3m1DeP3hKNjSMYLrcuOnRxIU=;
        b=QCZs88LXN5wmQK5xt8UlCyIeHrqTEWSc16sfcQTlnD8S/rjxwi+5o0rg8ESmVraUUg
         6NFfFQvh2VvKaJEX7FmEoLN6+7bRLz5i20rF2OSDkNaqwrUBLcEDDOLYrPU8Ohu0E1cR
         ENmKGcpjHxUkbDECin1v1HU7hziAW6fIPjiGV7FpcTon2myoReKYD/tyOtepNu1FNWqK
         c48HlW3kN3GAAVLKyEsc1TSf4eCw/D4twkcGfXlMw9kualPhhbJVvwkU6QLSmv+18iEG
         G9dJ9qkxYSxa+VdIx8Sfcu5I2E3fg3+DVYSv3iO3E3BuVZrn/A9fT026SRZiIny28UQr
         FLNA==
X-Gm-Message-State: AOAM532UUVJ3GFmfxqhfHczTltV/cj2vSl8OI0mN1XFBhdH8mQE+dWgI
        JApSO5SB5ijeQv86UuvxYw==
X-Google-Smtp-Source: ABdhPJwUvDMhOZ0QuT0/xwOAD4OVc8DPYqtAh+nU2te8BpCzdVHRhTpUzHc72Xdxdr31SC6HQ3CdOA==
X-Received: by 2002:a4a:d98c:: with SMTP id k12mr9815755oou.82.1639171698662;
        Fri, 10 Dec 2021 13:28:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm739797oth.81.2021.12.10.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:28:18 -0800 (PST)
Received: (nullmailer pid 1936301 invoked by uid 1000);
        Fri, 10 Dec 2021 21:28:17 -0000
Date:   Fri, 10 Dec 2021 15:28:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/7] dt-bindings: clock: Document Exynos7885 CMU
 bindings
Message-ID: <YbPGcXcj5Is6aj2t@robh.at.kernel.org>
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-3-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206153124.427102-3-virag.david003@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:31:16 +0100, David Virag wrote:
> Provide dt-schema documentation for Exynos7885 SoC clock controller.
> Description is modified from Exynos850 clock controller documentation as
> I couldn't describe it any better, that was written by Sam Protsenko.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Fixed double : in description
>   - Added R-b tag by Krzysztof Kozlowski
> 
> Changes in v3:
>   - Nothing
> 
> Changes in v4:
>   - Fix leading 0x in example.
> 
>  .../clock/samsung,exynos7885-clock.yaml       | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
