Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D76543ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiFHVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiFHVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:48:19 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C525CA;
        Wed,  8 Jun 2022 14:48:18 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id u2so16628017iln.2;
        Wed, 08 Jun 2022 14:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DSD6n7SqIRrkJflyY9v16h++03DHbVndZ5fsmVluVpY=;
        b=cwi3sgJVbGK5/a5yofj5IsJ0chGPUaZLjhDM9HLBsEAhYnt1ndpzS+0o7+wsETEDN8
         oaVtaa4KJP99yw/CIs5x/suLSHclZDmyGBqol1FTgXtS38VKiZkcdLFdkh+5mpQCU1Jd
         xY6Qn3W9yu+IAUM3k9ADqCpyPNRdPAHOf0ISxzN3UbMdI/FkBZT4uD3cBj5Wi4a1eGMX
         CI0S4tHkkELzjmE86VE/cnqPDOb7R7W7r4K5C/6YAOHsbVhs6Xey+jSApsV45boTRVyq
         kd18McEtcDogVhLONQQXLFSMag3DBKFzr7dT/YCZE+Bpq0xZa/muRvoS8aPwSOnT509T
         W04A==
X-Gm-Message-State: AOAM5333j6Rbz6E7rciuTDZgOzPkprql6GMRWvOzNEACvA9dMbagyaYP
        opmmhPDwGvAQJVRVCWnz4w==
X-Google-Smtp-Source: ABdhPJy/TjtIFK2XNa8YJamLmJFJcs1T73KDNKNmv3NgKRZb8+6pL7BKf2zfXN3uean8c2Mkm38reQ==
X-Received: by 2002:a05:6e02:1c22:b0:2d1:abab:8806 with SMTP id m2-20020a056e021c2200b002d1abab8806mr19448897ilh.300.1654724897688;
        Wed, 08 Jun 2022 14:48:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k29-20020a02661d000000b0032ead96ee5csm8452867jac.165.2022.06.08.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:48:17 -0700 (PDT)
Received: (nullmailer pid 2134383 invoked by uid 1000);
        Wed, 08 Jun 2022 21:48:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        venture@google.com, marcel.ziswiler@toradex.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, p.zabel@pengutronix.de,
        bjorn.andersson@linaro.org, olof@lixom.net,
        benjaminfair@google.com, biju.das.jz@bp.renesas.com,
        linux-serial@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        j.neuschaefer@gmx.net, will@kernel.org, lkundrak@v3.sk,
        yuenn@google.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        geert+renesas@glider.be, linux-watchdog@vger.kernel.org,
        gregkh@linuxfoundation.org, sboyd@kernel.org, jirislaby@kernel.org,
        vkoul@kernel.org, robert.hancock@calian.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, arnd@arndb.de,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        avifishman70@gmail.com, joel@jms.id.au, tali.perry1@gmail.com,
        tglx@linutronix.de
In-Reply-To: <20220608095623.22327-10-tmaimon77@gmail.com>
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-10-tmaimon77@gmail.com>
Subject: Re: [PATCH v2 09/20] dt-bindings: reset: npcm: add GCR syscon property
Date:   Wed, 08 Jun 2022 15:48:06 -0600
Message-Id: <1654724886.806854.2134382.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 12:56:12 +0300, Tomer Maimon wrote:
> Describe syscon property that handles general
> control registers(GCR) in Nuvoton BMC NPCM
> reset driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,npcm-reset.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


rstc@f0801000: 'nuvoton,sysgcr' is a required property
	arch/arm/boot/dts/nuvoton-npcm730-gbs.dtb
	arch/arm/boot/dts/nuvoton-npcm730-gsj.dtb
	arch/arm/boot/dts/nuvoton-npcm730-kudo.dtb
	arch/arm/boot/dts/nuvoton-npcm750-evb.dtb
	arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dtb

