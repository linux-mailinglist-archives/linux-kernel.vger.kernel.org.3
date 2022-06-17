Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030B954FD66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiFQTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiFQTO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:14:56 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE351E4F;
        Fri, 17 Jun 2022 12:14:55 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y79so5469285iof.2;
        Fri, 17 Jun 2022 12:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeUv7rb0+0nrUwkjQRwIDRYZN9duh54pctK4KzjFbfI=;
        b=j/g+X8jo/cUSLsXPxP1c/idNKf0Izpsx/boEUrk1J/R1Dl7I/4DxD2hwcr3/L7b0Jw
         kVIEV3g+fi+DoR4jyQpm0uMEyVPkja0ki6Zdjuk4UCsg42p8bIiIg0NsInvo9+g+Hi1y
         3/pVXE+Ypmf+7PY+QeSfDjzYBxpkyJ97+qwe8UWD4sRYBtFPJj5/1sVuG68T+URZMZ2/
         ZVN17HtXfXHFGguC0kMHo3IJxJ70CKC5TnL7D+HHlF3CD9Jwksdv2g6eNGPWRFI6KWTw
         fvqMHUgz0Tl4LH4d54PMh+E4FrWY/feO/OABoA4DD87sIMKOIUuY5ZD5r5y+RRNpA/MQ
         JAkg==
X-Gm-Message-State: AJIora+TPj79VS/KyIxA5RmcxMAxiDtNGj6QLlhy0d//qOMerpLPj8pb
        ED78COui1uDo2ye9qTIlfw==
X-Google-Smtp-Source: AGRyM1tgnyow1yrKz/dKuItCDeGRpyZ1YXWBAtFq0DyhUTXFmI/dv2mCbkHwF0Z17rUogJw3gCTtoQ==
X-Received: by 2002:a05:6638:1b5:b0:331:ad30:ff0f with SMTP id b21-20020a05663801b500b00331ad30ff0fmr6153852jaq.51.1655493295191;
        Fri, 17 Jun 2022 12:14:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o36-20020a027424000000b0032e7456da06sm2568564jac.15.2022.06.17.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:14:54 -0700 (PDT)
Received: (nullmailer pid 2126247 invoked by uid 1000);
        Fri, 17 Jun 2022 19:14:53 -0000
Date:   Fri, 17 Jun 2022 13:14:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 2/2] dt-bindings: vexpress-sysreg: Allow for no child
 nodes
Message-ID: <20220617191453.GA2126159-robh@kernel.org>
References: <20220613171809.3928949-1-robh@kernel.org>
 <20220613171809.3928949-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613171809.3928949-2-robh@kernel.org>
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

On Mon, 13 Jun 2022 11:18:08 -0600, Rob Herring wrote:
> It is valid for arm,vexpress-sysreg to have no child nodes when either
> the deprecated binding without child nodes is used or a platform
> has no GPIOs. If there are no child nodes, then "#address-cells" and
> "#size-cells" should not be required. However, "reg" should be present
> in all cases, so let's add it now.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks!
