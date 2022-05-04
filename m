Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D951B044
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378552AbiEDVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiEDVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:22:08 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C2D4D9FB;
        Wed,  4 May 2022 14:18:31 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5e433d66dso2485300fac.5;
        Wed, 04 May 2022 14:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ua5lbePfoqkbQU/tCSqIMk/LlWsx3KTHZiwWX1N4ZJk=;
        b=c+IVvPY/cMo8R/Ng0dEwM0yGRahBeTEGQ7RJTyzkjRRIg/FcBr1gtPLRPgdyzIvdaf
         qfMI9d3YBvWIZuB2P98oqRhtvXI08ClDvSMBw+mK7b24uA4nb2Pbrs32t0kEgEE4BM62
         NCPD4i/J7kVZGQisdHmSPGGbJnaQk3SwGnlcITtOmUALRgQf7l7FBBE3zlmUC/l+9r97
         Ih/thzpoZ4foU000wpdkycurNv7Viloc42TJBHAPnynE2OkS6Q6oaGOZBH/rwCFURsHh
         xH0Mnu2AuS25ObWVnSiH/ozqE6dpTZydocDuas8fHEimcmNL5ehElZ9GJ46UCrQvyH/6
         Nsfg==
X-Gm-Message-State: AOAM533pWCkelD8GO86Mj7KQgFnmLQ7x9wfVy5zMfoTDdwgjZOY6bhPT
        24aPtge0oXMtklY3O5lT5Ow9VjVUMw==
X-Google-Smtp-Source: ABdhPJxKdY7w169Ia03zmr/uBFV6KRNTP95hO+sx/QVwi05+FCDnlU/1rF+xzz/rcSJPKOAaJRsTsQ==
X-Received: by 2002:a05:6870:b292:b0:ec:ec79:4842 with SMTP id c18-20020a056870b29200b000ecec794842mr745047oao.145.1651699110531;
        Wed, 04 May 2022 14:18:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm9167831oae.52.2022.05.04.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:18:30 -0700 (PDT)
Received: (nullmailer pid 2242000 invoked by uid 1000);
        Wed, 04 May 2022 21:18:29 -0000
Date:   Wed, 4 May 2022 16:18:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Allow values for drive-push-pull
 and drive-open-drain
Message-ID: <YnLtpd639JgU5RKF@robh.at.kernel.org>
References: <20220429194610.2741437-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429194610.2741437-1-robh@kernel.org>
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

On Fri, 29 Apr 2022 14:46:11 -0500, Rob Herring wrote:
> A few platforms, at91 and tegra, use drive-push-pull and
> drive-open-drain with a 0 or 1 value. There's not really a need for values
> as '1' should be equivalent to no value (it wasn't treated that way) and
> drive-push-pull disabled is equivalent to drive-open-drain. So dropping the
> value can't be done without breaking existing OSs. As we don't want new
> cases, mark the case with values as deprecated.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/pincfg-node.yaml     | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Applied, thanks!
