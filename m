Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70225986B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiHRO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbiHRO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:59:12 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEB3D5AE;
        Thu, 18 Aug 2022 07:58:51 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id l5so1286462qtv.4;
        Thu, 18 Aug 2022 07:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fPoxGBPf5NZE66FQhKWYb3s56+gNdfQUrK1EC5WHaTg=;
        b=vTjqruJbEUjKzzkzrmLbrucZ925+PMA7buaADNLtUmbboJBwhNuYXwehHpcGAP5DKM
         rvWm1De3sxong74kvTjOslfHzthqIkAO4lrm74mQ6RvgF5p1kPz20qo6MnSt6q9PvKHM
         wFp22fOvVP+ytRkTm5g5zWix33PUEtZzzhFeu7pQrcsiJJXUHHkSTNq2pQPyX3hqthC/
         27Nd2SBTSE8MN2Pt4s35lMiFRYOGpi1Wg5H6QSMRUzVGlbZOrhMUguBseNmh/KvjhplV
         bRYlJ79zbWruxz/BQsyxH7JhinlXg7eosZwwEpc4bdMxAYhADt1a4+kmkDylK/J36vlO
         CAZg==
X-Gm-Message-State: ACgBeo02g33GQUp0l0tNrBS/GtS0Gkra+maQjYxp+uN0SuqbuSX+RwQc
        HEyfTaWb9AzuJ7HkrkPnEA==
X-Google-Smtp-Source: AA6agR6nblJYoeb1H2gBXIhyMUJf+lUVbU/lrXRwPfE27ZZOAGg07tCHpKSQCRMpP9h7iUKbmKd9ug==
X-Received: by 2002:a05:622a:410:b0:33b:72b2:6038 with SMTP id n16-20020a05622a041000b0033b72b26038mr3024805qtx.627.1660834730751;
        Thu, 18 Aug 2022 07:58:50 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c63:5705:782e:33fb:22e5:50bd])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a119600b006b9576cd060sm1614260qkk.21.2022.08.18.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:58:50 -0700 (PDT)
Received: (nullmailer pid 1859341 invoked by uid 1000);
        Thu, 18 Aug 2022 14:58:48 -0000
Date:   Thu, 18 Aug 2022 08:58:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: samsung: stop using
 bindings header with constants
Message-ID: <20220818145848.GG1829017-robh@kernel.org>
References: <20220816133016.77553-1-krzysztof.kozlowski@linaro.org>
 <20220816133016.77553-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816133016.77553-2-krzysztof.kozlowski@linaro.org>
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

On Tue, Aug 16, 2022 at 04:30:15PM +0300, Krzysztof Kozlowski wrote:
> The bindings header with pin controller register values is being
> deprecated and DTS already switched to a DTS-local header.
> 
> Do not reference the bindings header in schema and replace the defines
> with raw values.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/samsung,pinctrl-pins-cfg.yaml     |  1 -
>  .../bindings/pinctrl/samsung,pinctrl.yaml     | 63 ++++++++-----------
>  2 files changed, 27 insertions(+), 37 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
