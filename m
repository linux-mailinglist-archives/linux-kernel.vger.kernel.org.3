Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982C953D93A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbiFECR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFECRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:17:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C01A811;
        Sat,  4 Jun 2022 19:17:52 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so15322486fac.0;
        Sat, 04 Jun 2022 19:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vaQRGY53H6wADOsm4kW7eWOUF6mNNCacfi7LA2Rw00I=;
        b=npL5Td5L74p4eCnbJPCwj0E3shh1ETMT1NfQ/+nyxtm78VDaBU6WRiiS0ckJz97aUv
         o6ttrmcOf75+z4vbQbNo32E6ljNf97iUJnlSSmETaKd5Zei3JmHGKtgzIW8AEr/ve57q
         0MSa1LRuxqAKi3HV7w54Gtfsvtza7wtgaRqnt89AQEds7SwrJcN2ghavw3FHyvMQt9UU
         BEjx8gjUik6Ls8l7s8nXjl3HTebHM4cPNfQy1Yx41k4PVCYRoJLN7OiamH+G7zt73FOE
         aXP1GHHn8HgljsZzoa0iLeIQnbLm9az1foIZhCzmtj9uOs0wrDiq1cMtL3TReytFD459
         2KYQ==
X-Gm-Message-State: AOAM532xHC9o/dobovsbCXt21ySztxTSLNx2F8XYJq5fHu19jVGLnvKg
        xJK0fhHT427+4PpRx6UzXDysiLVmsg==
X-Google-Smtp-Source: ABdhPJw3plt6cA7kHbewJlcD/6xi88pJPH3DzFJ7woCXjGhnxxWz7NQWVoOCvGF3d8MrxTK7Dn0cMw==
X-Received: by 2002:a05:6870:7392:b0:f3:3d30:a44d with SMTP id z18-20020a056870739200b000f33d30a44dmr18009264oam.91.1654395471465;
        Sat, 04 Jun 2022 19:17:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e25-20020a056808111900b0032e73b538dasm978096oih.52.2022.06.04.19.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 19:17:51 -0700 (PDT)
Received: (nullmailer pid 3371064 invoked by uid 1000);
        Sun, 05 Jun 2022 02:17:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     michal.simek@xilinx.com, shubhraj@xilinx.com, sgoud@xilinx.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it, git@xilinx.com
In-Reply-To: <20220603170432.26605-1-srinivas.neeli@xilinx.com>
References: <20220603170432.26605-1-srinivas.neeli@xilinx.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: rtc: zynqmp: Add clock information
Date:   Sat, 04 Jun 2022 21:17:50 -0500
Message-Id: <1654395470.124495.3371063.nullmailer@robh.at.kernel.org>
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

On Fri, 03 Jun 2022 22:34:31 +0530, Srinivas Neeli wrote:
> Added clock information and deprecated calibration support.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V5:
> -Removed quotes and _clk suffix from clocknames.
> Changes in V4:
> - Deprecated calibrtion support
> Changes in V3:
> - New patch
> ---
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
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

