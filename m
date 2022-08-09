Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FC58E076
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiHITsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiHITrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:47:49 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9541517A88;
        Tue,  9 Aug 2022 12:47:47 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id h138so10435402iof.12;
        Tue, 09 Aug 2022 12:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k4UmaRvRZxWq4o+Yspru8OrOEwdOORLs/XhcJE2LcmE=;
        b=i7uR/89jJpgYHFV6gHO6aJrq7B0Q4L5AEXCwj90d1/03PdaLNOZu9NbqxC1BwTXHmU
         XDKmoivGwX92m05+wSDg4vy3EbO8WiIZAHSWaaUuc7EP6x5WtMVHFTVy5I6nbviBo4eG
         fw+zoom+DlHl5xkcWdCqgsT9Fq+g+XlHqBSWK/KXco8RTjEr8Kp9PTVTOBTkjuZe5Pw1
         jAlCzvGUkBJQ6yiglXffOdPiJW6gU834WIMragRju7txmNjjUDiF447HFqbHvB8f0DEK
         3uTTCUR+EH9PYcZYKd9F6zvTqTdXd88frGTx5Bo4lKS/UHEItVPkVhkuG/z2WccDJ2lg
         Abeg==
X-Gm-Message-State: ACgBeo2STXCGo5kwx6u7a0fqKlVEPuDBfIPCiAzjKIpaxrQ2ZRKTLMZE
        QuYzOs71KZ4vHqtOpxOIuA==
X-Google-Smtp-Source: AA6agR7fG1uhYXOmBJYv5wsJOKXjgKp41AG88l0opsqFJjhGJlNG6iL6q3oTW8sl2117x5aUUcG7/A==
X-Received: by 2002:a05:6638:16cf:b0:341:4543:b354 with SMTP id g15-20020a05663816cf00b003414543b354mr11803265jat.114.1660074466471;
        Tue, 09 Aug 2022 12:47:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h11-20020a92d08b000000b002de7ceafb4esm1386103ilh.20.2022.08.09.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:47:46 -0700 (PDT)
Received: (nullmailer pid 2274578 invoked by uid 1000);
        Tue, 09 Aug 2022 19:47:43 -0000
Date:   Tue, 9 Aug 2022 13:47:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     khilman@baylibre.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, nm@ti.com,
        lee.jones@linaro.org, linux-input@vger.kernel.org,
        msp@baylibre.com, devicetree@vger.kernel.org, j-keerthy@ti.com,
        broonie@kernel.org, narmstrong@baylibre.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, kristo@kernel.org
Subject: Re: [PATCH v3 04/10] regulator: dt-bindings: Add TI TPS65219 PMIC
 bindings
Message-ID: <20220809194743.GA2274545-robh@kernel.org>
References: <20220805121852.21254-1-jneanne@baylibre.com>
 <20220805121852.21254-5-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805121852.21254-5-jneanne@baylibre.com>
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

On Fri, 05 Aug 2022 14:18:46 +0200, Jerome Neanne wrote:
> Add TPS65219 PMIC bindings using json-schema.
> 
> Describe required properties and regname-supply.
> regname-supply is required when bypass mode is used for a regulator.
> Describes regulator topology.
> Interrupts support.
> Add a power-button property to configure the EN/PB/VSENSE pin as a
> powerbutton:
> 
> TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either:
> - EN in which case it functions as an enable pin.
> - VSENSE which compares the voltages and triggers an automatic
> on/off request.
> - PB in which case it can be configured to trigger an interrupt
> to the SoC.
> ti,power-button reflects the last one of those options
> where the board has a button wired to the pin and triggers
> an interrupt on pressing it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  .../bindings/regulator/ti,tps65219.yaml       | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
