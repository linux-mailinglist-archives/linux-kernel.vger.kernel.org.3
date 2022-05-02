Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4767C517B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiECADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiECADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:03:12 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05345344D6;
        Mon,  2 May 2022 16:59:38 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so7663718oty.3;
        Mon, 02 May 2022 16:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gezA+FgfQIOeosXiXauEFuGOC1DO4zlGtjWK/c4Mmoo=;
        b=ImQrAU+Gy9zV0JUNN4v5kSmZgKbfE6rmzOlf5BEuT7tyWUh2f/HjxJkeH/UJz1PVqa
         kvndIeNf2e3vF+OiCX0GEw1Idj+UIyeBehdfFByUAo5KjwPR2QAsdBl//3mpIEN7IqX0
         vvixmzxroMOV7r6SqK1bwjkAeKJVu5/RdZjWsJKeIfy3ChvtG9MlQpRM8J58FYURbV4I
         K6EkXtHJ6ura5KUoPGiY1nNDRZk3twHKT1P1f3czZpk3n32FN0MyhYddkTdGB+TC94SL
         LVwWdTECO00x3ZnusXBjau9OLuINKinbPgDV6V4zwmzQviDUtrreHh7zLc71PcBWD1Zi
         Pmjg==
X-Gm-Message-State: AOAM532v+4QXWCfiKQ0ydkuQXN3acYgGPCjetc3pjgmMPmbHVAEldnwF
        LD8xq5lKErD7Khb6xA2OPg==
X-Google-Smtp-Source: ABdhPJyLUr8CePi/NiyCU4NOTuQg5eORG04y++TX2wMUO+0xhMygAcWkga2uJnvHK7HmmMiL5LKfyg==
X-Received: by 2002:a05:6830:22e1:b0:605:e40d:d606 with SMTP id t1-20020a05683022e100b00605e40dd606mr5162983otc.205.1651535978105;
        Mon, 02 May 2022 16:59:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w10-20020a056830060a00b0060603221253sm3424123oti.35.2022.05.02.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:59:37 -0700 (PDT)
Received: (nullmailer pid 2058233 invoked by uid 1000);
        Mon, 02 May 2022 23:59:36 -0000
Date:   Mon, 2 May 2022 18:59:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 08/14] dt-bindings: arm: fsl: add
 toradex,colibri-imx6ull
Message-ID: <YnBwaHRcamhz1hMe@robh.at.kernel.org>
References: <20220425162356.176665-1-marcel@ziswiler.com>
 <20220425162356.176665-9-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425162356.176665-9-marcel@ziswiler.com>
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

On Mon, 25 Apr 2022 18:23:50 +0200, Marcel Ziswiler wrote:
> From: Denys Drozdov <denys.drozdov@toradex.com>
> 
> Add toradex,colibri-imx6ull for carrier board dts,
> including aster, iris and iris-v2 device tree,
> wifi and nonwifi variants for NAND and eMMC modules.
> 
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Fixed long line as pointed out by Rob's bot.
> - Added V3 to Colibri Evaluation Board as done elsewhere.
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
