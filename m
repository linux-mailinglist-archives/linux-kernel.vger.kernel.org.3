Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECA05183A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiECMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiECMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:02:36 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999C26AF2;
        Tue,  3 May 2022 04:59:04 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id k25-20020a056830169900b00605f215e55dso8144592otr.13;
        Tue, 03 May 2022 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Bn5OzfsrZ6KHsFRAzJ/z2ysuxzu8Eq1fItATtTsfaoE=;
        b=JuK9mT8vJMWhyDoaIoN3v9vZEE3+GZ3jlp9mA8AX4c0Bi5r6Hgg724A2q0KtkbfDuY
         cLsky/lLzSE2n2JeuxCQ9GY9Bu+CkWDTPhLuWxgvunytnKTRU95JD9cN7cIb7JWJYc6X
         TEwue/tB0xGBJ/gdzcz29S+uinR4oiAjaJO87DCtGHMOW52GcuvPb2W8urcfjjbViLEb
         NDID2FUQejKInxj0wYtYjQPrFBbHFkyu+LOyvK/ZykskTckTsnSZ9cgPt+dF+gW48TO1
         aASaUWGILrxCEcz4NovFIjxNCrXRENHSY9hhi/rR2jZ9MvmTHh/gbZ905QulgZBlAPMR
         E0jA==
X-Gm-Message-State: AOAM530Vzxg4bbtSMuACbJ6At7Xeb2vqC7ImgB6UOKNDThAcJo6hhnFS
        QNw9Ex85xwxjuRCT+fK/Fw==
X-Google-Smtp-Source: ABdhPJwoVPo6dI4Nm7MCzkgHnpwplJNwVGViql/65wPitn5rRmkYgum90kPCTbSg6hdaQbF6wP2EqQ==
X-Received: by 2002:a05:6830:23a6:b0:606:1bc8:b0d3 with SMTP id m6-20020a05683023a600b006061bc8b0d3mr3195067ots.196.1651579143584;
        Tue, 03 May 2022 04:59:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x21-20020a05687031d500b000e686d13872sm6779423oac.12.2022.05.03.04.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 04:59:02 -0700 (PDT)
Received: (nullmailer pid 3296828 invoked by uid 1000);
        Tue, 03 May 2022 11:59:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, sean.wang@kernel.org,
        matthias.bgg@gmail.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com
In-Reply-To: <20220503105317.54696-3-angelogioacchino.delregno@collabora.com>
References: <20220503105317.54696-1-angelogioacchino.delregno@collabora.com> <20220503105317.54696-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings
Date:   Tue, 03 May 2022 06:59:00 -0500
Message-Id: <1651579140.664800.3296827.nullmailer@robh.at.kernel.org>
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

On Tue, 03 May 2022 12:53:17 +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree and pinfunc bindings for MediaTek Helio X10 MT6795.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 224 +++++
>  include/dt-bindings/pinctrl/mt6795-pinfunc.h  | 908 ++++++++++++++++++
>  2 files changed, 1132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml:100:14: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 52, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 96, column 13
did not find expected key
  in "<unicode string>", line 100, column 14
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml:  while parsing a block mapping
  in "<unicode string>", line 96, column 13
did not find expected key
  in "<unicode string>", line 100, column 14
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml: ignoring, error parsing file
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

