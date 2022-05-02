Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DFC5177D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387236AbiEBUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387309AbiEBUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:19:08 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94981B2A;
        Mon,  2 May 2022 13:15:38 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so8456847ots.11;
        Mon, 02 May 2022 13:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wcuo3wLe8i7fX/0vTB283vnwAIkjYat/Xc/G+3XsJC4=;
        b=LHRgqje+N17ccMRK+8PG9O7a/cqF7prwvKSWaARNctebsk93UzzkiBeFCq+XXTrxuQ
         7v7WIGvBX7DgE+fkszGtuXvXx6VuCAr/6gQtc887siMp8O3CsjKfVxxVr4D6c+K4q9lx
         QwI1M3HYZV3VXjqBH0JsUGt5RejOiqV+CXpMW0uMXZ10NkyR8SvymTQOPKOm5i3Y95vy
         02jiJq+I3kktVVEjBu6KatcrM4olfQSDHG0cfW3LzCaeiOLzRFlpwAz0OrqdHsCXd8VI
         /jUETJPS/Z0DOrfc9s1qmKvW4YRk6bvmXVTeXOovc+zk2aqErCTKWa6X1Az9IFU6Ba8W
         5Fcg==
X-Gm-Message-State: AOAM531jMCxqtYHCnSCwaNbz5wJwvaqDhCqNiDqETAre2m9qU83z12h5
        YEyX21aEz71RnlDQYxjbNw==
X-Google-Smtp-Source: ABdhPJyBnRImjZTXHqLnyiVzGug8vuCN5NWHD9Wc3+zNvjMwq80j5IJH0zQxMvjczvzOOO/ANJcmuw==
X-Received: by 2002:a05:6830:1489:b0:605:e8f6:5047 with SMTP id s9-20020a056830148900b00605e8f65047mr4668736otq.185.1651522537861;
        Mon, 02 May 2022 13:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f6-20020a4ad806000000b0035eb4e5a6c4sm4198367oov.26.2022.05.02.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:15:37 -0700 (PDT)
Received: (nullmailer pid 1665884 invoked by uid 1000);
        Mon, 02 May 2022 20:15:36 -0000
Date:   Mon, 2 May 2022 15:15:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/6] dt-bindings: ti,sci: Add lpm region and
 ti,lpm-firmware-name
Message-ID: <YnA76FFG0wW1Jzrs@robh.at.kernel.org>
References: <20220421203659.27853-1-d-gerlach@ti.com>
 <20220421203659.27853-3-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421203659.27853-3-d-gerlach@ti.com>
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

On Thu, Apr 21, 2022 at 03:36:55PM -0500, Dave Gerlach wrote:
> Add documentation for the lpm region which tells the ti-sci driver where
> to load the FS Stub low power mode firmware and also the
> ti,lpm-firmware-name which tells the driver which binary to load. Both
> of these are optional for normal system operation but required to
> enabled suspend-to-mem usage of Deep Sleep state.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../bindings/arm/keystone/ti,sci.yaml         | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index ec88aa88a2a0..31c783507cd0 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -42,12 +42,19 @@ properties:
>            - const: ti,am654-sci
>  
>    reg-names:
> -    description: |
> -      Specifies the debug messages memory mapped region that is optionally
> -      made available from TI-SCI controller.
> -    const: debug_messages
> +    items:
> +      - const: debug_messages
> +      - const: lpm
> +    minItems: 1
>  
>    reg:
> +    items:
> +      - description: |
> +          Specifies the debug messages memory mapped region that is optionally
> +          made available from TI-SCI controller.
> +      - description: |
> +          Specifies the lpm memory mapped region where the FS Stub low power
> +          firmware is to be loaded.
>      minItems: 1
>  
>    mbox-names:
> @@ -92,6 +99,12 @@ properties:
>      type: object
>      $ref: /schemas/reset/ti,sci-reset.yaml#
>  
> +  ti,lpm-firmware-name:

firmware-name

> +    description: |
> +      Name of binary of FS Stub low power firmware located on the
> +      firmware search path.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
>  required:
>    - compatible
>    - mbox-names
> -- 
> 2.35.0
> 
> 
