Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83A4F6B34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiDFUV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiDFUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:20:28 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B281DF86F;
        Wed,  6 Apr 2022 11:17:10 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id z8so3270023oix.3;
        Wed, 06 Apr 2022 11:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6gGX1JeafegCBbM2c9piMtf7ay+mZ2pbbpD9LOI+Ak=;
        b=ca9mM081Zau2l05BylUKdUtYuwdNedgl39ltZnWRlP97HWhkPw3lg/WVr6tFilGRsx
         3UIcm1IFgLMzzaSCBj6VtXvzeLURK1hOAJ+BxOGyME8btAVs0z7dt1Ee2buo1k5HDgW4
         0QMAqfzrhKtgSbMS9eGsFVfhHGFccGoXJgNSrmBCJvTqY6VDwQ+5tG9r/PVsCvzH9JKF
         y+uSNe/T5KCSV6zHkn3OIzXawkiYs70BNWR2wf7QdSIndllqeWDgoe5njjVJlaPJ1gU9
         zOp4El708hgyuf+CddAmgk9DO730X8u+wrPQdsu1/2NHWtLuvAy/jpRaybb7BDHTXzmR
         SzKg==
X-Gm-Message-State: AOAM530fin9lCrVly0yhAR10ym+H/uFFPn2OWRYhjBmC7wA2POGDs7YM
        imo4I3U/TrhJWHKUCs3iQw==
X-Google-Smtp-Source: ABdhPJwfpvF0tXlBwNI9AWhehhWEr+8ujcczl865A4l9Y+c9W2djLeJTG6CYjERcm6c4EjcWSg1ocA==
X-Received: by 2002:a05:6808:120d:b0:2d9:a01a:4895 with SMTP id a13-20020a056808120d00b002d9a01a4895mr4342004oil.224.1649269029656;
        Wed, 06 Apr 2022 11:17:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a4a3512000000b00324add481b1sm6391334ooa.9.2022.04.06.11.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:17:09 -0700 (PDT)
Received: (nullmailer pid 2527774 invoked by uid 1000);
        Wed, 06 Apr 2022 18:17:08 -0000
Date:   Wed, 6 Apr 2022 13:17:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: uniphier: Clean up clocks,
 resets, and their names using compatible string
Message-ID: <Yk3ZJOotL22jZM/+@robh.at.kernel.org>
References: <1649145303-30221-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145303-30221-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145303-30221-2-git-send-email-hayashi.kunihiko@socionext.com>
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

On Tue, 05 Apr 2022 16:55:02 +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of clock-names and reset-names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-regulator.yaml         | 55 +++++++++++++------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
