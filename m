Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3737E4FE934
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiDLUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiDLUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:03:55 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C693B7D8;
        Tue, 12 Apr 2022 12:54:29 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so10632245otr.2;
        Tue, 12 Apr 2022 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wy3DmJdebYflJ+5t1obwtAcHSgIk+Vy2BCzfnX0reCQ=;
        b=jpCxjXGx0T+bvbYOoA0z7m6siFeKNxqpHHNQyzE4YHb9UVPVFuh6hQIgZGNrkFWRn1
         Afn5wIN132KHEKwvvEIu+Iw5hldychWqpsY9Lrx6OurqJro2A+NuoEJkerYsxJSYh21i
         ZM+djFnw+s2Q69dm/pmnhzmklVNst5vzZ3EM6C/f02AUGxygbkn6oNE4muh4UDIVrHrg
         oZTwtZderCvDpivacmtsPXBjXvJV7Hh3qkx77c4XGE8GMhhtRVzroyJzOCT7kQbzBiMO
         T7yoROyAVM4aHyXdif1/b8Kty0/kFCUgDDco22SFz1Jgxb/AflMzU3IBjOEVgK5v2sab
         4xcA==
X-Gm-Message-State: AOAM531OwMxm6uYL9W1NkwUtn1PsOieTBsEAzWeiwSpycha+sq2//p4a
        Qxw4GIiUBSna/tMNiQsxvw==
X-Google-Smtp-Source: ABdhPJwmbiD/aWCEKDHCHM7vKw278+FDcbZJ6Gk6iP8h1T1MtOVumIg988i7lWxCi7Lb32qAj9+W3g==
X-Received: by 2002:a05:6830:1113:b0:5e9:29c0:aeb2 with SMTP id w19-20020a056830111300b005e929c0aeb2mr196847otq.51.1649793268421;
        Tue, 12 Apr 2022 12:54:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e9-20020a056820060900b003216277bfdasm13227604oow.19.2022.04.12.12.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:54:28 -0700 (PDT)
Received: (nullmailer pid 775571 invoked by uid 1000);
        Tue, 12 Apr 2022 19:54:27 -0000
Date:   Tue, 12 Apr 2022 14:54:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle gpio pin
 property
Message-ID: <YlXY88aJIrcHc5Bc@robh.at.kernel.org>
References: <20220409211215.2529387-1-dfustini@baylibre.com>
 <20220409211215.2529387-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409211215.2529387-2-dfustini@baylibre.com>
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

On Sat, Apr 09, 2022 at 02:12:14PM -0700, Drew Fustini wrote:
> Document Wakeup M3 IPC property that indicates a GPIO pin is connected
> to the enable pin on DDR VTT regulator and can be toggled during low
> power mode transitions.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [dfustini: converted to YAML, removed unnecessary "ti,needs-vtt-toggle"]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> index d855c01ce61c..7f4a75c5fcaa 100644
> --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> @@ -24,6 +24,14 @@ description: |+
>    A wkup_m3_ipc device node is used to represent the IPC registers within an
>    SoC.
>  
> +  Support for VTT Toggle
> +  ==================================
> +  On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
> +  connected to the enable pin on the DDR VTT regulator. This allows the
> +  regulator to be disabled upon suspend and enabled upon resume. Please note
> +  that the GPIO pin must be part of the GPIO0 module as only this GPIO module
> +  is in the wakeup power domain.
> +
>  properties:
>    compatible:
>      enum:
> @@ -51,6 +59,10 @@ properties:
>        mbox_wkupm3 child node.
>      maxItems: 1
>  
> +  ti,vtt-gpio-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: GPIO pin connected to enable pin on VTT regulator

Looking at the driver, can't you add 'maximum: 31' here? If so, I can 
add it when applying.

Rob
