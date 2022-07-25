Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28F5807EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGYXEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiGYXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:04:31 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E61A248EA;
        Mon, 25 Jul 2022 16:04:30 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso9738630otv.3;
        Mon, 25 Jul 2022 16:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eTgoh7DbKWnFDYZi2IHM/90awoS3XaT0gHdUIdLXdDU=;
        b=OCx4d620BSA6qRO14Fcfh3h1NhEYhVMf90/R6vo4eZ1DiHFalpHoydPNjDHI/ej590
         3CaU/6zdDRvMpWImrIrZNPISkNllg9yYOv2wLQk65ETj3kByY1wAP12etZR3DBenZeXU
         oTMauJv07k7WHWJ31HXY3EOrjIK4cc7HZV0SUiFHrsbxAnkbW0GrhfXxU7G+BTfC0cVv
         dAAcaiTO/TC/59t+ThopRxj7hbXy7lrUN37bKF8PMP8DNWCkvf0c6KOqA5SC6Gu5NbPV
         vKIycs3YIzPSEG0sAbJWKQEU4Ekt1zECqMU9JLa/IxKGu+xhYvmFTwZlhg8QdMMdfO81
         fPuA==
X-Gm-Message-State: AJIora8QsaCGIkYWXHHEcPfQ1dXerM7jbs2Gw5wLo2kZtapha/y9TmHJ
        NB8yrbZjhKU5Z8kVeO6Zvw==
X-Google-Smtp-Source: AGRyM1uecQJtg6pRlsmJSeENIG+qRk4fLLpkHPBOGWzDmAImaMuPt3VmsmvMXDI5IQgKcJbUb5Un/A==
X-Received: by 2002:a05:6830:d0b:b0:61c:1bc2:fbc0 with SMTP id bu11-20020a0568300d0b00b0061c1bc2fbc0mr5397907otb.348.1658790269759;
        Mon, 25 Jul 2022 16:04:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f2-20020a4ae602000000b004288e69cac2sm5384551oot.23.2022.07.25.16.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:04:29 -0700 (PDT)
Received: (nullmailer pid 2916995 invoked by uid 1000);
        Mon, 25 Jul 2022 23:04:28 -0000
Date:   Mon, 25 Jul 2022 17:04:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 Document RZ/Five SoC
Message-ID: <20220725230427.GA2916958-robh@kernel.org>
References: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220722141506.20171-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722141506.20171-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:15:05 +0100, Lad Prabhakar wrote:
> Document RZ/Five (R9A07G043) SYSC bindings. The SYSC block found on the
> RZ/Five SoC is almost identical to one found on the RZ/G2UL (and alike)
> SoC's. "renesas,r9a07g043-sysc" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> The SYSC block on RZ/Five has no interrupts to the core so to accommodate
> this SoC make interrupts{,-names} properties optional.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> * Dropped "renesas,r9a07g043-rzfive-sysc" compatible string
> * Made interrupts{,-names} properties optional
> ---
>  .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml   | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
