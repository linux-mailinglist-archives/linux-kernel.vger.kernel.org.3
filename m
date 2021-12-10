Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB15447085C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbhLJSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:21:01 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44991 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhLJSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:21:01 -0500
Received: by mail-oi1-f179.google.com with SMTP id be32so14272730oib.11;
        Fri, 10 Dec 2021 10:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YU9YCbZbDktrwFwYhXC085Scw8TfNhTNhBZqDcowh58=;
        b=2LVjZJyHC0bzx2BkJAb0Cm1VRMu1LuzLm69vTEyVoyl28sBTPhrsz4MjkOX1TIriOM
         UDRa4oyC7Xn84PCypw+esFRELdoUY719T1TOgQKhavbnMRpiI+vhfggsZyPkHu0U9atr
         PR283SAEBY1bSqBdpeXpIxUBqhN6vCzIAl8yQXlQ9WFTtDWmKZn+9/5vQN1lKVg9tcSh
         wAMERXlr9AILLVeB+U4G+cUdxJ9BXJIZjWIMSxDkxxMDHEzf3SL8p/7S5s1AEOfsJK3V
         W2e37I8dX60CU4/A4sTu+9792RnQiy6HawkCS58YX2u+T8O0oA82RCjlg6Eu1iV6mjO2
         kJ7Q==
X-Gm-Message-State: AOAM531WBz3H2q+Dc3owQkCIbLYw0oEEGnYhcbHFNY7jBBohKN+Uqszr
        JGF6S/kQUNcATYRKJv3Dxwktm7jVHA==
X-Google-Smtp-Source: ABdhPJyvpSgennWM9D8Uf+LQaqbHK2gVSasZ6S9vGBlFwcRSN30Q22MHR58rfH44QR08viRIKDt9jQ==
X-Received: by 2002:a54:4692:: with SMTP id k18mr13899661oic.93.1639160245462;
        Fri, 10 Dec 2021 10:17:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bq5sm930460oib.55.2021.12.10.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:17:24 -0800 (PST)
Received: (nullmailer pid 1641340 invoked by uid 1000);
        Fri, 10 Dec 2021 18:17:21 -0000
Date:   Fri, 10 Dec 2021 12:17:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
Subject: Re: [PATCH v10 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Message-ID: <YbOZsd+zNmwOpB4x@robh.at.kernel.org>
References: <20211202062733.20338-1-moudy.ho@mediatek.com>
 <20211202062733.20338-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202062733.20338-2-moudy.ho@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:27:31PM +0800, Moudy Ho wrote:
> This patch adds DT binding document for Media Data Path 3 (MDP3)
> a unit in multimedia system used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rsz.yaml     |  65 ++++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    |  67 ++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml |  57 +++++
>  .../bindings/soc/mediatek/mediatek,rdma.yaml  | 216 ++++++++++++++++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  |  68 ++++++
>  5 files changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml

I'm not a fan of bindings/soc/ either. Put everything in 
bindings/media/. What's the difference between these blocks here and 
the version used for display? If they are the same h/w, then the binding 
needs to be the same. How they get used is the kernel's problem. 

It looks like the display ccorr, rdma, and wdma aren't documented. Fix 
that before you add new stuff.


> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> new file mode 100644
> index 000000000000..d7f104a0f165
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Resizer
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description: |
> +  One of Media Data Path 3 (MDP3) components used to do frame resizing.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-rsz
> +
> +  mediatek,mdp3-id:
> +    description: There may be multiple components with the same function but
> +      different addresses in MDP3. The MDP3 driver can select one or zero of
> +      them and connect other components in series according to the current
> +      application to form one or more data paths. This property indicate the
> +      selection order of the same components.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]

Again, an index nor an alias is the right approach for this. Use DT 
graph like others do. 'It's too complicated' is not a reason unless you 
show how and why it won't work.

Rob
