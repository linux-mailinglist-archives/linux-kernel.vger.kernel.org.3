Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047D59267A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiHNVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiHNVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:11:25 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6062463A0;
        Sun, 14 Aug 2022 14:11:24 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4342885otb.6;
        Sun, 14 Aug 2022 14:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SNtxptsKRfjxSNBzwKDrbRbP+rVioeM6pMX342S2Bzo=;
        b=DmDZ7ucoTSly1lkkfTagT/pkYAf8VdMEN/Hv13T5+6i9PEI8jqr9dRWqNwScPyTPTj
         ZDdoGSwls+zoKeyHv7ZKWywmIjwzK9f9i/kZqvPyolaJjrRNM6IMriFonzWiRuNHCLlD
         LaHo96FpM1zd+020734ykI3vyVCWjFwPXBvjk254eYV4qNkGHm4LReSDz/Y0raz16LHk
         JH6sRp3oWYTP3DoCLm0mkfeCmrM8ogKPNgkDYYPdV2EjDIGoC63nBuw2+zJYN/M07mBr
         EdmgNzyQiODs8exj8f2RKUguZu5b10U/DQpiQimh5WR8jnhb4lSjDGLl4DOXJcCYxnNr
         vX+g==
X-Gm-Message-State: ACgBeo2hJ9zUEqHhnkPDv14Su8GnAxH14c9O4JlIJIpblA+dvP9HwG/U
        vspwF6zMstO+TgrVvsw8Yg==
X-Google-Smtp-Source: AA6agR4VVIBNTZCoEgw4V7rWL5Xl6HZTIc9xhHfD7yz058qiISTBRw/kvHeZmSjVqY9jQPet77fZmw==
X-Received: by 2002:a9d:748a:0:b0:637:2ef1:f3f3 with SMTP id t10-20020a9d748a000000b006372ef1f3f3mr4959581otk.90.1660511483711;
        Sun, 14 Aug 2022 14:11:23 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id m15-20020a056870a10f00b000fb2aa6eef2sm1049682oae.32.2022.08.14.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 14:11:23 -0700 (PDT)
Received: (nullmailer pid 716555 invoked by uid 1000);
        Sun, 14 Aug 2022 21:11:04 -0000
Date:   Sun, 14 Aug 2022 15:11:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: Drop Pratyush Yadav
Message-ID: <20220814211104.GA716504-robh@kernel.org>
References: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 11 Aug 2022 09:38:40 +0300, Krzysztof Kozlowski wrote:
> Emails to Pratyush Yadav bounce ("550 Invalid recipient").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
