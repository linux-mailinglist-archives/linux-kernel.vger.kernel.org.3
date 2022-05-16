Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4052897B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiEPQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiEPQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:06:53 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFFF369D5;
        Mon, 16 May 2022 09:06:50 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so10361371otk.1;
        Mon, 16 May 2022 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ix5+n8jLX0xn9oVA4bpU37TO89ZN8Kkt7VWibJYMlw=;
        b=qFNJmhOuNj97zMAfSmGv8afx/Vi2g/2EqLF82nNhh+08G4NogyLwb341O0kNSri+hH
         d/qfj5LpwUv8stAwAK/bDVqiHb3PQhh4dCVhtHN+U9pMCCzEy/BwmX7H8f/rVQ32EHDt
         A3zYlmYE4vlTXXZjGza/YnvMIb6Zya3KwNZP1lo9bSmeqVPLiSgQND0hiboyiyc3wKC3
         QIvzvhH2MOwYOyK7P/jqeH2y9Q0n0LoyUn4e8WSUzUC0+k+t0bUSM+g53jKGscXjY17+
         Jtl+ntnD4PFcB7L5ecLOEuiv8ehdBxJ6bTgWk4wlB8+ZGxX0C5iNO6pAFLkQWTbC8UlD
         Bgvg==
X-Gm-Message-State: AOAM530Enaj6F3/yOeRJhhYybMyV78zB2HkXs3lVdFFVI/gMRneptOFP
        6scbo9cbq+HKylrP5+lXRecosg3zlA==
X-Google-Smtp-Source: ABdhPJzW5WeEOa3z3diF4JnjwBtxGHuHRKJMuCBUHOQLfVWaE3DV10AanZlGUjyKpeg+8MKJeRre+w==
X-Received: by 2002:a05:6830:3482:b0:606:412b:2678 with SMTP id c2-20020a056830348200b00606412b2678mr6121896otu.143.1652717209466;
        Mon, 16 May 2022 09:06:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a05683018ca00b0060603221274sm4001908ote.68.2022.05.16.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:06:48 -0700 (PDT)
Received: (nullmailer pid 2738986 invoked by uid 1000);
        Mon, 16 May 2022 16:06:47 -0000
Date:   Mon, 16 May 2022 11:06:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: arm64: add BCM63158 soc to binding
 document
Message-ID: <20220516160647.GA2737211-robh@kernel.org>
References: <20220514232800.24653-1-william.zhang@broadcom.com>
 <20220514232800.24653-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514232800.24653-2-william.zhang@broadcom.com>
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

On Sat, May 14, 2022 at 04:27:56PM -0700, William Zhang wrote:
> Add BCM63158 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> index 5fb455840417..4e3a1a5391f6 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> @@ -28,6 +28,13 @@ properties:
>            - const: brcm,bcm47622
>            - const: brcm,bcmbca
>  
> +      - description: BCM63158 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm963158

bcm963158 is a board?

> +          - const: brcm,bcm63158
> +          - const: brcm,bcmbca
> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.17.1
> 


