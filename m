Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1B580843
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiGYXct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiGYXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:32:44 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC326AF2;
        Mon, 25 Jul 2022 16:32:41 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id j70so15319020oih.10;
        Mon, 25 Jul 2022 16:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m42VKEi6vfilBIhiiPuyGWZwKs1BezZsmmSu0W28oqo=;
        b=obiYHIE2goA84LRuK/3Y3ESj/uZpImnMZdxosUpzG2OiQSMKXbixHsN7gUdg0ZiHhQ
         fSNdA3A5vAY+FD25OoGDorXD+XzAKhv1roAhM0QQkEYN4pl66j5c9IXnnfat+NoePGw9
         yg8OZqyEuyQgPs8r2QqbYYEDEYxSz1eO4GwnYXqjMQ02gUebMBBOkdrdsPtW3Gmu/BG9
         6bLIM+fncAqGHEAeHOvvnllsoOqTpqIsUfiz5FY1zjLs/h80cKJkh4ynjd24b+bI96d/
         orUUQdMODZ0brI9vlDdorjV6mQlCXkGrArDvYM79Wsq9V14QFFsv+a8B0TK+f0yQ5Q/g
         nT0Q==
X-Gm-Message-State: AJIora+lthPnvVDb7V3vi+9xviZpVCgDfS/BvVnmEqEI+KeLQNDsaNmG
        YE39gyMQG4dBvmoR9aF4LQ==
X-Google-Smtp-Source: AGRyM1ssvfUPu9EZBI8aiA6OYavAGGieTHFnlufnRd235wdBKsS0sLYzFpiF3aBtFwfz3jO8ZbFnnw==
X-Received: by 2002:aca:de42:0:b0:33a:4c62:8de1 with SMTP id v63-20020acade42000000b0033a4c628de1mr13290637oig.211.1658791960344;
        Mon, 25 Jul 2022 16:32:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e22-20020a056870239600b0010c2d339ea6sm6596152oap.23.2022.07.25.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:32:40 -0700 (PDT)
Received: (nullmailer pid 2963489 invoked by uid 1000);
        Mon, 25 Jul 2022 23:32:38 -0000
Date:   Mon, 25 Jul 2022 17:32:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, rafal@milecki.pl,
        krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] arm64: dts: bcmbca: update BCM4908 board dts files
Message-ID: <20220725233238.GA2960972-robh@kernel.org>
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725055402.6013-4-william.zhang@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 10:53:56PM -0700, William Zhang wrote:
> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
> binding rule for BCM4908 family based boards. This will break drivers
> that use the old compatible string for binding. Fortunately there is no
> such usage in linux and u-boot.

How does adding an additional compatible break things?

> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> ---
> 
> Changes in v2:
> - Add Acked-by tag
> 
>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts | 2 +-
>  .../dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts     | 2 +-
>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts | 2 +-
>  .../arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> index 2dd028438c22..d8b60575eb4f 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
> @@ -7,7 +7,7 @@
>  #include "bcm4906.dtsi"
>  
>  / {
> -	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
> +	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "Netgear R8000P";
>  
>  	memory@0 {
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> index 064f7f549665..296393d4aaab 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
> @@ -7,7 +7,7 @@
>  #include "bcm4906.dtsi"
>  
>  / {
> -	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908";
> +	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "TP-Link Archer C2300 V1";
>  
>  	memory@0 {
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> index 04f8524b5335..787c7ddf9102 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
> @@ -6,7 +6,7 @@
>  #include "bcm4908.dtsi"
>  
>  / {
> -	compatible = "asus,gt-ac5300", "brcm,bcm4908";
> +	compatible = "asus,gt-ac5300", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "Asus GT-AC5300";
>  
>  	memory@0 {
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> index 3c2cf2d238b6..23b96c663239 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
> @@ -3,7 +3,7 @@
>  #include "bcm4908.dtsi"
>  
>  / {
> -	compatible = "netgear,raxe500", "brcm,bcm4908";
> +	compatible = "netgear,raxe500", "brcm,bcm4908", "brcm,bcmbca";
>  	model = "Netgear RAXE500";
>  
>  	memory@0 {
> -- 
> 2.34.1
> 


