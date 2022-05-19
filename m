Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B439C52DDC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbiESTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbiESTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:23:04 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A3541AD;
        Thu, 19 May 2022 12:23:03 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so1832002oti.13;
        Thu, 19 May 2022 12:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=orrXJpfL6g4XiiOjKR9Uk/mezcrEThgaAMQXh56e974=;
        b=erhTU/50Mvx3uIC8gPjVe5Nq7uOfgdNekdVA3fcqrVtiZVCl7g4nQiP+GVIc9T995S
         fpNLQv8B9qQs3BPq9kbp1g520bc0Ngexp+vWkin4uxNVJKOopO0LiKsx4MdHYRzzxfYA
         gRfZ9i9wH//AxkoNpjb5J07Ikh3biC1NNopkHv9snD0dhDUnt8B65qhfZECNtjXSzc+N
         LD/GeLZ5nnnE0E0oMYv9PCcartlaxRjqdc9138V712+o4QcvttSOninyivfAv9O2lEy7
         ba6DRn6nc8S6uhpKvt39wkmV+HkX7eWv+OyAd9ipdJm0fznW4tPFIf6xaYNVN5dgDS9b
         ARrw==
X-Gm-Message-State: AOAM5309GyHVzbV7bE3nNiKpTjJIq+XzRkG9IBzazHtiXr5DiCDYmZbp
        ME09Iy1SeYLlOZls6au9lkFZ13ayIQ==
X-Google-Smtp-Source: ABdhPJxa3ixUPZOqLI2uyA1deo55I/uUmEcrt+gWB5r7hOqwqFoCHJGoLjwwQDY+i31j1fH/bgfP0A==
X-Received: by 2002:a9d:4698:0:b0:60a:eb23:ff1 with SMTP id z24-20020a9d4698000000b0060aeb230ff1mr800653ote.24.1652988182743;
        Thu, 19 May 2022 12:23:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ed11-20020a056870b78b00b000f200873c09sm64952oab.27.2022.05.19.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:23:02 -0700 (PDT)
Received: (nullmailer pid 2044188 invoked by uid 1000);
        Thu, 19 May 2022 19:23:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com> <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
Subject: Re: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Thu, 19 May 2022 14:23:01 -0500
Message-Id: <1652988181.087976.2044186.nullmailer@robh.at.kernel.org>
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

On Thu, 19 May 2022 18:04:54 +0530, Harsh Agarwal wrote:
> Added support for multiport, mport, num-ssphy and num-hsphy
> properties. These properties are used to support devices having
> a multiport controller.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:367:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:368:10: [warning] wrong indentation: expected 11 but found 9 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:370:11: [warning] wrong indentation: expected 11 but found 10 (indentation)
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:409:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/snps,dwc3.example.dts'
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
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 401, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 409, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/usb/snps,dwc3.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:  while scanning a block scalar
  in "<unicode string>", line 401, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 409, column 1
./Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/qcom,dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
./Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: ignoring, error parsing file
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

