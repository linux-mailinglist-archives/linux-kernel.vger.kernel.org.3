Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E459754C993
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348846AbiFONQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348856AbiFONQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:16:07 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78B2E096;
        Wed, 15 Jun 2022 06:16:04 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id d6so8728417ilm.4;
        Wed, 15 Jun 2022 06:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8C80sIX/zds/z0xyweVsBMgV7P8Pift98ShjLgz5ZwQ=;
        b=0iO9xBfkS60awmBiiU63PXTb86zX0eTAEBWBPpXsTeofnnaYPumY1x+xyl78Nr2pBT
         e12mYeRqVfnOYtWh1YtuwYtckIObiEk2zZWrOFNF1RKjj7kviTn5ee5dqgzgi7YvELup
         6SdCemA2W6PANsAJ2E8egUoXFl1yNOoa9a0k2pJvNrIijRbCrVR5jDhInUWWY5tCEzIV
         fIXJhNOH/HnpOegF+Wvp2Fg4byBPVDUubeaFisEjEGZXuCtNsod6t3ipVJgi//rradiz
         yvsMi10lSrlVkL9L4FVDDivXNVZw1T/WqFKquONI63DVhwJlniAQTXw56chHZ55KJA+F
         jsLA==
X-Gm-Message-State: AJIora9CWAD4r7Hpaww1Ri1rWcbVwg+s4Vj5cACdpui5cIqI9DviJkw1
        EWDtLq6+w7YiussBYtNcCv22ufCmuA==
X-Google-Smtp-Source: AGRyM1uZ9utNL5h2kFhjalsMtkLLXkoWdL+p72Vo2Z4lpjk/ny0uIeL/R8e97UqCCB1L4EDdFORe3A==
X-Received: by 2002:a05:6e02:1c02:b0:2d3:ccfe:6551 with SMTP id l2-20020a056e021c0200b002d3ccfe6551mr6203007ilh.134.1655298964054;
        Wed, 15 Jun 2022 06:16:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z6-20020a023446000000b0033214fb0061sm6121054jaz.23.2022.06.15.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:16:03 -0700 (PDT)
Received: (nullmailer pid 662450 invoked by uid 1000);
        Wed, 15 Jun 2022 13:16:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
In-Reply-To: <20220615070813.7720-2-romain.perier@gmail.com>
References: <20220615070813.7720-1-romain.perier@gmail.com> <20220615070813.7720-2-romain.perier@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings documentation
Date:   Wed, 15 Jun 2022 07:16:02 -0600
Message-Id: <1655298962.395709.662448.nullmailer@robh.at.kernel.org>
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

On Wed, 15 Jun 2022 09:08:09 +0200, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e RTC driver, it includes MSC313e SoCs and SSD20xd.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/pwm/mstar,msc313e-pwm.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml:21:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

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

