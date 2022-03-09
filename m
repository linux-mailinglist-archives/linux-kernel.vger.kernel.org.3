Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD34D267A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiCIBpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiCIBpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:45:13 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E664A98F59;
        Tue,  8 Mar 2022 17:44:13 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 12so1179231oix.12;
        Tue, 08 Mar 2022 17:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ALkCbf8MuhMJodp57Ej8qON6XmpBkZSCiYrZoQVas08=;
        b=AxUUXixCUd5Vka4iI7yC9Dj9P8dXHAT+Qd1ARBSiNkXlSy5Jyj149jD7fvS5190hJp
         9nhbBOYfuMBZULarMyFn24LLMUk5KCNWvSBGi3zCmMKt1J73ksDpa6vdGNDtDZqnhWUK
         lk0+iFadl/arQEuxrhC09ni8rGL8pdwUkCVRnBxMmICwkpGePh06IIs1a4jIxYiZwN0M
         GoLaE6la7vpcw8qWfdMMh7JpZEi6q3SD/JR3L44KjXqTONYLSmIbGlWCimaFi29GDhOk
         nlbWLc+FcpBcmQeoLUMRLsZW2hL5QmWlFUbQ/lwWC7b2dMlWNWo4Al0LPShEK2K1HhPG
         3fLw==
X-Gm-Message-State: AOAM533tjYog/DLG2M/YhfohXb4a0NY+ST//0udVYDeOf+KQ4ZDPSMAe
        WmhJ+Cytj7bj1W9N67WUtA==
X-Google-Smtp-Source: ABdhPJzkQoJUy7fj4/Xv/jJzuFahiq5iE8LnS7VsFRB7lnay6JTi7wT4vnvsbqhOSD23Trg9tyBCBQ==
X-Received: by 2002:a05:6808:14cc:b0:2d9:a01a:48ac with SMTP id f12-20020a05680814cc00b002d9a01a48acmr4660064oiw.247.1646790253013;
        Tue, 08 Mar 2022 17:44:13 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t11-20020a4ae40b000000b0031cc933b418sm253018oov.40.2022.03.08.17.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 17:43:51 -0800 (PST)
Received: (nullmailer pid 1742460 invoked by uid 1000);
        Wed, 09 Mar 2022 01:43:47 -0000
Date:   Tue, 8 Mar 2022 18:43:47 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        alexandre.belloni@bootlin.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, lee.jones@linaro.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Message-ID: <20220309014347.GA1740998@robh.at.kernel.org>
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
 <20220307153656.177589-2-sergiu.moga@microchip.com>
 <1646701660.903645.3624793.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646701660.903645.3624793.nullmailer@robh.at.kernel.org>
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

On Mon, Mar 07, 2022 at 07:07:40PM -0600, Rob Herring wrote:
> On Mon, 07 Mar 2022 17:36:55 +0200, Sergiu Moga wrote:
> > Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> > format.
> > 
> > Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> > ---
> >  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
> >  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 43 insertions(+), 36 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1602300
> 
> 
> pwm@e1604000: compatible:0: 'microchip,sama7g5-pwm' is not one of ['atmel,at91sam9rl-pwm', 'atmel,sama5d3-pwm', 'atmel,sama5d2-pwm', 'microchip,sam9x60-pwm']
> 	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml
> 
> pwm@e1604000: compatible: ['microchip,sama7g5-pwm', 'atmel,sama5d2-pwm'] is too long
> 	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

Disregard, I see patch 2 addresses this.

Rob
