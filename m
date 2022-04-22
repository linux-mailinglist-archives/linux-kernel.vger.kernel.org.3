Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32850C41C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiDVWUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiDVWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:18:58 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23D32B270;
        Fri, 22 Apr 2022 14:10:53 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q129so10419044oif.4;
        Fri, 22 Apr 2022 14:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Nr76zUBX5qbBzQwafS7vJUYy7tt+K1FZ/hLi4/AzYYU=;
        b=NaKloHoAg+u+tWmduOGS1FimtJdpse83oks9+FIQQ0t2e/2v9XfqrA4CrZM4Cf8yeb
         OiZwoXhxT5ksf4jcrKTLjyrTaukvx25akCF3xls8Ps/8ufTDvx1HUqB0AU1lOPytoFgU
         KXEZDrh8bFoAa10I5eleizx+u/FAz1f/nzwrOjwKCWyTWGKY5151vdEqScT8nMvJz97j
         iIYAW/CwywHEclsdw9VdxJKVnzgkz2Fe5+fI2+bW+sjrfsFd6nXY5zVE/p1+lvrOBeto
         6UFH7ydU+KTm4jEzCIWapiRwax8xy+DWN+NnnxC8UiJo6Lb/xiul0ntr6M+S5nj10rM/
         tkQw==
X-Gm-Message-State: AOAM5312cRE7xuEk7C4LgepWKK1/z7r4HfuM68yYuRB0RF9/Z/vdFcaK
        3pkjpZ29XZbTPS5SuHQRDA==
X-Google-Smtp-Source: ABdhPJzjU+5uYIIOqRuE5MFu+v9BEUztor4ok1KVwR7kOVT+cK6Cy4a3yvF7XQJFY9SapSKG8y1D+g==
X-Received: by 2002:a54:4882:0:b0:322:b38f:c1f5 with SMTP id r2-20020a544882000000b00322b38fc1f5mr7800766oic.19.1650661852481;
        Fri, 22 Apr 2022 14:10:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830010b00b006054602a7fdsm1162508otp.18.2022.04.22.14.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:52 -0700 (PDT)
Received: (nullmailer pid 2784292 invoked by uid 1000);
        Fri, 22 Apr 2022 21:10:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220422145147.2210587-3-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com> <20220422145147.2210587-3-sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: nvmem: sfp: Add clock properties
Date:   Fri, 22 Apr 2022 16:10:47 -0500
Message-Id: <1650661847.300402.2784291.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 10:51:40 -0400, Sean Anderson wrote:
> To program fuses, it is necessary to set the fuse programming time. This
> is determined based on the value of the platform clock. Add a clock
> property.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


efuse@1e80000: 'clock-names' is a required property
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb

efuse@1e80000: 'clocks' is a required property
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb

