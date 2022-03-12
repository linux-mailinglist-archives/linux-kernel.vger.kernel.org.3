Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211004D6C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiCLDqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCLDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:46:32 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E42357E5;
        Fri, 11 Mar 2022 19:45:28 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id o83so4093423oif.0;
        Fri, 11 Mar 2022 19:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwjHEM1ve6vauVKyKa9ZUyCUyEFXM5iLr7KYRJbKfko=;
        b=6DUqSopus9/uD7UsQAk2tQEhL0dnin6cKgwWagUwioPqpUpColNJGHc7/DZfzwO5KQ
         NEBAidU1nF6A4w5Rd5TAHf9gRYfzAWwiDuBowWlAElNeyjmIGvnAeJ2r8nOqw45NDqft
         aVy4FiDug3z09m1M82RYxlVBemYVKXaac4bT2HfQuvfljli20DMwR/HsoXcdE+Co/ykY
         tSEiqcazdaFlsdVflugGMj7B1B+BxwEBQNj9i3xjIPKepz58ZOXRF6m0hOgzUkvbJvmA
         S2ppqril+DqWZrzypqudex4vTkS4NEVCJBWvc6JQerUHLGiW3yOSq0eowiO2GZRtonkn
         TcjA==
X-Gm-Message-State: AOAM533C6BDOGWe0m6Lr7ntsPrhysFyVgVnGsWUJw+sGFJYGSCsDU7jE
        +0ZhUhpZkw3Hw2E/j/G31w==
X-Google-Smtp-Source: ABdhPJyN4Me6aXpEWsG65Sb5BfWNEBIhIM8S49iH8KYbautApP4UfXutmtJ97KxAWUQ7Amb9REJqQg==
X-Received: by 2002:aca:34c1:0:b0:2ec:8ee8:90c7 with SMTP id b184-20020aca34c1000000b002ec8ee890c7mr3951666oia.267.1647056727702;
        Fri, 11 Mar 2022 19:45:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 67-20020aca0546000000b002d46e151b9bsm4645324oif.18.2022.03.11.19.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:45:26 -0800 (PST)
Received: (nullmailer pid 730303 invoked by uid 1000);
        Sat, 12 Mar 2022 03:45:25 -0000
Date:   Fri, 11 Mar 2022 21:45:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Peter Geis <pgwipeout@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: ata: ahci-platform: Convert DT
 bindings to yaml
Message-ID: <YiwXVRPJITCOiCoj@robh.at.kernel.org>
References: <20220311210357.222830-1-linux@fw-web.de>
 <20220311210357.222830-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311210357.222830-2-linux@fw-web.de>
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

On Fri, 11 Mar 2022 22:03:52 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Create a yaml file for dtbs_check from the old txt binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> 
> v6:
>   - fix indentation of examples
>   - add compatible marvell,berlin2-ahci
>   - change maximum of ports-implemented
>   - add select to exclude qcom compatibles
>   - drop marvell,armada-380-ahci
>     it is not handled in the ahci-platform.c but ahci_mvebu.c
>     and incompatible due to missing phys/target-supply
> 
> v5:
>   - change subject
>   - drop brcm,iproc-ahci from standalone enum
>   - fix reg address in example 2
>   - move clocknames next to clocks, regnames to reg
>   - drop interrupts description
>   - drop newline from dma-coherent
>   - drop max-items from ports-implemented
>   - min2max in child phys
>   - fix identation for compatible and sata-common
>   - add additionalProperties=false for subnodes
>   - pipe for paragraphs and newline after title
>   - add maximum for ports-implemented (found only 0x1 as its value)
>   - add phy-names to sata-ports
> 
> v4:
>   - fix min vs. max
>   - fix indention of examples
>   - move up sata-common.yaml
>   - reorder compatible
>   - add descriptions/maxitems
>   - fix compatible-structure
>   - fix typo in example achi vs. ahci
>   - add clock-names and reg-names
>   - fix ns2 errors in separate patch
> v3:
>   - add conversion to sata-series
>   - fix some errors in dt_binding_check and dtbs_check
>   - move to unevaluated properties = false
> 
> arch/arm/boot/dts/qcom-apq8064.dtsi had caused errors for clock-count
> ---
> 
> have not added reviewed-by from v5 because i have changed patch too much
> 
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 --------
>  .../bindings/ata/ahci-platform.yaml           | 182 ++++++++++++++++++
>  2 files changed, 182 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml
> 

Applied, thanks!
