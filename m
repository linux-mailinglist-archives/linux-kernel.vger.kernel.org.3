Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAE52AC92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiEQUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiEQUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:15:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0450033;
        Tue, 17 May 2022 13:15:50 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id n24so146061oie.12;
        Tue, 17 May 2022 13:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLuq8/jIrJucgBFEatj0kqdfIbuB917FOxPZ2pJhVlM=;
        b=8GRNQ/LA6n4Z0BMzIOviL8tb8iXGSnZViQvasKBnZWPHqL4xKeKBB83Qyxf57fsjd4
         Kaf8H3cwNhmtezI3votpMwcxzUZxKLM9BJwV9+dADXbVK4GUfJGNNmwieEvnu9OO3wyD
         s+I/oLZWD+ZzaLzzo/F3REXHZeYLM2WTYOxPC21Eb+Drvrnna3MXw0RPncm9byuVTshG
         DOfpMbWm1s70fhA9kVGYnm761jxFCs+3Yu5J7PPE0aKj0P0FVVyjhU89IY3WrdEb+EpS
         ktWgoqBBR8QF1uzBxgclSel0sxPfuR1QHHgaUtXlme53LIH4p/WEjoFTzkqD8P0yTRNB
         3MeA==
X-Gm-Message-State: AOAM531RUF4pZS5G1VPOdYWs8sE6LJDuhNp9q9aTF4gmwFopQr/vq1Ci
        8a/wYVjrTD8U09KjZM3P+Q==
X-Google-Smtp-Source: ABdhPJy4qhjcEoJ8bmJKtyo5sNfuFbkzX3w7OdbKNgT7Td6iqrnA+pCkTtn7SSqdKvy9VsyLUfshzg==
X-Received: by 2002:aca:7c1:0:b0:324:fe9a:9856 with SMTP id 184-20020aca07c1000000b00324fe9a9856mr16536836oih.293.1652818549940;
        Tue, 17 May 2022 13:15:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k12-20020a4a2a0c000000b0035eb4e5a6bbsm186513oof.17.2022.05.17.13.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:15:49 -0700 (PDT)
Received: (nullmailer pid 1554564 invoked by uid 1000);
        Tue, 17 May 2022 20:15:47 -0000
Date:   Tue, 17 May 2022 15:15:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Mr.Bossman075@gmail.com, dev@lynxeye.de,
        giulio.benetti@benettiengineering.com, mturquette@baylibre.com,
        clin@suse.com, daniel.lezcano@linaro.org, tharvey@gateworks.com,
        tglx@linutronix.de, devicetree@vger.kernel.org, abel.vesa@nxp.com,
        cniedermaier@dh-electronics.com, arnd@arndb.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
        shawnguo@kernel.org, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        stefan@agner.ch, sebastian.reichel@collabora.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, sboyd@kernel.org, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, marcel.ziswiler@toradex.com,
        aisheng.dong@nxp.com
Subject: Re: [PATCH v3 13/15] ARM: dts: imxrt1170-pinfunc: Add pinctrl
 binding header
Message-ID: <20220517201547.GA1554500-robh@kernel.org>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
 <20220517032802.451743-12-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517032802.451743-12-Mr.Bossman075@gmail.com>
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

On Mon, 16 May 2022 23:28:00 -0400, Jesse Taube wrote:
> Add binding header for i.MXRT1170 pinctrl device tree.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Nothing done
> V2 -> V3:
>  - Change to (GPL-2.0-only OR BSD-2-Clause)
> ---
>  arch/arm/boot/dts/imxrt1170-pinfunc.h | 1561 +++++++++++++++++++++++++
>  1 file changed, 1561 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imxrt1170-pinfunc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
