Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63527514FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378662AbiD2P4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378244AbiD2P4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:56:40 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EEDC90C5;
        Fri, 29 Apr 2022 08:53:18 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id l16so1671407oil.6;
        Fri, 29 Apr 2022 08:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FFjFGklMesuiQkPh+8rzTAyTXof2tZBqFJs5Jn3OJF4=;
        b=p0DnbdUbo6W4ci3IqQsyUmAlKcRRbV+1v3kzVr5RaRRqfTuWIjYXyY1fhIoaDzdgn6
         QPTpXIhFNB1kOqlbOar7vkoRLrrjxxWX12BLOulhTS/WRCmW5Pm4sPRbYsz3dLI8WGJH
         Pp3HuZE7RgjjTnggckcxhU4FTHSPiyGipNhlwfLYP0GeGHPljdpf8Mv3raMnquRGTean
         axU/qgFF7U3m/vbSnn7kPEYZw+yCDoc3yAxzdTkoAZr8+Ncph0Gyi0YMfVBTx9zLDGer
         A9tnvZXsFoZsK2BfnUBkbNgQlWQCKr3g7KTYIQdln0cB4XMXvEdeOex/7aXABGKT62/N
         kVjQ==
X-Gm-Message-State: AOAM530LOYSnv6FFG+3cyOU6zTTqozxi/GVJPmgitBO5YDwdM4Q51377
        kEOHSDhcUmpO1TMUGaWI2A==
X-Google-Smtp-Source: ABdhPJxBDckK9tQAVZHKd7BiQTS1n/On3l+TQwVLBKxxqANVBsJa67fSMJpCyXx9MaORSsHbqtpJ+w==
X-Received: by 2002:a05:6808:f8d:b0:325:5728:997b with SMTP id o13-20020a0568080f8d00b003255728997bmr1891780oiw.163.1651247598036;
        Fri, 29 Apr 2022 08:53:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o24-20020a4ae598000000b0035eb4e5a6d0sm890263oov.38.2022.04.29.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:53:17 -0700 (PDT)
Received: (nullmailer pid 2344490 invoked by uid 1000);
        Fri, 29 Apr 2022 15:53:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     shawnguo@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        tglx@linutronix.de, leoyang.li@nxp.com,
        cniedermaier@dh-electronics.com, aisheng.dong@nxp.com,
        soc@kernel.org, olof@lixom.net, abel.vesa@nxp.com, clin@suse.com,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        stefan@agner.ch, Mr.Bossman075@gmail.com,
        daniel.lezcano@linaro.org, sboyd@kernel.org, tharvey@gateworks.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        giulio.benetti@benettiengineering.com, marcel.ziswiler@toradex.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
        linux@armlinux.org.uk, linux-gpio@vger.kernel.org, dev@lynxeye.de,
        kernel@pengutronix.de, linux-imx@nxp.com, arnd@arndb.de
In-Reply-To: <20220428214838.1040278-8-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com> <20220428214838.1040278-8-Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v2 07/15] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Fri, 29 Apr 2022 10:53:16 -0500
Message-Id: <1651247596.107110.2344489.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:48:30 -0400, Jesse Taube wrote:
> Add DT binding documentation for i.MXRT1170 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Change title to Clock Controller
>  - Rename to add fsl
> ---
>  .../bindings/clock/fsl,imxrt1170-clock.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/fsl,imxrt1170-clock.yaml#
Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.example.dts:20:18: fatal error: dt-bindings/clock/imxrt1170-clock.h: No such file or directory
   20 |         #include <dt-bindings/clock/imxrt1170-clock.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

