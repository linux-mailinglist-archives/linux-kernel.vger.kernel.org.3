Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2814BFAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiBVOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiBVOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:23:13 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DBA278F;
        Tue, 22 Feb 2022 06:22:47 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso14761425ooc.12;
        Tue, 22 Feb 2022 06:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XKCxldxqHUoemM602pSY3YQO+W+9otl7pTevlPAHCdw=;
        b=8KVxOl0haEzWycDXs5t05JiF7t95XfHcRhTvupRmIxaWmF5Id/5w6vWseUE9QLqqH8
         sJ/h0uvMtYpmUGixdH3+51u7ft1w1pdS7lLIUWeNgJs68pxu/DHnVdwDrDOZxK8AqgtM
         NFsZnhrh/HGuo7deJz0yPaSGX0p/zfi2fQkgjAONi9CYInrC2XvfzGNYbGOPMd9TZadC
         PE8BvPQhQlsFk4pevhkHWokJ+xzngeR6X8TUoy+um4RmwgT8qJRZ0YCfN1XYqhcpEGx+
         4kPBdAxeFLylqTgswgPFEiEXDIkZv1a6ldUFNosDVIyloCJ/F/xiMKSZPvcUmtZeb5rf
         vuAw==
X-Gm-Message-State: AOAM531+Qy0MCI5ZHnmHck6RbTPEw58oBOOT4BH9F/7q6UwJIVjRrFKL
        OyDPWDWrp/Y1uIPstwFbxg==
X-Google-Smtp-Source: ABdhPJyc9s472te/AAFY8ubCipQH+6Q54mfkUCFyS1Ec7t2YMPN+m4hW/pOoeMTrV7ATaHZh7YhgBw==
X-Received: by 2002:a05:6870:2890:b0:d3:f439:2cbb with SMTP id gy16-20020a056870289000b000d3f4392cbbmr1685581oab.139.1645539766673;
        Tue, 22 Feb 2022 06:22:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a8sm7302026otb.46.2022.02.22.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:22:45 -0800 (PST)
Received: (nullmailer pid 3016158 invoked by uid 1000);
        Tue, 22 Feb 2022 14:22:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     dianders@chromium.org, viresh.kumar@linaro.org, nm@ti.com,
        rafael@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, mka@chromium.org
In-Reply-To: <20220221225131.15836-2-lukasz.luba@arm.com>
References: <20220221225131.15836-1-lukasz.luba@arm.com> <20220221225131.15836-2-lukasz.luba@arm.com>
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Date:   Tue, 22 Feb 2022 08:22:43 -0600
Message-Id: <1645539763.088690.3016157.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Feb 2022 22:51:30 +0000, Lukasz Luba wrote:
> Add DT bindings for the Energy Model information.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../bindings/power/energy-model.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/energy-model.yaml:34:5: [warning] wrong indentation: expected 2 but found 4 (indentation)
./Documentation/devicetree/bindings/power/energy-model.yaml:35:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/power/energy-model.yaml:36:16: [warning] wrong indentation: expected 9 but found 15 (indentation)
./Documentation/devicetree/bindings/power/energy-model.yaml:35:39: [error] syntax error: expected ',' or '}', but got '{' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/power/energy-model.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 46, in <module>
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
ruamel.yaml.parser.ParserError: while parsing a flow mapping
  in "<unicode string>", line 34, column 5
did not find expected ',' or '}'
  in "<unicode string>", line 35, column 39
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/power/energy-model.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/power/energy-model.yaml:  while parsing a flow mapping
  in "<unicode string>", line 34, column 5
did not find expected ',' or '}'
  in "<unicode string>", line 35, column 39
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/energy-model.yaml: ignoring, error parsing file
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595776

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

