Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4378B5625EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiF3WQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiF3WQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:16:02 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3945722C;
        Thu, 30 Jun 2022 15:15:59 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id l24so521472ion.13;
        Thu, 30 Jun 2022 15:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ak3+dnp61amEiQ9u+EY3cuHBMwvFNkOIcVD4cKlddrk=;
        b=3K3kN7WLOEo6JiJedzr/1+Pd/kwHHBTlMgsLbE2g3JZ//lPiYR4Yr03vUkA1bmbU3W
         cuv8BgMht4zvoV0p/nHPAs5IjBKC2nt4iq/bzGt7FJWlU74x3JxlQWtbReOPKcy5F+sq
         pyHm0AjrJGyVSga8QCLuNYWvl0VncMcmSluRdSJpWpWEinQo4PU83UkuB2GUnV4wW3Na
         CIDb92B/rzLlcN+/Vu1m1ScbFw0MaA0fCwDrzGX4YCwxproDsSP2JkIF/RFXXtXhyAi7
         Z0c8ZW0Euzu1r+grVamFKRveWdjdvveXeXCueh6JzeEE2bNjFscOAvjmJQoV6+teN0Jk
         fhuA==
X-Gm-Message-State: AJIora/qCyayC4hfS6fE2bKZt9ySqiKs5thdY8gkAeTk4s22Rpj6qFPP
        SUGFd5KmBBjcSP0q4qGJIg==
X-Google-Smtp-Source: AGRyM1vE/h3cXANQTxAFuDv4VQARTKgj8HZVod3l/44O5+NhZJF0h2bjCBppIfPdZR/32eQjnyvy7g==
X-Received: by 2002:a05:6602:13c8:b0:669:c3de:776f with SMTP id o8-20020a05660213c800b00669c3de776fmr5469069iov.124.1656627359098;
        Thu, 30 Jun 2022 15:15:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b9-20020a05660214c900b006762d8becd4sm139051iow.55.2022.06.30.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:15:58 -0700 (PDT)
Received: (nullmailer pid 3418639 invoked by uid 1000);
        Thu, 30 Jun 2022 22:15:56 -0000
Date:   Thu, 30 Jun 2022 16:15:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     airlied@linux.ie, ck.hu@mediatek.com, devicetree@vger.kernel.org,
        granquet@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chunkuang.hu@kernel.org, linux-arm-kernel@lists.infradead.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com, daniel@ffwll.ch,
        wenst@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 01/15] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
Message-ID: <20220630221556.GA3418578-robh@kernel.org>
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
 <20220624030946.14961-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624030946.14961-2-rex-bc.chen@mediatek.com>
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

On Fri, 24 Jun 2022 11:09:32 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DP_INTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DP_INTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> [Bo-Chen: Modify reviewers' comments.]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
