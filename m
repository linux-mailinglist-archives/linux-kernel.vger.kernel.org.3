Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1E4AE789
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiBIDEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiBIDCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:02:13 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB69C061355;
        Tue,  8 Feb 2022 19:02:12 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso1052716oop.0;
        Tue, 08 Feb 2022 19:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r9n/VE8ShNQNiwipYWkPFL8cBHsQZxENNYkTj1Nzpt8=;
        b=oGlZXgdAyEOFTaHmEzufmo7zLD2pBL70ptvYL05ZRVpVn17SVjmvUcsKTvQp6q2WYE
         RwEfXMoXj4cQGk3WjJHVw7trvatwhsqY9p1EPMEQzLuUQ9e6LBDzW0tH7MpnGYnOps6f
         51CNlEVfxh15gt/e+wVEK2+vgp+cMqr9USv4aPkSmXs494ZciSZsSuQA42YOD80nhbci
         wofdqSdKgY3K1AMNlliTEMVaA1bpk7L4dvDJObT8o+sjIDsZtYZgTNZ4u9enA1f0wmoV
         52Yuh5aNe5o1Zb+wrznnNTotvdz3Voag/KXuWBtfLIGAmYVTlawF9nvASltbu35XDOho
         hKeg==
X-Gm-Message-State: AOAM530HSidXmuD79vTKmYNNmthwTZJZJIlOd3joX5m+Qd1gLNMzIyuj
        4dR3mwaibWDcyAc33UjsVg==
X-Google-Smtp-Source: ABdhPJzet+Dv7YYDkSGgJ2JnIoD3tapZgHhdllycdoCmXgkx2+9s9J1YxBIMJuyIWUjbzLMqyE9qyQ==
X-Received: by 2002:a05:6870:91c6:: with SMTP id c6mr103120oaf.147.1644375732021;
        Tue, 08 Feb 2022 19:02:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r186sm6264409oie.23.2022.02.08.19.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:02:11 -0800 (PST)
Received: (nullmailer pid 3539514 invoked by uid 1000);
        Wed, 09 Feb 2022 03:02:09 -0000
Date:   Tue, 8 Feb 2022 21:02:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        George Sun <george.sun@mediatek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-mediatek@lists.infradead.org, Tomasz Figa <tfiga@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, Irui Wang <irui.wang@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Steve Cho <stevecho@chromium.org>, srv_heupstream@mediatek.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Fritz Koenig <frkoenig@chromium.org>
Subject: Re: [PATCH v1, 2/3] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for mt8186
Message-ID: <YgMusfSSXXLlyxyX@robh.at.kernel.org>
References: <20220122075606.19373-1-yunfei.dong@mediatek.com>
 <20220122075606.19373-3-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122075606.19373-3-yunfei.dong@mediatek.com>
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

On Sat, 22 Jan 2022 15:56:05 +0800, Yunfei Dong wrote:
> Adds decoder dt-bindings for mt8186.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
