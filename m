Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CD52AB00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiEQSgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbiEQSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:35:54 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E568C17;
        Tue, 17 May 2022 11:35:52 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d39f741ba0so25253174fac.13;
        Tue, 17 May 2022 11:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uT4mlGSo9wkGcsmi1CtjInRJB/kA6igNndb7eOFpdHc=;
        b=HDPT+ZTgz2H6kdptO+Zkb0Hoo+zpvbFQrRCklyDsVoo7P+5qxHDsh3TApi+UdiCllL
         havTadYDc3WA/8kuXCS4vauFLVlZ0UuhE+G7jkTHggAlu5bfkGWSwvK6hCiGm4rws22u
         aqgn2R0hExyphjm5U8vHTkCEdsOZUIwHla3FBuZhmAqzXWUtZfjVTUhF6TqN8MFVfXyS
         Hn/Q4F7GbKDKnnwB/VbtTJ7a3dlKJ1Eu1oXraRR14asfJqu1mVTJ/LhEDf4C0qWAC5rA
         HWDvgdKtxvw6lhrbygFcopvayIHnBI/yIxOWhzNX5pAS6nraV0ct1If+mUcJ+0XHvNw0
         8C2w==
X-Gm-Message-State: AOAM530xMmf++RXinfZL706LkN+kFdSpipTMqUDNMggKaPSVbodajdCX
        Aiv/EV1derzCXeIkOxqs8YptLBQ5jg==
X-Google-Smtp-Source: ABdhPJzUR8Qm1+s37SFKkN3y3YVTp69fOdZZUeq8CYIbwWDdBHEW2LD9zUy8Dm7A0l84PqMmkVSVww==
X-Received: by 2002:a05:6870:b40a:b0:d7:5c87:64ab with SMTP id x10-20020a056870b40a00b000d75c8764abmr13350053oap.168.1652812552134;
        Tue, 17 May 2022 11:35:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l10-20020a4a434a000000b0035eb4e5a6d2sm47454ooj.40.2022.05.17.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:35:51 -0700 (PDT)
Received: (nullmailer pid 1387304 invoked by uid 1000);
        Tue, 17 May 2022 18:35:50 -0000
Date:   Tue, 17 May 2022 13:35:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        nfraprado@collabora.com, sean.wang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl
 bindings
Message-ID: <20220517183550.GA1387243-robh@kernel.org>
References: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com>
 <20220517083957.11816-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517083957.11816-2-angelogioacchino.delregno@collabora.com>
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

On Tue, 17 May 2022 10:39:56 +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>  include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>  2 files changed, 1132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
