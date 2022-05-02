Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2A5177CE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387194AbiEBURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEBURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:17:43 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC919A1A9;
        Mon,  2 May 2022 13:14:13 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so5232763otl.0;
        Mon, 02 May 2022 13:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkeg6XLEWMu4HTjeFF0OJwDdi6kmXL5/h/LctGqY8Kw=;
        b=H5TgUBNgdVHeQiWqDMlQDWkTDJN0cHuAliGAG3QY4oppgTD58ZrK64OWnm11jCBGp4
         Y9Oka1d5gsbldczt2QJ3TtQlgpuh4MVuEQR9NOtqeksCEB1IpyS+hn4RsGsNhW+3Jp8L
         7Ikxsby3NHdjcUEkRNJE8tULw414Ku4yIeOwSNWVhwku6Fhk2TSEfLUnfx2b8gPGyab5
         aoZJXz2FWVKxStx94t6WCpe2nebL4VwTCzk6IGfXwALBtmUZnJnONr7DX2oNUWZn2Qmm
         Ypr+yChqQB1708HcT1e8pkRTVhTGQk2BNQp0n1wQ0tvPN8E5VOyhVSVnV8U8xYnv0hx+
         0ZMA==
X-Gm-Message-State: AOAM531Qg11wMpgr9aUbwlN8UeyCx6NdSv6q/V3kvWyMGTmeUX3foUgz
        MXzxwgA3tJwOhA8C3QtLHg==
X-Google-Smtp-Source: ABdhPJwBQR971yAKeQpRWNLef9R+91JgJ3Xdcyk325o+0xXi591PrH9bHMO0DKElqNTJhKv+k+AYIQ==
X-Received: by 2002:a9d:2ab:0:b0:605:6c58:668c with SMTP id 40-20020a9d02ab000000b006056c58668cmr4824172otl.284.1651522453137;
        Mon, 02 May 2022 13:14:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b000e915a9121csm6708074oae.52.2022.05.02.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:14:12 -0700 (PDT)
Received: (nullmailer pid 1663461 invoked by uid 1000);
        Mon, 02 May 2022 20:14:12 -0000
Date:   Mon, 2 May 2022 15:14:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: ti,sci: Add ti,ctx-memory-region
 property
Message-ID: <YnA7lKVJ4Mwm78ME@robh.at.kernel.org>
References: <20220421203659.27853-1-d-gerlach@ti.com>
 <20220421203659.27853-2-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421203659.27853-2-d-gerlach@ti.com>
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

On Thu, Apr 21, 2022 at 03:36:54PM -0500, Dave Gerlach wrote:
> Add documentation for the ti,ctx-memory-region property which is a
> phandle to a reserved-memory carveout to be used by the ti_sci driver
> storage of low power mode memory context. This is optional for normal
> system operation but required to enabled suspend-to-mem usage of Deep
> Sleep state.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/arm/keystone/ti,sci.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index 34f5f877d444..ec88aa88a2a0 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -61,6 +61,15 @@ properties:
>    mboxes:
>      minItems: 2
>  
> +  ti,ctx-memory-region:

What's wrong with 'memory-region'?

> +    description:
> +      Phandle to the reserved memory node to be associated with the
> +      ti-sci device, to be used for saving low power context. The
> +      reserved memory node should be a carveout node, and should
> +      be defined as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +    $ref: /schemas/types.yaml#/definitions/string
> +
>    ti,system-reboot-controller:
>      description: Determines If system reboot can be triggered by SoC reboot
>      type: boolean
> -- 
> 2.35.0
> 
> 
