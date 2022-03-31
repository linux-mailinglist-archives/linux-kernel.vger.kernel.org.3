Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A94EE305
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiCaVEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiCaVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:04:40 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87D48E51;
        Thu, 31 Mar 2022 14:02:52 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-d39f741ba0so563331fac.13;
        Thu, 31 Mar 2022 14:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPpKv/SRYRVRgx340zgE9vNuwcsgGJc8X/6zcb18sHU=;
        b=7/0462vS34se931kZDqhsnzJQ7aRunJhwGTN6G7wnaqXiT9PDmcsbSqp9TAyryicll
         avS2EYiUFXcDFqQdsQrkWRz/mM4Jx8DflQ/gkSmdL4xmPUB8vf1RnTSXl/aTTwAqt5Yu
         xWbh8Otp2fcsibCYaQJUYcTq51woblDUvj3XZN9pe9bGynW3FhWHekrQCROrxMQmxG55
         RL0VEnB0z73bzuWmulAUXUrauJe1LBSMnTftQ4VSRQAx9ZdJicq9ximoSehNMmBk1tBB
         QwruxesYdzHOaUqpmtNMYEK4jvTo9BGG/Bw9dcyFVoo0utFTTJAR6Z3ro+/P86RcMk38
         QvWg==
X-Gm-Message-State: AOAM5301rVpsUiW/DZJzwAAfE5lsbBOJNyJr2Abii1B6SvdKVCahScrW
        mxW8pdtbrJJ7MGwFqm3zrw==
X-Google-Smtp-Source: ABdhPJx+liwNi8k9r0GFPEwVam5wEa/kx0Kr2LuK5t6NBLA283LhT6sQ+0IC9HLsm7yy+/KT32oAhQ==
X-Received: by 2002:a05:6871:728:b0:dd:c167:4393 with SMTP id f40-20020a056871072800b000ddc1674393mr3610185oap.108.1648760572112;
        Thu, 31 Mar 2022 14:02:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm305416otn.55.2022.03.31.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:02:51 -0700 (PDT)
Received: (nullmailer pid 1494803 invoked by uid 1000);
        Thu, 31 Mar 2022 21:02:50 -0000
Date:   Thu, 31 Mar 2022 16:02:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] dt-bindings: irqchip: mrvl,intc: refresh maintainers
Message-ID: <YkYW+rWOEMV8CVOf@robh.at.kernel.org>
References: <20220317142952.479413-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317142952.479413-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 15:29:52 +0100, Krzysztof Kozlowski wrote:
> Jason's email bounces and his address was dropped from maintainers in
> commit 509920aee72a ("MAINTAINERS: Move Jason Cooper to CREDITS"), so
> drop him here too.  Switch other maintainers from IRQCHIP subsystem
> maintainers to Marvell Orion platform maintainers because its a bigger
> chance they know the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. Do not add Sebastian.
> ---
>  .../devicetree/bindings/interrupt-controller/mrvl,intc.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Applied, thanks!
