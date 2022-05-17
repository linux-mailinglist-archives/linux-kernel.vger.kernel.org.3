Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8710552A4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348833AbiEQOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbiEQOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:23:11 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0F3F31D;
        Tue, 17 May 2022 07:23:09 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-f1d2ea701dso340060fac.10;
        Tue, 17 May 2022 07:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3bndXuI64Ue3mK3JPaJB5nfwxeA2qn3jb/SOUY4QzA=;
        b=z2Htye3bfvicLK9vy3ehxmf0axbbYcTi1DkqJbAj3NVMyB6WOd+4Qb9BE18WykhkHl
         NYvnmGrPliHdvUZcR1X6TOb1Vlzja54CzFF/hsiwJQDbNdbjM6sWFAkliCh3t2gr1LvD
         0//dSFedQnsbu/oKWEv8TnYYE2g6q1vXr0CDOm+4f8bUSS8MhW0N6cTckkii76PQ7U1J
         MEkqAA4RWlD7RBmETtNtffT1kY9fGU1TGhc7wnloi/RsvHs2HtpLS+oVvu/EJxLEdiK3
         dEvVV7PUnvdjlrYu2LFoobo/+Pm/pRuLSJW0tUpkv+eFEtxNvZDh9wuk8+ImCxyX0eQZ
         dPKQ==
X-Gm-Message-State: AOAM5325JcPxbwurM08vsOcw+/KVQ6uBLKLDjF8NKKhZPUW14m7wRNpi
        s0n9YIGpUKEEUL7+kspHtsu3rosIqw==
X-Google-Smtp-Source: ABdhPJwz52ZsVy1j3AZUaF/8tQV+K0T7ERkl5YogzEitZs3wIwNkF0iwmb0yzNEaabSRJZt2L9stbg==
X-Received: by 2002:a05:6870:79a:b0:e9:109a:1391 with SMTP id en26-20020a056870079a00b000e9109a1391mr12272799oab.105.1652797389034;
        Tue, 17 May 2022 07:23:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830144f00b00606a6c09a0csm4907036otp.12.2022.05.17.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:23:08 -0700 (PDT)
Received: (nullmailer pid 961752 invoked by uid 1000);
        Tue, 17 May 2022 14:23:07 -0000
Date:   Tue, 17 May 2022 09:23:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kursad.oney@broadcom.com, samyon.furman@broadcom.com,
        philippe.reynes@softathome.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        anand.gore@broadcom.com, joel.peshkin@broadcom.com
Subject: Re: [PATCH 1/5] dt-bindings: arm64: add BCM63158 soc to binding
 document
Message-ID: <20220517142307.GA961687-robh@kernel.org>
References: <20220514232800.24653-1-william.zhang@broadcom.com>
 <20220514232800.24653-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514232800.24653-2-william.zhang@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 16:27:56 -0700, William Zhang wrote:
> Add BCM63158 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
