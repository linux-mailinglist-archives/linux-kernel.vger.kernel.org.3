Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B456D039
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGJQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:54:19 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5FECC5;
        Sun, 10 Jul 2022 09:54:18 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id a12so1873430ilp.13;
        Sun, 10 Jul 2022 09:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=srd0SwVtQLc3vr70hEtn2ikS3RE4F1eFzPfbFQeWgLU=;
        b=Dyhg04xeEx6dj/vkoG7FLasrz6iBzToeCDVQ3JjEUKIdFT5Vkp5LL6urTT9DW6/RW+
         D2Ag4u0BBlGiwLtZgfCzopzF8HDi1Htxhg+TE9BPIMAdgqxIcPd1mmss59+UVktNP3z4
         ++83eo2yPQsPyeM/+nEhBsIUfGHTYkgXVaLt5K+fyq1YQYBS2Oa2/EOCAwLqEVPNwFkA
         75/l9o9ynZox1fW3p7/d1SAxeRPhrhfBfffYlQFTESXIxYpwbVZxPZGpQ+zWWmbW8LB0
         wD7VRONkWZ2wb1W0KK09SlEcb6557u4WAebjP43WgPjGbR5lOBfLnpRGqh2KyOXZN6+A
         K2vQ==
X-Gm-Message-State: AJIora9vy1rariNcugAZvXKFeJLsFCv3kPmTTRNElifZLouVJjiCxJJz
        7KmiWMC4xnkKTQSxWuBl1pjJIYL8wA==
X-Google-Smtp-Source: AGRyM1v1x2JdWQvDCpJxBK4+b963wTLaRb1e+97cWbaaqBkOkg7g/oVHKNEb23HT8ibw4XlDGTBdAg==
X-Received: by 2002:a05:6e02:15c5:b0:2d7:a1cf:6f87 with SMTP id q5-20020a056e0215c500b002d7a1cf6f87mr7648419ilu.30.1657472058051;
        Sun, 10 Jul 2022 09:54:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s5-20020a92d905000000b002dc0d2f7c7bsm1839960iln.4.2022.07.10.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 09:54:17 -0700 (PDT)
Received: (nullmailer pid 1602127 invoked by uid 1000);
        Sun, 10 Jul 2022 16:54:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     MollySophia <mollysophia379@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20220709141136.58298-1-mollysophia379@gmail.com>
References: <20220709141136.58298-1-mollysophia379@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Sun, 10 Jul 2022 10:54:16 -0600
Message-Id: <1657472056.244279.1602126.nullmailer@robh.at.kernel.org>
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

On Sat, 09 Jul 2022 22:11:35 +0800, MollySophia wrote:
> Add documentation for "novatek,nt35596s" panel.
> 
> Signed-off-by: MollySophia <mollysophia379@gmail.com>
> ---
>  .../display/panel/novatek,nt35596s.yaml       | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.example.dtb: panel@0: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

