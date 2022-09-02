Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEB5AB81A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiIBSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIBST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:19:27 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0AEDD6;
        Fri,  2 Sep 2022 11:19:24 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12243fcaa67so6667867fac.8;
        Fri, 02 Sep 2022 11:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KW4nmJxC2UWMUp990Fkr+YzerSKZovQARWrLIEvTTQE=;
        b=YrjxiQi883zciSRyEm3L0+C3yfJ+nSwiWQ3TAujslpZM45qDB/yAmHaI8RQEwpW0iT
         heUM8vfBsmQnZ5rzQ+ZsmlZUJMXawBMp2YhX4qlHI4BKUJDmr8CCgylVo30MLOWrh1X3
         m8mYJS0BgncMiJYE05+8cGPXxUBhVuuUYfCCmXsOkbMGpOHMQwcft5defIVlKmVB+Q+p
         SqfERlkWlFEwek+Ux7H6nOv/JOJonI3iHs/Y2Zm+cm2odvqweic1XzE8WH2uftHW7Cae
         4TyjKkUdaQjz9l8u5z58ZBa4J+r2HYQIYNjNVm5rRH6MykEHrDJV3Ok+sCx47pnx7JJ3
         HW2w==
X-Gm-Message-State: ACgBeo16mDTlGOgGANA3Pggz4uhcy4T7jipbg7XrZZo9/C9Vzxb0TdEu
        w3oi3oQIleRL+a9FDh8rUA==
X-Google-Smtp-Source: AA6agR7zJKJQn83IPHVAWk3IbF3tpzJEotiRHoaiAoBWuEU29vlzyuig22drfwWxdqfltEM9aCuFNw==
X-Received: by 2002:a05:6808:45:b0:343:657d:4089 with SMTP id v5-20020a056808004500b00343657d4089mr2421692oic.68.1662142763277;
        Fri, 02 Sep 2022 11:19:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y11-20020a0568301d8b00b006372969fbdcsm1374873oti.26.2022.09.02.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:19:22 -0700 (PDT)
Received: (nullmailer pid 172292 invoked by uid 1000);
        Fri, 02 Sep 2022 18:19:21 -0000
Date:   Fri, 2 Sep 2022 13:19:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     xia.jiang@mediatek.com, Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        nicolas.dufresne@collabora.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kyrie wu <kyrie.wu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        maoguang.meng@mediatek.com, Tomasz Figa <tfiga@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [V7,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec
 compatible
Message-ID: <20220902181921.GA172239-robh@kernel.org>
References: <20220826092904.10283-1-irui.wang@mediatek.com>
 <20220826092904.10283-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826092904.10283-2-irui.wang@mediatek.com>
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

On Fri, 26 Aug 2022 17:28:57 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
