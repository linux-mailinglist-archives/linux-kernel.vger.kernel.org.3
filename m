Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C54BAD50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBQXpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:45:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBQXpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:45:02 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660240E4D;
        Thu, 17 Feb 2022 15:43:30 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q8so5665805iod.2;
        Thu, 17 Feb 2022 15:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7FBp4Uo9WR66JeSaowaJzLczvvMhuR66KyZhuYXKE5g=;
        b=kNBxCn6iyWb4LJCWPf7HxKXHOy0/HJxO32RrnCFmm3nMSqH1/3mJ+H/sMUvbkNrQxr
         F56psP3nh62SK6qGZpVg8yLCYGrWkSFwSAKxDs5WdY+4Bjwfp5iYv753IDJQ7wr+wDmd
         0wX2z/fOb1EbAVJTAcWfFz3RWWJ2kgvuLeBFd60kcw2xjrhhV/yL7BLTnl4ASruoq7xu
         FygoBN/6Fk0MW/8vWLfK65j0vqHRRgqf5L6794PMC8G6ypzEA7L1HcGp4Cik2JKKMTCf
         mRc3JZrRn8DHs6+jyS+Cv/0q33UpfRbIMxUYvPz0BCyswDhnBflBZ+IgpOwut+8jUH6U
         ZH/w==
X-Gm-Message-State: AOAM532Rpu5JrGzDLNYk6MOG6zGN4lq+CWpQJIimYGXBMN/vZuexuB/X
        rmGPfziM/GFxfVnJB81NR3dg+b2v5g==
X-Google-Smtp-Source: ABdhPJzzoMYuRcsqQZNfeNmCERtRhjk2WYSpOj6vT0HjTShBxZ1MSOEkhohwfF7Bob1fHv7v9fvEQg==
X-Received: by 2002:a6b:8d4b:0:b0:63e:baed:9c69 with SMTP id p72-20020a6b8d4b000000b0063ebaed9c69mr3418316iod.55.1645140515943;
        Thu, 17 Feb 2022 15:28:35 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y16sm2360429iox.46.2022.02.17.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:28:35 -0800 (PST)
Received: (nullmailer pid 3970803 invoked by uid 1000);
        Thu, 17 Feb 2022 23:28:33 -0000
Date:   Thu, 17 Feb 2022 17:28:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        kavyasree.kotagiri@microchip.com, herbert@gondor.apana.org.au,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        claudiu.beznea@microchip.com, linux-crypto@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PACTH v4 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Message-ID: <Yg7aIXP2QjOiFlIK@robh.at.kernel.org>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
 <20220211093922.456634-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211093922.456634-2-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 11:39:20 +0200, Tudor Ambarus wrote:
> Convert Atmel AES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "aes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../crypto/atmel,at91sam9g46-aes.yaml         | 66 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 20 ------
>  2 files changed, 66 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
> 

Applied, thanks!
