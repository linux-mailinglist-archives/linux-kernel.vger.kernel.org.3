Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11E54A031
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiFMUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiFMUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:52:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58FE0C8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:10:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p63so4871320qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=v7I9W+KWz8qCcwRO9hK+FauPyteN/yVzDhLqH8wmqRU=;
        b=qUfbsn7KlSJMoOLXI6w6yy7TrJ1t3GV0eaUVEpVlSmhhSGPrIysNUeydu8ibydKY2p
         1zMc9WXdAnvTmzm/lrM27CFeS6jhwcwhiZx2Ch+XXMkguFXByWQ1/3m9I+9pp8etU2CF
         wrkQRVC0U5MG0ta45bpCFNsfYcLbmavJSAPP3NEu/pDmPwFapsEotpifbzYcKQ5wkiL4
         dAYl9wue9Te1yAbLZJE0fxDNbbZKuu1H0mwbDD3ztzuhlxwL2jF0RXF9WlqjiHKqlmm8
         +eZ7tSpup8IssWLJOtSXTNAsUlDpf5nuAlDTqiciGANTlc+VgbcwYDZbXTeCqb3jVEOo
         vXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=v7I9W+KWz8qCcwRO9hK+FauPyteN/yVzDhLqH8wmqRU=;
        b=mG2Vo/jAqbxbcS5vLu5idJiZknP0rpoj8rpzcQ3EU7WgH2Dxmj8vLcJ5umDhWVHs8L
         cYdlfZJzTP6Z2CxGp/N9l5cyOvjutz02LXKQF3+T3N4lhQt42pNfYFAC+MiVZpPF2Eyx
         hIvBZhKkykNoatXqd2sZL5vxl+YvqQBAVEjbNCDqLIOCwOvfpis/WdPwP7lO4HnKeeUw
         Ph4IM5f07DpwxlTXz8SGp7dLTxFz3Hj5MVgzFQYtvYjUw0IlewchxyUj+YOuGBfckynq
         FvOPd45mmACdgIN7a4oOrezOIqoyf2ZbOxWWF/W9cIzRm+gto6eCplaAH8wi1TXQ9zwI
         kusw==
X-Gm-Message-State: AOAM532D8zYBbRn0KW4Tc+xi1wo+Iny8eNLsZ7tEalu6MGCO/RS1LxIA
        MW0lWVIuKczmRJPNMD6Qg7vSPQ==
X-Google-Smtp-Source: ABdhPJypEb0jxGKtk5VfHQekdsoaNysCZ3OatxB9gwkAI+QgXupZeQPtmwZAmNKNz+Dgb1z5OMMIwQ==
X-Received: by 2002:a05:620a:4e9:b0:6a7:8357:303d with SMTP id b9-20020a05620a04e900b006a78357303dmr1407957qkh.105.1655151007308;
        Mon, 13 Jun 2022 13:10:07 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006a6d60a39d0sm8268202qkp.5.2022.06.13.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:10:06 -0700 (PDT)
Message-ID: <edbb4605c9e30329d2f5a4ff738571acb6b91f1f.camel@ndufresne.ca>
Subject: Re: [PATCH v4, 0/3] add h264 decoder driver for mt8186
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 13 Jun 2022 16:10:05 -0400
In-Reply-To: <20220512034620.30500-1-yunfei.dong@mediatek.com>
References: <20220512034620.30500-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 12 mai 2022 =C3=A0 11:46 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Firstly, add mt8186 compatible and private data, then add document for
> compatible "mediatek,mt8186-vcodec-dec". For mt8186 is single core
> architecture, need to add new interface for h264 hardware decoder.

Would be nice to take the habit of sharing fluster score for this new HW, I
would expect no less then what the numbers you'd get from running over MT81=
95 or
92, remains nice to demonstrate that this was tested and document any oops =
along
the way.
>=20
> Patche 1 add mt8186 compatible and private data.
> Patche 2 add mt8186 compatible document.
> Patche 3 add h264 single core driver.
> ---
> This patch depends on "support for MT8192 decoder"[1]
>=20
> [1]  https://patchwork.kernel.org/project/linux-mediatek/cover/2022051202=
1950.29087-1-yunfei.dong@mediatek.com/
> ---
> changed with v3:
> - fix __iomem not reasonable, align share memory to dram.
> changed with v2:
> - fix sparse and smatch check fail for patch 3
> changed with v1:
> - rebase driver to the latest media_stage.
> ---
> Yunfei Dong (3):
>   dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings for
>     mt8186
>   media: mediatek: vcodec: Support MT8186
>   media: mediatek: vcodec: add h264 decoder driver for mt8186
>=20
>  .../media/mediatek,vcodec-subdev-decoder.yaml |   4 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_dec.h |   1 +
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
>  .../vcodec/mtk_vcodec_dec_stateless.c         |  19 ++
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 177 +++++++++++++++++-
>  5 files changed, 203 insertions(+), 2 deletions(-)
>=20

