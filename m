Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC44F8576
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbiDGREY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiDGRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:04:18 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA981C9B44;
        Thu,  7 Apr 2022 10:02:17 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id e189so6246851oia.8;
        Thu, 07 Apr 2022 10:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Wp8RSwIrgzG7uQ3b1/ypwJs7daFfqxiiYUEMrzxbqT0=;
        b=1tYAl2yFyP6/X2KSem7RfxY6ckyAUuZDEu4EjliaL2r+TVs9KQJXEzDjxU89Tx1EVL
         88F4iQqBYLRaUSaWAFn8Qx+snactdPUnhIx6a+A/xAN8VjtrmmMWnBs8UD8pCBAQf37R
         xkhXQTQ3Woqilebpz5pVPYQPHbTBKYPcdtzSRDLM6WrZ8f8iK+ZD3na+wdf7hXLyM0vh
         KmIUta8eaJ4eLFT0tveJgj9fhEXriPUWAhpRTKYY6vUTuw3VVZBdYEyIX54rmOfLmoSo
         MI8Xt6AVTwGm78kFweTr3keWlTQDVJ4dHdxOTWyhUTzxX/ok5GBN8NIExAUEUr7tTW3R
         qV4Q==
X-Gm-Message-State: AOAM531pwWDXbhtxKmp0F+6PqtIEuFaj7yGM/Vo1cblbKyB1wvxcxtlA
        69k47FjgVHfdo9GLoZBbZQ==
X-Google-Smtp-Source: ABdhPJwfZgiNM9aE7g93ngGxHZ9S+c/XahJIWijit/HHJyW68508gY+Yc3Pn8uYTbOC5M8Fw+qgcdQ==
X-Received: by 2002:a05:6808:30a7:b0:2ec:cf1c:9a06 with SMTP id bl39-20020a05680830a700b002eccf1c9a06mr6455461oib.272.1649350935482;
        Thu, 07 Apr 2022 10:02:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mj27-20020a0568700d9b00b000de29e1d6adsm6053342oab.16.2022.04.07.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:02:15 -0700 (PDT)
Received: (nullmailer pid 1406984 invoked by uid 1000);
        Thu, 07 Apr 2022 17:02:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20220407101034.13122-2-markuss.broks@gmail.com>
References: <20220407101034.13122-1-markuss.broks@gmail.com> <20220407101034.13122-2-markuss.broks@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: convert ktd2692 bindings to yaml
Date:   Thu, 07 Apr 2022 12:02:14 -0500
Message-Id: <1649350934.490785.1406983.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022 13:10:05 +0300, Markuss Broks wrote:
> This patch converts the leds-ktd2692.txt bindings to modern yaml
> style device-tree bindings.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
>  .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
>  2 files changed, 87 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml:37:24: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/leds/kinetic,ktd2692.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 52, in <module>
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
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 36, column 5
did not find expected key
  in "<unicode string>", line 37, column 24
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/leds/kinetic,ktd2692.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml:  while parsing a block mapping
  in "<unicode string>", line 36, column 5
did not find expected key
  in "<unicode string>", line 37, column 24
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml: ignoring, error parsing file
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

