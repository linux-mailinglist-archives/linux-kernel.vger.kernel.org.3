Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F74AFE98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiBIUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:37:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiBIUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:37:40 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CCE00E598;
        Wed,  9 Feb 2022 12:37:42 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so3826860ooa.11;
        Wed, 09 Feb 2022 12:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vvNKi/Wm0VLtELILJszjggawGQx7UYnFBx5UN6T3jA=;
        b=kdxheazUUYXTTKFRyvaq8o0hgUZBOFjzBeooUFeu7iz+aDJZ7W+HN6X8P0XxGmDO/q
         QaJUbx6EWfIwRj0aMsCHEAx2qGXH5+231/8q9eEvBZtC96klTkX50limU252QZRzF2g7
         525rCOVuFTO0i+nAQm6gI6vt/ufUeMG4kYdc8XQrZyseA8MUItr2xA5aLwPVV1ZhFUoZ
         Rfibypr48UjKJ/xqRyHG77zl+e9fUtYISsVNVpmhGfkl1Y5/4xycQcpEpXTpTqN+xpmB
         EBNkhK3o7KV8FLBhn2YMIbYMWAxAbE3msTtNCC+B/xtNpYAVa/L0yEqitu4IZ03c0FOL
         ELrA==
X-Gm-Message-State: AOAM532WYaz0A3+hhlxjlciGrxNn3MTpop/v/w6l+c9kXfS6ZBrvO5dO
        /N0Y+l66G6aSHyADrU15QwqGAuh7LA==
X-Google-Smtp-Source: ABdhPJzDNBwd/NZ7M3FaqezQTKEcdU8xCVOg4y//z9QAs0xMXOadIO7noGIod4pEwfE0Iw17L6nY9w==
X-Received: by 2002:a05:6870:c7ae:: with SMTP id dy46mr1533523oab.309.1644439062215;
        Wed, 09 Feb 2022 12:37:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c32sm7310728otu.15.2022.02.09.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:37:41 -0800 (PST)
Received: (nullmailer pid 863156 invoked by uid 1000);
        Wed, 09 Feb 2022 20:37:40 -0000
Date:   Wed, 9 Feb 2022 14:37:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        srv_heupstream@mediatek.com,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomasz Figa <tfiga@google.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        Irui Wang <irui.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        George Sun <george.sun@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2, 3/7] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for mt8195
Message-ID: <YgQmFEhdM20Zr9NJ@robh.at.kernel.org>
References: <20220128035440.24533-1-yunfei.dong@mediatek.com>
 <20220128035440.24533-4-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128035440.24533-4-yunfei.dong@mediatek.com>
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

On Fri, 28 Jan 2022 11:54:36 +0800, Yunfei Dong wrote:
> Adds decoder dt-bindings for mt8195.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml           | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
