Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04C53B95C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiFBNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiFBNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:05:49 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01914084B;
        Thu,  2 Jun 2022 06:05:47 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id i66so6406353oia.11;
        Thu, 02 Jun 2022 06:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LNaq7sEztiDWF2FCJpJbFxTE7mAwKmgj75OQYyNv2Lw=;
        b=7xTVTcc+SQO0vzNkR3GX3ZszqZHU5pxzNJxZ8lk4Tk59OALDEjf0zGVHivLFvVFGaV
         BEwl4OM2CAxSzKYGmQP2sWhoZ2BPE9xvUn2Av/+xQ/PaZ8ig/sfxHHaLtd/VvDLS4M0l
         ZGb/kvfUC4NOpnOTlnjk9k0aA1vpdiuX3Uuw/txyLMYU03hG/xQLuysbnV8yPWxObvEp
         p3/kI046Orzf27xfY4VCBTwhfBKpzD781liCCKwXN+ufk11DRtvffWahQWfoNZXhzAg1
         ELh7g2K6pQcCkMV5mWk/oM5/YZhtmVbSHeJuk261E1qkG+N0/ZRHqUQtp3eZ1RLd80gG
         pJpQ==
X-Gm-Message-State: AOAM532dvS++pHPBTL1xUAdgtIa+m0PK7R8MjQfiilgR84X+uXtsDMol
        DPgIPbGihi90K/zveHA20g==
X-Google-Smtp-Source: ABdhPJxs1Y0i7VKbCMntycxl5hizJm7Nq2kWqQ8bHM1Bplx9d/kQA7s8uN6OuQaO4Y0+hxy1mvQMNQ==
X-Received: by 2002:aca:2408:0:b0:32b:ef3:67c5 with SMTP id n8-20020aca2408000000b0032b0ef367c5mr2539773oic.189.1654175146719;
        Thu, 02 Jun 2022 06:05:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a05683002e200b0060603221247sm2159020ote.23.2022.06.02.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:05:46 -0700 (PDT)
Received: (nullmailer pid 2108487 invoked by uid 1000);
        Thu, 02 Jun 2022 13:05:45 -0000
Date:   Thu, 2 Jun 2022 08:05:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     mturquette@baylibre.com, ikjn@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        weiyi.lu@mediatek.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, miles.chen@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding
 of MT8192 clock
Message-ID: <20220602130545.GA2108433-robh@kernel.org>
References: <20220523102339.21927-1-matthias.bgg@kernel.org>
 <20220523102339.21927-2-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523102339.21927-2-matthias.bgg@kernel.org>
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

On Mon, 23 May 2022 12:23:38 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The code controlling msdc clock gate was moved inthe the consumer, the MMC
> driver. This node did never represent a working implementation of any
> peripheral. It was just a lonely clock gate that wasn't used. Delete the
> binding description of this node.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> 
> ---
> 
> Changes in v3:
> - Update commit message to explain better why we do ABI breakage here
> 
> Changes in v2:
> - Delete compatible in binding descprition as well
> - Add RvB tags
> 
>  .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml      | 8 --------
>  1 file changed, 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
