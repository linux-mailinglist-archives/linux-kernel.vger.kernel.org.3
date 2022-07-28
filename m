Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2475584286
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiG1PCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiG1PB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:01:58 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E03AE72;
        Thu, 28 Jul 2022 08:01:56 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id r6so1050997ilc.12;
        Thu, 28 Jul 2022 08:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xhkwBQOC3l/9BVCi/iH6M0p6a60oLxwKOAOMHWHS0M=;
        b=5s454/aOaM9742ipbSdq+EygaCLRCf19v2j0sYdarVZfNTtQLrw9JddnvOvJL+5qdd
         ArH4sT3jNTzHbz9mzhExKxcbrWcCX/MnL+9BcHEl/blnAiLK3+1G28z2izENJeDoP6PV
         dPk0d3AAfwkYdY1CDCk4Rb4741xsT6pp+0/VHi1o7q8VaJ3mH4Ll4OctDBvtLyt+bKvn
         SFrxKBE6+LVwdhqyqZkfQX+GVQ23pITeQ0APCynk1dRNuO9JJQq3/X6YocO6v6tNrn3D
         GyHH/4tuD6MT+nmSTzrc/DiUQHkNgtynQYaUpthtnwwJY/OOCLgunOy1xXf29UOM1Lsc
         ImUw==
X-Gm-Message-State: AJIora8RioNiYn7S+rWu57aj4Qwry4SsDK+9iPjAgBMxN99eYD8NWLaP
        AiPV0vSvx9d3DFvTQIkg2g==
X-Google-Smtp-Source: AGRyM1s9TBNPMh+h0VSF1UIFm+2L8BR6R7Sx3FR1UBFzNemD2E/mHDcueOUOM4kTLY1m3sJ5cH/1jw==
X-Received: by 2002:a05:6e02:194d:b0:2dc:6c56:a522 with SMTP id x13-20020a056e02194d00b002dc6c56a522mr10900635ilu.203.1659020515826;
        Thu, 28 Jul 2022 08:01:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s20-20020a056638259400b0033f3d432a2asm460506jat.174.2022.07.28.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:01:55 -0700 (PDT)
Received: (nullmailer pid 879826 invoked by uid 1000);
        Thu, 28 Jul 2022 15:01:52 -0000
Date:   Thu, 28 Jul 2022 09:01:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: correct
 number of pins
Message-ID: <20220728150152.GA879792-robh@kernel.org>
References: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 16:01:48 +0200, Krzysztof Kozlowski wrote:
> BMG160 has two interrupt pins to which interrupts can be freely mapped.
> Correct the schema to express such case and fix warnings like:
> 
>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
