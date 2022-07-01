Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622D563AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGAUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiGAULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:11:30 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9E53EC7;
        Fri,  1 Jul 2022 13:11:18 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id p9so2063856ilj.7;
        Fri, 01 Jul 2022 13:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsGXONk8NHMc+Ouuuz0n5DIppbte+ODnFw+dCWHoPlk=;
        b=v9MqdTa7InzFzmLBZom1H7DMfvvAqhSScmN5AM4u7tswSJjxKza12fFhjZuBDzvfCg
         Kn1wFHVQrNORtzZsIu4V5nxPrtNSAbj/pv6w/EVgVbXbWRqs2q2/LWITbaZ7wEqWjaWh
         AFCZczKIvGAloHgewAOWt+O08wkvG9qpvYI6fXMySzxAzw+m8un5oJMW6gKm9IkBelRi
         HbuD3PtnJsCi4IGzNt5jfN6S9KKP7lsEcYdD2J6zOoMm9BfwcfAqaq8LjaEsq74+hF4x
         YnbQqudxylqUQpqEwh5eEyCNVnKJzpx/cr/bOsEC7zK+LQehxn5ZF1k67b2f+UHlSmPv
         t58g==
X-Gm-Message-State: AJIora8qdvD05qQc/UpSLnqlApKD9tC0dbjnLoJJ7KdctGVlpAQ1BGuJ
        9zXur4SNcqw6xt9yZwTXwA==
X-Google-Smtp-Source: AGRyM1sQr9on9f/i3W+HzDLrop3QB8HUNE+suPlqzim3Ia3W9/3g2hWw9BJyd/+X2qBvEEHcaQiZqg==
X-Received: by 2002:a05:6e02:180d:b0:2d9:26a6:d016 with SMTP id a13-20020a056e02180d00b002d926a6d016mr9294139ilv.170.1656706277255;
        Fri, 01 Jul 2022 13:11:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f7-20020a05660215c700b00674f80edd63sm10897632iow.23.2022.07.01.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:11:16 -0700 (PDT)
Received: (nullmailer pid 1439506 invoked by uid 1000);
        Fri, 01 Jul 2022 20:11:15 -0000
Date:   Fri, 1 Jul 2022 14:11:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     nfraprado@collabora.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Fix name for
 mediatek,rsel-resistance-in-si-unit
Message-ID: <20220701201114.GA1439444-robh@kernel.org>
References: <20220630122334.216903-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630122334.216903-1-angelogioacchino.delregno@collabora.com>
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

On Thu, 30 Jun 2022 14:23:34 +0200, AngeloGioacchino Del Regno wrote:
> When this property was introduced, it contained underscores, but
> the actual code wants dashes.
> 
> Change it from mediatek,rsel_resistance_in_si_unit to
> mediatek,rsel-resistance-in-si-unit.
> 
> Fixes: 91e7edceda96 ("dt-bindings: pinctrl: mt8195: change pull up/down description")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Note: No devicetree uses this property as of now.
>       Even if any DT did, it wouldn't work, as the pinctrl code checks
>       for 'mediatek,rsel-resistance-in-si-unit'.
> 
>  .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
