Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A284E1F82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbiCUE0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbiCUE0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:26:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55323151
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:25:10 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2db2add4516so143248227b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NSXl8x9VQewgRZHgqXMmZGOEdV3eFjb3sYvvvg6pNg=;
        b=J6gele5F7EmCQLLAJAVg85lJycQ/fkbtMV60Bxn6mvBD54K/cP91HfuCJSamixeAe6
         SMimZpLUVi6GEmvbVU07gyHdeCeiYdtk4dmtLUJ8nH0xQuKRP5nXagiIZ3LrTCv9YfDe
         C+mSOTSyfmPr+Jge0Xnm2nipVd5HfDakmx2EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NSXl8x9VQewgRZHgqXMmZGOEdV3eFjb3sYvvvg6pNg=;
        b=xYHD9zem6kDDSr3pCJwladCXwKXJRM0zV6Z09zZLOQbu+I10UaxYYjhqVHUs3mORvu
         zqeAGQyl9FbDyiyA4TrQHjmMAm74/IO6N51OiD3bQek9lkR5gXZ5k8y5gLWqt4UvR4qR
         nwMAf+EyTes6ZSocOsHXExk+lT6jRPTUBHzdzrnB2lFU2dAIlZnhopVH7Retd1G6NEgC
         Tv5/Ov9o6kbZa5rqWGk21TBoJ81NKpMDvYKx1wzZcEvWGnJMuJGyVzIKFhOw/xdatnSc
         UOy4JJcTD01aBQ7sR+6/JUq3421+7pBTyENfwBHJeld5w9qvtCXy0j9HSSwbsiyx8QmK
         Rbtg==
X-Gm-Message-State: AOAM531tf6xci24IS9yqS4Z8etny9lGXy4tLbvxf08Nc44u0OPRS/ASd
        l7lPebw2jmvLCke3ZDMNBNUEtjl4gkRp3FsAimJ4hw==
X-Google-Smtp-Source: ABdhPJxzqdQkJL+E26J8ZUZbTwrpFeuieBZ6OBpvDJ70M8HbgvzqPpoqzxqTXlsc0yVVk8krFj2m/iV9tyn319SkBwY=
X-Received: by 2002:a05:690c:9c:b0:2e6:4ca0:d140 with SMTP id
 be28-20020a05690c009c00b002e64ca0d140mr502772ywb.161.1647836709475; Sun, 20
 Mar 2022 21:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
 <20220318095417.2016-2-jianjun.wang@mediatek.com> <2e0989c3-7132-6091-5c9e-5dc8d9af22e8@collabora.com>
 <319cf016-55fb-dcd4-9157-ad795c8e68ff@kernel.org> <e0adbb4d-aa87-49ea-d79f-11c5f4fc4bdd@collabora.com>
In-Reply-To: <e0adbb4d-aa87-49ea-d79f-11c5f4fc4bdd@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Mar 2022 12:24:58 +0800
Message-ID: <CAGXv+5GzC_LFd_1uTBDT=2otiUrJn9NGa4g=R4NhED7-p-G9RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, Randy.Wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 9:56 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 18/03/22 14:51, Krzysztof Kozlowski ha scritto:
> > On 18/03/2022 12:12, AngeloGioacchino Del Regno wrote:
> >> Il 18/03/22 10:54, Jianjun Wang ha scritto:
> >>> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> >>>
> >>> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> >>> ---
> >>>    .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
> >>>    1 file changed, 75 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> >>> new file mode 100644
> >>> index 000000000000..868bf976568b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> >>> @@ -0,0 +1,75 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: MediaTek PCIe PHY
> >>> +
> >>> +maintainers:
> >>> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> >>> +
> >>> +description: |
> >>> +  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: mediatek,mt8195-pcie-phy
> >>
> >> Since I don't expect this driver to be only for MT8195, but to be extended to
> >> support some more future MediaTek SoCs and, depending on the number of differences
> >> in the possible future Gen4 PHYs, even different gen's, I propose to add a generic
> >> compatible as const.
> >>
> >> So you'll have something like:
> >>
> >> - enum:
> >>       - mediatek,mt8195-pcie-phy
> >> - const: mediatek,pcie-gen3-phy
> >
> > I am not sure if this is a good idea. How sure are you that there will
> > be no different PCIe Gen3 PHY not compatible with this one?
> >
> >
>
> Thanks for pointing that out, I have underestimated this option.
>
> Perhaps Jianjun may be more informed about whether my proposal is valid or not.

Just FYI, for Allwinner and I believe Rockchip as well, the compatible strings
always list the first SoC the hardware block was seen on known at the time
of driver/binding submission. No generic compatible strings are ever used.

Not sure if that's the general rule or not.


ChenYu
