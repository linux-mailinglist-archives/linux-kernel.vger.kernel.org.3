Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438834F66DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiDFRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiDFRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:18:52 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DEA3CF490;
        Wed,  6 Apr 2022 08:15:34 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-de48295467so3245513fac.2;
        Wed, 06 Apr 2022 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+ED+sR+qRf0zwLS0gXqp8dJnXQFBqtZvdW8ue++BTs=;
        b=5NKMyr8x/tGB5a0svuDhPoKmDaucpq4EFabNKLshLa5/hGQHYgiDlMCNk7XYqjC/RI
         NRiaK0Itgmio1f4A1MXFOCIVoxhjqG/RhjryGvzNGFiMQAPwxjh+FP4M3oXKKNz/wasH
         xPiJUIy9s9gzCc0k2KNvMPN/1dAB5CR7oyppJwfUh3fVKAA3kEnTZjpSH0lVXDRxvWw4
         3QiDpdEWtVnoJ/AKdI6vscdWe228lBcfQSxmntAh0X2JQ2AU56yXKa9UBv9lN2+ONiiw
         BJSbbsdXV56eGErKmNdP308vmib8+eDHrDKgQL9QxDIqPlqhrJSaBhaNqioTOXiWmRRg
         EDOg==
X-Gm-Message-State: AOAM531kvK7hSPFPR9M9Ex3QrBCVwTwqNImURvZd/9tcvsS5Hp9gdrZA
        OW0/a3M7hrtbDJ8gc0mQfA==
X-Google-Smtp-Source: ABdhPJzgBHcySaaFvNECTinQeNeU1dgeUNA45/xoDtws5ZDF6hnlDSoHsqpL6P19iakXO7w7cj/3fA==
X-Received: by 2002:a05:6870:e0d1:b0:e2:1c3b:cca2 with SMTP id a17-20020a056870e0d100b000e21c3bcca2mr4072699oab.163.1649258134207;
        Wed, 06 Apr 2022 08:15:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a9d2a87000000b005af548abe73sm7129649otb.4.2022.04.06.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:15:33 -0700 (PDT)
Received: (nullmailer pid 2263515 invoked by uid 1000);
        Wed, 06 Apr 2022 15:15:33 -0000
Date:   Wed, 6 Apr 2022 10:15:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        p.zabel@pengutronix.de, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, daniel@ffwll.ch,
        robh+dt@kernel.org, rex-bc.chen@mediatek.com,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chunkuang.hu@kernel.org, jitao.shi@mediatek.com
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dpi: Add
 compatible for MediaTek MT8186
Message-ID: <Yk2ulZODO9cHRjN/@robh.at.kernel.org>
References: <1648727917-3099-1-git-send-email-xinlei.lee@mediatek.com>
 <1648727917-3099-2-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648727917-3099-2-git-send-email-xinlei.lee@mediatek.com>
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

On Thu, 31 Mar 2022 19:58:36 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dpi for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
