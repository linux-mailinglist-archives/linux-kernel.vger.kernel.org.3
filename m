Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C891146F552
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhLIU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:59:42 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45812 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhLIU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:59:39 -0500
Received: by mail-oi1-f176.google.com with SMTP id 7so10370951oip.12;
        Thu, 09 Dec 2021 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=prvfBI9Quc6o5I6vG+M4mn0hhqXgxhBS6i0p8peqrqM=;
        b=VwRhlF+y0nERUwiinuVrjKlyieeVrLMAtWdTRhXwHBhXQQJDDRAPP3wBS43RW6ZiOQ
         ehtnjAKq3Fa/C7h+DbE8KF+hZT5zLUw0I7X1qHaR9SFLmmAhwcGIAQ3n0OxYrtamFi7c
         sMY7Bu6wnwjE3lHfoNfstRoEKJY6Oo1ikQGOEMQ+Vm/ljrrm6+tjelgXClKnTI8yxNiy
         bypWs+02lg8GyxARDnhfZD5Lnjg78xafSbX6Gc4GAz3h6xrzcWeS9kJWWwNg7nOQhvqC
         6BSxmzl7BPfwVgQZj2fXuCUsCeWoj2Ysk7+7iY+DK/lF2ox5Vn8VIO6hXn+JFC0A+wlz
         FVVw==
X-Gm-Message-State: AOAM531RD6FV5Ez449v7C7JbzgLd7HSbgEoV1lg2MIjIGkShZZ1Jq3rg
        1b3FXbA9y4hH+jzvFa1W6eqXjwGczw==
X-Google-Smtp-Source: ABdhPJybhyZk4J9Vxx8G9PJuL02kaDsp5aiZt01nzYkMTqIqjtT7ZQgkq9M4xPkk69/adSOdvZdlIA==
X-Received: by 2002:a05:6808:485:: with SMTP id z5mr8383709oid.96.1639083364886;
        Thu, 09 Dec 2021 12:56:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s9sm181423otg.42.2021.12.09.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:56:03 -0800 (PST)
Received: (nullmailer pid 3925944 invoked by uid 1000);
        Thu, 09 Dec 2021 20:55:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        jsequeira@nvidia.com, bbasu@nvidia.com, vsethi@nvidia.com
In-Reply-To: <20211209172206.17778-6-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com> <20211209172206.17778-6-sumitg@nvidia.com>
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Thu, 09 Dec 2021 14:55:59 -0600
Message-Id: <1639083359.670183.3925943.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 22:52:03 +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent CBB2.0 (Control
> Backbone) error handling driver. The driver prints debug information
> about failed transaction on receiving interrupt from CBB2.0.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml:73:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
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
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 71, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 73, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml:  while scanning a block scalar
  in "<unicode string>", line 71, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 73, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1565951

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

