Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7434589474
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiHCWgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHCWf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:35:59 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150996548;
        Wed,  3 Aug 2022 15:35:59 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id j20so7728954ila.6;
        Wed, 03 Aug 2022 15:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=opKDkyi7lKJltuG48YWCzI+exumamPnJWTRLbM7FknY=;
        b=YXLtIERrfuxVu27g0rw68DM02zNEHhi+8XwBmz4C9mL5VWBhNWicVdmAlluzyZ6aNS
         89rLqpFijHb7jFq2OBz+4i3tC+SfbieLuIyRuNVWdBcF7GCU4Az74swjFJfiCd0f1ovJ
         x1A95n0zYpzNt43QguS/RcwGX/6DKweRlgKKj4KoVxrQ6PQ295C5xw9g3BNQsIXbwTYO
         +PAg1sOVyEyXfobS8IhEcucJOLdNT5ZJmzkKDNM7UpiwOa2v0w624gYobyPjMAq65v4v
         vXlHgmBh7JHC8Cyr/Xt+0BpDpmd8p+RylgMSN5VgdjfJp5RWqMXkGPAnv9tRueNZ/84e
         u1pw==
X-Gm-Message-State: ACgBeo09BgBjSrwam3nRtxHfLotvoq3HSB3ajASwp/kEYHeu1rpD5xrS
        a3Y1cy3gzLbOHX/E379sxQ==
X-Google-Smtp-Source: AA6agR6J7aD3Fr1axinuEJMEMgZ//1CcnRFYYmCYHmkoxDAcLOTepjMYtaMIn36eWwHarpA6qTaTDw==
X-Received: by 2002:a92:d492:0:b0:2de:2d95:a5fd with SMTP id p18-20020a92d492000000b002de2d95a5fdmr11094666ilg.111.1659566158310;
        Wed, 03 Aug 2022 15:35:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b1-20020a926701000000b002df38c1e8d8sm685134ilc.62.2022.08.03.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 15:35:57 -0700 (PDT)
Received: (nullmailer pid 2743980 invoked by uid 1000);
        Wed, 03 Aug 2022 22:35:56 -0000
Date:   Wed, 3 Aug 2022 16:35:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     jianguo.zhang@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, matthias.bgg@gmail.com,
        zhiyong.tao@mediatek.com, sean.wang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 1/2] dt-bindings: pinctrl: mediatek: add support for
 mt8188
Message-ID: <20220803223556.GA2743930-robh@kernel.org>
References: <20220801095215.10876-1-hui.liu@mediatek.com>
 <20220801095215.10876-2-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801095215.10876-2-hui.liu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022 17:52:14 +0800, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add the pinctrl header file on MediaTek mt8188.
> Add the new binding document for pinctrl on MediaTek mt8188.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>  .../pinctrl/mediatek,mt8188-pinctrl.yaml      |  226 +++
>  .../pinctrl/mediatek,mt8188-pinfunc.h         | 1280 +++++++++++++++++
>  2 files changed, 1506 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
