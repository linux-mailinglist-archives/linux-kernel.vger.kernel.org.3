Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F6570DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGKXG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGKXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:06:56 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954987F5D;
        Mon, 11 Jul 2022 16:06:54 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id e5so6360852iof.2;
        Mon, 11 Jul 2022 16:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jKnFEt3v9Ij4sGBUlCkc8S9Apq19vugwTmTpFoHS/4U=;
        b=ldct2yN0bRqZ2MZTi8e7ucKszbNoolzL528Df0vw2XNzfD/7nRWp1nQHA7mOIdYRiC
         yzyaetCfXziQ4+aTvwbBcyiyCMyckrJfZyTk8iLCTrwVHD36mx86WNM4UTj+KEPr6/uN
         /wCdw8KZprsmxXJWIQW2MoyuE/gG5PC2dnoMK+SmAYvIDFROhys8ffYp1yYhrkrAPOBD
         LcIjxklkSP++suV2z5YuzJnX0SWF4RrTK1JISmYIxH7ITnHqycRrqmydUuhW9KiujkUY
         W48NV8fPtiGRwHEAY2yVTSD9X0lQEI1zG63KEMY8VdeN5E+sQdmgV13halyvoo8pIidI
         qlzw==
X-Gm-Message-State: AJIora+wasxXiz0784RzLnyh0Cje4ADIRIeu+c6ZfWzKs4WyExDgYcyv
        WafJ4HyQW0tHop2FXTvzew==
X-Google-Smtp-Source: AGRyM1viSKiUNw6YfRQlp5Lz66WqirzHrgbr9bZGtdkZjNdVo6JOFKiC/ZhAfq1WhdMv+gAYL9IYxA==
X-Received: by 2002:a5d:8d94:0:b0:669:64ff:5172 with SMTP id b20-20020a5d8d94000000b0066964ff5172mr11088052ioj.163.1657580813735;
        Mon, 11 Jul 2022 16:06:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y12-20020a92090c000000b002dadcb25d4esm3090474ilg.59.2022.07.11.16.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:06:53 -0700 (PDT)
Received: (nullmailer pid 438820 invoked by uid 1000);
        Mon, 11 Jul 2022 23:06:51 -0000
Date:   Mon, 11 Jul 2022 17:06:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/4] dt-bindings: pwm: fix microchip corePWM's
 pwm-cells
Message-ID: <20220711230651.GA438786-robh@kernel.org>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
 <20220708143923.1129928-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708143923.1129928-2-conor.dooley@microchip.com>
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

On Fri, 08 Jul 2022 15:39:20 +0100, Conor Dooley wrote:
> corePWM is capable of inverted operation but the binding requires
> \#pwm-cells of 2. Expand the binding to support setting the polarity.
> 
> Fixes: df77f7735786 ("dt-bindings: pwm: add microchip corepwm binding")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
