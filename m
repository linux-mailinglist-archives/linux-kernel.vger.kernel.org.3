Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F155D5A2BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiHZQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiHZQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:05:41 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB3B7776;
        Fri, 26 Aug 2022 09:05:39 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso1304610otv.1;
        Fri, 26 Aug 2022 09:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=l2CYbReoo6IQotUuafc5L1MgWobtM1BV+FJ6GirhkVY=;
        b=SotR09RwqQUEwG3IaKHjBbAOzoT4wVMuaAKR4bNr1AkzxPtXPet5VTct+IMMfT9v56
         dA8uonOQFz2OzpEmaGqUX/Nr+mMikpCOGtLz3v2vtbPodu84q57ALD5nap91uKhq8Kmz
         wNLqicRT5Od3+vGFZvmC9FtpghxIM04HncFOfxdmqdZtNhliQ627wKxlei2ywJRzWsBF
         C+7jo5bFIBvjyiY/YQJ6QMZih0ruwSaTtBbA+Im08/oUqezBCWQAims0ers9ZKJbcYix
         S3onZ1yw+ur2ipqbRKnVepqkw0Pz3D/RUWxR3wxO+sf8jxTj0425BcrGXageYsaVan2R
         x1vw==
X-Gm-Message-State: ACgBeo22Iy5MefwVWy0ACuBC0fSeRucF8YWAaJbdLG3gI/IIklXSxvF9
        9JHFdprDtyHhZIvqe/gk3A==
X-Google-Smtp-Source: AA6agR7WFwUHcRXfjT87hLY9poTqk+KF9p12zL0+wx5pw29pSK/XpQUjBP4Kh00WIoMzONXQAtHn7w==
X-Received: by 2002:a05:6830:2323:b0:636:dc0d:4f3a with SMTP id q3-20020a056830232300b00636dc0d4f3amr1598056otg.127.1661529938004;
        Fri, 26 Aug 2022 09:05:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cg4-20020a056830630400b006371a0ff355sm1207526otb.77.2022.08.26.09.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:05:37 -0700 (PDT)
Received: (nullmailer pid 3267070 invoked by uid 1000);
        Fri, 26 Aug 2022 16:05:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        devicetree@vger.kernel.org, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220825204041.1485731-2-horatiu.vultur@microchip.com>
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com> <20220825204041.1485731-2-horatiu.vultur@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Date:   Fri, 26 Aug 2022 11:05:31 -0500
Message-Id: <1661529931.052703.3267069.nullmailer@robh.at.kernel.org>
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

On Thu, 25 Aug 2022 22:40:40 +0200, Horatiu Vultur wrote:
> Document Lan9662 OTP controller.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../nvmem/microchip,lan9662-otpc.yaml         | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.example.dtb: otp@e0021000: compatible: ['microchip,lan9662-otpc'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.example.dtb: otp@e0021000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

