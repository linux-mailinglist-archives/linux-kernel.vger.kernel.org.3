Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A754C17DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiBWP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBWP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:57:10 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F912BFE;
        Wed, 23 Feb 2022 07:56:42 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so22844817oob.8;
        Wed, 23 Feb 2022 07:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3Vba8z4dbCmRqhhRSkGlmEC3D9t0b+3WQ7/W8fH8vI=;
        b=G3I76obmSowIp6JjmptqQGi0ZkdSweAcyFeF6MkKVS2+ifhaRlL6BJGEBJTDA0ZILl
         Ff6DmCPSwegAwNUAdpMFstdXsQfK3IbSxuE+jtJLh2Grz5efgS7zV1E1R1dL1EQW6oJQ
         BSmj0uLeB6d4rEYdRma5ta+ZakHXX8jCALXrmF3oNBSfaZ0tlH8UiqNecRAoc/ESXghG
         6yEwKVf0BrLgXVOIV5Z/oj4knpJVsHH0tYCl1ZlbQ01g9taBbBakoHU22OOncvIyFV8T
         xn8TDMom9bWrP8vni75KXfi3FhiTo1rpDLF2oo0SZPPTD5tEFRCia1qRxRzO0X8bdXO8
         yu1g==
X-Gm-Message-State: AOAM530LwcBsPla0+gCkgJKJ1Hc5MfIsP8rl2GSHtM/qMCooLoczniQ9
        o+gyTA/UF6bMHnhT4kS7UA==
X-Google-Smtp-Source: ABdhPJxnG7GzhAGSVs+w+1VXDBMsrEaRjsAytstqwvHnobowOfPivb0uvq9nZ24DlRxjqw8LCWzqOQ==
X-Received: by 2002:a05:6870:56a6:b0:ce:c0c9:69c with SMTP id p38-20020a05687056a600b000cec0c9069cmr4148025oao.238.1645631801528;
        Wed, 23 Feb 2022 07:56:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e20sm3264689oiy.30.2022.02.23.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 07:56:40 -0800 (PST)
Received: (nullmailer pid 1003410 invoked by uid 1000);
        Wed, 23 Feb 2022 15:56:39 -0000
Date:   Wed, 23 Feb 2022 09:56:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, masneyb@onstation.org,
        sean.anderson@seco.com, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-pwm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org, krzk@kernel.org,
        sboyd@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Document clk based PWM
 controller
Message-ID: <YhZZNxMC8NAbnQxX@robh.at.kernel.org>
References: <20220220115030.23772-1-nikita@trvn.ru>
 <20220220115030.23772-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220115030.23772-2-nikita@trvn.ru>
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

On Sun, 20 Feb 2022 16:50:29 +0500, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> Changes in v2:
>  - fix the file name.
> Changes in v4:
>  - Use generic node name in the dt bindings example.
> Changes in v5:
>  - make compatible required
> ---
>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
