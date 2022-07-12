Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47D571C67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiGLO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiGLO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:26:15 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9386B8EA1;
        Tue, 12 Jul 2022 07:26:14 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id h200so7947510iof.9;
        Tue, 12 Jul 2022 07:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Mwfd/m3zpk78sJK7nn2vE1VYk2hb35cFLS9pd42jCiI=;
        b=sOLx8NOPqcbkhqqTQtOXlwj3BU4MfcAKBFdVlUpiB/pR09UKmkx+uY7hxCdgcAB3sS
         SAn+vAEq0Jxlqh9mjdYSKLRa3Tkry2Ewo82T/KL0Rb9C+IhsXJdZzdWb0ZH1kV8tZQfU
         nL0o6wcKGVQpqMRtWPKd2TmtpbYJ7ZVuWD5wQ10VhnNgMPrfWDgPT20Ha0GG8Ld34sx6
         tkmfXkVUI5QP3CRxRur/a626v/GwqO94mz565Qyr9Hp/MX3vSOXAPsIbIgYOYk/vJujd
         0EtkqR9MiC4vZH8iFiRoytHGbXpdjkBwCj0RCfZyOO2EhZncFyk7sjvWJICy1ugku/Wa
         z/TQ==
X-Gm-Message-State: AJIora+Nk4Vq7WICIZQIOlFgCbcNTfth8qK7/OMKbVrDcKcVFACeGdmU
        GjQRzce8yVS0IJn/f3aLIg==
X-Google-Smtp-Source: AGRyM1uQLAcirqFEfLkDKLsk9TU4a8owrMVfxUjgaeO2hrKaXbUywPSmFTal17hen3JlJmxPkXBYqQ==
X-Received: by 2002:a05:6638:218c:b0:33c:9cae:166d with SMTP id s12-20020a056638218c00b0033c9cae166dmr13409432jaj.223.1657635973941;
        Tue, 12 Jul 2022 07:26:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w8-20020a92d608000000b002dc0e7027edsm3799668ilm.32.2022.07.12.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:26:13 -0700 (PDT)
Received: (nullmailer pid 1805847 invoked by uid 1000);
        Tue, 12 Jul 2022 14:26:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com> <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
Subject: Re: [PATCH 4/4] dt-binding:perf: Add Amlogic DDR PMU
Date:   Tue, 12 Jul 2022 08:26:12 -0600
Message-Id: <1657635972.094089.1805846.nullmailer@robh.at.kernel.org>
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

On Tue, 12 Jul 2022 14:36:41 +0800, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  .../devicetree/bindings/perf/aml-ddr-pmu.yaml | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/perf/aml-ddr-pmu.example.dts'
Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml:51:5: did not find expected '-' indicator
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/perf/aml-ddr-pmu.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 33, in <module>
    sys.exit(load_entry_point('yamllint==1.26.3', 'console_scripts', 'yamllint')())
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 210, in run
    prob_level = show_problems(problems, file, args_format=args.format,
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 106, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 203, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 140, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 580, in check
    for problem in _check(conf, token, prev, next, nextnext, context):
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 346, in _check
    'wrong indentation: expected %d but found %d' %
TypeError: %d format: a real number is required, not NoneType
./Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml:51:5: did not find expected '-' indicator
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml: ignoring, error parsing file
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

