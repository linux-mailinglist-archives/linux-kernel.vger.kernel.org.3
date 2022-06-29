Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B55F334
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiF2CJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiF2CJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:47 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538602CE38;
        Tue, 28 Jun 2022 19:09:46 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id h85so14683077iof.4;
        Tue, 28 Jun 2022 19:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JARNJ/aUAAWYF8Kp9K5vhEa9VQqjpKlqU+P1/PZeinw=;
        b=m5tH2CVBLf67LXgaKfGIzaRr0/Sg/Usy2R+Xwglpjc5ezzlUm5ERzaO4VM9A7jpkcQ
         rp1lvPx9iy1OAaErBthIswwJnUhUvT4m7hv5J1rvdMDQDGXD/XgDrX7XPHnzMgh6cnXn
         F9XqKE5BdI+6FT8Po8DOh73eFhr9/uio7wTpFin3ErJ+JGuf7zQsDkn+bn1sUUu+A88s
         qDafDYhBSTbg5HESvlbJ73A8HIk8VPu1GsQ1B8kY++wSthKFtOaaKp184hng0V7XQSeR
         fXANRyHr0mOwPTuFEgPrheYa3oDBYClNk8/M4Z1m9ZWkYpvmKWZIew9WMjQCjpscvesV
         xN6Q==
X-Gm-Message-State: AJIora+PIZ4wSQ2WfuzdM+laKIs0HfY4ituSVlsUn1REV2FZztbsCqmS
        vyUvcVSvIlkAPxu6ze2uEg==
X-Google-Smtp-Source: AGRyM1slPM29QAD/Q6rfKGUPHPz46pGl5j8ASLSRBWb17aap3g6ZtMAMFFX/FUCNsC04wBp4fZMJAw==
X-Received: by 2002:a6b:7a46:0:b0:675:7cc7:516b with SMTP id k6-20020a6b7a46000000b006757cc7516bmr546965iop.43.1656468585563;
        Tue, 28 Jun 2022 19:09:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d94c7000000b006752c67c7c3sm4738029ior.19.2022.06.28.19.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:09:45 -0700 (PDT)
Received: (nullmailer pid 1403672 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
In-Reply-To: <20220628182147.2837180-2-vincent.knecht@mailoo.org>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org> <20220628182147.2837180-2-vincent.knecht@mailoo.org>
Subject: Re: [PATCH v1 RESEND 1/7] dt-bindings: leds: Convert is31fl319x to dtschema
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.884791.1403671.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 20:21:39 +0200, Vincent Knecht wrote:
> Convert leds-is31fl319x.txt to dtschema.
> Set license to the one recommended by DT project.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../bindings/leds/issi,is31fl319x.yaml        | 113 ++++++++++++++++++
>  .../bindings/leds/leds-is31fl319x.txt         |  61 ----------
>  2 files changed, 113 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:properties:adi,excitation-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb:0:0: /example-0/spi/ltc2983@0: failed to match any schema with compatible: ['adi,ltc2983']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

