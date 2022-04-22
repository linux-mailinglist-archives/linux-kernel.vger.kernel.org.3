Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76B50C2DA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiDVWUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiDVWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:18:50 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA4251754;
        Fri, 22 Apr 2022 14:10:51 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id e189so10388337oia.8;
        Fri, 22 Apr 2022 14:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=J6rqRfMieshNlsEnUPYfVWhJgAntYIwqBg8y4VOu9MM=;
        b=wF9Cswt2ZUw+2I7I7tiNQjPkgmzKj+xOyOcYEV5WC4p2Usln7l02M1bZMWfdCjbeW7
         g7PYk29tH8JsxpGbxatf3xo7G+04VrPn4F+zkXCkTR1jkAu58Hg+7YllFIF7QsCQ1WSH
         H8ckVqUkiaJZzwYwAS9at8F9ZSI39OSViNqoAiXR33Zwv4LH1l82p/x3l8Q8bozyAra0
         8kjuIlwuXkHkSXqPT6y1h1D0f9MwNd++1FnupibbpC1i/EpoSwZYonqxS+yTsN4maeCs
         G7uaByrcfDyFXz1w/mzrRmA1jAi+dToMr1jjb+yEdU67BYGS8kZ79LU5Qvl52V/nWmNn
         EvmQ==
X-Gm-Message-State: AOAM530AOT/lFU1MJFdod6uVte0bWfVoBYbNslz4JBiLoq2XufC1NOdv
        szw2hnTjzuFFs4XWoe6uaQ==
X-Google-Smtp-Source: ABdhPJw3FMFldMU2qxgLgJpZScY+EUzAC+IZqNRhFvnPBjaTLofwsJMPu2/vSLA8NxsTdHjlGDDTYA==
X-Received: by 2002:a05:6808:10c6:b0:2f9:a7fb:823b with SMTP id s6-20020a05680810c600b002f9a7fb823bmr7798368ois.249.1650661851222;
        Fri, 22 Apr 2022 14:10:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x21-20020a4a6215000000b0033993dc1d65sm1230760ooc.8.2022.04.22.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:50 -0700 (PDT)
Received: (nullmailer pid 2784288 invoked by uid 1000);
        Fri, 22 Apr 2022 21:10:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     icenowy@outlook.com
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        linux-pm@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
In-Reply-To:  <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
References:  <BYAPR20MB24721F9954252BECBEF486ACBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sun8i-thermal: add binding for R329 THS
Date:   Fri, 22 Apr 2022 16:10:47 -0500
Message-Id: <1650661847.274095.2784287.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 00:11:55 +0800, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 has a thermal sensor controller that has only one sensor, and the
> structure of it is like the H6 one.
> 
> Add device tree binding for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml:90:13: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts'
Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml: found duplicate key "const" with value "allwinner,sun8i-r329-ths" (original value: "allwinner,sun8i-h3-ths")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line 912, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 121, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 131, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 674, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 445, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 263, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.10/dist-packages/ruamel/yaml/constructor.py", line 294, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 89, column 13
found duplicate key "const" with value "allwinner,sun8i-r329-ths" (original value: "allwinner,sun8i-h3-ths")
  in "<unicode string>", line 90, column 13

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys


During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 74, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
    print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
AttributeError: 'DuplicateKeyError' object has no attribute 'path'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml: ignoring, error parsing file
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

