Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4040658083C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiGYXas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGYXap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:30:45 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BB26AD3;
        Mon, 25 Jul 2022 16:30:44 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id u9so15279567oiv.12;
        Mon, 25 Jul 2022 16:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tB43GG8tX1vlD+706vvfn3AjCvnxhM5ALYIKkm0V9O0=;
        b=CcE+Jjo7F92tkssJLDan51jyI1y9xf2Zja1DIX+OQZ+qpNtrcOKH6auJxl6Bp+ncCP
         TPuZhdKPr+wGfcwSfE1bgoWC7mhTfAZuGbfKmrCaGbIOE/kFhfUqLfp8Xtb6m2WU/rpe
         KzHYyeyk5yyeVceiE+yJ/kIrleQQqRukgKmfJVj5EWj+Oj6rTO+5qkAfP8ev2WxKU/wG
         nwjsPki2Hu2XBcARfpyBquzfRSr/AFslu8QHMatqKmPfiU8mW/DHu0SWgkHgkbOTV4Y3
         k4335cQaKxdztCVt3GWbpXNoqq8JagZmvoJ+zSHsVP1jH6EvGXe+tHe16USRtrLGaHuv
         Dxwg==
X-Gm-Message-State: AJIora8s9h4fkrjszBIUFcfeKdWXu02YEBkKLkeh3WlGlgAf5LeekEJC
        nm6e1gnkfhuwyzKsI/9wPA==
X-Google-Smtp-Source: AGRyM1tw2MDk+wa9BktP1d0UBMBoKVhhyO8ZCHNfXLyaG2jdgZEuu2gIESNxxRgEO+Tg1XrEVtUzag==
X-Received: by 2002:a05:6808:1304:b0:33a:ade0:b35d with SMTP id y4-20020a056808130400b0033aade0b35dmr6812932oiv.227.1658791844249;
        Mon, 25 Jul 2022 16:30:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i6-20020aca2b06000000b0033a11fcb23bsm5349387oik.27.2022.07.25.16.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:30:43 -0700 (PDT)
Received: (nullmailer pid 2960495 invoked by uid 1000);
        Mon, 25 Jul 2022 23:30:42 -0000
Date:   Mon, 25 Jul 2022 17:30:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anand.gore@broadcom.com, krzysztof.kozlowski@linaro.org,
        rafal@milecki.pl, kursad.oney@broadcom.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
Message-ID: <20220725233042.GA2960432-robh@kernel.org>
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-2-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725055402.6013-2-william.zhang@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 22:53:54 -0700, William Zhang wrote:
> BCM4908 is one of the Broadcom Broadband origin WLAN Router/Access
> Pointer SoCs. It was originally added by Rafał before Broadcom
> started to upstream the support for broadband SoCs. Now that Broadcom
> Broadband SoC is supported under arch ARCH_BCMBCA, this patch moves
> BCM4908 SoC device tree descriptions into BCMBCA binding.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> ---
> 
> Changes in v2:
> - Add Acked-by tag
> - Improve commit message with more details
> 
>  .../bindings/arm/bcm/brcm,bcm4908.yaml        | 42 -------------------
>  .../bindings/arm/bcm/brcm,bcmbca.yaml         | 21 ++++++++++
>  2 files changed, 21 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
