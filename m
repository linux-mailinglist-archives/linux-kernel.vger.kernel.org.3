Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FC4B71B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiBOPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiBOPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:23:11 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA118AE4A;
        Tue, 15 Feb 2022 07:22:58 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id h11so15040135ilq.9;
        Tue, 15 Feb 2022 07:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5VCIuSaUaGTs0ZgwHiplE8qOxEpyPo50926xTtWMFIE=;
        b=X06Tup3MwxAjcnMdvRjx5rBalcA51ZUwrAg8IwrxWUG9Ekq42x8eg4sDHa2gwOXQhJ
         JEr7tRgvIvlKEls4bUnW9KASTqEeBdVwKM8bRVkwu4fsFytPLpX+e9Tfqtigf93TRF+6
         7YIGFlqvQPeCrnTHvko2c8wtalz0vlDNmriQuMCzTowc3DvJth1w3OcRWkrQx+APATE4
         NqIp4oeTg08DXyf2dKosCfb6bqTRFyPfFTpzQZghRhnKiCDbQtaqNddVaYAyqvP5NPut
         TTIlCqgcSESuDiGfeVu7onKaP3EQt6kQXWyAuvr/RvC54uWA3TfI7Aa+jXHgAM6vDs2J
         AkDA==
X-Gm-Message-State: AOAM533Q4CECH24ZuYJz/BcQA5aRjz5yJEUv/rQac6RGWpCkZ+oBo9nk
        /tghiG3uWZuQ4tDd4EYPyA==
X-Google-Smtp-Source: ABdhPJwoWBynoWihqkBcd1NfufxvSR86qj7ghYMDulkjze8yUyVxHyVhrB0iBONiVGy1uK3jbbtb9Q==
X-Received: by 2002:a05:6e02:194b:: with SMTP id x11mr2771254ilu.123.1644938578112;
        Tue, 15 Feb 2022 07:22:58 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l2sm5303071ilv.66.2022.02.15.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:22:57 -0800 (PST)
Received: (nullmailer pid 3450860 invoked by uid 1000);
        Tue, 15 Feb 2022 15:22:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
In-Reply-To: <20220213171532.346270-2-dario.binacchi@amarulasolutions.com>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com> <20220213171532.346270-2-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate
Date:   Tue, 15 Feb 2022 09:22:45 -0600
Message-Id: <1644938565.059972.3450859.nullmailer@robh.at.kernel.org>
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

On Sun, 13 Feb 2022 18:15:27 +0100, Dario Binacchi wrote:
> It allows to change the M06/M12 default scan rate.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml:90:21: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 90, column 21
make[1]: *** Deleting file 'Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dts'
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
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 90, column 21
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml: ignoring, error parsing file
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1592123

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

