Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD0522129
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbiEJQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347355AbiEJQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:28:27 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FB132A3A;
        Tue, 10 May 2022 09:24:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q10so3933721oia.9;
        Tue, 10 May 2022 09:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j28JmSqoNSbvAv+R8pu/wm6jwTaozWE5LRqHm67RqEY=;
        b=VCleOKv6wasF6G61xTtn70WRKZtfY+8Da5LmWicAmg01e+mm25sigMp0DtBuyp6mB3
         sbj3wx6fDLXmDDd/wQdnTYyWRK08Kxs9wM8PiKOSZMvoUa1u0UTgVWlW5QcLtHQunbDD
         YZs/afaL/rVSjNMOQL7Y8tFxp1aRzbf1OvscwBB3fGIr2MViL+rclH35RJCZpbjbwIHW
         gac8E/uYNgp5qYpTFs61gpz4DCABJHugpOcKwl+S/wb11Y8kcf+oyR+sjwU+H8AzHzP8
         Lgrlc0KqYqoHrqMH9JUhNIg/UbbcmrrOhjaxLNW9GuxlgD2PWSbnMC/9aOGG27UnygGL
         rSlQ==
X-Gm-Message-State: AOAM531/lSuIr2x0Ez5IbM/V4qUEdmbcQXepG0MdJCgMCfPAYlbspqZm
        0mbTp9fPHjiVAWjF6yB9QQ==
X-Google-Smtp-Source: ABdhPJz93OKT6IoYl3L6n5pAT6/vmah532joJuytZ5GS6kerqhTeu8YJckeFx5y0B7udRjeMsHBAlA==
X-Received: by 2002:a05:6808:16a3:b0:326:a585:95b8 with SMTP id bb35-20020a05680816a300b00326a58595b8mr422724oib.281.1652199867204;
        Tue, 10 May 2022 09:24:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x36-20020a056870332400b000e686d13892sm5553926oae.44.2022.05.10.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:24:26 -0700 (PDT)
Received: (nullmailer pid 2137673 invoked by uid 1000);
        Tue, 10 May 2022 16:24:25 -0000
Date:   Tue, 10 May 2022 11:24:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        devicetree@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: correct 1g vs. 1gb in
 toradex,colibri-imx6ull-*
Message-ID: <YnqRuYcKHUxGCWnb@robh.at.kernel.org>
References: <20220506145720.291735-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506145720.291735-1-marcel@ziswiler.com>
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

On Fri, 06 May 2022 16:57:20 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Correct 1G vs. 1GB typo.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
