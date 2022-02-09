Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E094AFE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiBIUhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:37:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBIUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:37:05 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726AC0DE7EB;
        Wed,  9 Feb 2022 12:37:08 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id r27so3774141oiw.4;
        Wed, 09 Feb 2022 12:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIhHhyih/7ZhXtvq9LuF0lqvT9O7H7X5U0jczH+YH4s=;
        b=ONezZheLvcATD8W+JN5Y7O2A+xF3zeh6aAtlrUIzcmzQKGMKa6+oCj+Ja30PjsY95V
         RcE3BvLPzCcuovDMR7TLcQEX+EnA4kmOvW/Yrd/Dj/W+jIpgNiJnE8oQCOMewh08qNUh
         54q6AO95PwlKh+glGPYNQAXt8Muw3eypK9iunMMyBKUBmhYe3ZVPE46PsbdOFRYS+tGX
         h0305C+GiYI7nDdY/sZjtplOeZ0Q752tXAfE7Eoie5GT5OOO4bOOH71C4VSswEH3QL5W
         517sVsb4QbGQZrB/LKdI2PNEElrqL4Q+8q1d5ugMgp4qLjK6l4GtD4aB2DUW9Mx/Zub6
         GiMA==
X-Gm-Message-State: AOAM533mpMny1UkdiceSlTmmtInjsSYUkm5AEapsOuEuauvOyFp4jxHp
        7V41lFnbVXuwjXOKhG90QQ==
X-Google-Smtp-Source: ABdhPJy4JKuU/2pyAT8/RT39URC0YEPefqUshCvwl80gipjwlzTCz6tyUtL+RPSK1CFrfBlAbwLDDQ==
X-Received: by 2002:a05:6808:211c:: with SMTP id r28mr1739810oiw.4.1644439027436;
        Wed, 09 Feb 2022 12:37:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg34sm7485772oob.14.2022.02.09.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:37:06 -0800 (PST)
Received: (nullmailer pid 862149 invoked by uid 1000);
        Wed, 09 Feb 2022 20:37:04 -0000
Date:   Wed, 9 Feb 2022 14:37:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2, 1/7] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for lat soc
Message-ID: <YgQl8CtttQ99+8lB@robh.at.kernel.org>
References: <20220128035440.24533-1-yunfei.dong@mediatek.com>
 <20220128035440.24533-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128035440.24533-2-yunfei.dong@mediatek.com>
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

On Fri, Jan 28, 2022 at 11:54:34AM +0800, Yunfei Dong wrote:
> Adds decoder dt-bindings for compatible "mediatek,mtk-vcodec-lat-soc".

What's lat soc? How does this relate to what's already there in this 
binding.

The subject space is limited, avoid saying the same thing twice 
(dt-bindings).

> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index 6415c9f29130..a3c892338ac0 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -189,6 +189,55 @@ patternProperties:
>  
>      additionalProperties: false
>  
> +  '^vcodec-lat-soc@[0-9a-f]+$':
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mtk-vcodec-lat-soc
> +
> +      reg:
> +        maxItems: 1
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description: |
> +          List of the hardware port in respective IOMMU block for current Socs.
> +          Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +      clocks:
> +        maxItems: 5
> +
> +      clock-names:
> +        items:
> +          - const: sel
> +          - const: soc-vdec
> +          - const: soc-lat
> +          - const: vdec
> +          - const: top
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - iommus
> +      - clocks
> +      - clock-names
> +      - assigned-clocks
> +      - assigned-clock-parents
> +      - power-domains
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.25.1
> 
> 
