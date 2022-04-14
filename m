Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82486500D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiDNMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiDNMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:22:36 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E461A35;
        Thu, 14 Apr 2022 05:20:11 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so3228155otj.10;
        Thu, 14 Apr 2022 05:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jfLbrErxPSU2rAmAIkQlwSpxDTxXq1N0X3SRKecv6Z4=;
        b=vDCoZ9Z9NDMfzmpIkDELDPmzvXbuLKczzKTQ/AMaK4dm99B4jI1YsBn7Nk1hv2imhC
         Ely/fp9YgB65xSsXBMPEF6dt2iwOQI+woDDkRmPcmTA+TRB2ZqGDeJfo2vVCpbeynBcZ
         MgzcmF3ZyyipQD5Ts6cQUJhCCiMXJl4fniO5N2euejjHvgkWfbvBoiu2MH8PBowfX1SG
         Ky7qwuu3HZqQANZzK4KxEEiA/yLBtd6Tj3vj/ftrA56TB3G5Fy+pcxa3H2kEv/7Zktsa
         96RUtTzMfQjVM7hSjwXHxBOjeM4A/HpGBHd8W+wZEU9+yOOS5ROxuK9yQWfolNPAE0UZ
         66Sw==
X-Gm-Message-State: AOAM532jTCeAQXSBX3y+8VV4W6W5imn//DjaWk3EAFgf6Px/+5PREZmv
        h/97VXcP9oBVxfvu1S5Yvw==
X-Google-Smtp-Source: ABdhPJx4xNkKUWm+NeTCrYVhzwHAgxx56YjSw9GyjrDqz1yynrl/Dd9TI9a4RWdAO/Sp46NmcGS/cg==
X-Received: by 2002:a9d:75cd:0:b0:5c9:61fa:3a42 with SMTP id c13-20020a9d75cd000000b005c961fa3a42mr823491otl.15.1649938811097;
        Thu, 14 Apr 2022 05:20:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p129-20020a4a2f87000000b003332606e636sm616848oop.2.2022.04.14.05.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:20:10 -0700 (PDT)
Received: (nullmailer pid 1698373 invoked by uid 1000);
        Thu, 14 Apr 2022 12:20:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20220414085106.18621-10-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com> <20220414085106.18621-10-marcel@ziswiler.com>
Subject: Re: [PATCH v1 09/14] dt-bindings: arm: fsl: add toradex,colibri-imx6ull
Date:   Thu, 14 Apr 2022 07:20:09 -0500
Message-Id: <1649938809.981246.1698372.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Apr 2022 10:51:01 +0200, Marcel Ziswiler wrote:
> From: Denys Drozdov <denys.drozdov@toradex.com>
> 
> Add toradex,colibri-imx6ull for carrier board dts,
> including aster, iris and iris-v2 device tree,
> wifi and nonwifi variants for NAND and eMMC modules.
> 
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 23 +++++++++++++------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/fsl.yaml:666:111: [warning] line too long (113 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

