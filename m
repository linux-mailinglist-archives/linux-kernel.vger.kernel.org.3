Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A54AA2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347094AbiBDWQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:16:03 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36792 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiBDWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:16:02 -0500
Received: by mail-ot1-f47.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so6160614oth.3;
        Fri, 04 Feb 2022 14:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKzyhj492iupmKVkuYuTvH2Dd+XaBGupMBhlEiis9Pg=;
        b=Q5CfTsWapnNxUADKR7jSrBlcQi9FVjvIylB/3hTlC5n1LEYY1op2Ri8BtxujyTy70D
         kuZFR3cO51Fz9bzWMNOFw+gg+vsnjStgxQhl2yEQhb71qqW+vlU/cu32sGmk+d8myWgg
         XcbjyPVAHuZWASQ9JS+FUB0XQ5u10UElWMfwNt67nCaFUJK2nzGmJ3O+prKhqG+jx1o4
         rLhSp7mwZp1ZN3GT57GW96KQXyhHr3De9VB4U7Djhe9hfQoE0XqGaEjnab3kIgcXt1xy
         dyKr807E9H7JAkPAHcTE56weqPJocNoCwXj3OO0FMji352sD+1MUCfBZ4It3JlTN50Jl
         rtrQ==
X-Gm-Message-State: AOAM530ybu4d4l4yKYh0OARUiSsE3bMJcvcv6TKMTqOArlRSUMNaiAHF
        cd/0vd6SSQFu+/t74CtXmA==
X-Google-Smtp-Source: ABdhPJzdroYs9goDboCxre8nk1v4ou7De5N5c68fCX4LaB0bE1C78KMV3vGQeROwd0ZSXv8JiWEL/w==
X-Received: by 2002:a9d:7e98:: with SMTP id m24mr422771otp.358.1644012961558;
        Fri, 04 Feb 2022 14:16:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l22sm1246191otj.44.2022.02.04.14.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:16:00 -0800 (PST)
Received: (nullmailer pid 3278485 invoked by uid 1000);
        Fri, 04 Feb 2022 22:15:59 -0000
Date:   Fri, 4 Feb 2022 16:15:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Benson Leung <bleung@chromium.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v6 2/4] mfd: dt-bindings: google,cros-ec: reference
 Samsung SPI bindings
Message-ID: <Yf2lnzBvoHva7i7k@robh.at.kernel.org>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:23:45 +0100, Krzysztof Kozlowski wrote:
> The ChromeOS Embedded Controller appears on boards with Samsung Exynos
> SoC, where Exynos SPI bindings expect controller-data node.  Reference
> SPI peripheral bindings which include now Samsung SPI peripheral parts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
