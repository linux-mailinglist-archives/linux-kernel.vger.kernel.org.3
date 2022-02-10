Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD214B181D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbiBJWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:25:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344821AbiBJWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:25:47 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACB25C2;
        Thu, 10 Feb 2022 14:25:48 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s185so7614370oie.3;
        Thu, 10 Feb 2022 14:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IuYr67090/unQtnWlIbbp7LhlrD6io0xMAwVl2CDLrI=;
        b=LoeaPqu1m+OW/sbdCE912+298Ra6amAEBG/49pNTLqvUYwkj5VmW7H2RpZj+hwwRax
         N1c9PG5wUApL5fkUwnGMb7c5VHpOja8SSG7qGfsVN6wMvwQGiMaKNKAXUqwpVsjFiHSG
         0yYS+h6tDeo3hjQJewBYnY3arROEiEWhQhvvWO6+KaR/Q8L/CzJRsAJ0CAYeuYbVfJUB
         yiX8nRnXWm/mP+EUeuj4XtX7fAaoa9vzQEMK9hcfUSLSQGxH1T+DwkJRTxQRsHQm8PWW
         wfydjR9iVIxM4A40ywzyZTSurkXMbQ/bWCbBXyOvS1/QYSe2nH0HsBI+WesStQ8HNKg2
         vh7w==
X-Gm-Message-State: AOAM531i761g5Rhbwg4VAqq2qBRvAcKiMvu9tTvMn6p7494qE5k8ZT3l
        TTLSNiZOzuCi/vm7tYTEnCxzzYVheQ==
X-Google-Smtp-Source: ABdhPJxTTAiZghF/RJpwGFWgFAR76ncOfNRN9a4vEHny1yhxWEbzgB1VFssOG8rl+VNVqhvjd7VFIw==
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr1895131oik.309.1644531947317;
        Thu, 10 Feb 2022 14:25:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j2sm2808135oon.18.2022.02.10.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:25:46 -0800 (PST)
Received: (nullmailer pid 3262541 invoked by uid 1000);
        Thu, 10 Feb 2022 22:25:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20220210163708.162866-2-markuss.broks@gmail.com>
References: <20220210163708.162866-1-markuss.broks@gmail.com> <20220210163708.162866-2-markuss.broks@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Thu, 10 Feb 2022 16:25:43 -0600
Message-Id: <1644531943.391463.3262540.nullmailer@robh.at.kernel.org>
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

On Thu, 10 Feb 2022 18:37:06 +0200, Markuss Broks wrote:
> This patch adds device-tree bindings for the Imagis
> IST3038C touch screen IC.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../input/touchscreen/imagis,ist3038c.yaml    | 78 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.example.dts:23.26-37.13: Warning (i2c_bus_reg): /example-0/i2c/touchscreen@48: I2C bus unit address format error, expected "50"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1591241

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

