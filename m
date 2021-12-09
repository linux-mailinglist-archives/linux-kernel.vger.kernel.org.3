Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C646F558
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhLIU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:59:50 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46932 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhLIU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:59:44 -0500
Received: by mail-ot1-f53.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so7486285oto.13;
        Thu, 09 Dec 2021 12:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xankO6gBp3GIQVGfoW7EkvgG0j2YUNnq+3nk9J8aM3Y=;
        b=Lvfr31Ir4ToOrOTOil/D++KrmODrCf3+6M26h9rzY6nM4yTc/E3lfaHYgt2VqgY5SV
         we5AR30VOPTPnHY+KmEQfjfeEjP3ndPoCxpDf7jhS4+gn1ZyAHuT+L7LY3IIDp52a5Fw
         LDesJf/mpWNizZAjq/rlB4PGpn/C246IRs8D7jwQOl0abA5+Ki3BESuPsyL0Ikt9ixIF
         DMc8iaqIm8XPy0oOK0SsGA4hJHgjEMXHPap2DjBaNok54pt9RKpkPDj5zw/cIZF8hKeO
         75XQ0Y0zzzrhI0tYDjsfMwiMhktEn6T5RSPT6Wzuu/zw8ckGvXlI0AVAIdui9T3/ZTl/
         VUXw==
X-Gm-Message-State: AOAM533TOyoRjzuDrWTP6oXfLaojLaN75+O6waJAUXC8W/eutYDv2qtC
        H8ndtfSOf0QpZR6iykusEDjRzzcdrQ==
X-Google-Smtp-Source: ABdhPJwdiucO7zUXMfidK1yeB7NQIdXOz8owmo+BnV3zHDhRQCqAGR9lTU/GuZ9/jhRAnrnrc0psMg==
X-Received: by 2002:a05:6830:410a:: with SMTP id w10mr7711368ott.55.1639083369909;
        Thu, 09 Dec 2021 12:56:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w71sm181746oiw.6.2021.12.09.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:56:09 -0800 (PST)
Received: (nullmailer pid 3925942 invoked by uid 1000);
        Thu, 09 Dec 2021 20:55:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     robh+dt@kernel.org, vsethi@nvidia.com, jonathanh@nvidia.com,
        bbasu@nvidia.com, devicetree@vger.kernel.org, jsequeira@nvidia.com,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <20211209172206.17778-3-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com> <20211209172206.17778-3-sumitg@nvidia.com>
Subject: Re: [Patch Resend v1 2/8] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Thu, 09 Dec 2021 14:55:59 -0600
Message-Id: <1639083359.653823.3925941.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 22:52:00 +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent the error handling
> driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.
> The driver prints debug information about failed transactions due to
> illegal register accesses on receiving interrupt from CBB.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra194-cbb.yaml        | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml:96:1: [error] duplication of key "properties" in mapping (key-duplicates)
./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml:109:1: [error] duplication of key "examples" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
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
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 96, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 656, in load
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
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 96, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys


During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
    print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
AttributeError: 'DuplicateKeyError' object has no attribute 'path'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1565943

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

