Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DA57EA05
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGVWpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiGVWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:45:22 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24285C06C1;
        Fri, 22 Jul 2022 15:44:58 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-10d845dcf92so7911512fac.12;
        Fri, 22 Jul 2022 15:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ioVQy2I3MdZUDLSAqqkpUrVLPrHTAHelafX5k6eqdBE=;
        b=3qpFQDM4VFFpqTSchRc+Q2xC2X2ftptDxshes6H6zEirQHIBY24GuvI/uFHDQJU54z
         bL0KmXxMurza7KQTfd6kKPP9e3uSFwvIBUfRPAaGur2l6ITv1w0ugbFtSioFWj5xmKuO
         gTzo/QIiRjjcowDuPKo0AlIVUBsIl9ME+WkZoE4c2F9ZThDmLUd1J5Mt+Wjur3B/i1np
         /gUAN/fWRSc8Yx9szNYh/CsfrKav/O2d12q7Y636iHORzU9R8Q2EX7ev1kT0eKoAYqQ+
         cb4Z0dsnuHYrhZysCbxCryhK/AsiiEkyn/jVOOMqyeBE248ghPNd40lG4ZfrLXK14k29
         pm0A==
X-Gm-Message-State: AJIora8Ay1snMuN7zuU0bFJNIVB2VJ1c2TGhPfhgea8mRc7ewsSS4+rr
        a0Xgcg4zgUpLnLFawLN8wA==
X-Google-Smtp-Source: AGRyM1u3KIvwo/7k4pN2H7zBPDtRg3eayR02wXAeGUhiinm97BPU+V7kgU8N/QSyliNRp5lNNH2orQ==
X-Received: by 2002:a05:6870:4722:b0:10c:d04:ebcf with SMTP id b34-20020a056870472200b0010c0d04ebcfmr1124713oaq.80.1658529893918;
        Fri, 22 Jul 2022 15:44:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f97-20020a9d2c6a000000b0061c87262540sm2433071otb.65.2022.07.22.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:44:53 -0700 (PDT)
Received: (nullmailer pid 20307 invoked by uid 1000);
        Fri, 22 Jul 2022 22:44:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?b?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, linux-spi@vger.kernel.org,
        michael@walle.cc, tmn505@gmail.com, reimu@sudomaker.com,
        miquel.raynal@bootlin.com, paul@crapouillou.net,
        rick.tyliu@ingenic.com, richard@nod.at, aric.pzqi@ingenic.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        aidanmacdonald.0x0@gmail.com, jinghui.liu@ingenic.com,
        sernia.zhou@foxmail.com, dongsheng.qiu@ingenic.com, vigneshr@ti.com
In-Reply-To: <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com> <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Date:   Fri, 22 Jul 2022 16:44:50 -0600
Message-Id: <1658529890.261669.20305.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 00:48:29 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
> and the X2000 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/ingenic,sfc.yaml:52:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/ingenic,sfc.example.dts'
Documentation/devicetree/bindings/spi/ingenic,sfc.yaml:52:1: found a tab character where an indentation space is expected
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/spi/ingenic,sfc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/spi/ingenic,sfc.yaml:52:1: found a tab character where an indentation space is expected
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml: ignoring, error parsing file
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

