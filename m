Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448F84D6C54
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiCLDqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiCLDqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:46:48 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201C23A1A3;
        Fri, 11 Mar 2022 19:45:42 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id o83so4093779oif.0;
        Fri, 11 Mar 2022 19:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vd8wRMirH20qZ3MunPMpjYuLCrOwOqi3XC/b/3pYVHA=;
        b=AEmN4XziGjGnoCm2ZOC3TnGCMEVjdx8ZtBsIlRiMDnCNOyDJrI+9Lkfuo3PbeSuRJk
         fe4FRxHpzdqkWoemzW3AZ6uO8Cxu4vM7TcbXwyFvL/jXSUwFTyrGA4OViFbWyQRxSLwF
         wozG+oD+XfWNPCmHx5WEHCC/r53889vugYyIzyYeLNPbhQ2QiRiFGlYG6gJ5idyNHIhV
         4OHx9oGojvI01S78Ky2+/XeXyp/qkx7pfeCBRMghWrtBFaaK7Cmr1FFuUwKmb/OqWzIb
         EitQZN+Z7z/0C1R9DSTqSyiT8+HWojNpGgITgx9NQnoL5bUEaBfF1fxUxRzU71JXFTur
         5qMw==
X-Gm-Message-State: AOAM532e8Gey1RntpjRgBuSsE873F8zCe8wZj986dSknc/BHwEst9cV4
        m49NQlOgClBr1c3q/4LQVQ==
X-Google-Smtp-Source: ABdhPJx4byST3cn01Iwsrcdl0TxymdYn3svPvMQkqG/bJhnL9oRUPuCxQhxOTuMBuuFJbDX7dtHbZg==
X-Received: by 2002:a05:6808:d4:b0:2da:503b:40a with SMTP id t20-20020a05680800d400b002da503b040amr8863995oic.121.1647056741712;
        Fri, 11 Mar 2022 19:45:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb39-20020a05680816a700b002d9a8eb89fasm4515278oib.46.2022.03.11.19.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:45:41 -0800 (PST)
Received: (nullmailer pid 730936 invoked by uid 1000);
        Sat, 12 Mar 2022 03:45:39 -0000
Date:   Fri, 11 Mar 2022 21:45:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Frank Wunderlich <frank-w@public-files.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        soc@kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <vireshk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v6 5/6] dt-bindings: ata: ahci-platform: Add
 rk3568-dwc-ahci compatible
Message-ID: <YiwXY6/JVwMUfa71@robh.at.kernel.org>
References: <20220311210357.222830-1-linux@fw-web.de>
 <20220311210357.222830-6-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311210357.222830-6-linux@fw-web.de>
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

On Fri, 11 Mar 2022 22:03:56 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific compatible for rk3568 ahci controller
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> v6:
>   change subject to dwc instead of dwc3
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
