Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9BF53AE45
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiFAUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiFAUqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:46:49 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366FF13569A;
        Wed,  1 Jun 2022 13:41:22 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso2097769otr.0;
        Wed, 01 Jun 2022 13:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJYEOamuUI8+hGxefhFmvlXiUIoxuSnHZm1hsc1vWFY=;
        b=GWRhY0RZ/zVZpju167zKzKkMoyOXH37HTPWBmo5RYFWNbOMiSYxNj0BcoJvEkS1XCD
         lZiVT68hMi6RA28YHbxMWR+WxDtxH6kuCPCJanW0LuxwwZHJFkVX9wswkU/aQ/swu4rq
         Llliepwxg0776+NBzO44nodD62ORoz8W2Ey4PuVyamD7j8i+CIQzF/j8cW1iIPabf6th
         EyRLf2VIoOW0SB51ntxeWND6Xl5Z+a1+o+CO2OpvmKnNEycZWGL4DBR3JhLEnftFLpdK
         D3r8c07aRWjzyLtkfnRNY6qE+IxIV//2EZGtlXo4Lwgnr0yiPzJNuSrVIZQRxHH6q/cL
         ZAMQ==
X-Gm-Message-State: AOAM533W3B6cpd3Xs5kLZpBZN1K0ouwlFqf+7i9yAEb341T7ErnMJsub
        uCXBdhZ4f6ziIapZ6pWiohyizf56JA==
X-Google-Smtp-Source: ABdhPJxaah9NBd3MkGoro16iedv6h3Eq2gaNVukZrkbQHdoOU5IuH/kCtMA2VHhv966s8GbqSpJkug==
X-Received: by 2002:a9d:12f6:0:b0:60a:e98d:cc7c with SMTP id g109-20020a9d12f6000000b0060ae98dcc7cmr653579otg.18.1654113831593;
        Wed, 01 Jun 2022 13:03:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 12-20020aca120c000000b00325cda1ffa5sm1290278ois.36.2022.06.01.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:03:51 -0700 (PDT)
Received: (nullmailer pid 342702 invoked by uid 1000);
        Wed, 01 Jun 2022 20:03:50 -0000
Date:   Wed, 1 Jun 2022 15:03:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, martin.botka@somainline.org,
        tglx@linutronix.de, paul.bouchara@somainline.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.lezcano@linaro.org,
        linux-mediatek@lists.infradead.org, marijn.suijten@somainline.org
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: mediatek: Add CPUX System
 Timer and MT6795 compatible
Message-ID: <20220601200350.GA342663-robh@kernel.org>
References: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
 <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
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

On Wed, 18 May 2022 13:24:34 +0200, AngeloGioacchino Del Regno wrote:
> Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
> System Timer on MediaTek platforms and add the MT6795 compatible for it.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
