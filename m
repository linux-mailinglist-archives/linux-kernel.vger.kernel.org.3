Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473E9505A38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbiDROtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbiDROsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:48:53 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4E65812;
        Mon, 18 Apr 2022 06:35:51 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id x22-20020a4aca96000000b00338fbaf797bso1224496ooq.10;
        Mon, 18 Apr 2022 06:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/7DrYrmalKThMdy4LcLfM/HEgQyeZb4ql4+RxoW5Tek=;
        b=n82QxnLUGM1ZVFYN1x60081DH8QIjn9dyhiDhQPB1TQixPgDHDEC2BfnunviyMMRGt
         kvqpD97I6TQBAn1o7kSyMKMcfTKqe5fVpbPmLtPl713PxVIyq9JIxQbcabP/SrTx6mC4
         Y8VCAW4LuNkCscXcFSu2Ic6wnTc4PfafYUBNygCKs0S6M1mO610YE/E5y16/edwMEDCB
         NZp9MNABTsTzS8914mUZqJjbKL+iZJhDt+zfv1TkbZol0ODlrHSCHbI10yA0fnsJmakP
         q0Dlejijiu0JEuJG2dEQsiHgrmENFP7M706VT/MJpsJpkA3oDf9S+TYGlY8BzjriEPYj
         gOxQ==
X-Gm-Message-State: AOAM530AOwmWD3vKoVW95y9I2+Px0nFGsmCpAtpieEN9hyEHag2Sh78i
        3LO4QCWGfNVBx0CwSDiALg==
X-Google-Smtp-Source: ABdhPJycojyv4H+nJQ2x1+adkeuVDAjldV3SjAu/92fF+LKn4/jU3ne8TQqcEwIkD35VyIOwx2l8gQ==
X-Received: by 2002:a4a:8888:0:b0:321:7448:42df with SMTP id j8-20020a4a8888000000b00321744842dfmr3575456ooa.82.1650288951046;
        Mon, 18 Apr 2022 06:35:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g15-20020a05687054cf00b000e29cbc65e4sm3956240oan.51.2022.04.18.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:35:50 -0700 (PDT)
Received: (nullmailer pid 3125299 invoked by uid 1000);
        Mon, 18 Apr 2022 13:35:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, will@kernel.org,
        arnd@arndb.de, ychuang570808@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, cfli0@nuvoton.com, soc@kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org
In-Reply-To: <20220418082738.11301-3-ychuang3@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com> <20220418082738.11301-3-ychuang3@nuvoton.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Document MA35D1 clock controller bindings
Date:   Mon, 18 Apr 2022 08:35:48 -0500
Message-Id: <1650288948.503037.3125298.nullmailer@robh.at.kernel.org>
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

On Mon, 18 Apr 2022 16:27:35 +0800, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml:41:9: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dts'
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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 41, column 9
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 41, column 9
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml: ignoring, error parsing file
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

