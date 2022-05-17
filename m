Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91052A9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351656AbiEQRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351633AbiEQRx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:53:58 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C693F88C;
        Tue, 17 May 2022 10:53:57 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id i66so23172428oia.11;
        Tue, 17 May 2022 10:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YsDesghEDI/0tS5NHJX5qsEzOQ4O5WyEDYrAlt3mmLs=;
        b=64vqOHVRsVfvZfjjSAoE9ift0brEPuxAVCtF0nbfg03ITHeGvuJpkZWmw46SgzuNs5
         1Q080semW7GrXciv2P8lC8IkXemiITy3I9BaE/IHDByaM1xxvuQd/8lAf1wMbgZLZxWT
         LOEpRFRokr7vwoh3kGXebeeNyOnSBqDQftvT9WTZrxRRnWlqK+6WP3Xx1jSaEyGubwEp
         FYNHIvIf7Q7Z6CPY/QLws/eXvD5AE2CBqvQRbE/X/GY9yHClcOl+HDm7neOIXECXCYrK
         vJf33jMXRVhUCRuwV91EcTz5EB+0Qw2Gt8V1eC6Gg3VNJuTeOGB0DV/T8uLRvJtO4YCH
         cCDw==
X-Gm-Message-State: AOAM532tWYK8V9IpxgoDUGBsk9HZsxTwKX4J2+z0Dp/sOtb+3Ch6DsiL
        Gd2CEup/ahb/wmEZtLfV9g==
X-Google-Smtp-Source: ABdhPJwljlblhzDw8zaW7HVqTSFpVeLgpJoxWDJdz7BuwXhztpSN+kRl6+3UUY5tJXYbETz/hauMvQ==
X-Received: by 2002:a05:6808:1302:b0:326:dbcf:a2d0 with SMTP id y2-20020a056808130200b00326dbcfa2d0mr16468689oiv.106.1652810034896;
        Tue, 17 May 2022 10:53:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p9-20020a05683019c900b0060603221276sm60670otp.70.2022.05.17.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:53:54 -0700 (PDT)
Received: (nullmailer pid 1316050 invoked by uid 1000);
        Tue, 17 May 2022 17:53:52 -0000
Date:   Tue, 17 May 2022 12:53:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     drinkcat@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        cellopoint.kai@gmail.com, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        randy.wu@mediatek.com, xiandong.wang@mediatek.com,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, allen-kh.cheng@mediatek.com,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        pihsun@chromium.org, hsinyi@google.com, jason-jh.lin@mediatek.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        river.cheng@mediatek.com, roy-cw.yeh@mediatek.com,
        tfiga@chromium.org, devicetree@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: Re: [PATCH v15 1/3] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
Message-ID: <20220517175352.GA1315998-robh@kernel.org>
References: <20220512092306.6895-1-moudy.ho@mediatek.com>
 <20220512092306.6895-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512092306.6895-2-moudy.ho@mediatek.com>
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

On Thu, 12 May 2022 17:23:04 +0800, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 85 +++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     | 65 ++++++++++++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    | 70 +++++++++++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml | 58 +++++++++++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  | 71 ++++++++++++++++
>  5 files changed, 349 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
