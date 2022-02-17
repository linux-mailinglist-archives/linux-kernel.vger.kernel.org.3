Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35884BAE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiBRAGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:06:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiBRAGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:06:32 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5251E63;
        Thu, 17 Feb 2022 16:06:04 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id z16so1005772pfh.3;
        Thu, 17 Feb 2022 16:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s929dscyVLXL47tG8YulOaG8Qoyz2aoFJHGoNxnOm6g=;
        b=qLfU4SHQR2+YL9a5Dcge/xGo3PafejM+vToi1VjPiBa6IfWVYMQY00lN0YQJBY5CWD
         jWs9O6mssLUMfLdX4PBHvQVAClZPP2kVT8lQymQIsP8GsWHolSLxk4WB/AyQJ2BzmwVt
         iw5TjdlFnWy6AP8s35kPXMLvt2Ngg45rZPVD012qVNNU7h5LmFO0JkW8SECD9a7dwT+v
         Yq0OLgo36ChhKUh9pEX6BI7f4og/eCt6JDteYkrmrb5O1fbzhtO2jCl1quPYyAOwaBNZ
         uGxU01QCRplIIXQfCSVA1emS1ZoarUF8yTAiJJyBnggu2cM6m9ParnWEh1Wx5X+0Qyc7
         ROcQ==
X-Gm-Message-State: AOAM530R8yl6knqBhkZ+VGMcNy1RR8rfQeIECAmxhECsE4i/Tm8v55jZ
        ZAxs1uz4oGeRYEyJJFcH+qYrLFq1hw==
X-Google-Smtp-Source: ABdhPJyWUVkU+CbllDyvAbEcidfFEm9xfSeMGni+GqR8gNOSrJ8HQeqkslB+1u5bMqeKbC/5N5yHdA==
X-Received: by 2002:a05:6e02:1a66:b0:2c1:888d:b9cb with SMTP id w6-20020a056e021a6600b002c1888db9cbmr2874007ilv.74.1645142298733;
        Thu, 17 Feb 2022 15:58:18 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f13sm2839519ion.18.2022.02.17.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:58:18 -0800 (PST)
Received: (nullmailer pid 4013102 invoked by uid 1000);
        Thu, 17 Feb 2022 23:58:16 -0000
Date:   Thu, 17 Feb 2022 17:58:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 2/3] dt-bindings: nvmem: brcm,nvram: add NVMEM cell to
 example
Message-ID: <Yg7hGKWFWG4ntk+u@robh.at.kernel.org>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220211130554.13062-1-zajec5@gmail.com>
 <20220211130554.13062-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211130554.13062-3-zajec5@gmail.com>
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

On Fri, Feb 11, 2022 at 02:05:53PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVRAM doesn't have cells at hardcoded addresses. They are stored in
> internal struct (custom & dynamic format) . It's still important to
> define relevant cells in DT so NVMEM consumers can reference them.
> 
> One of cells set in almost every device is "et0macaddr" containing MAC
> address. Add it to example to show how it can be referenced.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add children nodes description per Rob's request
> ---
>  .../devicetree/bindings/nvmem/brcm,nvram.yaml    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 8c3f0cd22821..fc1df9d1c4d4 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -27,11 +27,23 @@ properties:
>    reg:
>      maxItems: 1
>  
> +patternProperties:
> +  ".*":

This doesn't really work as a schema as it matches every property or 
child node.

> +    description: |
> +      Each child node represents one NVRAM entry (variable). Node name has to
> +      match variable name as internally defined in the NVRAM.
> +
> +      Some of common NVRAM variables are: "board_id", "boardflags", "boot_wait",
> +      "clkfreq", "et0macaddr", "sdram_config", "wait_time".

I meant documenting these as schema, not just in a description:

properties:
  board_id:
    type: object
    description: ...

  board_flags:
    type: object
    description: ...

I'm guessing making this list exhaustive is not possible?

> +
>  unevaluatedProperties: false

     type: object

To say anything else must be a child node.

>  
>  examples:
>    - |
>      nvram@1eff0000 {
> -            compatible = "brcm,nvram";
> -            reg = <0x1eff0000 0x10000>;
> +        compatible = "brcm,nvram";
> +        reg = <0x1eff0000 0x10000>;
> +
> +        mac: et0macaddr {
> +        };
>      };
> -- 
> 2.34.1
> 
> 
