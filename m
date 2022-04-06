Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98FA4F633E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiDFP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiDFP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:26:47 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0F567C51;
        Wed,  6 Apr 2022 05:25:26 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-dacc470e03so2688068fac.5;
        Wed, 06 Apr 2022 05:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZAiwNLyOdCqn327S7Lza4+QFCdIZGu76iyxPe00STg8=;
        b=fEQ/gv2HdE5MFizzHU2tW9pk31Ssp6GcGqPzi5tOmIh4f0YiAaAR5hbmVAYQo+84yL
         r5oeysMMV81jXpk5F+DsSNNdg8DxhegaNm39LyImOORn0aXL9bIBmqCQEbyHPXSdZkQ+
         ljHQfubXjpTx7XZS21o0sGQCqjeB1f1gadz/tGwYC0duhYoP8pn95djxwYS8sBGhGbHZ
         OI5xn/LgFbcbskryauR55Grr+4zgxYTP1bFKTUrRsRhjLfQ3j6gVncoOqR3UObzWIbSq
         k6pQt5wCtNcPOkZqyDc71GqhEf55F0GtnSfrrOeIAjcaItz+3+KjNxzhDnitbxspDoB3
         Mo7Q==
X-Gm-Message-State: AOAM531Qz5UrBB0ImVRUL4jtR6SqtTaQVncJlDbggjWDOX1dqwUC6Ulv
        f6OW0AbS9CvhCcVCZaKNlXlWwOf/ew==
X-Google-Smtp-Source: ABdhPJw7dq0Mj6SFn7qO94i5CoOYKOOyYXs9QtdK23qSduHeloMb3lGgbs5sF7l1G1NkfAXjnetxhA==
X-Received: by 2002:a05:6870:c109:b0:d9:e74e:d09a with SMTP id f9-20020a056870c10900b000d9e74ed09amr3640814oad.142.1649247925324;
        Wed, 06 Apr 2022 05:25:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s6-20020a4ae546000000b0032480834193sm5902589oot.46.2022.04.06.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:25:24 -0700 (PDT)
Received: (nullmailer pid 2048304 invoked by uid 1000);
        Wed, 06 Apr 2022 12:25:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, qperret@google.com,
        maz@kernel.org, linux-watchdog@vger.kernel.org, will@kernel.org
In-Reply-To: <20220405141954.1489782-2-sebastianene@google.com>
References: <20220405141954.1489782-1-sebastianene@google.com> <20220405141954.1489782-2-sebastianene@google.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add qemu,vm-watchdog compatible
Date:   Wed, 06 Apr 2022 07:25:24 -0500
Message-Id: <1649247924.294947.2048303.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Apr 2022 14:19:54 +0000, Sebastian Ene wrote:
> This watchdog can be used to detect stalls on vCPUs.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../devicetree/bindings/watchdog/vm-wdt.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/vm-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/vm-wdt.yaml: properties:timeout-sec: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/vm-wdt.yaml: ignoring, error in schema: properties: timeout-sec
Documentation/devicetree/bindings/watchdog/vm-wdt.example.dtb:0:0: /example-0/watchdog: failed to match any schema with compatible: ['qemu,vm-watchdog']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

