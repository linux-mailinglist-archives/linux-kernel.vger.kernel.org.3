Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712DD4E572B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbiCWRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiCWRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:11:32 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7B49F1B;
        Wed, 23 Mar 2022 10:10:02 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id j83so2272268oih.6;
        Wed, 23 Mar 2022 10:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hKrd5H7B7WvqIMdiaPvuwOv1aT0mWRSH/OSMprLgR4=;
        b=FyU61z3ULQu+ggh2Ydmpi4STYh5/cIg9lWETadGTZBYtzujYiTc0F+LSXz68yL44pD
         LvljJfNWgpn6a90iDMpG8TA6SI9ET/3IxsV5/NiLHRZBKAmWrq5fwpp+9hwau8QpknVO
         txkvZenn6+gtnB69KAp3vBziLUqopS//6Hzb/aNonByRWqjqdjWTaKXaYb9d2TScRlx2
         sJGbCXfSqtj9OsQRedDNKfYsJhaLQr29y6a+1HqKxK3dMf9G4Ih+gT2fNj7qaalhd8Hf
         Uf3rcjYt0t9JkYITA5mJyQLHZY+PqeqOkdahKQLJR2lrqyMqcXvt9c7TQ/g+Ekl2NK0M
         2ESQ==
X-Gm-Message-State: AOAM532fuMgWnaAsVD164SC8nPl0by6NIH/e2OLfXsOk5TRNbCUeKa1O
        XPMIQ/mf+zmMf7ed51pnQg==
X-Google-Smtp-Source: ABdhPJx8jPlgF405kvPPYl2lYEG107noZH9leUHMGog8OncHx0ZtDujB9+uS/h2L5Tca9Pa2VoBzyg==
X-Received: by 2002:a54:400c:0:b0:2ef:8951:a271 with SMTP id x12-20020a54400c000000b002ef8951a271mr535618oie.267.1648055401409;
        Wed, 23 Mar 2022 10:10:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 11-20020a05687013cb00b000dd9b5dd71csm184164oat.56.2022.03.23.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:10:00 -0700 (PDT)
Received: (nullmailer pid 94890 invoked by uid 1000);
        Wed, 23 Mar 2022 17:09:59 -0000
Date:   Wed, 23 Mar 2022 12:09:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     aaronyu@google.com, trevor.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org, tzungbi@google.com, devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        julianbraha@gmail.com, linux-mediatek@lists.infradead.org
Subject: Re: [v3 02/19] dt-bindings: mediatek: mt6358: add new compatible for
 using mt6366
Message-ID: <YjtUZ0gbt/KZ4WKH@robh.at.kernel.org>
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313151023.21229-3-jiaxin.yu@mediatek.com>
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

On Sun, 13 Mar 2022 23:10:06 +0800, Jiaxin Yu wrote:
> Add new compatible string "mediatek,mt6366-sound" for using mt6366.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/sound/mt6358.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
