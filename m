Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACCF58BE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiHGWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiHGWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:40:47 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE8BCA8;
        Sun,  7 Aug 2022 15:33:54 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i84so5894083ioa.6;
        Sun, 07 Aug 2022 15:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=3eZwuAFmjc+ZRz+NnpymNnE5U9avZ4uyAs/hATKVDy0=;
        b=VVmtLY/XQAxuXiitQ8f1y8BbVrThiqW11AABbhdsD1qr5DY1V1F2f54fpkYlCfy6Yf
         61vpM4RHGIDl7qAEyIurGi6tBjlVpQtbI+txyqyC23+60+2fv83RaOPnOwsNCYw4kXU0
         Si3mmtl0mMk6o7Ewftm8pYBoDIYoZ5xHjYqOqTJ4VeeEm/rntzw8j39fbgLAxQbEQ9qW
         0eD0GBqhJCfY8YV+1BC8kCBt0P4Y6NwTbKYYJoC4Vq7QmAeAIR96ND3u6OxKfP3TTfJg
         aXxR57TVHEdGWyf6xOAnOYYVlkw+BTSfCFgQi/3eFtjKXtDel+AyCu4a906KJt92tSfA
         WpuA==
X-Gm-Message-State: ACgBeo1yhOsNATS144hj/v56E+jLOUbQ1T8IZAa330fIVSzsk+z8RPlZ
        AXbsE+co6gHfN/ZvDIapQQ==
X-Google-Smtp-Source: AA6agR6CbM74O42J1P5fVI6paXKlRrzL+WE41cDa93XM13rQjSONQDHjl6WY3uvZKT/x8peMjJNypg==
X-Received: by 2002:a6b:cd4f:0:b0:675:b0bf:d999 with SMTP id d76-20020a6bcd4f000000b00675b0bfd999mr6358562iog.193.1659911633211;
        Sun, 07 Aug 2022 15:33:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o9-20020a022209000000b0033f7e44904fsm4473076jao.134.2022.08.07.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 15:33:52 -0700 (PDT)
Received: (nullmailer pid 2326179 invoked by uid 1000);
        Sun, 07 Aug 2022 22:33:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     u.kleine-koenig@pengutronix.de,
        William Salmon <william.salmon@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
In-Reply-To: <20220805165033.140958-2-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com> <20220805165033.140958-2-ben.dooks@sifive.com>
Subject: Re: [PATCH 1/8] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Sun, 07 Aug 2022 16:33:51 -0600
Message-Id: <1659911631.163349.2326178.nullmailer@robh.at.kernel.org>
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

On Fri, 05 Aug 2022 17:50:26 +0100, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v3:
>  - add description and example
>  - merge the snps,pwm-number into this patch
>  - rename snps,pwm to snps,dw-apb-timers-pwm2
> v2:
>  - fix #pwm-cells to be 3
>  - fix indentation and ordering issues
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pwm/snps,dw-apb-timers-pwm2.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.example.dtb: pwm@180000: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

