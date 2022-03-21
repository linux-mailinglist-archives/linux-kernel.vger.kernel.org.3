Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DB4E3329
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiCUWuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCUWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:50:30 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641A443A51;
        Mon, 21 Mar 2022 15:30:23 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id s207so17759361oie.11;
        Mon, 21 Mar 2022 15:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zbp0hIb8uBy2/xVSmAWjwvVhJzm0B0givR3TBIiOw0Q=;
        b=ECFyqAj1G+nUD67jd/CbWlSsNLp/9ZW/WNWfNTJ9WDvCiWgXbZk5Gah/DCrx3NW2N/
         8SL6t8WK9dM+uLeiUx1bbaSba4Y/w7oO64JDhWwgz0ZOi4HARfurGomyotF+tCKLQS6p
         81e9YrplS6nU1dgzN76mt5SXgSHy52UDGIcpE7Ir/eZWITUY+Le9oAj9sksemJV2HXAc
         0XRDnSgoAfbGBtnAqvCn9ze3B5q662bUCMxS2y25TPgL+P+kvrlahEyOVext+Ho7aERm
         e4yO9z6gBk5096BlSRCTGDrgn8OWMgFE451/ykcEqgX17imcolypywUqCOZ6cuK2dNRN
         mXHw==
X-Gm-Message-State: AOAM532Yt2BJuCtQWjTtF4/Fx3fozl/Com++mFAufxFDXnLGkCZhAGzR
        WpXjVN4DSLQ5FDrtTMiFzg==
X-Google-Smtp-Source: ABdhPJwt1zw6TNwDij87xVlDMEQVe7cTjU5dSscPmUpAKgOWzXQ8WYcqWpTBlrQ/KYGd/g16yMgQ4Q==
X-Received: by 2002:a05:6808:30a2:b0:2da:3ab6:2c83 with SMTP id bl34-20020a05680830a200b002da3ab62c83mr675374oib.206.1647901823127;
        Mon, 21 Mar 2022 15:30:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm2491234otq.80.2022.03.21.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:30:22 -0700 (PDT)
Received: (nullmailer pid 656090 invoked by uid 1000);
        Mon, 21 Mar 2022 22:30:18 -0000
Date:   Mon, 21 Mar 2022 17:30:18 -0500
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
        river.cheng@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v14 4/6] dt-bindings: soc: mediatek: add gce-client-reg
 for MUTEX
Message-ID: <Yjj8eoXmsYRRvb1I@robh.at.kernel.org>
References: <20220317143926.15835-1-moudy.ho@mediatek.com>
 <20220317143926.15835-5-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317143926.15835-5-moudy.ho@mediatek.com>
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

On Thu, Mar 17, 2022 at 10:39:24PM +0800, Moudy Ho wrote:
> In order to allow modules with latency requirements such as MDP3
> to set registers through CMDQ, add the relevant GCE property.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index f825af49f820..a4892979480c 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -60,6 +60,14 @@ properties:
>        include/dt-bindings/gce/<chip>-gce.h of each chips.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>  
> +  mediatek,gce-client-reg:
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property, such as phandle of gce, subsys id,
> +      register offset and size. Each GCE subsys id is mapping to a client
> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1

items:
  items:
    - description: phandle of GCE
    - description: GCE subsys id
    - description: register offset
    - description: register size

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.18.0
> 
> 
