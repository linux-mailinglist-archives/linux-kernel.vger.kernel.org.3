Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551652B007
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiERBmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiERBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:42:17 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD04541A6;
        Tue, 17 May 2022 18:42:15 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-f189b07f57so926245fac.1;
        Tue, 17 May 2022 18:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crkI7+HwsdAoc3Iq1GjjnJUYtoumtzV3pILJENOsucw=;
        b=paDn/idW6m4wLhw5KkJ19HKat1dPY4xuzAKWb06qPkjqubnZn6cclKGyOMycNGK2C+
         FjoSrSil2mnNsfeRoHtRLs5yLQuMqW2MKjYCu7I+oBhMOOVhwKTDMx9CV5BaWND4ARDM
         y9vs8xKR+7CC+UW8/CghtFpX5J7IXtShVBc026/Hwe1Rp0DJav5C67buK1YlsEJU1Wyj
         W562SnAl0ONNIcvGkH6Ky3qJOFBEfCD+F+EX1oiojLqad8QVIcQ21ktt6588AOQ4jnAp
         q94dXK5Yi6CZcq30modnskb0GZLC9qy8yZkf2dB0Slj72Ov2o9KDUGHe9SuFxF6FqO2P
         Sp2Q==
X-Gm-Message-State: AOAM532p1C9c214cejlyu0vD/lhKzHnlZRv4ZK/ShpGX8vBNmU+kAi/P
        xlQaW3Bi5/84Ynr0rsN0KQ==
X-Google-Smtp-Source: ABdhPJxdxYNaSg4qceB2OCZjxphvGORaZqyQisZZrLDaSde4Qt++qmPmm1WVwJIhjbJG92ClP0kR9g==
X-Received: by 2002:a05:6870:65a5:b0:f1:9153:c355 with SMTP id fp37-20020a05687065a500b000f19153c355mr8456281oab.163.1652838134589;
        Tue, 17 May 2022 18:42:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r41-20020a05687017a900b000f15ca674b2sm406734oae.52.2022.05.17.18.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:42:13 -0700 (PDT)
Received: (nullmailer pid 2045103 invoked by uid 1000);
        Wed, 18 May 2022 01:42:12 -0000
Date:   Tue, 17 May 2022 20:42:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     joro@8bytes.org, krzysztof.kozlowski+dt@linaro.org,
        yong.wu@mediatek.com, will@kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH 8/8] dt-bindings: iommu: mediatek: Require
 mediatek,pericfg for mt8195-infra
Message-ID: <20220518014212.GA2045069-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
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

On Tue, 17 May 2022 15:21:07 +0200, AngeloGioacchino Del Regno wrote:
> The MT8195 SoC has IOMMU related registers in the pericfg_ao iospace:
> require a phandle to that.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Note for Rob: as of now, there's no iommu node in upstream mt8195 devicetrees yet.
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
