Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD404ACA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiBGU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiBGUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:22:55 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F86C0401DA;
        Mon,  7 Feb 2022 12:22:53 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so15093686oot.4;
        Mon, 07 Feb 2022 12:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf75cF96xkDnXxPJYcJ4U9WkCMvyuWK346gnEuAcTZA=;
        b=cPevAMbOLzZMf71w6HDfsIyfm41AqR/7aBU9NCJzo+67ImC+OYVUy41tw2n0T9W+/7
         yyB3sSVv+kZVWTX9dQziBTMKzGhiDj0ObGcr9py06MAQqIi3Peh520USKYTd2jUY8MAj
         5fSBN+TjTV1+aYjE6mmr9kXGhCtxlG0c2HUALdlilNA+ksdxEQnG8MLZPRPR5V4vMqCK
         r2KYrpIDMP2D//atC9/k6CAltoWrTAahb/9ENIA/JdlgxlZfQCVh64jgFgfy95oR8tfY
         Xsb2ac1d1h+JdlkG9iDX5GSo3ioBSSogn6I2/89Eflq+BFZ4A0pzqF3Ooc4PKSoHfHsl
         KPgQ==
X-Gm-Message-State: AOAM530gkntl8nOhYNj6L413eK0e547wULbWCky0rF3f5LKNP1oxX3ON
        14YahPkAfqDoMqrXTZd1Jw==
X-Google-Smtp-Source: ABdhPJxIPwPMQEK4tBgcvwf7JkxXGyj273AJTnR5MSFoTfd4NZAtv1f3WBtSNTjThuANXOrvMSU98A==
X-Received: by 2002:a05:6870:a543:: with SMTP id p3mr224500oal.177.1644265373276;
        Mon, 07 Feb 2022 12:22:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x17sm4275899oop.1.2022.02.07.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:22:52 -0800 (PST)
Received: (nullmailer pid 844681 invoked by uid 1000);
        Mon, 07 Feb 2022 20:22:51 -0000
Date:   Mon, 7 Feb 2022 14:22:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        Oliver =?iso-8859-1?Q?St=E4bler?= 
        <oliver.staebler@bytesatwork.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 01/12] arm64: dts: imx8mm: fix strange hex notation
Message-ID: <YgF/m+X0SZxDWIt/@robh.at.kernel.org>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
 <20220204225706.1539818-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204225706.1539818-2-marcel@ziswiler.com>
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

On Fri, 04 Feb 2022 23:56:55 +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix strange hex notation with mixed lower-case and upper-case letters.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Add Laurent's reviewed-by tag.
> 
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
