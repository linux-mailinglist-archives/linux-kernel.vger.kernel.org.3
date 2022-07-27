Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2A582A27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiG0QBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiG0QBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:01:00 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FEA4A83D;
        Wed, 27 Jul 2022 09:00:59 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id y197so13034763iof.12;
        Wed, 27 Jul 2022 09:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUIs7DBnCsR9cP62lpQKrDWjtHiCWXhqawFuOwvIork=;
        b=KJ8oRdswQ1XFgAjwIrm4JIf6r15D/jpgOydOfp1RvPz1HnPt+nO6NOBX/g1C0UEHRb
         y74/XJZmEV2CybIu3xX+gUuLREjivcuW+rE4OvBENd1RhTv8TNROVkcLo0ChPfHICbtA
         ENhr5PXNPUpT7vkTEjWa39YiDplgeiWFFVOqmee77O5oB1rfYZ8Xi4xvkevyd3k6dBM7
         S2v13vkvhjn01bU3GUN6GoPpl9CCRXKVVz5y8h+BiOw6Hr5+3pUDn7ry3qgQ22W+SKSQ
         EoVHxXxOehAQ+8xCU1+S9FIjeTNO1Bk8ntNRbPbEQ9vBcoBG1nbBv66oC+1Mvr15LI6J
         4Adw==
X-Gm-Message-State: AJIora9jB/BzbO0iUt7Q9e0gtWwjwn/Jlk+NDzlbBkerCh1T+axGn00K
        QD96sgyYFcv1yHPkd6408Q==
X-Google-Smtp-Source: AGRyM1sWxuWqBZ+/pnkqKc4dOYIKgmM7u9Z/u1EpfWc5rboGgsQ69l5hTpQ6oZfVbOxSBQsTzRwDwQ==
X-Received: by 2002:a05:6638:d15:b0:341:610d:5472 with SMTP id q21-20020a0566380d1500b00341610d5472mr9165526jaj.188.1658937658422;
        Wed, 27 Jul 2022 09:00:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b8-20020a920b08000000b002dc06989d86sm7017921ilf.52.2022.07.27.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:00:58 -0700 (PDT)
Received: (nullmailer pid 2755041 invoked by uid 1000);
        Wed, 27 Jul 2022 16:00:55 -0000
Date:   Wed, 27 Jul 2022 10:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        George Sun <george.sun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, devicetree@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>
Subject: Re: [PATCH v2, 1/3] dt-bindings: media: mediatek: vcodec: add
 decoder dt-bindings for mt8188
Message-ID: <20220727160055.GA2755004-robh@kernel.org>
References: <20220727023721.31945-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727023721.31945-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 10:37:19 +0800, Yunfei Dong wrote:
> Add decoder document in dt-bindings yaml file for mt8188 platform.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml           | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
