Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F591544FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiFIOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFIOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:48:22 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E85C39;
        Thu,  9 Jun 2022 07:48:21 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id z11so92379ilq.6;
        Thu, 09 Jun 2022 07:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0WCE+IuXPv4P5hy6ujeRoh5ZAtEnh1boIThWFrsiCBw=;
        b=xfb6881J1KtIuyrFx9dZ947Zyofh36trRy68EO9RLmvHhH8QV3iwdpq7GAMVkCeiSt
         Guk9S6owv8vMf/u1kj0ao5GJcsfCgT1vietVT8W3e3LQpRET9/OSEqXVOyBLgRLiPGqt
         LoItxg15RgzLrqXhWkYKpxTfc/TAM4cpsCR+4nqH6533lroAkTHHFEIVEUF+MeFVtHpW
         I/MS8YSPUS2Wen2KBJPqGCuq15iEsnhXxsSsKbrIrFNzW1yNfKqjCURl5EaEIGgiILoX
         L8WH+bPsLgDgR3vlpuEUuqAIG03CxJFhQUP+z6XmmNXw0Gl8A88w7Omby6z3q9Z3R3XR
         Hjfw==
X-Gm-Message-State: AOAM533LPr2WMo9NhxW7+QQAgPZJJZRU4RNiC2tBkDyDM3lSbfd1/GN/
        JkPMhhdYZLxPrb9yUMzZeg==
X-Google-Smtp-Source: ABdhPJxb92Y7ZKqBPIPt6cH7BCGm+00H2xfEKvdk+htKr6C/haG1yW2tFbq8E2SJz3UU0CQJOwt5jA==
X-Received: by 2002:a05:6e02:968:b0:2d3:983d:7e38 with SMTP id q8-20020a056e02096800b002d3983d7e38mr21786886ilt.305.1654786100265;
        Thu, 09 Jun 2022 07:48:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x15-20020a02908f000000b00331f576f5c5sm1923982jaf.174.2022.06.09.07.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:48:19 -0700 (PDT)
Received: (nullmailer pid 3772354 invoked by uid 1000);
        Thu, 09 Jun 2022 14:48:17 -0000
Date:   Thu, 9 Jun 2022 08:48:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        philippe.reynes@softathome.com, anand.gore@broadcom.com,
        samyon.furman@broadcom.com, Rob Herring <robh+dt@kernel.org>,
        f.fainelli@gmail.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, tomer.yacoby@broadcom.com
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM63146 SoC
Message-ID: <20220609144817.GA3772217-robh@kernel.org>
References: <20220608180100.31749-1-william.zhang@broadcom.com>
 <20220608180100.31749-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608180100.31749-2-william.zhang@broadcom.com>
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

On Wed, 08 Jun 2022 11:00:58 -0700, William Zhang wrote:
> Add BCM63146 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
