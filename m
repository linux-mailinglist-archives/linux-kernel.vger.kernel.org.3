Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0855A051
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiFXR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiFXR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:58 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A09B11C0E;
        Fri, 24 Jun 2022 10:26:57 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id r133so3399192iod.3;
        Fri, 24 Jun 2022 10:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BthQGtlJ7YM7FtzqkSGqjkdRPK/OFaiOsx4qPPYSk/U=;
        b=BjH43I6UV10nFX0KPMbDW8PFwyYWVBlF834czOd6meI88eqRBLf9HISFoe14IE6AHP
         1PvjJhZay2yWrug3gLqiJ/pTIZYdPdSPb1d2ADGBkSHyaICXA+3FTGauJn36aOFvPQPk
         4K5atd43OYZMRcZ1ZZiwfCxuCNg3SdbhY49ypDsQSwq0oZycbs+NSQ0BkaXbsqA+P5Gi
         y/PkYf3OIYVbjyQ0gvgeLeSKbqLBDIDk1iXSXe6ixx6TWW/MmZsXj2kK2ORmSaMVg4o+
         50Yr/ULUKjMNzr6hFVQfpPT9Hx1wHRGW+xb3R8xJIXFZlKANjz8iz3CXgy+2IUWLxgoN
         YWuw==
X-Gm-Message-State: AJIora93ESJt/qUg9qqJdcH4kblxHwKOVbe8OuNdn531eY/17X7IJMGL
        zHMEgvY3qFYNRsnCoaYJ4Q==
X-Google-Smtp-Source: AGRyM1ulT+mHDtyp2//nc5gc8V8xa1im5Viun+GPS9iWSdt1sEhL4j3QD+EdD95Dxfkt51QZr3umVA==
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id j15-20020a05663822cf00b00331a5b922f2mr147245jat.218.1656091617604;
        Fri, 24 Jun 2022 10:26:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u10-20020a02b1ca000000b00339da678a7csm1297888jah.78.2022.06.24.10.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:57 -0700 (PDT)
Received: (nullmailer pid 146348 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, shubhraj@xilinx.com,
        neelisrinivas18@gmail.com, a.zummo@towertech.it, sgoud@xilinx.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, git@xilinx.com, alexandre.belloni@bootlin.com,
        srinivas.neeli@amd.com, git@amd.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com
In-Reply-To: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
References: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
Subject: Re: [PATCH V9 1/3] dt-bindings: rtc: zynqmp: Add clock information
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.412994.146347.nullmailer@robh.at.kernel.org>
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

On Fri, 24 Jun 2022 17:32:01 +0530, Srinivas Neeli wrote:
> Added clock information and deprecated calibration support.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in V9:
> -Updated clock information in clock-names.
> Changes in V8:
> -None
> Changes in V7:
> -None
> Changes in V6:
> -Removed dtc warnings.
> Changes in V5:
> -Removed quotes and _clk suffix from clocknames.
> Changes in V4:
> - Deprecated calibrtion support
> Changes in V3:
> - New patch
> ---
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml     | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.example.dtb: rtc@ffa60000: clock-names:0: 'rtc' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

