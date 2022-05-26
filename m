Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA053487D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiEZB5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiEZB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:57:39 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453FBA997;
        Wed, 25 May 2022 18:57:38 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso690749fac.4;
        Wed, 25 May 2022 18:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fBooorBUc9TiuuZP7V/CE0nVyIQJLuFcFSmL3ukgr+0=;
        b=tKdg0VJFl9dI6sUBLNXdz0c6wp7LFlaQv5nYQSh5mMQznvGVE7Farcp4I2d+iZ/AQv
         xEijVe1ZY/MLqqKnVXrIminnc7l3lk16xt9mPZZOT7xKeDG7vk5h1Ttr3EEpXSaaxXV6
         wlFnFBKD2XgDxqMOJB3EedYO2tzGSqSuiWeIw5xs4skNn2B1NispPuGY7q3cXdiNImVP
         F//xB2w+nSkUusEgrJG3QZL6GVvlPtaevUwUOm+Qs1EwQ9yXdtpHSMswGxLphINZ2vkF
         AIzslnQA12dOvKxbjTeZeHn/T6vuaVNQeFawStmjHHOTVsBG4IhPsEonQ37vS6LIROOW
         nQdg==
X-Gm-Message-State: AOAM530C2TmfSXlBInlBwERRiIy9Mfq6LO2FbtULEtLdNxW48U37Htti
        hwze+kXs3O51Jg7kbfKmUw==
X-Google-Smtp-Source: ABdhPJxUeqloFyZQmwKt5j7Tji4hIdlUPLrqi9TrK0/U1U2+xqrrho6dVSvMuYpjlY4QrOa42I+OCA==
X-Received: by 2002:a05:6870:b68a:b0:f1:8001:1182 with SMTP id cy10-20020a056870b68a00b000f180011182mr37728oab.30.1653530257854;
        Wed, 25 May 2022 18:57:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w27-20020a9d5a9b000000b0060603221240sm134732oth.16.2022.05.25.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:57:37 -0700 (PDT)
Received: (nullmailer pid 2896334 invoked by uid 1000);
        Thu, 26 May 2022 01:57:36 -0000
Date:   Wed, 25 May 2022 20:57:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: mt8192: Add
 drive-strength-microamp
Message-ID: <20220526015736.GA2896280-robh@kernel.org>
References: <20220525155714.1837360-1-nfraprado@collabora.com>
 <20220525155714.1837360-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525155714.1837360-2-nfraprado@collabora.com>
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

On Wed, 25 May 2022 11:57:13 -0400, Nícolas F. R. A. Prado wrote:
> Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> drive-strength-microamp instead of mediatek,drive-strength-adv.
> 
> Since there aren't any users of mediatek,drive-strength-adv on mt8192
> yet, remove this property and add drive-strength-microamp in its place,
> which has a clearer meaning.
> 
> Fixes: 4ac68333ff6d ("dt-bindings: pinctrl: mt8192: Add mediatek,drive-strength-adv property")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 27 ++-----------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
