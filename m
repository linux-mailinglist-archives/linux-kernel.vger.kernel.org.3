Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB70D48BD24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbiALCZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:25:42 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38502 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiALCZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:25:41 -0500
Received: by mail-oi1-f181.google.com with SMTP id g205so1605991oif.5;
        Tue, 11 Jan 2022 18:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytmxgcvgOBYV5/XB/+SAtEOazCkov2Vt5OdiPkB8I5Y=;
        b=CKKcynaSnXDm46nL3egBoIEQ6XO6E0F8DUk65JsYG8rAsxSpIrB5DsZlztSljOYpPf
         9y5mr6HwxN0GtxiLdBQg9HiZxa2DvbmfDu6ieJieERyLjCaxCibQ2pft8JJkISLjuJ6w
         J6HU6+K6JKn0CqTq1CzBzfcnqXeCEipBEXGavMCvNfkqrataxn+/eFkl4f9G4oYBwfJw
         KndfH3zXjlmCrNBsZ0LkNe5efEgiVEV4nMN9rNofuOD3Ynw7pdKqphp8JsOEqwrvIRyf
         KPvdp58Yz1yhLo1If/CA+1Da63KLA1P5aPGLt/1h7BeJ+cLeeLYGV+/AaYxlglQQtRHb
         u+Uw==
X-Gm-Message-State: AOAM532WAuAfKg57FIhst1+Jnjr1/2vPV2TD4w0qqGAbbw3NDBvV79Eo
        ys4bCzu7Cwulscq3kzJqzKYU1S4+yw==
X-Google-Smtp-Source: ABdhPJxASHdr8yB+bbKUJlAspuu+aUPON+33sWszhR4pyTyeomBJCphu3qL2NJ+19+hZ12S1tXAl7Q==
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr3795968oib.18.1641954341283;
        Tue, 11 Jan 2022 18:25:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm2022265oil.6.2022.01.11.18.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:25:40 -0800 (PST)
Received: (nullmailer pid 3950141 invoked by uid 1000);
        Wed, 12 Jan 2022 02:25:39 -0000
Date:   Tue, 11 Jan 2022 20:25:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andi Shyti <andi@etezian.org>,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] spi: dt-bindings: samsung: allow controller-data
 to be optional
Message-ID: <Yd48I0+IfUXbJ0B8@robh.at.kernel.org>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
 <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 11:13:37 +0100, Krzysztof Kozlowski wrote:
> The Samsung SoC SPI bindings requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml  | 1 +
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml         | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
