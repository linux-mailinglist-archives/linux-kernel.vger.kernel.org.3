Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99253711B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiE2N14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiE2N1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:27:53 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BCD70935;
        Sun, 29 May 2022 06:27:51 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f2cbceefb8so11220418fac.11;
        Sun, 29 May 2022 06:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0m7CcmaqJ3DybPkFOApxgNfU3rE4ON+v8lfBmfHIxgw=;
        b=STfCkzz5CwOnYSWi3R9h955iKN34cuia4l+GPwXHSSKMHMV4bzNYBrDD0qhGFdYxcU
         7fi1xQ/CFXk2VQM5Eh1YCLoFL5pkMBRObn3St8giTFu2jDVk4UdcrZ/spdtRyoGI/P/z
         gxsRZ7236MUaRDvi7oGcR//N+s+mfZjkY0qth4+d/1Eu+crUCoKEMyNmEolBOeKR2WCS
         V4tQ36As9FyOv2qjqxly6vDx9+JiHR0IWqciPIdkGL68V4v6BIsJFpFqbzDuTtXsy5dP
         KpZDDomjzHd2j8ns1i8oensDBughRTSP22ngUC8a/GnvvA9dchJm+QwOxidWdZ/55aSJ
         mWhA==
X-Gm-Message-State: AOAM533wUn9IE+DIdo1Wg+MyPgQjlrHm9pG5+sim0r14JUWFz8Z6KHIb
        L578SsQJuyZilO47hC2RiA==
X-Google-Smtp-Source: ABdhPJyo6KCyr0YCpjBZPdNr7qIYTx3KfwPGCn+bI8DR4jxWy4KyJvi5IvHgrSN6x/6fuTj/WsqF+g==
X-Received: by 2002:a05:6870:d5a3:b0:f2:c923:682f with SMTP id u35-20020a056870d5a300b000f2c923682fmr8678701oao.120.1653830870889;
        Sun, 29 May 2022 06:27:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a056830204900b00608b8e6fad5sm3926505otp.76.2022.05.29.06.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 06:27:50 -0700 (PDT)
Received: (nullmailer pid 1443081 invoked by uid 1000);
        Sun, 29 May 2022 13:27:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     ashish.deshpande@nxp.com, arnd@arndb.d,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mikelley@microsoft.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        rvmanjumce@gmail.com, sunilmut@microsoft.com, javier@javigon.com,
        jasowang@redhat.com, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        will@kernel.org, mst@redhat.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220527184351.3829543-2-manjunatha.venkatesh@nxp.com>
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com> <20220527184351.3829543-2-manjunatha.venkatesh@nxp.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: uwb: Device tree information for Nxp SR1XX SOCs
Date:   Sun, 29 May 2022 08:27:49 -0500
Message-Id: <1653830869.379260.1443080.nullmailer@robh.at.kernel.org>
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

On Sat, 28 May 2022 00:13:49 +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
>  .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml:45:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.example.dts'
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
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 43, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 45, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml:  while scanning a block scalar
  in "<unicode string>", line 43, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 45, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml: ignoring, error parsing file
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

