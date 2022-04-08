Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA67A4F9EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiDHVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiDHVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:10:45 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16633A5F5;
        Fri,  8 Apr 2022 14:08:40 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e4so10112145oif.2;
        Fri, 08 Apr 2022 14:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtNOffG7+AZH7DNsHcVDZKDFT7CQVQsPJnnJzJzy/B0=;
        b=PkOtfByCiR5jmrQVboZSq1+farrnY73UKhnjyNAriJA8/QIvu5WXdoekRwSVRzL2lL
         z5YTYwtnHFAcvsVmqR6+a5Ndfycp22Sx/xdspMLwCvvKuV3TqY86ln8j01PThbfIey0g
         xAM1e6fLldnImYN3l3pkgwXoSmRSVGhAYlC7p0L6A+Xdb7R0z+FCMEzlUBJC1prQf5DJ
         eJQqgIbC2bUqCbhIhZ71slBS1XbCvn/Cb7YLnUOjEQ+Kz5t6nn1Lck1rE0TdwxJmJ2dU
         CqtFowSm2WGPvrfAM1P+d2dauUSQ4Egi6d9FZohIegKqHi9+WPbAH3gjobzeaiQCm+Sc
         X57A==
X-Gm-Message-State: AOAM530sptv08/X6xOETWY6KUGY8RxcHprfmDb8URWdKYm61R1yH9CaH
        gm1/6Ey8FHrgU5mLYjzfbQ==
X-Google-Smtp-Source: ABdhPJw4LuNsnZe554pFV/CHUCpgFp+l2b3pXHMu9DJaVTyLpiAabIqOXNn8Rz4CzPeqD4iJjWSqww==
X-Received: by 2002:a05:6808:1893:b0:2f7:5d31:7768 with SMTP id bi19-20020a056808189300b002f75d317768mr818802oib.122.1649452119930;
        Fri, 08 Apr 2022 14:08:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s26-20020a4ac81a000000b00322a2b5d943sm8839792ooq.37.2022.04.08.14.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:08:39 -0700 (PDT)
Received: (nullmailer pid 4069325 invoked by uid 1000);
        Fri, 08 Apr 2022 21:08:38 -0000
Date:   Fri, 8 Apr 2022 16:08:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Tali Perry <tali.perry1@gmail.com>, devicetree@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Patrick Venture <venture@google.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nancy Yuen <yuenn@google.com>
Subject: Re: [PATCH 06/14] dt-bindings: reset: nuvoton,npcm-reset: Convert to
 yaml
Message-ID: <YlCkVo2rJiRKNl/x@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-6-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-6-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:30 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Nuvoton NPCM reset controller
> to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Benjamin Fair <benjaminfair@google.com>
> ---
>  .../bindings/reset/nuvoton,npcm-reset.txt     | 32 ------------
>  .../bindings/reset/nuvoton,npcm750-reset.yaml | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
