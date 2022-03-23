Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B04E58C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiCWSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiCWSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:55:27 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3756E4EC;
        Wed, 23 Mar 2022 11:53:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w127so2560058oig.10;
        Wed, 23 Mar 2022 11:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B4V11ArPsY0ZWyGU1/ks8Bjgl91EV/yBP3SM7+CsE7s=;
        b=EoVkyihyhTfwsx/6qzzLMEv1Z55HmSbGuiyPxlOUyq9tt5zTgkSkUnz9C5sXiqz+8t
         xxO8YoeWfKCUdYLaAoUMPiWDyZrZkRMx7EVa6JGKbnLQ+ppS9csNckD3QyFwTjiiLqws
         6+ca2MUwg17t1yPU3B6SYXPSikm4oZZjUCc3Mpyxc8pbFolBFNJ8in1gD+vCtOaFx6GE
         Dt9KggbMbsy6d3aIZVGyHopzkE+4CJmXl+VUxrczTavfZQMMo+OMGWPMP6hvMm3dQ4DR
         /+SC4hz20LVmh/dStLq781Fp3Kzb4c/IFf7BX9y6kU0Ceuz/EJzwvmtQdEb2iEjwNJnq
         nXbw==
X-Gm-Message-State: AOAM5331oqDy2z6uv/QUJA4IJfojdyKKM5MJhh2CtLtenasZe1yNyyZl
        k/nCFwySj6F2FyQs5EtsSQ==
X-Google-Smtp-Source: ABdhPJwjNndSTRij/JUQZ8o87qWbf5Cqh1rl38niEfGmp+g4CJRSm+R39jvT+Au1cNer8GT/oHXfkA==
X-Received: by 2002:a05:6808:1b12:b0:2da:28e1:39f7 with SMTP id bx18-20020a0568081b1200b002da28e139f7mr782701oib.289.1648061636800;
        Wed, 23 Mar 2022 11:53:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm307608otq.80.2022.03.23.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:53:55 -0700 (PDT)
Received: (nullmailer pid 251847 invoked by uid 1000);
        Wed, 23 Mar 2022 18:53:54 -0000
Date:   Wed, 23 Mar 2022 13:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: pinctrl: mt8192: Add
 mediatek,pull-up-adv property
Message-ID: <Yjtswk8gU1n1eVW2@robh.at.kernel.org>
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-4-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315211936.442708-4-nfraprado@collabora.com>
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

On Tue, 15 Mar 2022 17:19:35 -0400, Nícolas F. R. A. Prado wrote:
> Add the mediatek,pull-up-adv property to the pinctrl-mt8192 dt-binding
> to allow configuring pull-up resistors on the pins of MT8192. It is the
> same as in mt8183-pinctrl.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
