Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD658945D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiHCW0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiHCWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:25:58 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB838A2;
        Wed,  3 Aug 2022 15:25:56 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id z6so8196827iln.13;
        Wed, 03 Aug 2022 15:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=75J351RhvLWaNaDEuKDQSYMAYS+EvEUS1HxFqA844aM=;
        b=I7XRoEjwIypDIeh6aIaHHsDsuFe/vhOQLSfuTeEAt1VtQCmDGQN9eyqy6TKiSmPM7g
         rey6oZ2owioNznHb0+qn1DMYFHcLu0ce15askHhQ8eONf4VLsiGRALH3FHmOzKyOdbl+
         KzQDXTaxqOfw+eDTez5GtclEgwkZHUOxmGg8rZOKqvmisrs8eZggu8CVoVPjRVr/5S5x
         F+PKrAtNWattw6iHVBuqwP8YckLUdAnUXJyDIfa5qE2p8XeUEXalHET+ThA/wQiiAzNS
         Ng3WBfDxw4XOCqNOs3qXz15A43N3XTjvzbDe24DArW/Ulvd3wMbS5ZSwlXo7jJCQqxBt
         /a6g==
X-Gm-Message-State: AJIora9oatnpyCqIlr3vT3yeb33GSU5KSvnm+gQ5C3BRv3/HfNo4x86H
        nGEgDPWYiNi2VfJ5BPTITQ==
X-Google-Smtp-Source: AGRyM1vFgEiM4mqDqG8n02VeO5CgzGHFBqz8H57zw5X0V7f6EMV3CS5bmW+6+WMG6BHO7ysuxySmDQ==
X-Received: by 2002:a05:6e02:1a25:b0:2dc:743c:864a with SMTP id g5-20020a056e021a2500b002dc743c864amr11342302ile.248.1659565555800;
        Wed, 03 Aug 2022 15:25:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bc11-20020a0566383ccb00b00335b403c3b4sm8176076jab.48.2022.08.03.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 15:25:55 -0700 (PDT)
Received: (nullmailer pid 2730520 invoked by uid 1000);
        Wed, 03 Aug 2022 22:25:53 -0000
Date:   Wed, 3 Aug 2022 16:25:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elvis Wang <Elvis.Wang@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: add definition for mt8188
Message-ID: <20220803222553.GA2727128-robh@kernel.org>
References: <20220729084319.6880-1-Elvis.Wang@mediatek.com>
 <20220729084319.6880-2-Elvis.Wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729084319.6880-2-Elvis.Wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:43:18PM +0800, Elvis Wang wrote:
> Add dt-binding header for mt8188.
> 
> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index c2aeba63bd47..50f97f6feeef 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -41,9 +41,9 @@ Optional properties for a client mutex node:
>    defined in 'dt-bindings/gce/<chip>-gce.h'.
>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
> -'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h'
> -'dt-bindings/gce/mt8192-gce.h', 'dt-bindings/gce/mt8195-gce.h' or
> -'dt-bindings/gce/mt6779-gce.h'.
> +'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h',
> +'dt-bindings/gce/mt8188-gce.h', 'dt-bindings/gce/mt8192-gce.h',
> +'dt-bindings/gce/mt8195-gce.h' or 'dt-bindings/gce/mt6779-gce.h'.
>  Such as sub-system ids, thread priority, event ids.

What about a new compatible string?

Really, this needs to be converted to schema...

Rob
