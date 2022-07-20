Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEE57C0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiGTXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiGTXcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:32:39 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2BA42AF4;
        Wed, 20 Jul 2022 16:32:39 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id n138so145770iod.4;
        Wed, 20 Jul 2022 16:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTw5TM8NIkj7Y2Npa+S/jOHSj+YeoroLMLD1j/HNVQw=;
        b=PI4WccehixOnYESOB01nuhZUIpyLiNfwd0IZu6dRV7PC4p6Kkn1gBYbQDVO0uKlt7C
         vRyDsLZhsrwWbN9+HR8peXkZhgGQSLQJpSddmW51SybtZFI1ZiENXnNUQEdMZMWKZCoE
         2ASjMes3qUash/vXpJOjmHNjGidXilvQX834BRGxIHxr3kT8driLF+xDxNFrCa+UJjNC
         QRgOPwa5OEyiJZyo2oxC90S5XZOkEKIsPmhLdopptz7VkdQhTEORNA36nBw4X9LqEkYK
         KI2zYvHFa0wkWAezKf+FeSnQB/2tLbx69pQWKpLjJa1lqPurptTRHNoz6z5K+LsI4a1e
         mP2Q==
X-Gm-Message-State: AJIora8+8GCvY4YxTCZgE2p/Wz6pG3jM8aqEeWFg9Tsns2j0XzkJRffg
        NR2JBU3fOTAGRwbTp6ieXQ==
X-Google-Smtp-Source: AGRyM1ufbECga9pyQXyTVMLdTt5n/U5W3j3M1T/W2MXkulykIVZgEBZMlc66M25vXLcty1OcHT8LiA==
X-Received: by 2002:a05:6602:2b8a:b0:67b:c57f:b4bc with SMTP id r10-20020a0566022b8a00b0067bc57fb4bcmr17058794iov.55.1658359958428;
        Wed, 20 Jul 2022 16:32:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f19-20020a022413000000b0033efe711a37sm117507jaa.35.2022.07.20.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:32:37 -0700 (PDT)
Received: (nullmailer pid 4185445 invoked by uid 1000);
        Wed, 20 Jul 2022 23:32:35 -0000
Date:   Wed, 20 Jul 2022 17:32:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Darren Etheridge <detheridge@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: display: ti,am65x-dss: Add IO CTRL
 property for AM625 OLDI
Message-ID: <20220720233235.GA4180021-robh@kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-3-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719080845.22122-3-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 01:38:39PM +0530, Aradhya Bhatia wrote:
> Add am625-io-ctrl dt property to provide access to the control MMR
> registers for the OLDI TXes.
> 
> These registers are used to control the power input to the OLDI TXes as
> well as to configure them in the Loopback test mode.
> 
> The MMR IO controller device has been updated since the AM65x SoC and
> hence a newer property is needed to describe the one in AM625 SoC.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 11d9b3821409..672765ad1f30 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -118,12 +118,33 @@ properties:
>        and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
>        interface to work.
>  
> +  ti,am625-oldi-io-ctrl:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description:
> +      phandle to syscon device node mapping OLDI IO_CTRL registers, for
> +      AM625 SoC. The mapped range should point to OLDI0_DAT0_IO_CTRL,
> +      and map the registers up till OLDI_LB_CTRL. This property allows
> +      the driver to control the power delivery to the OLDI TXes and
> +      their loopback control as well.

What's wrong with the existing ti,am65x-oldi-io-ctrl other than the less 
than ideal naming? And you just continued with the same issue so the 
next part will need yet another property. Sorry, no. Just use the 
existing property.

> +
>    max-memory-bandwidth:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        Input memory (from main memory to dispc) bandwidth limit in
>        bytes per second
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ti,am65x-dss
> +then:
> +  properties:
> +    ti,am625-oldi-io-ctrl: false
> +else:
> +  properties:
> +    ti,am65x-oldi-io-ctrl: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.37.0
> 
> 
