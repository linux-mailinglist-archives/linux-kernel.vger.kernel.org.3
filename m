Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F5513EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353029AbiD1Wuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiD1Wus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:50:48 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9245C1C85;
        Thu, 28 Apr 2022 15:47:30 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e4so6896398oif.2;
        Thu, 28 Apr 2022 15:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9huJcn8s6ZFvkhQOahKXB71N3KDAgwVMDPvWBisL6g=;
        b=m7Or5MwA0SpspSA7SPShFKLZ9+znIpSZTSZp5lylOYIMbC634U1U0AYmnlXKUMHbKp
         gUX7erwmX1NWu7rqpOR6E5bUwOOX3GOik9gA4kBxhrqviGnGZNgIcdOX/+gfwXeUHxxk
         tMJFbHgrSdxuIczqlcESgijLv2DDyvon/O1opFgtR2t9yl9dnhSTsVAa5uVumSNuQRLW
         XvPDwHFiRbjQK3CajUYqmqv6y9la1gNNaciNagCHzLDbWA7Vw+Wg21MuFjL+5PV1LLu5
         IJkfsAopq2Y5OG65tMFSTVqp+MkvVoTgjRBR732U1/JvsmIkk1aOSXbNR7gwGL+z+FHw
         8YMw==
X-Gm-Message-State: AOAM531sKkG80gh0kzvzLCNOhgsf46WOHhcdvnslerG+Wn3dQAJ5KRJr
        hoN2XOgWZn0KxZRxBonbfQ==
X-Google-Smtp-Source: ABdhPJwQ+JcKDCCjOO6AHPTKM6j6zc+pbT0oXXUv6iLsfFX/+IFTobBDki78XdVQVepJo34vSAfOAg==
X-Received: by 2002:a05:6808:150f:b0:322:b58e:25df with SMTP id u15-20020a056808150f00b00322b58e25dfmr218208oiw.198.1651186049925;
        Thu, 28 Apr 2022 15:47:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk3-20020a0568081a0300b003257eb687bbsm582152oib.31.2022.04.28.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 15:47:29 -0700 (PDT)
Received: (nullmailer pid 488602 invoked by uid 1000);
        Thu, 28 Apr 2022 22:47:28 -0000
Date:   Thu, 28 Apr 2022 17:47:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: fsl: convert fsl,layerscape-scfg to
 YAML
Message-ID: <YmsZgE3sAA8MhxmB@robh.at.kernel.org>
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427075338.1156449-5-michael@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:53:38AM +0200, Michael Walle wrote:
> Convert the fsl,layerscape-scfg binding to the new YAML format.
> 
> In the device trees, the device node always have a "syscon"
> compatible, which wasn't mentioned in the previous binding.
> 
> Also added, compared to the original binding, is the
> interrupt-controller subnode as used in arch/arm/boot/dts/ls1021a.dtsi
> as well as the litte-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> changes since v2:
>  - none
> 
> changes since v1:
>  - moved to soc/fsl/fsl,layerscape-scfg.yaml
>  - generic name for node in example
>  - mention added "syscon" compatible in commit message
>  - reference specific interrupt controller
> 
>  .../arm/freescale/fsl,layerscape-scfg.txt     | 19 ------
>  .../bindings/soc/fsl/fsl,layerscape-scfg.yaml | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml

Applied, thanks!
