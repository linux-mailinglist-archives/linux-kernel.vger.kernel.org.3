Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD65AECF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiIFN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbiIFNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:54:44 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A980F53;
        Tue,  6 Sep 2022 06:41:33 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-127a0d798bdso7735548fac.4;
        Tue, 06 Sep 2022 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=U7KMCwyPUAeyOkS8LvXUFPy4Xy4KgDM/4fM2ZNJCPo4=;
        b=bfki+yWcXz98D9qBYIwI1d8sJlDKhefVdfDQcuXhOwEYm0xuBoxYoVIp1S1kuCEn//
         5V5bGvQ82RMexka8VMwwF3hObbdwU3Dps5FNyZWQJ8oP+OPdlTibi8jfBm8PXYfeGc6Q
         +E64dHA62bADt4sZ7nxdlxYmt1kxckDrIsZQi8nZE8gkm0lTTmXGcqL5RHjCKVYcy7bm
         tuiiwNHKNJPgJzBfHFnZkIPZZi/VyxBddp9CIoBbsLqcbvvXzoZupy0WS2vPW9SZxWxO
         UrEQ7bxlYEVDA2TUKr+3ixqBq9PabTqfHpRE56v0jYBoL22ta1V3JKxopXNqGsxeaxQU
         trrg==
X-Gm-Message-State: ACgBeo16+Ep15vr9UPjCELRdAgoNVQk57oDEcmCrbGb9u5I9m3lsHel8
        uWLtW7GUmhXFsz+eDVhdHw==
X-Google-Smtp-Source: AA6agR4VFYt4Q6uqaviz/cWYZjZnXg/9Uo8qUBasuYk+y+0PkxJ2esvoAyfunvvkKBZRtHtdKfWDnQ==
X-Received: by 2002:a05:6870:831d:b0:10d:a96f:8bc with SMTP id p29-20020a056870831d00b0010da96f08bcmr11029950oae.143.1662471647776;
        Tue, 06 Sep 2022 06:40:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y2-20020a056808060200b003450abf4404sm5315654oih.21.2022.09.06.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:40:47 -0700 (PDT)
Received: (nullmailer pid 360956 invoked by uid 1000);
        Tue, 06 Sep 2022 13:40:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk> <20220906082820.4030401-2-martyn.welch@collabora.co.uk>
Subject: Re: [PATCH v2 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
Date:   Tue, 06 Sep 2022 08:40:45 -0500
Message-Id: <1662471645.313702.360955.nullmailer@robh.at.kernel.org>
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

On Tue, 06 Sep 2022 09:28:16 +0100, Martyn Welch wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
> Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
> Inc.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes in v2:
>  - Enumerate pi4ioe5v6534q as requiring pcal6534 fallback
> 
>  .../bindings/gpio/gpio-pca95xx.yaml           | 98 ++++++++++---------
>  1 file changed, 52 insertions(+), 46 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml:24:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

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

