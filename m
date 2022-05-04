Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69E51A414
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbiEDPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352473AbiEDPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:33:06 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C82244A38;
        Wed,  4 May 2022 08:29:30 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so1142546otl.0;
        Wed, 04 May 2022 08:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NQ3hOnaopgb1u4v6GSL1A1TZUSjB62fOKP/GjKT+74=;
        b=DAm7MVpSfghPXqvUHjSJoQQfTOXgxwf+bVJASM7Jlh4ObPENY5GuCWxCi0Fcf1H6SL
         vnKgLWQ3Rd3lQye9UKUkgyY4rvIrTh+Zjd216cmzTu251zksgyub/1BWuUvSyxZCCK2/
         d+929IK/hEgAwKFaBLcfwAoDypFbNEsgBO5HqGZdSarmnv4t5pTfzAdYZp33wLSnC4H2
         67Wv5pPylympuClPrLaxq6BmqHo9caqc6aO5b2jeY6iskDHRYYVYgdotkeoqql5plx6i
         O0bQPnV1s8Ug7o1eaok8IEAKhSI9nRGa0fZ4YnKusBnQtY1Y3EXvV3x+5Pq4+qyx/lIF
         Svgw==
X-Gm-Message-State: AOAM530l8KEeBEjGziHCT53LjEwHZpnOe1WNYk7cSqB4IUtISQFd7K8a
        hFaNAZHCSeKmKZ72+6qrTskKpJjdkA==
X-Google-Smtp-Source: ABdhPJwwPQTqIDALHv8/q9v5utopx/7unnTSMQlFLOQ11ycLjqa2kC8fkIoKQpZgOm7ijGGfQC+RQw==
X-Received: by 2002:a9d:634e:0:b0:605:f40a:258f with SMTP id y14-20020a9d634e000000b00605f40a258fmr7472854otk.375.1651678169476;
        Wed, 04 May 2022 08:29:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p6-20020aca4206000000b00325cda1ffbbsm4339035oia.58.2022.05.04.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:29:28 -0700 (PDT)
Received: (nullmailer pid 1744191 invoked by uid 1000);
        Wed, 04 May 2022 15:29:25 -0000
Date:   Wed, 4 May 2022 10:29:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: Re: [PATCH 03/13] dt-bindings: arm: mediatek: Add MT6735 clock
 controller compatibles
Message-ID: <YnKb1aDgiUKprKSS@robh.at.kernel.org>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
 <20220504122601.335495-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504122601.335495-4-y.oudjana@protonmail.com>
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

On Wed, 04 May 2022 16:25:52 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add compatible strings for MT6735 apmixedsys, topckgen, infracfg
> and pericfg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/arm/mediatek/mediatek,infracfg.yaml          | 8 +++++---
>  .../bindings/arm/mediatek/mediatek,pericfg.yaml           | 1 +
>  .../devicetree/bindings/clock/mediatek,apmixedsys.yaml    | 4 +++-
>  .../devicetree/bindings/clock/mediatek,topckgen.yaml      | 4 +++-
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
