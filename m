Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8847B4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhLTVGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:06:09 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:45856 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhLTVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:05:59 -0500
Received: by mail-qt1-f173.google.com with SMTP id p19so11006836qtw.12;
        Mon, 20 Dec 2021 13:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fqRSjSjlVwMx3PCYB3pn/czslzADAGvnpT9c5YDGfOE=;
        b=WsZua+6VjEG/N4cxVAQwCUoy1L5ukQg8G2mBkszOgwC4ot8hjEuaz1AEojko+IauJw
         aGoLlJQchG0NntwBHzul+8ytgh82pF64BGQTsommjyRksJl9jUTbZe+V1prgWJysH/vx
         Dnd35S8xEBCcHzRY2qQvR9/mSTt9HZc4SL3KWRcT1BpIex0pF+os/0VQj2M6NxWNu36f
         6Nhl3rLkeNWjJASI9RgJDZolPjaeASKDb/7cJWC5sM3npkQX226niUG9RSJ8R2NGNmTO
         xeKIYTlxOvlRF/pJZ/LP8svp1+BdMFWmG/0/VyeDnHMyQELpM0cbh1uAkhiEf7AB3A9c
         N/3g==
X-Gm-Message-State: AOAM532qxqUybUgR2Eo8o0CGJ3UuPW6xR4mq06w6XP3MFRrPImhOkUnT
        w9pd1Q4lEFR5tRRIyWfKpRYAssvhw1/P
X-Google-Smtp-Source: ABdhPJyR9q1EP5eXq8kXEDXWr5wln0geOO6zBx9YUws8l8NgUVUVoK5EDZDup9slQkQFdPdCqx91eQ==
X-Received: by 2002:ac8:5811:: with SMTP id g17mr9286067qtg.535.1640034357899;
        Mon, 20 Dec 2021 13:05:57 -0800 (PST)
Received: from robh.at.kernel.org (adsl-72-50-0-33.prtc.net. [72.50.0.33])
        by smtp.gmail.com with ESMTPSA id o1sm15956979qtw.24.2021.12.20.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:05:57 -0800 (PST)
Received: (nullmailer pid 3900651 invoked by uid 1000);
        Mon, 20 Dec 2021 21:05:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yaqin Pan <akingchen@vivo.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, kernel@vivo.com,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211220141629.14282-3-akingchen@vivo.com>
References: <20211220141629.14282-1-akingchen@vivo.com> <20211220141629.14282-3-akingchen@vivo.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Mon, 20 Dec 2021 16:05:52 -0500
Message-Id: <1640034352.478511.3900650.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 22:16:29 +0800, Yaqin Pan wrote:
> Add snps,dis_split_quirk property for dwc3 controller
> 
> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:229:3: [error] duplication of key "snps,dis-split-quirk" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/snps,dwc3.example.dts'
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
  in "<unicode string>", line 32, column 3
found duplicate key "snps,dis-split-quirk" with value "{}" (original value: "{}")
  in "<unicode string>", line 229, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/usb/snps,dwc3.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
schemas/usb/snps,dwc3.yaml: ignoring, error parsing file
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
  in "<unicode string>", line 32, column 3
found duplicate key "snps,dis-split-quirk" with value "{}" (original value: "{}")
  in "<unicode string>", line 229, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys


During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 30, in check_doc
    print(filename + ":", exc.path[-1], exc.message, file=sys.stderr)
AttributeError: 'DuplicateKeyError' object has no attribute 'path'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/usb/snps,dwc3.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1571063

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

