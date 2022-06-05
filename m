Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58AC53DC28
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiFEOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFEOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:09:07 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D411C3F;
        Sun,  5 Jun 2022 07:09:05 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l81so1135419oif.9;
        Sun, 05 Jun 2022 07:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UM1+tAQfwCJxynEEbS7hC4oL/u5ZhtBtswMEBnTz5Q=;
        b=uefNagaEBJlaqgMrzB2++GSGlEStxwJmeM7cD+6P/TnHCNtheJBOa/GyG2OW6KImL/
         tMnc0m951vs7XYUKMDDaLXvXG2hDUibzEpFKTcN48GReBk8Wbt3Ip4MTcv9jlubOmVOy
         crBsiwMvl8zqYqavd/kTqOx0edmm4DpYr5dyEAW5YUQ7f6v9SFvE5jkDzmmTEfY5yii1
         LOKyBq7ZqpAZ3HAZlhgNvSto6sX/CgaEH4/EqZ2ztqGQJd54eNy3fFFXm9dc0RvdmRst
         Qr0u34Tq6bXDVHp5ulrG0051btxX04k1Jjdrk3wuA3NvNIeEbVe0Lba/sQAZHUQ61VCi
         ZsGw==
X-Gm-Message-State: AOAM533/okyVp6/wAkNbUoH+MshV6tPlxgqBhIwJFQT876fP7HDih2mz
        nrjLw8gCU+N2KDrWSdC1OA==
X-Google-Smtp-Source: ABdhPJyGOxXe0HzRZnNWi4FbQzq6WczTjE4jxBsfS8yN/wpmxxzpFnB+68MjLF9B0pyg64rU3VbsQQ==
X-Received: by 2002:a54:4688:0:b0:324:ef47:98b7 with SMTP id k8-20020a544688000000b00324ef4798b7mr11404496oic.29.1654438145200;
        Sun, 05 Jun 2022 07:09:05 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.0])
        by smtp.gmail.com with ESMTPSA id d22-20020a056830045600b00608b8e6fad5sm6417302otc.76.2022.06.05.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:09:04 -0700 (PDT)
Received: (nullmailer pid 3421501 invoked by uid 1000);
        Sun, 05 Jun 2022 14:08:59 -0000
Date:   Sun, 5 Jun 2022 09:08:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: ps2-gpio: convert binding to
 json-schema
Message-ID: <20220605140859.GA3421419-robh@kernel.org>
References: <20220529132638.13420-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529132638.13420-1-danilokrummrich@dk-develop.de>
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

On Sun, 29 May 2022 15:26:37 +0200, Danilo Krummrich wrote:
> Convert the ps2-gpio dt-binding documentation to DT schema format using
> the json-schema.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
>  .../devicetree/bindings/serio/ps2-gpio.yaml   | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> 

Applied, thanks!
