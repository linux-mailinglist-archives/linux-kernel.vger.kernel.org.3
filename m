Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861250EA92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbiDYUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiDYUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:33:31 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8181AF2E;
        Mon, 25 Apr 2022 13:30:26 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id l9-20020a056830268900b006054381dd35so11626429otu.4;
        Mon, 25 Apr 2022 13:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m960rHYQMT5ec31Ba8Q7vx7Lhukm/+6mto0BJCbs4mM=;
        b=RMq2VYJ+VMXms9N+3VOcKp9hJHaoLrs1g6SoooBUcadCKjKAN+uwV3eJGZhbE4XEnt
         OlT70M+fg/s4qPkITy6AVxv/g+yOqTIDoDO2HAEvbnPCcUXAa4EEr/FMIb5w3Ep6sZkn
         R24zj7fCMqZ3+CYUx3orYRbfUNWsfIrv4go18gHXzwHfHHBstAw6mDtCot2fZS0rw3ul
         cmPy1u0GgnIXI90kSTEPJZLmueuJs0DCfOqHznCIAaS/RuUu8FEulj8j2NccfYbk7AUQ
         YgdCbMSeAqvc9E/QNgdbfCc7acKKxaQyG91zT2yQR+xcbMZHWUVWzqG+yR66s///HCdt
         +jAQ==
X-Gm-Message-State: AOAM5331Yyf3/QR9agMtSXPXdk9pc2i4pfzKLdICpoLN0nbj9i/B4YiJ
        3PAi6kX8uPu6WSiKOWR/PQ==
X-Google-Smtp-Source: ABdhPJyWoKaQ+tANQen6zRwgyqIt1c7O4dW+6NqSD3A8CnOB74HXWs5JAxN1XmGn7H2r2Rxq3F/8ww==
X-Received: by 2002:a9d:7a4e:0:b0:605:4e1d:47ce with SMTP id z14-20020a9d7a4e000000b006054e1d47cemr7242704otm.150.1650918625933;
        Mon, 25 Apr 2022 13:30:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x15-20020a056830408f00b006054688cba0sm4142755ott.52.2022.04.25.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:30:25 -0700 (PDT)
Received: (nullmailer pid 219429 invoked by uid 1000);
        Mon, 25 Apr 2022 20:30:24 -0000
Date:   Mon, 25 Apr 2022 15:30:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2] dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
Message-ID: <YmcE4K/qM5Xy0ADj@robh.at.kernel.org>
References: <20220425140433.33936-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425140433.33936-1-michael@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:04:33 +0200, Michael Walle wrote:
> Convert the fsl,layerscape-dcfg binding to the new YAML format.
> 
> In the device trees, the device node always have a "syscon"
> compatible, which wasn't mentioned in the previous binding.
> 
> One thing added here, compared to the original binding is the clock
> controller subnode of the LS1028A SoC and its "simple-mfd" compatible as
> used in arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi as well as the
> little-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - moved to soc/fsl/fsl,layerscape-dcfg.yaml
>  - generic name for node in example
>  - mention added "syscon" compatible in commit message
>  - reference specific clock controller
> 
>  .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 ------
>  .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
> 

Applied, thanks!
