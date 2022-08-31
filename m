Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C45A87B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiHaUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:47:19 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50314EA30F;
        Wed, 31 Aug 2022 13:47:18 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11eb8b133fbso22584979fac.0;
        Wed, 31 Aug 2022 13:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zEbVbunJlre6mDmNp2IBjlatEi3ALf9EvbX8coz8GaM=;
        b=O5245wv+m7LTIgaCxEX2UdJv8C0UHYR86YnrXWrjllsjYwz+xk5cUmGiuVfa8/XWjm
         U26cPLj2ABQSu7nUAvr9F/cRT0dCPUfd0E2zVS/+UDsvQa/c8xdBcgKYpVZ65AVzZwHH
         7xpixNb9EcruchFU4pDeUSY0aw8cpi+8VcgGhWnaEZu3S25H7aqiendgkiB0YmzToEO6
         o09bUpmMjJROgMKn6ZhC+YhVJvI2ZVTKfgSMLu3yyzFq7Rr0RTcKlDCEE0dvhTC1D5Dq
         fxRxYAnLsgFouNSfA3w0H8V5MbUWzl26p7Xb4KkzxkAsHkbgQmquGRe6oR+xuIizGbeh
         qYoA==
X-Gm-Message-State: ACgBeo1Z7LW+nl/qRwZrNMCEd50hUN4t2rekhharL/gEUZbAToBwdxnA
        myqpRo2g0SJ0p9N+tKIzhfJqViXznw==
X-Google-Smtp-Source: AA6agR62qFR4xIl27/iMdfvrciIsuXxB//hS7o7lV+FgBflwrbZCRsOpseR8UzXcrHhST6xVa8ShVg==
X-Received: by 2002:a05:6870:a99c:b0:11c:2c37:3d03 with SMTP id ep28-20020a056870a99c00b0011c2c373d03mr2276728oab.0.1661978837570;
        Wed, 31 Aug 2022 13:47:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v6-20020a4aad86000000b00448a3ecdc9dsm8541119oom.22.2022.08.31.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:47:16 -0700 (PDT)
Received: (nullmailer pid 218610 invoked by uid 1000);
        Wed, 31 Aug 2022 20:47:16 -0000
Date:   Wed, 31 Aug 2022 15:47:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220831204716.GA218548-robh@kernel.org>
References: <20220823145649.3118479-16-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-16-robh@kernel.org>
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

On Tue, 23 Aug 2022 09:56:47 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml        | 1 +
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 4 ++++
>  2 files changed, 5 insertions(+)
> 

Applied, thanks!
