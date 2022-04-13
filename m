Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539FC4FFDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiDMScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiDMScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:32:11 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9131DA4F;
        Wed, 13 Apr 2022 11:29:50 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id q189so2954498oia.9;
        Wed, 13 Apr 2022 11:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GHDZJGdlID6AtWEELApFyX5XRyr/rxJuuRGXdTraOus=;
        b=WjCI+83Stf7KG3t/mG5uSwctEQph1vM/4D35o+hKuYDiZ2vYH3lrQ+1YRiYgsikok+
         U/go+ArXmnDuN8Mjeiq+pSSLqvoHDY/A4Ij79b40KcGNkVV9Cow/ivFoMf/Xrykq0Yc7
         FtGHPIDkY0Fx/lIZm0bQYh62wEcO6cANg9+eKgqH8rkdHc4kjGdD3SWKijehVnj9pl1R
         iTK0alc1Z2Q70jhEmxrEvkgCf7Hk13ol1vBwRYHvQ7wRunB/1gezywQaByfCnl441P+B
         8/0PKZFhjfyUE96rV9mmSmQKJz6AI88RHNwkfrnRoTDKdtFMc8hKZfOw1FWRBIuzQFjP
         AdYQ==
X-Gm-Message-State: AOAM531Lc9Zuxegd7dul9jKgkat8cgFDb1xP8ZT+YlzGZh90IIf8aMJl
        UXEsBp6Ks4NODhPE6nSAoA==
X-Google-Smtp-Source: ABdhPJx5swjtX0jDXRp1fN9wJcpuQyarkQAujy8AgxdM5qVYe6Yfq/nt39vdFenxx2uyJzcCst7mUA==
X-Received: by 2002:a05:6808:159e:b0:2fa:6e29:9141 with SMTP id t30-20020a056808159e00b002fa6e299141mr72144oiw.142.1649874589850;
        Wed, 13 Apr 2022 11:29:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o185-20020acabec2000000b002ecf1218c53sm13893844oif.15.2022.04.13.11.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:29:49 -0700 (PDT)
Received: (nullmailer pid 3603766 invoked by uid 1000);
        Wed, 13 Apr 2022 18:29:48 -0000
Date:   Wed, 13 Apr 2022 13:29:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     devicetree@vger.kernel.org, gregory.clement@bootlin.com,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        sebastian.hesselbarth@gmail.com, robert.marko@sartura.hr,
        andrew@lunn.ch, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kostap@marvell.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: mvebu: Document bindings
 for AC5
Message-ID: <YlcWnPVywM19VPi5@robh.at.kernel.org>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
 <20220406032158.1449049-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406032158.1449049-2-chris.packham@alliedtelesis.co.nz>
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

On Wed, 06 Apr 2022 15:21:55 +1200, Chris Packham wrote:
> Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
> SoC.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - Restore syscon and simple-mfd compatibles. These are needed by the
>       pinctrl driver.
>     Changes in v2:
>     - Remove syscon and simple-mfd compatibles
> 
>  .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
