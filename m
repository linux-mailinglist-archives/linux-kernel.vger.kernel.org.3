Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C464BD3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbiBUCgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:36:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiBUCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:36:35 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600D3DDE0;
        Sun, 20 Feb 2022 18:36:12 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id r7so8982377iot.3;
        Sun, 20 Feb 2022 18:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FxeQCl1x7bPN2N7fKduzQexfeAZe1Kk7c2rGWjraM2M=;
        b=vKnQxwU0+VxmSw9UgqnXXmy67eKsY5scUhrpbbtqsCdtT4dRP+MxYhekfIpriQTshC
         1nm2PjKWr6m0zD/HMv+YamC02/uNkUyKQA2phTNMYRPFErn166bxut6/9kHzAvgNwOjL
         xzbb27GxpmVv3C6qYeCeEC43SeTYYOB3whsz09/BHkZLKGNL5q/rgPIT0tctSQJVaRfe
         KST+7ak1id9I58t9S8i17QskVHfr5OIEc3LAO67hVS8FkPO3q524hELgHaYn13/W6Tyd
         R4wlW1uXKFkaYttTA0zDX1zgQxKKIOord1jX0vtOraXN+uxsS4Rfywokru+s4rNP3pbg
         hhTw==
X-Gm-Message-State: AOAM530TsRhPWYhMdkRmKMuUkBwczMYaV2gv36O3PXXZFF3OKhpP+cJW
        bjzhbTW0aSqazCtL9gqaGozjPJ73Eg==
X-Google-Smtp-Source: ABdhPJwOKow//TiuesfE0CYp/GWJkr7IS6te0xCDAT81+jaq7aIKH6XqV2hxLRYv99lirxqpAHRZdQ==
X-Received: by 2002:a05:6638:2722:b0:30d:2b4e:5ff with SMTP id m34-20020a056638272200b0030d2b4e05ffmr13408270jav.261.1645410972080;
        Sun, 20 Feb 2022 18:36:12 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f13sm4569612iov.39.2022.02.20.18.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:11 -0800 (PST)
Received: (nullmailer pid 2041534 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     chegbeli <ciprian.hegbeli@analog.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org
In-Reply-To: <20220217135140.5658-3-ciprian.hegbeli@analog.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com> <20220217135140.5658-3-ciprian.hegbeli@analog.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: add ADE9078
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.316145.2041533.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Feb 2022 15:51:39 +0200, chegbeli wrote:
> Added device tree bindings for the ADE9078
> 
> Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>
> ---
>  .../bindings/iio/meter/adi,ade9078.yaml       | 153 ++++++++++++++++++
>  include/dt-bindings/iio/meter/adi,ade9078.h   |  21 +++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
>  create mode 100644 include/dt-bindings/iio/meter/adi,ade9078.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml:131:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml:  while scanning a block scalar
  in "<unicode string>", line 129, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 131, column 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/iio/meter/adi,ade9078.example.dts'
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
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 129, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 131, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/iio/meter/adi,ade9078.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml: ignoring, error parsing file
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594257

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

