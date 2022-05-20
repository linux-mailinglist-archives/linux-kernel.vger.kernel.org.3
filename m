Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184DE52F5B4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiETWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiETWdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:33:32 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12C16329E;
        Fri, 20 May 2022 15:33:31 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id i66so11485291oia.11;
        Fri, 20 May 2022 15:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXDaYfdouwA97Dyh3xFZZ2BaIW2LzW4Se1PNa8S3D9Q=;
        b=OAGwjAfKT45ZI/iYqIRtke9+AZnPnclq8yYtrACiJ1be4Y9maAU73+tGK6U7e4ZGJ3
         EdZxgykMtg73akUMxhfbugE13LOf3SHGdBS7L2GnTAlK15aw8/+Oz5wNOvTf9ypBx3Ka
         jz2SgIaSEbcKpZxIPt6OiIqneLlIi/3kJtvfCfoHsxEQ9DzTfUifqRcMjfaMisGpaHHf
         YG5ULDdvST3ZpGQkw1vdnVkN1t/EtTCPH5RcUEQR4t+aLj1pSulhdXQGLKFeMbo5N9Hu
         Y/0sqb31hDGLHct2VHI0cWqpNbh7ZoLcxxnjo+pp27y5Bq7FR7qHCzy+QdPukWAEkWGS
         qUig==
X-Gm-Message-State: AOAM5310iBug4amcwL9skVFmssApvmvHYMJSm7HSqTEAsclihDgDAzvh
        D4PoQarxvXp34dFYZrsCyA==
X-Google-Smtp-Source: ABdhPJxEqOGnOf4NSH7Hk1LJ68LHOPidjNw1JrZtODYMxN39z+e4TAoUh6dDrjhozXcA7G6zekSwbg==
X-Received: by 2002:a05:6808:11c2:b0:2f9:b58f:5ac7 with SMTP id p2-20020a05680811c200b002f9b58f5ac7mr7100268oiv.132.1653086010592;
        Fri, 20 May 2022 15:33:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a4aac87000000b0035eb4e5a6d6sm1636202oon.44.2022.05.20.15.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:33:29 -0700 (PDT)
Received: (nullmailer pid 374265 invoked by uid 1000);
        Fri, 20 May 2022 22:33:15 -0000
Date:   Fri, 20 May 2022 17:33:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, chun-jie.chen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        runyang.chen@mediatek.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org
Subject: Re: [PATCH v7 18/19] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8186
Message-ID: <20220520223315.GA374204-robh@kernel.org>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-19-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519125527.18544-19-rex-bc.chen@mediatek.com>
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

On Thu, 19 May 2022 20:55:26 +0800, Rex-BC Chen wrote:
> We will use the infra_ao reset which is defined in mt8186-sys-clock.
> The value of reset-cells is 1.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
