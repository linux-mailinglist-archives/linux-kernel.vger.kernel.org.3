Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8C4BA636
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiBQQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiBQQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:13 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A972B2FFE;
        Thu, 17 Feb 2022 08:39:58 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id c14so2673811ilm.4;
        Thu, 17 Feb 2022 08:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/j/oL7B6VpVuxaUPOtNjyB5enKb3oFuW0hBLhdLu0mk=;
        b=Tvnb1L4BWdKRqK4CzusFUzgZgn3FrCCU5raNq57ZDtiBS3rdV/rlBX5v7r7rsklYcL
         UDXjpTBD7b3YHBmrtcTE2+yU9DUXL0U9xepK6qEX9andwAzKCkpDVwNwo4SYZmRE76n4
         JzNTXrRyECsBXe3Y3Iu9UYNsbvgHK7W8x0JNQ5Z3TO+9kIbQKbf/XQQyAjXlm+pFWfwT
         kINKBaSYcwuf1HoMDC7iPIp/IflUsYlNKteGk0vBOuFvMX1hvJEaKiwbxXOQ8hA7XNNP
         L/wjvIs6oDWHBeYpkZZuScVOFBbUzFow2tUqk7hiXZ7F4aTIvXOziAkgkujlg2xQV/gy
         kGvQ==
X-Gm-Message-State: AOAM530e98q7cT3NiOUTgfTe6Uo42PUzQv7N/cYNZSDA/44xYyb421Fl
        4KGkDpHNT2stSeF/e4ESmA==
X-Google-Smtp-Source: ABdhPJz6ShYnm8au8sy+zdCys28kffvuQrBgybBe54H3/FKN33f3cmhGisStfQpgdHyWSVLZ7X+yPw==
X-Received: by 2002:a05:6e02:216c:b0:2be:f54b:987b with SMTP id s12-20020a056e02216c00b002bef54b987bmr2588240ilv.254.1645115997609;
        Thu, 17 Feb 2022 08:39:57 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a6sm2410552iow.22.2022.02.17.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:39:56 -0800 (PST)
Received: (nullmailer pid 3365320 invoked by uid 1000);
        Thu, 17 Feb 2022 16:39:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220216181434.41682-1-nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com> <20220216181434.41682-1-nick.hawkins@hpe.com>
Subject: Re: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding
Date:   Thu, 17 Feb 2022 10:39:55 -0600
Message-Id: <1645115995.339005.3365319.nullmailer@robh.at.kernel.org>
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

On Wed, 16 Feb 2022 12:14:33 -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: This binding will be used in creating the HPE GXP
>  architecture. GXP is the name of the HPE SoC.
> This SoC is used to implement BMC features of HPE servers
> (all ProLiant, Synergy, and many Apollo, and Superdome machines)
> It does support many features including:
>         ARMv7 architecture, and it is based on a Cortex A9 core
>         Use an AXI bus to which
>                 a memory controller is attached, as well as
>                  multiple SPI interfaces to connect boot flash,
>                  and ROM flash, a 10/100/1000 Mac engine which
>                  supports SGMII (2 ports) and RMII
>                 Multiple I2C engines to drive connectivity with a
> 				 host infrastructure
>                 A video engine which support VGA and DP, as well as
>                  an hardware video encoder
>                 Multiple PCIe ports
>                 A PECI interface, and LPC eSPI
>                 Multiple UART for debug purpose, and Virtual UART for
>                  host connectivity
>                 A GPIO engine.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../devicetree/bindings/soc/hpe/gxp.yaml      | 35 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/hpe/gxp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/soc/hpe/gxp.example.dts:22.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/soc/hpe/gxp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1593884

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

