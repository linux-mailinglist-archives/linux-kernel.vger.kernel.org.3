Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42050023C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiDMXGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiDMXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:06:07 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA32255A8;
        Wed, 13 Apr 2022 16:03:44 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso2211823ots.3;
        Wed, 13 Apr 2022 16:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6n2orThYJMK64yUyZXxxDzaxl2UslTETHJ5TJ4xxPU=;
        b=zSVgMlumhIsYBBUDBMFS/HMvtrrWm8sqCNgZN+lKXOmcs/ZA2ZMuJX698NltXd/NaZ
         ceVPh8ulXCkz/qwRAk5VaY3nSg0aL33PvDT5FcMW6dcENb/05qXUr+3UAdyWSvQgm4x0
         sIOj6BAbrOSChgbRbhQmsnnbmXjAOub1XWUuSxAkMe4kyDMn5tjvwyO0ffGlEkCL1OoW
         SC5krvf4iA/7WgWgsQNA6GqcHNllQXQWRwa1QLWnfibo4aLi/Ogy+zZ0rTHp+nisZlrE
         3481Mfr0IYp1qU7x1EUkqGbWaL5wsdQAk+o8FQckL7U03oaiIxjy6K31XbWfMjkoihUP
         CEPg==
X-Gm-Message-State: AOAM533MwX2fqRhLq0j2E3xtALTiCJ20Z3ZP/yUEbUaKJY9sWYX2wo72
        msVQleAkFdgvDpWwF+ji8kykvT28XA==
X-Google-Smtp-Source: ABdhPJx4S2rZ6YIF3m+FvOThc9/KLWF8G4Kb7iko6OSV2RpyAjSqfaz7em5gsvnl9O5ufXXm0kcohA==
X-Received: by 2002:a9d:6047:0:b0:5b2:4003:cfcb with SMTP id v7-20020a9d6047000000b005b24003cfcbmr15452834otj.59.1649891024123;
        Wed, 13 Apr 2022 16:03:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o18-20020a9d7652000000b005cbf6f5d7c5sm152356otl.21.2022.04.13.16.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:03:43 -0700 (PDT)
Received: (nullmailer pid 4104301 invoked by uid 1000);
        Wed, 13 Apr 2022 23:03:42 -0000
Date:   Wed, 13 Apr 2022 18:03:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     jason-jh.lin@mediatek.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        srv_heupstream@mediatek.com, allen-kh.cheng@mediatek.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        daoyuan huang <daoyuan.huang@mediatek.com>, tfiga@chromium.org,
        xiandong.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        river.cheng@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        drinkcat@chromium.org, randy.wu@mediatek.com,
        roy-cw.yeh@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, hsinyi@google.com,
        Rob Landley <rob@landley.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        pihsun@chromium.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 4/6] dt-bindings: soc: mediatek: add gce-client-reg
 for MUTEX
Message-ID: <YldWzq2oiRxUdPz4@robh.at.kernel.org>
References: <20220411074925.25539-1-moudy.ho@mediatek.com>
 <20220411074925.25539-5-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411074925.25539-5-moudy.ho@mediatek.com>
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

On Mon, 11 Apr 2022 15:49:23 +0800, Moudy Ho wrote:
> In order to allow modules with latency requirements such as MDP3
> to set registers through CMDQ, add the relevant GCE property.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mediatek,mutex.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
