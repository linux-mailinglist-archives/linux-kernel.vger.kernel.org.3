Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AE59FB50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiHXN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiHXN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:26:59 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093256D56C;
        Wed, 24 Aug 2022 06:26:59 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11d08d7ece2so13893571fac.0;
        Wed, 24 Aug 2022 06:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=viWueFiZ5OfydC+pO3bw0kvTAFJjoYrGSGQ4/iAQQVY=;
        b=ECTx5GMDDT89wU/fh1UzSzfp2erzoWxu5PW1hwwUdzB79vyNRSRIMWjyUkMvnovZcW
         oRfmMwsM+AEGbdtWXmndB7mxPuWqiJbXhgErekNI5Ll2g8P590rr50D+gOkPwnQQcNBZ
         fQNoKNV+L8JoaEHGtFOrcip4mcqvxS/W+edQtD6Z8/9mxXYboFkl2p2YuZNEzO9EzC/J
         T6gB6DK0QKKM8ToSfy9pVe9YFdOlV0VGEjFSHuqh24KJxKv4FJhhGkbT1767lJtc1lsz
         wGLhSuqPk+4vXRoRUU8/98Rdc1rma6yQCrQDqR/tcNxqhcoI0viw76uhrtdWGlDx24kz
         I4KQ==
X-Gm-Message-State: ACgBeo297w8hc9cA6NzwBZ4//6fYqP5iyra7u2KzbGT3OYp60SuSGXhH
        FDFBGeD4Lo5mFNKrFbACsA==
X-Google-Smtp-Source: AA6agR4hiwTnYcZXZZDgaAHHGMgSYNVWUIkbngaylk2cV1PJhQLLoL7hjMUUg3zhPzICm+SbbABfWg==
X-Received: by 2002:a05:6870:b384:b0:11c:e692:699a with SMTP id w4-20020a056870b38400b0011ce692699amr3644688oap.213.1661347618286;
        Wed, 24 Aug 2022 06:26:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a9d2c07000000b0061c3753c30dsm4501465otb.17.2022.08.24.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:26:57 -0700 (PDT)
Received: (nullmailer pid 2098939 invoked by uid 1000);
        Wed, 24 Aug 2022 13:26:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
In-Reply-To: <20220823183319.3314940-5-mail@conchuod.ie>
References: <20220823183319.3314940-1-mail@conchuod.ie> <20220823183319.3314940-5-mail@conchuod.ie>
Subject: Re: [PATCH v4 4/4] dt-bindings: riscv: isa string bonus content
Date:   Wed, 24 Aug 2022 08:26:57 -0500
Message-Id: <1661347617.007635.2098938.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 19:33:20 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> **NOT FOR CONSIDERATION**
> 
> I figured, sure why not add the strings for version number validation,
> just in case we need them in the future. The commented out string is
> considered by dt-schema to be "not a regex", but regex101 thinks it
> is... Maybe dt-schema does not support named match groups, but they
> are the only way that I could trivially find to make this somewhat
> manageable. Either way, it is permissive so it allows combinations
> of "M", "MpM" & no number.
> 
> Not-signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/riscv/cpus.yaml:87:111: [warning] line too long (297 > 110 characters) (line-length)

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

