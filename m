Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19D4B0067
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiBIWfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:35:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiBIWfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:35:42 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146FE01644C;
        Wed,  9 Feb 2022 14:35:44 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso4179741oop.9;
        Wed, 09 Feb 2022 14:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5fTrwS5rMcO9/kl6ojaw4OQF9uM5X4OfMj/GMQCbWk=;
        b=OLXn7e7WQt8GAUqgikyTBd5IlKKWRZ+eFOaz6XT3iBvR10Zb9nD6AtOW+GQJMcS1qi
         dLtoN6mT/dXo6uN/DD3+0b5vzWSkVmsRwHPv1eTXWNVgQyYj+5pfjdK1ZjSNV0QMfFsZ
         Z22TS7BXTOpI4pwAi6d55WPmcdRxEUxeI1/LZ5W+pwo4SVvJjruxt5wcpvNlEtLfhlAv
         GObOVDaBZNWznt/Ry8mwD89dp7dLgm1P1euoXVjuI3c2gcR1ohW/DUzQx7n5pT0yEVra
         eQgwrvyk5Q7s8c40+LnBqIhRmIr3AWZCsd9gagYzgRDH4qSPfGXDU9uFG4Xtwmxchp7r
         ohOA==
X-Gm-Message-State: AOAM530Zf0MlUWJrUaIXsq9V3fdkSFZIk7T2u97feU1ZaXRNay0O5IdG
        PsPfuqzamWhPyyQTO0PNXA==
X-Google-Smtp-Source: ABdhPJxqfDJ9yCEcYw3PdO97m7IdVwwhJ4cf2NE0mwgb5Nm481pxklEis7a3JldAdbzsJSVROGs1RA==
X-Received: by 2002:a05:6870:e505:: with SMTP id y5mr1804779oag.109.1644446143483;
        Wed, 09 Feb 2022 14:35:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l38sm7447772otl.45.2022.02.09.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:35:42 -0800 (PST)
Received: (nullmailer pid 1067145 invoked by uid 1000);
        Wed, 09 Feb 2022 22:35:41 -0000
Date:   Wed, 9 Feb 2022 16:35:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 7/8] dt-bindings: phy: samsung: move SATA phy I2C to
 trivial devices
Message-ID: <YgRBvd6Dzn57e2i1@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-7-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 20:36:45 +0100, Krzysztof Kozlowski wrote:
> The I2C interface for Samsung Exynos SoC SATA phy is a very simple and
> limited, so move it to trivial devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        | 14 --------------
>  .../devicetree/bindings/trivial-devices.yaml       |  2 ++
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
