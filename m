Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7C4ECBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiC3SV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349999AbiC3SVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:21:13 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444E433A3;
        Wed, 30 Mar 2022 11:19:08 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id e189so22880153oia.8;
        Wed, 30 Mar 2022 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hweB/9EQsegxUegVTpdI7p6DUtmjW2hJD38s6/JrS/g=;
        b=crqSrLHQTKeaO/d3dspsOQFjgD0k8gLaT9piV8V1fc496ezdV6ynbCgceZpTBB+Icj
         PnsAoMbLumfIIKasa4YQlXUCnvW9GdaA7PQxLyIgitJDI61vazos3SexmM+EBW1QzWua
         2XfMSdPRDvhOsFHKK3tBhCVLLOcE/lTEIQGi+J66GTlpUqNeERD4LueLDVr4b8H2Clzb
         w9k5Kcl+vnCSB5CvvFDmJ3Xwf3AxlyPRlIQebxgK8uf4/VMrej+rUKK1DMMqOMlk/cp0
         C55IVq5B8JIvJJgHCNPvKly2d5fvjREImquuqOqEzg/iMc4Yq9ZGYSO9/DO7+BQLnpCK
         oe+Q==
X-Gm-Message-State: AOAM532PlT0BSnkfOWcBsdlXXBgsr3kf2MbI3w5cVdMXy/eYrUPdzzoR
        l9LEIt/gpRs7KWAt4mP7NRxhOsFHLw==
X-Google-Smtp-Source: ABdhPJxrAurQlMV/OgRxHFYSVU1OV7Bh4TuJ5iQSoUOucGxUM9ilr/cEg04iV3J3714He3FkYTOJdA==
X-Received: by 2002:a05:6808:1991:b0:2da:350d:f9fc with SMTP id bj17-20020a056808199100b002da350df9fcmr571035oib.251.1648664347250;
        Wed, 30 Mar 2022 11:19:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lx20-20020a0568704b9400b000de29e1d6adsm9838831oab.16.2022.03.30.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:19:05 -0700 (PDT)
Received: (nullmailer pid 3378991 invoked by uid 1000);
        Wed, 30 Mar 2022 18:19:05 -0000
Date:   Wed, 30 Mar 2022 13:19:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: auxdisplay: holtek,ht16k33.yaml: Add
 holtek,refuse-primary-fb
Message-ID: <YkSfGfzyCIDIpVN8@robh.at.kernel.org>
References: <20220330073440.3986724-1-david@protonic.nl>
 <20220330073440.3986724-3-david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330073440.3986724-3-david@protonic.nl>
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

On Wed, Mar 30, 2022 at 09:34:40AM +0200, David Jander wrote:
> Document the DT property that will cause the holtek auxdisplay driver to
> back off if it detects that it is the first driver to probe a framebuffer
> device.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> index fc4873deb76f..4de32c3e26ce 100644
> --- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> +++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> @@ -53,6 +53,9 @@ properties:
>      $ref: /schemas/leds/common.yaml#
>      unevaluatedProperties: false
>  
> +  holtek,refuse-primary-fb:
> +    description: Refuse to claim the first framebuffer device

How is this specific to this device?

Rob
