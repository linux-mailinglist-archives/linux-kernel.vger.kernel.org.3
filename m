Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053424AA2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiBDWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:15:27 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46614 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346848AbiBDWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:15:23 -0500
Received: by mail-ot1-f47.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso6100810otv.13;
        Fri, 04 Feb 2022 14:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8RFHngLhDeWO4wQPXHQGcIdh24A8gAlUMWTLplW+TI=;
        b=iYoKOD7LQyRzvMDM8duQPme7Oa96o2IjRLv8UmAWlGBjYnnMruE/HxIANiOuFH+Fby
         dKjkg6VlDFQLJeoNv1Otr44yB21PRs27NlTVMZASA4dFClRGf6QK77x/VXVdbbujwPdU
         tsZ9vjYiiH6WyM8phvD+9sOnGorEX9JlYludRmrq91kb4UCr+Awzd/HtGKXNuNjtIyRK
         Ac1XW9hS8AeZJ83MX7/vIlDsdO92f3gwRYSj9FF9t2rGDu1yryj0/sGQkrk22eC8BECN
         iQb/RuGfLsk36kATp65HUA4a16jnmbmELkwQjvqv5YNg2q4d/irFuJYNmclLYM3ItfY1
         z/8Q==
X-Gm-Message-State: AOAM532Cy9+AXvbKqkI9db/cG7dCmR1jBPiuYEoYT7RyzVvRyaA7cgi7
        YofKNH9YioVFdiWI7dLISpztimM+iw==
X-Google-Smtp-Source: ABdhPJw1r36BfQdNmjT2kjJd0xyM5pbLBON8ItumuXjTSCU4U75vKCiZ0SQbcnm/cAX7aMItBNevWw==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr403290otf.299.1644012922815;
        Fri, 04 Feb 2022 14:15:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 31sm1243392otr.13.2022.02.04.14.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:15:22 -0800 (PST)
Received: (nullmailer pid 3277483 invoked by uid 1000);
        Fri, 04 Feb 2022 22:15:20 -0000
Date:   Fri, 4 Feb 2022 16:15:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <Yf2leGSnt4tvMnnn@robh.at.kernel.org>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:23:44 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format.
> 
> The conversion also drops requirement from providing controller-data and
> its data for each of SPI peripheral device nodes.  The dtschema cannot
> express this and the requirement is being relaxed in the driver now.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
>  .../spi/samsung,spi-peripheral-props.yaml     |  33 ++++
>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
>  MAINTAINERS                                   |   2 +-
>  6 files changed, 223 insertions(+), 124 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
