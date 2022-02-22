Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C024C043B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiBVWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiBVWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:00:55 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51858EDF2A;
        Tue, 22 Feb 2022 14:00:29 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so19619316ooi.7;
        Tue, 22 Feb 2022 14:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ahIfnQC+pBJvI8nLD1bgg4bC0v2cnmUgLsiuj1DT6xk=;
        b=JEG5HXKLb/WqmC7h+yyA/NtFuqayNTU6cBWzGoNJaqp/N0IggThltqLJPyZwcTCnRn
         qvsK7UkrAoFJhKQIR+4VL6hdYLmkEwWmBbeq2C2LevIpJXyX6QupInITkeEGXu3reGv1
         4Q4WxjR6YNHs69buXd9cC3l1nVsxTX3soV7RmKFFHnW+wOO2ZI/5HsDiFpaDGRpHLer3
         lrcYaAfYyexWb/qj8GMC6bvJbJs5B8znjTloeIlmmpNO/F8mqA5gNTzd09JjjL9D/E6A
         dIWHLuu62VCsCY4xFwbMZuBf5P86UHLTIBaIGMhbJReSd6dD0vpMQ27Qce2QcLt90Bp3
         zQFA==
X-Gm-Message-State: AOAM533lU0/TOEoMXM4WPk6DKtHV6f5wOxBFvTqpy6ZTa0Uuf0ssmxvF
        e6O90znrDH/hXYnw8B9gVDFpeOabdA==
X-Google-Smtp-Source: ABdhPJxU5V8a/mhci0bcME8D0XxY2nJq9ysPy54nPwaOoVyAORCRsXr1IXhAY9u4FMvG72dq0LfebQ==
X-Received: by 2002:a05:6870:f604:b0:d1:bd6e:47e3 with SMTP id ek4-20020a056870f60400b000d1bd6e47e3mr2716113oab.30.1645567228624;
        Tue, 22 Feb 2022 14:00:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id er36sm3107051oab.9.2022.02.22.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:00:27 -0800 (PST)
Received: (nullmailer pid 3665249 invoked by uid 1000);
        Tue, 22 Feb 2022 22:00:27 -0000
Date:   Tue, 22 Feb 2022 16:00:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: usb: dwc2: add iommus
Message-ID: <YhVc+98vHe5uMvGe@robh.at.kernel.org>
References: <20220218161522.52044-1-krzysztof.kozlowski@canonical.com>
 <20220218161522.52044-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218161522.52044-2-krzysztof.kozlowski@canonical.com>
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

On Fri, 18 Feb 2022 17:15:20 +0100, Krzysztof Kozlowski wrote:
> The DWC2 node might use IOMMU (e.g. Altera Stratix10), so add "iommus"
> property.  This fixes warnings like:
> 
>   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dt.yaml:
>     usb@ffb40000: 'iommus' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
