Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6777D4D6C46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiCLDme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCLDmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:42:33 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B35225012;
        Fri, 11 Mar 2022 19:41:29 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so12816748oos.9;
        Fri, 11 Mar 2022 19:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oNsSbU81OUsNipcqGi4kDdt9Jb+DagFs8iHskSA3Mxg=;
        b=G2gfXOPnSBRJvK833Z+BW3ASY7gF/5SVfzvl2Zeo9MX2RgQXTnL2p8VeZ7FXGOJUTw
         cmfD00QP5FcLTDRZE4xgHY6q9+6BBlDCUQ1F1Un2+Eh60K5eBHbYJQxJ6xviEyUC6zBq
         fvVu4V9rklUeV6zaWdUgdwxIgqI39U+lvZQYgbn/mCyyZl+44AH9kFAQBUD8nc+S1liI
         ju7U0uLnpBCfEwUNHAvilyICeeNJXT5lU60CfrpM12JwrLXIFjlc3267vEdH17O2eQgW
         MNC26Qjl99L67p9JGi+pMOpZydHWyjwTPPRe8Kh1LyH0nW84fHNRfzxcLAZWaJ+kCNXR
         p34Q==
X-Gm-Message-State: AOAM530NL6uvTMniIepybJZb/2JjTmuQK5Mvj1lbKlaWliuv8gpfChOB
        4Vrpo+rSSmbX5qfWeQcQ5OkrPqO8ig==
X-Google-Smtp-Source: ABdhPJwFT/b/Tqt8IBJIG7pfi25dMZItnO6F40ExssZ51LpuYW2i+GHVenEJv+UvSbQesICiPJRAtA==
X-Received: by 2002:a05:6870:f150:b0:da:3ad6:c149 with SMTP id l16-20020a056870f15000b000da3ad6c149mr12626103oac.51.1647056488732;
        Fri, 11 Mar 2022 19:41:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056808148400b002d9be41b179sm4800151oiw.50.2022.03.11.19.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:41:27 -0800 (PST)
Received: (nullmailer pid 724637 invoked by uid 1000);
        Sat, 12 Mar 2022 03:41:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220311235119.523374-3-linus.walleij@linaro.org>
References: <20220311235119.523374-1-linus.walleij@linaro.org> <20220311235119.523374-3-linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] dt-bindings: gnss: Rewrite sirfstar binding in YAML
Date:   Fri, 11 Mar 2022 21:41:25 -0600
Message-Id: <1647056485.116768.724636.nullmailer@robh.at.kernel.org>
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

On Sat, 12 Mar 2022 00:51:18 +0100, Linus Walleij wrote:
> This rewrites the SiRFstar DT bindings in YAML.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/gnss/sirfstar.txt     | 46 ------------
>  .../devicetree/bindings/gnss/sirfstar.yaml    | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
>  create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1604572


gnss: 'lna-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/omap3-gta04a3.dt.yaml
	arch/arm/boot/dts/omap3-gta04a4.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5one.dt.yaml

