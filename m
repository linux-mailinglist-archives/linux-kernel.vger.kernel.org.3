Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0917C545A48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiFJC5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJC5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:57:41 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5374F9CE;
        Thu,  9 Jun 2022 19:57:39 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id s23so24058093iog.13;
        Thu, 09 Jun 2022 19:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=p9jnLRpQ5+408FDZHB0dR0waJq+nmC2anyqDtqpuqUw=;
        b=UANq3JRCmMTbkcDsyTR6jYSbqBHRCnd2mw07H6FhmDF5lsbufiScFoxEqa3Rsn5VEI
         GnIRGjL11AgqWpo0kniorfpFPrQYdLvg3a3xZJAPSFkiGxoX1W9dUA5ims5+Yk00Aa4e
         yGCKusxHk11HFz+l+AlTIAbw662B+d6yYw4sc1vX/dxfOg9wohQAXqZ+ac/xkfLHmx6S
         0BQ1pU3Xw3kZun3RLGgZYzrQQwtJcaGJ9akChodfTXc1cv5ifPbl0iqJeXRpAEkoAPOw
         L68Ca1SHRluS5kdTdeNzoWIFrNiR+F3wbq+X8cEwquNKNsCALETrxDUaUitNCjpW84rM
         TF1w==
X-Gm-Message-State: AOAM531PVziV2KjHt5F8VeIuGqL0TB0yt57w18gwUQc/eaPpOcXmYs2g
        yoH2JdVL4y0ss3sCOeQfBA==
X-Google-Smtp-Source: ABdhPJziJbgRIEmxRA3A0BekoJjMrpw+Tm1wqI/df6NhT7/M9K0q0dM+Le7Mm9yIKa2lBcIUn0Ed7A==
X-Received: by 2002:a05:6638:381c:b0:331:b4c2:1f93 with SMTP id i28-20020a056638381c00b00331b4c21f93mr11876156jav.185.1654829857755;
        Thu, 09 Jun 2022 19:57:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t18-20020a056e02011200b002d663b3dac7sm3043777ilm.5.2022.06.09.19.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:57:37 -0700 (PDT)
Received: (nullmailer pid 560617 invoked by uid 1000);
        Fri, 10 Jun 2022 02:57:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, max.krummenacher@toradex.com
In-Reply-To: <20220609150851.23084-2-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com> <20220609150851.23084-2-max.oss.09@gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power domain controlled by a regulator
Date:   Thu, 09 Jun 2022 20:57:35 -0600
Message-Id: <1654829855.220248.560616.nullmailer@robh.at.kernel.org>
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

On Thu, 09 Jun 2022 17:08:47 +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Adds binding for a power domain provider which uses a regulator to control
> the power domain.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  .../power/regulator-power-domain.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/regulator-power-domain.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.example.dtb: power-sleep-moci: $nodename:0: 'power-sleep-moci' does not match '^(power-controller|power-domain)([@-].*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

