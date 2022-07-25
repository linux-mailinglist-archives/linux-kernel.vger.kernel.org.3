Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8B580738
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiGYWT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGYWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:19:57 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ED252A8;
        Mon, 25 Jul 2022 15:19:56 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id n133so5012500oib.0;
        Mon, 25 Jul 2022 15:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbbhG0x/GmEMqsFPTNhHHd72R0EMBvUmg+t2tR9hUck=;
        b=FX/FHkIsSEKNEpnpEAUocqnJOJLxc79vUUKQQp+Mg2WyT/IYjIua4KWWAOlUuWdE8a
         u8wtyLLG3uZ4GG4YgLribtpkM4Y8x9GxyqPZ5opJdXiBhWtRKhH7Hk/AGLgoPMTBaUlf
         XHdAZGNwoSRyn/mJAqQXBq6i5hW7JK8iA8pw+s9LwG5ahDtXP5QbHBopU7VMpXR+x4tC
         keaBk9CV+DO2Gwc+4XO33cGyLcpghLF9zSTWJ2TI3kD0+BrvX0CcEA8PHCNjlVkWrPP4
         mRvy7r7go7B/ZnFTyL1ie9tiXEo8FGIVMh9jJHFxLz6cbqgrEvVv+tqs2WKSbNl87u3p
         XCNw==
X-Gm-Message-State: AJIora9PnC0OQBHBqSEDJghdBzbQld9nrR8oNN4odAstasbZth6cnniq
        S+5AP64xSKC8bc1HZyCYzg==
X-Google-Smtp-Source: AGRyM1uuT1vQIr57VczZbMYqBCAWavAInhVTP1sLXmo5Mj9c6tQOoxLBzzgmuH+5owc4zloQm+1brQ==
X-Received: by 2002:a05:6808:654:b0:33a:66b8:a7ef with SMTP id z20-20020a056808065400b0033a66b8a7efmr6977756oih.108.1658787595756;
        Mon, 25 Jul 2022 15:19:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t21-20020a056870f21500b0010dc461410bsm4790197oao.38.2022.07.25.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:19:55 -0700 (PDT)
Received: (nullmailer pid 2844967 invoked by uid 1000);
        Mon, 25 Jul 2022 22:19:53 -0000
Date:   Mon, 25 Jul 2022 16:19:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        srv_heupstream@mediatek.com,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Tiffany Lin <tiffany.lin@mediatek.com>
Subject: Re: [PATCH v2, 2/6] dt-bindings: media: mediatek: vcodec: Add
 encoder dt-bindings for mt8188
Message-ID: <20220725221953.GA2844911-robh@kernel.org>
References: <20220720085731.11011-1-irui.wang@mediatek.com>
 <20220720085731.11011-3-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720085731.11011-3-irui.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 16:57:27 +0800, Irui Wang wrote:
> Add encoder dt-bindings for mt8188.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
