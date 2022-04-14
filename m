Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D0501B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbiDNTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiDNTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:02:15 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAC235DD1;
        Thu, 14 Apr 2022 11:59:49 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id m16-20020a9d73d0000000b005f8edc0599eso2312386otk.11;
        Thu, 14 Apr 2022 11:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Nl2pGAEONu2QZQaKFQeELDG1/h7wE66s82x4Cf8lwpw=;
        b=fFmkASgi7c5K5t4ivloXXBd1lU6eonwg7lTiaHiAWNKXRcty1Q9MF4btkdnlrHIG7x
         mkfUztOi9vAQsHrZr89nGO27J/AG/3Z+tqOKGOLlrQSEwDBEg9DF4ej3+csV/o3VpATI
         X3qFDljhKPePxoHkMX1olhKtwxs+kRoVVUCRNj+pQ21IEZvSNalfl2owhYo5WgJ2d9Oe
         odMRJDlQ8/+xDmIefH/ILW/7tKaMcUqpJ5IfFajT887HdlRWkBDhx6u2PYiuIuwReYWa
         YIX7Tb84/CCXQeQFeZrVhfKfgbgMXmXLsGrhaWFn1UFB+7jqDqGDuKeJai0+5ycWCFNC
         tf3w==
X-Gm-Message-State: AOAM530Ztu2mNldIXam158lM+ixzFZ8Bj8yPMrkMD9FnHeKX6kSZcRSF
        W58aOfkAXXUzCb5rwugI+Q==
X-Google-Smtp-Source: ABdhPJwedm86wTsiUMw3yS6TJXC6nvD9bMArTaTctu3idGdEl8LSY9aitZoSwhqQzZELBAOqDK+aYg==
X-Received: by 2002:a05:6830:2051:b0:602:4dc7:c893 with SMTP id f17-20020a056830205100b006024dc7c893mr673170otp.187.1649962788669;
        Thu, 14 Apr 2022 11:59:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y27-20020a544d9b000000b002f9e39a7467sm317435oix.39.2022.04.14.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:59:48 -0700 (PDT)
Received: (nullmailer pid 2441858 invoked by uid 1000);
        Thu, 14 Apr 2022 18:59:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220414170616.23319-3-markuss.broks@gmail.com>
References: <20220414170616.23319-1-markuss.broks@gmail.com> <20220414170616.23319-3-markuss.broks@gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Thu, 14 Apr 2022 13:59:45 -0500
Message-Id: <1649962785.233373.2441857.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Apr 2022 20:06:13 +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for the Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/mfd/siliconmitus,sm5703.yaml     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml:50:5: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 52, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a simple key
  in "<unicode string>", line 49, column 3
could not find expected ':'
  in "<unicode string>", line 50, column 5
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml:  while scanning a simple key
  in "<unicode string>", line 49, column 3
could not find expected ':'
  in "<unicode string>", line 50, column 5
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml: ignoring, error parsing file
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

