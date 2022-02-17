Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C74BADDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiBRAEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:04:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiBRAE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:04:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3924A93A;
        Thu, 17 Feb 2022 16:04:11 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z2so5677518iow.8;
        Thu, 17 Feb 2022 16:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLCyYoS9aJ9wXLhi8hxYqyvuriAYuRyIEnSfXpo5OxA=;
        b=zEukcAuDrvdfy+Ec3l+bU7SZ5ejgWAwPISpUpTt6v7GTyQPNbZESvr+zPStIWD4gjX
         3AS5JrTcRAGaI8tDGyBPKG46oXTDnNZhgms+6jVqsCfAUYPx0ekY8qSY/h4DxtnTvYHi
         x730mWEM3nMUrZwKx4sw/x6TSLQh1OgQN0ncR8Z3Xgs4W3vhTGRnDrqHyQiTiuytrTLX
         v2FMfKL675o0or4YJAwKn8/5rKBY5AWs8BYm51dVSVX9LPXYl335IAZKqu7Qr9PCK50q
         a+dytrA92n+mn7Gpmt3LhUIAPqyepqHkU4/GCzQxN5VFiuI54ZxKQogaJSCM/bg+70io
         vGoQ==
X-Gm-Message-State: AOAM533MpECBSM2N1CwI8i9cxePYChWxFIFieP23n4iNTSumihYpKUrN
        bX4/qkmeK/L8LmV3pGNZOg==
X-Google-Smtp-Source: ABdhPJzHW1Fdru6iaeIHbAkYzs8aCRWR3e0vh+2ODhi0kFxLx2gcpAr1zc5BnU4CGAMTFw6TyRT6mg==
X-Received: by 2002:a05:6602:73a:b0:640:3ded:e0bf with SMTP id g26-20020a056602073a00b006403dede0bfmr3570505iox.134.1645142311282;
        Thu, 17 Feb 2022 15:58:31 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z13sm2970817iox.21.2022.02.17.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:58:30 -0800 (PST)
Received: (nullmailer pid 4013485 invoked by uid 1000);
        Thu, 17 Feb 2022 23:58:29 -0000
Date:   Thu, 17 Feb 2022 17:58:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: add imx8mm gw7903 support
Message-ID: <Yg7hJa0XXBjVxRVb@robh.at.kernel.org>
References: <20220211190418.11870-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211190418.11870-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 11:04:17 -0800, Tim Harvey wrote:
> The GW7903 is based on the i.MX 8M Mini SoC featuring:
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - microSD connector with UHS support
>  - LIS2DE12 3-axis accelerometer
>  - Gateworks System Controller
>  - IMX8M FEC
>  - software selectable RS232/RS485/RS422 serial transceiver
>  - PMIC
>  - 2x off-board bi-directional opto-isolated digital I/O
>  - 1x M.2 A-E Key Socket and 1x MiniPCIe socket with USB2.0 and PCIe
>  (resistor loading to route PCIe/USB2 between M.2 and MiniPCIe socket)
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
