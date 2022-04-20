Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED6507E10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358714AbiDTBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355704AbiDTBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:22:09 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CC32EC3;
        Tue, 19 Apr 2022 18:19:24 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e604f712ecso442366fac.9;
        Tue, 19 Apr 2022 18:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ymt6zLehDv2YaRJlxv7TiKEzkQbOENuBrCPBeLy0sX8=;
        b=Uwi/HvanS9GVl+ErFko6NTkrKjxiwRKDSIUuD/rZWRqv+IxLv664zR9uIaSdhkZdR2
         UK7NV8VzC6i0ZggRFYqhRy8pogsRgHP0cpSYytfxzwZLtYUEjqRMFfiZHhQuTw6yz72k
         zeKu8tb6xfSXCbyKIkPJTD3zvCjcNkiiUwCer+SAapoXsP7dgQDMZG/3lTSJ8Db+PwI2
         6IxxR7hewNua1MICcbiDxuuRDjfZQy1EMB8G81I0qfIuZjyum2/4yxQioSlZHnkNO4Ec
         WIijzifUeZFgggRpe1gSOKVIDBBbz17mFywkrWxiVrBoiSedKl9fiAQdKkv6spmxo7QV
         n0lQ==
X-Gm-Message-State: AOAM531hXXI0Qssaa0jk4Q559wlDUsu8ZsNNskOTBN8zJwLj4jG1wJ80
        7sFMlTzPZJp2RHWqbMHEhYHiNWa6uQ==
X-Google-Smtp-Source: ABdhPJwG/Xsq9q7suyuuPEmJ1/c/c30gxnNuR+j5n45Cv6/bz718vvs/f+CesGdXCOra+fRs+F0SXA==
X-Received: by 2002:a05:6870:5702:b0:e2:9f03:dae1 with SMTP id k2-20020a056870570200b000e29f03dae1mr579743oap.201.1650417564088;
        Tue, 19 Apr 2022 18:19:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u3-20020a4a9703000000b0033336ab4909sm6080383ooi.7.2022.04.19.18.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:19:23 -0700 (PDT)
Received: (nullmailer pid 4040590 invoked by uid 1000);
        Wed, 20 Apr 2022 01:19:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220419180938.19397-4-y.oudjana@protonmail.com>
References: <20220419180938.19397-1-y.oudjana@protonmail.com> <20220419180938.19397-4-y.oudjana@protonmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: arm: mediatek: infracfg: Convert to DT schema
Date:   Tue, 19 Apr 2022 20:19:21 -0500
Message-Id: <1650417561.533052.4040589.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 22:09:39 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert infracfg bindings to DT schema format. Not all drivers
> currently implement resets, so #reset-cells is made a required
> property only for those that do. Using power-controller in the
> example node name makes #power-domain-cells required causing
> a dt_binding_check error. To solve this, the node is renamed to
> syscon@10001000.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
>  .../arm/mediatek/mediatek,infracfg.yaml       | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


infracfg@10001000: '#reset-cells' is a required property
	arch/arm64/boot/dts/mediatek/mt7986a-rfb.dtb
	arch/arm64/boot/dts/mediatek/mt7986b-rfb.dtb

syscon@10001000: '#reset-cells' is a required property
	arch/arm64/boot/dts/mediatek/mt2712-evb.dtb

