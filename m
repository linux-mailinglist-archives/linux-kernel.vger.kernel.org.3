Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079AA4E56FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiCWQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCWQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:58:22 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA496E4E1;
        Wed, 23 Mar 2022 09:56:52 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-de3f2a19c8so2306807fac.1;
        Wed, 23 Mar 2022 09:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v7L9ap4GpNRjjElNdT0yh/Sp/wCcecw0FkTSkrd8bsw=;
        b=WTisdeBLjqudkEn4FdW2MeIxt5Q0E9s4zeWtDRZGNmZWjdwfwGiKx5qlg/MerFIYUR
         4yzSSmbPQn7Wdmt61v+vi2Yjx9+UmJtfEmWlBGdV5k1FAmRyxP+ByViN9duAQF3cuFew
         iExk/3TVOuGieOlZgbN/ahS4YuHT5a/+x7SHvzu0GA2vQDjfImNUdcdwSWFWfOWC/xfK
         sS74R0CPoE1dTYI6XYGRbbq7mr0i6qUNWue4HajuR6y7tjbyZv7NOsR6KT100ZgqUmsh
         XTaifLcJEiVOf7KHiZyvFjx+iqVZIYous0CaR2fouzVIMuivXXzlFocJ4fOpvr4Cs/fr
         rwSw==
X-Gm-Message-State: AOAM532mcq/vucoxMvWTKsko5cfDhFud+ZRoenZEbjUmr55HgK7m5Y9S
        ZcqqYtVTAa1GGTRcqksiOQ==
X-Google-Smtp-Source: ABdhPJx0rcy71J5iBnTkDYdwY7ow5S9sY6VGoRn0bx+CmDpmUoBHODo18+Ib2exeipbENAG7oZNWsw==
X-Received: by 2002:a05:6871:203:b0:dd:bd36:fd8b with SMTP id t3-20020a056871020300b000ddbd36fd8bmr4664191oad.122.1648054611728;
        Wed, 23 Mar 2022 09:56:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm219920oae.33.2022.03.23.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:56:50 -0700 (PDT)
Received: (nullmailer pid 74591 invoked by uid 1000);
        Wed, 23 Mar 2022 16:56:49 -0000
Date:   Wed, 23 Mar 2022 11:56:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Tom Rini <trini@konsulko.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Anderson <seanga2@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        u-boot@lists.denx.de
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <YjtRUVL2fRZpLFl5@robh.at.kernel.org>
References: <20220228131250.16943-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228131250.16943-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 14:12:50 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot uses environment variables for storing device setup data. It
> usually needs to be accessed by a bootloader, kernel and often
> user-space.
> 
> This binding allows describing environment data located in a raw flash
> partition. It's treated as NVMEM device and can be reused later for
> other storage devices.
> 
> Using DT should be cleaner than hardcoding & duplicating such info in
> multiple places. Bootloader & kernel can share DTS and user-space can
> try reading it too or just have correct data exposed by a kernel.
> 
> A custom "compatible" string allows system to automatically load
> relevant NVMEM driver but phandle can be also used for reading raw
> location.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Update descriptions to don't make this binding MTD (flash partition)
>     specific. Mention multiple possible storage ways.
> V3: Drop
>     allOf:
>       - $ref: nvmem.yaml#
>     as we don't use anything rom the nvmem.yaml. Thanks Rob.
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 

Applied, thanks!
