Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C69500D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbiDNMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbiDNMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:22:37 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386365167;
        Thu, 14 Apr 2022 05:20:12 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w127so5141001oig.10;
        Thu, 14 Apr 2022 05:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xGrPDaLTatvDRaAzhvLwefpB2hL2dRTZUI93t0u/qVg=;
        b=ewlPZrlCGroOCcp0CIhB4QjDCUqTQtTheDJBPTlCxtQg3vRrQFEvDsZWDIZ3/nfuJt
         xaVI/4OB3Cm2vo227F5bL0nCo83gAG2APMfPgnyPRh6d5Uz1rX3uCnE2A2Y5lhJYgSRi
         h0rieZmuHvAwuljNBlVbCJoUvgfZ9CT/TVUedge4CwOCdORKdj/PA0hZM9y8U5n5E2rp
         WA61woTXNN5x393Md71a7hF2RGz5CV2kd6ZZqsDlukCD4m1CGxiImED71T9REed1XSHY
         9tSqj4M5VyQeZAfiSdo6DTKEwTl4T1mP3h9oxWeG2lZ2zG9nS3YVF/RxoS/nJRTskcYV
         MskQ==
X-Gm-Message-State: AOAM533l8U4qaVJDIMxdfpb7B9C2DPD5DLqZs6HP/7xKUfknhQAQ05PN
        seWutIuQa8viP7XL347kK5X4mBFbGg==
X-Google-Smtp-Source: ABdhPJz1GwFXvOT+FtK2fL+VEtZ6FpkS42FsXeP7N6c56vV3yFsB0DBcu2XqAACbZmkE7DIbMHS2gg==
X-Received: by 2002:a05:6808:179f:b0:2fa:54a:e47c with SMTP id bg31-20020a056808179f00b002fa054ae47cmr1123593oib.131.1649938812152;
        Thu, 14 Apr 2022 05:20:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d20-20020a056830005400b005b22a187045sm681531otp.11.2022.04.14.05.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:20:11 -0700 (PDT)
Received: (nullmailer pid 1698376 invoked by uid 1000);
        Thu, 14 Apr 2022 12:20:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev
In-Reply-To: <20220414092831.3717684-4-fabiobaltieri@chromium.org>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org> <20220414092831.3717684-4-fabiobaltieri@chromium.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Thu, 14 Apr 2022 07:20:09 -0500
Message-Id: <1649938809.993469.1698375.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Apr 2022 09:28:30 +0000, Fabio Baltieri wrote:
> Update google,cros-ec-pwm node documentation to mention the
> google,cros-ec-pwm-type compatible.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

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

