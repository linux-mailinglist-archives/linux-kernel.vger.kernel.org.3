Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38C4F1BEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381963AbiDDVYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380265AbiDDTZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:25:06 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA73B037;
        Mon,  4 Apr 2022 12:23:09 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-d39f741ba0so11854884fac.13;
        Mon, 04 Apr 2022 12:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIFxnat34WFgpybFJIb4ucsy9v2GfYyVlHzTRVzu9II=;
        b=p7sgaV1KkwcHjxp/vlyfRnDI4Vp19yAtiHdnadEPBuaLtMRE0cozlz9SGmnysgPT/p
         p1r6sAlZedh1OdlgUkuGQhncDpb+2s/gaQu2TKC4Q7/ZqX/rzWHeB6Laj4zeDTlwHtlW
         MiS4cEWCMq7AOXFTjw5AQ6SCQ0J5/+Mu03tii6+MCqz0kXad9K5eUAFj3iScKKnePHCU
         fWKqRFR7wM8SNHzzuTDFxdaI/GYxZ+agePVBisig0GPKibeZSgjuxJ5JmpM1LAeFemMY
         yKEZ0a8Fxp3XgV2IaI0n6gqZxlfFH5N3vqJIsxVEpC6O1C7YJklX8ZkGsvDJ14XfaEUm
         5/Nw==
X-Gm-Message-State: AOAM530Lgnw5HiMQ5q4hLjsjpoU6G4l/YND++tyR2gvg5FEYNj+L0Wll
        WTSSzrPhx0zHbNf3zH3Kwg==
X-Google-Smtp-Source: ABdhPJxGvYRMISdRC5MROfVxG4x2VQDddPAJcrf4fiX749Isc/0j1TL+GUY/U5TzrMlxzPaIiijgSg==
X-Received: by 2002:a05:6870:46a4:b0:e1:f307:c1a2 with SMTP id a36-20020a05687046a400b000e1f307c1a2mr412329oap.238.1649100188792;
        Mon, 04 Apr 2022 12:23:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a544688000000b002f90678740esm4638093oic.37.2022.04.04.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:23:08 -0700 (PDT)
Received: (nullmailer pid 1802528 invoked by uid 1000);
        Mon, 04 Apr 2022 19:23:07 -0000
Date:   Mon, 4 Apr 2022 14:23:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: add rockchip,rk3036-pinctrl
 compatible string
Message-ID: <YktFmxYK76/W1N2A@robh.at.kernel.org>
References: <20220330133952.1949-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330133952.1949-1-jbx6244@gmail.com>
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

On Wed, 30 Mar 2022 15:39:51 +0200, Johan Jonker wrote:
> Add the compatible string "rockchip,rk3036-pinctrl" in already
> in use in rk3036.dtsi to rockchip,pinctrl.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
