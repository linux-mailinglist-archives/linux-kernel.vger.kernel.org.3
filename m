Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40F47317D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhLMQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:20:21 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35338 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhLMQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:20:19 -0500
Received: by mail-oi1-f170.google.com with SMTP id m6so23823107oim.2;
        Mon, 13 Dec 2021 08:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YupVdED8A01BspMm/zZJRbD1Ui5NnhzXhU+KsneVHKo=;
        b=lf5YgBQ6p74VzKL9IEEQV0dEegC0V45UDUk5nOGMNclBHtrpATuqIz6Kv+TWGPT1yS
         AUeNQDfYcKjmRzoWKm+oKe32nY7OT9LrL6pAze8+GNQ6mU+gzolMD2bu7CoV5gT76VKr
         q1c+48S9lh1W+7a30apoTwX/D8BKFHTg2D7QVzvRFfIUZmkB+1Yenc8MIqily41lRqva
         egoS3VfWzoZKT0G1Fa3Y25LcJ2VIMgmWzb8cgns0WEFMjfr7qBz//G6/yeRrLOxzhOzX
         sefpf24dxcZINxqp/eBytSF0vtHNH1olLKW1H+kM3HfwfCmSrYa51Cd3ZqJF6u8fv6VX
         zhGQ==
X-Gm-Message-State: AOAM531fJLR/1tM22zVjQ7py/lQnUWfVnabokiONf4MFKdyrLKUSssRa
        ZMb9E9n4PkddKL+xTdKfaw==
X-Google-Smtp-Source: ABdhPJzC70M8zR3XO5nSIOMaVhWv+v5neKeHiM1ExcZ80BPIk1+XyCMD5ZdObK4NZILBt2g0l8B0xQ==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr28759970oiw.68.1639412418162;
        Mon, 13 Dec 2021 08:20:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm2720822oig.15.2021.12.13.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:20:17 -0800 (PST)
Received: (nullmailer pid 1139466 invoked by uid 1000);
        Mon, 13 Dec 2021 16:20:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     romain.perier@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211213100112.1791192-2-daniel@0x0f.com>
References: <20211213100112.1791192-1-daniel@0x0f.com> <20211213100112.1791192-2-daniel@0x0f.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for Miyoo
Date:   Mon, 13 Dec 2021 10:20:15 -0600
Message-Id: <1639412415.386959.1139465.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 19:01:10 +0900, Daniel Palmer wrote:
> Add a prefix for "miyoo". The only details I can find about
> the company is their aliexpress store "miyoo global store":
> https://www.aliexpress.com/store/912663639
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/vendor-prefixes.yaml:762:4: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/vendor-prefixes.yaml:  while scanning a simple key
  in "<unicode string>", line 760, column 3
could not find expected ':'
  in "<unicode string>", line 762, column 4
make[1]: *** Deleting file 'Documentation/devicetree/bindings/vendor-prefixes.example.dts'
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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a simple key
  in "<unicode string>", line 760, column 3
could not find expected ':'
  in "<unicode string>", line 762, column 4
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/vendor-prefixes.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/vendor-prefixes.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/vendor-prefixes.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1567228

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

