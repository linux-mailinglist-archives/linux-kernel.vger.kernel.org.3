Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091C570D91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGKWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:52:13 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C5545DE;
        Mon, 11 Jul 2022 15:52:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id y2so6300780ior.12;
        Mon, 11 Jul 2022 15:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVsyVNeM7VExApQQm27V2U3K3Ew7O7BqPXEGzNor7JQ=;
        b=D/JirY36DvMTmsWBC6DYkwuUdWtvWRMNlNAXXKDCeMX9zT5g31uJxyC9WfupciJKO5
         QrKzHpPr6/Yy7Ur7JbYMamNYEP9KYMOO5nkSfJwdAtEkuTGSV/ZbUQrWLotqN8QLVufY
         FUs6zUFZFe/Cy73gl0gbT4uFnfq6hc5kvYf2DkmwKThdejwmdHPcPYxL3wc5E7fQz62X
         sD6mau+400OaoaNuUjp4qUFHgHo/VUpUFxezM9fvoyuObR88oYVMlnaptAUQzgEful7U
         RnGNsMledSndykIlO4fszfK5VOXXzmQ4x/ye8PMPKe8QAKmhcYpDRmiEK2uJbppCTBFv
         Vtaw==
X-Gm-Message-State: AJIora/thZJqtLw2BD2Rme2KDqVOiBhOhgIEqrXrVcgMeI8herxuh23G
        CnCqR1QbZ7qEL+fmhxuIHg==
X-Google-Smtp-Source: AGRyM1tboW87HTQuEDF23kVnOyKb4dQSSMkiAiV0GeGCkS39NqiwWm05SeXFvwjvxMgWWBF0r8rcVQ==
X-Received: by 2002:a02:9044:0:b0:33f:3845:3ea0 with SMTP id y4-20020a029044000000b0033f38453ea0mr9718285jaf.176.1657579932190;
        Mon, 11 Jul 2022 15:52:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d20-20020a0566022bf400b0067b78bcba0esm4183238ioy.43.2022.07.11.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:52:11 -0700 (PDT)
Received: (nullmailer pid 417587 invoked by uid 1000);
        Mon, 11 Jul 2022 22:52:10 -0000
Date:   Mon, 11 Jul 2022 16:52:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add compatible for
 mt8188
Message-ID: <20220711225210.GA417534-robh@kernel.org>
References: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
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

On Fri, 08 Jul 2022 14:58:34 +0800, Chunfeng Yun wrote:
> Add compatible for mt8188
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
