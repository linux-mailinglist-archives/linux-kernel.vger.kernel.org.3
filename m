Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D889352F5B1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353915AbiETWdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiETWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:32:58 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FA163284;
        Fri, 20 May 2022 15:32:58 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5e433d66dso11852687fac.5;
        Fri, 20 May 2022 15:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+A8nYno3K9fjfGCVzllAZ4bC8ICFLl/EZ6hiaypTZ0=;
        b=pElcQPU5terX3e3xy89/mFm23KCrs6dsTbJmFtdFbw3/KwFFt7Jqt9RMna+4bAmTSw
         Jpt0iiJCkoj4S5nWdltaFhI5TSfc/8j3BHPeoq0bobHUatXZHj2x01eV+P1ef5hOTkA1
         l9V4QXx2CZA9XEZ9h65XOpQybLEc4DUQKcfdoT8XjNhvCuqFZq3pOQVeHDtOjC9rKvy0
         GtOIkWP4WYDYYcpX7H5XU0jCohfVEH7/TLKC67Wfgn3KMTGuZ0cqmjwNm4wXoNJwSAmI
         WaOvo2Bj2OBH8/0jgLwQiB7dUV2cF+1kFKhP/fKYBnM2BI7BCQkr5Me/RzVF1bB1YXMn
         Olew==
X-Gm-Message-State: AOAM531M9PQlZa188EiD+FOnO/rgJQKHVpKWeSYLxID38TCMw0iAHr+f
        5ndzSkGpz4xbnjVI5i601w==
X-Google-Smtp-Source: ABdhPJxAYBhJ/Opqa1MfmSNj+qtDt0LMPMLf7JCAo8KdxjvZj/7iZqkk839Elkm3pETPKoROUJKHXg==
X-Received: by 2002:a05:6870:4619:b0:f1:e78d:fd54 with SMTP id z25-20020a056870461900b000f1e78dfd54mr7360868oao.195.1653085977332;
        Fri, 20 May 2022 15:32:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x26-20020a056830245a00b0060afe803e5bsm356937otr.35.2022.05.20.15.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:32:56 -0700 (PDT)
Received: (nullmailer pid 373515 invoked by uid 1000);
        Fri, 20 May 2022 22:32:55 -0000
Date:   Fri, 20 May 2022 17:32:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, runyang.chen@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        devicetree@vger.kernel.org, chun-jie.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 17/19] dt-bindings: reset: mediatek: Add infra_ao
 reset index for MT8186
Message-ID: <20220520223255.GA373481-robh@kernel.org>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-18-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519125527.18544-18-rex-bc.chen@mediatek.com>
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

On Thu, 19 May 2022 20:55:25 +0800, Rex-BC Chen wrote:
> To support reset of infra_ao, add the index of infra_ao reset of
> thermal/svs for MT8186.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8186-resets.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
