Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3E50145D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiDNNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiDNNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:41 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADFE6;
        Thu, 14 Apr 2022 06:28:16 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so5209497fac.11;
        Thu, 14 Apr 2022 06:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1uOhWs8cm16131L6dfi8BY/Hr1kwqioEhMv1kPjh21A=;
        b=n5HIYEo0RplCPe63s7fiDIbFnbQl/vT4PiFq0QMHxuT4cCGZg6fZoCveh01zMR2pYb
         qvCUC+1b361Vjhzr09bJmwlLJbl3wbP3WnXUIm/7fme8x6Av3I0UmX+DskRV0JAvxEXm
         hPpfm9bH486vFn0ITdpKeVKLqXDLz6L7KUAkl6TrvDxPaiXJNKDGyROje6bTwzIziknT
         WMxlSeXeKRtKPlh/FRqhdz4JePFYl+o52e+is6JLKzJPU7dHcHTqiZ+4eMwE7+9k4Hhu
         HIB7I+ChBKux+ZBx6+XQh3C0HWO3YhYCNHDsnGuNc6OQWUFjT2SSP9hHgt9IzKpbESFS
         79vw==
X-Gm-Message-State: AOAM531VBeulcAsz02HQ08hu4/4UqmvD4Rtfio0b/tz4Y/ISHI75VVDE
        ofVO2GxNYL/nzx+qauan0g==
X-Google-Smtp-Source: ABdhPJyH1P7seZTuHtknt0P9RpLaIUL8KvuTzAmz12RLMFPKbN6I+QpfZtLgjNxlPTOvprxh63GYuQ==
X-Received: by 2002:a05:6870:d0ce:b0:de:79e2:7ec7 with SMTP id k14-20020a056870d0ce00b000de79e27ec7mr1224269oaa.245.1649942895544;
        Thu, 14 Apr 2022 06:28:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o8-20020a05680803c800b00321034c99a6sm8965oie.3.2022.04.14.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:28:15 -0700 (PDT)
Received: (nullmailer pid 1863786 invoked by uid 1000);
        Thu, 14 Apr 2022 13:28:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220413190713.1427956-25-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com> <20220413190713.1427956-25-clabbe@baylibre.com>
Subject: Re: [PATCH v5 24/33] dt-bindings: crypto: convert rockchip-crypto to YAML
Date:   Thu, 14 Apr 2022 08:28:14 -0500
Message-Id: <1649942894.398402.1863785.nullmailer@robh.at.kernel.org>
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

On Wed, 13 Apr 2022 19:07:04 +0000, Corentin Labbe wrote:
> Convert rockchip-crypto to YAML.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 66 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml:30:7: [error] duplication of key "const" in mapping (key-duplicates)
./Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml:31:7: [error] duplication of key "const" in mapping (key-duplicates)
./Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml:32:7: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.example.dts'
Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: found duplicate key "const" with value "hclk" (original value: "aclk")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 912, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 131, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 674, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 445, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 263, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 294, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 29, column 7
found duplicate key "const" with value "hclk" (original value: "aclk")
  in "<unicode string>", line 30, column 7

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys


During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 74, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
    print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
AttributeError: 'DuplicateKeyError' object has no attribute 'path'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: ignoring, error parsing file
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

