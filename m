Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7247471F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhLNQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:06:59 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41980 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhLNQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:06:58 -0500
Received: by mail-ot1-f44.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so21341015otl.8;
        Tue, 14 Dec 2021 08:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWeglYX86Kh/jx6qsj0rbVo/zA4v+6dDtBcJ8ZfP9I8=;
        b=ATx2CtZW8+uN1RxVBwQNl1zycF+FIBAExw/Rj52MkHnT1Rl5t+aLy+uFgVUVKHynAj
         kJt/daxdNjPuFOgzXEJhPKnuEijsGtJI5Dd2wDxyUFv72wRqe7RuYh5piiwD+FPur5Aj
         BU5q5ImYPzWP7/gIoHwQHwIDw9f3xXAf6oPRcbnxKN5v61Hx7HT7Pe3oi9Tcf8dxwNG+
         SpwTeRJhhi72iWefDhF/Y4jirOiBjK5vTlXZiMUqLcV8vMTXogYYdTntwKtSAB3DDnxM
         0igbq/WAIiBQjKpL3DdEy9VnqfmZXgNuEyGfXxrYs7oX7H6VPIwG6YAOBFKYA0MZF7Wm
         yfgA==
X-Gm-Message-State: AOAM530yVb1a7mUZaLj4DAWOrTLdgMLtiDvxIU2pDiX3h0K/2PAJ2CAl
        5Or58YSzZ4Bb80E0rcZ5Ig==
X-Google-Smtp-Source: ABdhPJzkIOmtEo5hn0+hMuoG7HvhDOIIqOzzWYSglSMtBtWvqRjpOAt28cIAYU9DiODBsaihaQ23kw==
X-Received: by 2002:a9d:5190:: with SMTP id y16mr5121669otg.364.1639498017370;
        Tue, 14 Dec 2021 08:06:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j5sm48247oou.23.2021.12.14.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:06:56 -0800 (PST)
Received: (nullmailer pid 3472932 invoked by uid 1000);
        Tue, 14 Dec 2021 16:06:55 -0000
Date:   Tue, 14 Dec 2021 10:06:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Fritz Koenig <frkoenig@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@google.com>, devicetree@vger.kernel.org,
        Steve Cho <stevecho@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v13, 15/19] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for mt8192
Message-ID: <YbjBHwMXFwi/Sds4@robh.at.kernel.org>
References: <20211213084141.13363-1-yunfei.dong@mediatek.com>
 <20211213084141.13363-16-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213084141.13363-16-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 16:41:37 +0800, Yunfei Dong wrote:
> Adds decoder dt-bindings for mt8192.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> Fix comments from rob.
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 265 ++++++++++++++++++
>  1 file changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
