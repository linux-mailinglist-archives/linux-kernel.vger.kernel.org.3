Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48119534885
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbiEZB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345977AbiEZB7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:59:12 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120CBCEA4;
        Wed, 25 May 2022 18:59:10 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f2cd424b9cso674620fac.7;
        Wed, 25 May 2022 18:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9oXg2kBeJmnkGZvWgG6eEkTx3Gi2MoPZPKKT6AOD548=;
        b=7iqf3KBxW2Bu4/xRJQiUbDHgw8ATy5wJpIRsJjIDVxSMwJ/F5/NqfmbkQZEmlaFMaj
         kc4TJ3GiWVfpfngbl9SvYu9WS8uSW0ujNIkI27qvKzJmvSPItw6LXgU5ulcYdyHnccTN
         tQM+UjsNjzpyb8Llr26hIcOdCeQmx0UooRREo/ejbRKctc9VEbqtOT/6x7Tdv7i0i1hu
         /XbMWF8pfdtN905dYe7ub4zZ4jK/wlUXW2YAkvLQAfW9rgf8I/jQerUktw1YEhOPhO4H
         rzZH9Ic3rSa9L8egWdzTHdLmlv1LmR7D63rg8ix4eWhFBSeT9r9kuo8+DMSB5aZwEw+u
         MO/A==
X-Gm-Message-State: AOAM533KaRXtARRf/RcN9lg11ye8PtHJKFGt5+zvNsHDXqaJtD2O5DL6
        TaVHACZmN7EXOuK6MJkb5A==
X-Google-Smtp-Source: ABdhPJz2yvzDccIouYKE6g3DEh1N9wTWXJs74pfezYFbQOP9kIqvQhmleO0uyGjGRUdEW+RvqxdjXw==
X-Received: by 2002:a05:6870:6011:b0:e6:2d00:6b5a with SMTP id t17-20020a056870601100b000e62d006b5amr14095oaa.263.1653530350292;
        Wed, 25 May 2022 18:59:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o25-20020a9d7199000000b0060affecb2a5sm134139otj.17.2022.05.25.18.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:59:09 -0700 (PDT)
Received: (nullmailer pid 2898644 invoked by uid 1000);
        Thu, 26 May 2022 01:59:08 -0000
Date:   Wed, 25 May 2022 20:59:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, philippe.reynes@softathome.com,
        samyon.furman@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        florian.fainelli@broadcom.com, tomer.yacoby@broadcom.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: add BCM6846 SoC to device tree
 binding document
Message-ID: <20220526015908.GA2898559-robh@kernel.org>
References: <20220525175124.7524-1-william.zhang@broadcom.com>
 <20220525175124.7524-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525175124.7524-2-william.zhang@broadcom.com>
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

On Wed, 25 May 2022 10:51:22 -0700, William Zhang wrote:
> Add BCM6846 SoC device tree description to bcmbca binding document.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---
> 
> Changes in v2:
> - Add new line between entries
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
