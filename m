Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADAE57BF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiGTUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:32:15 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B14A811;
        Wed, 20 Jul 2022 13:32:14 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id n13so1340816ilk.1;
        Wed, 20 Jul 2022 13:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IARPxdpRl8tz+zWVsX1n/ZXaygmNXEXGZkFMJF6ObAk=;
        b=3s/ug4kRghrVQ77VgjY2w2bhkFl9X+u+J/t3udsyXJUpSp7aMJN6DTeykDaCBqYg+L
         /LBl7UGevDEj2Vez8sgnLv5Vo5575KAuQ/qhLdCes1T9/9DjkWfiC+euzjhb4D/pCey4
         kacbonkFWNUXL1irmyaMCkthHc7k+94my/n/vTLgovjG/7lzo0kMGksMji5QrMtRdBD6
         H0AyiO6jYJ6jn/Mt9o7AG9ntN0GwfOvBskOjiVJLja4Wd9wyWI9j9Z0jyY7o0aEaYrsw
         iae17KPxsjn7+Cfm0OrJlcF8Grt/3FxqEGta/pk0MqTtLddMf4s6v0xXpEz6xoYO8YDH
         FrIw==
X-Gm-Message-State: AJIora+tuZQr8IYqDOz3TAy1h42NNSGUgGlny5o4wXtiXctbO2rhZnng
        IyZLPwLhVHQ5GOz+3MAl+g==
X-Google-Smtp-Source: AGRyM1ubB+OJB0nt41EjvMvcdSWrDY1/E3SjI6HEuFBiYbtv0MUvmMFunSkSNpIDqTK5Qp3I+frGTg==
X-Received: by 2002:a05:6e02:1708:b0:2dc:8201:c2c8 with SMTP id u8-20020a056e02170800b002dc8201c2c8mr19150968ill.185.1658349133716;
        Wed, 20 Jul 2022 13:32:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z20-20020a05663822b400b00331598832besm8146977jas.25.2022.07.20.13.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 13:32:13 -0700 (PDT)
Received: (nullmailer pid 3925125 invoked by uid 1000);
        Wed, 20 Jul 2022 20:32:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220720150007.2168051-2-martyn.welch@collabora.com>
References: <20220720150007.2168051-1-martyn.welch@collabora.com> <20220720150007.2168051-2-martyn.welch@collabora.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Carrier
Date:   Wed, 20 Jul 2022 14:32:12 -0600
Message-Id: <1658349132.217422.3925124.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 16:00:04 +0100, Martyn Welch wrote:
> Add DT compatible strings for a combination of the 14N0600E variant of
> the MSC SM2S-IMX8PLUS SoM in combination with the SM2-MB-EP1 carrier
> board.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes in v2:
>   - New addition
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/fsl.yaml:933:111: [warning] line too long (118 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

