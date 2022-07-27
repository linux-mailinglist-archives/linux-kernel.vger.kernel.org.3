Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB358298B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiG0PXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiG0PXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:23:41 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AD46D9C;
        Wed, 27 Jul 2022 08:23:41 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id f8so780029ils.13;
        Wed, 27 Jul 2022 08:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z5vpqZfmFKwVrz9tfkSeyBo2CWCpn59/Ud7Jqj6aBSo=;
        b=69wpzKAF8NxsdRTN2v59i5fLz9BzWm3UxJcTDNrHavHwSRcjUkqQtDC+/bUCfOInzS
         jEuk5uKz9WGfdVLs/Ws3Ot9xNYJuuIngyyVRI5uHjooss8LyRnNpXH8rNZktL+rRLvgV
         btiXBsS+j2pVsY3piQ3sYxOL7M2bhJSJx2g6+TW4D0NuHnDJhB2fo7zxsSPz13sFwcWC
         BLUraUFFxaXvnYkuPvnr8mgh2BB9Szjt8bfpv/TVwRNXJM9d2lG7IGEAUQw1ddlA9yEg
         ZF4GH/PiRMao4QQykvql5YeGaxEbko88Okv1f5D64xhsRkLg7UnGimYCzFkCv06KYfcU
         umMg==
X-Gm-Message-State: AJIora8iXcLna1qLTdHNTzrhrjsHRBjbqrYhBiyVEzCeTtVOsylTcbtc
        2DpToQAzfEm8YhvCdCP0fg==
X-Google-Smtp-Source: AGRyM1up1oPDnQEY9tNohSqCcyJOjFy1DCKFfz/b2rGCtlJVjvqTI93Dp4hC6w8f3DmUzFX2ZvN2pA==
X-Received: by 2002:a05:6e02:1c8d:b0:2dc:8162:282e with SMTP id w13-20020a056e021c8d00b002dc8162282emr8837058ill.5.1658935420412;
        Wed, 27 Jul 2022 08:23:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v5-20020a056e0213c500b002dce9ddcb08sm61488ilj.30.2022.07.27.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:23:39 -0700 (PDT)
Received: (nullmailer pid 2696011 invoked by uid 1000);
        Wed, 27 Jul 2022 15:23:38 -0000
Date:   Wed, 27 Jul 2022 09:23:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Atul Khare <atulkhare@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: sifive: add gpio-line-names
Message-ID: <20220727152338.GA2695979-robh@kernel.org>
References: <20220726170725.3245278-1-mail@conchuod.ie>
 <20220726170725.3245278-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726170725.3245278-3-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 18:07:26 +0100, Conor Dooley wrote:
> From: Atul Khare <atulkhare@rivosinc.com>
> 
> Fix device tree schema validation messages like 'gpio-line-names'
> does not match any of the regexes: 'pinctrl-[0-9]+' From schema: ...
> sifive,gpio.yaml'.
> 
> The bindings were missing the gpio-line-names element, which was
> causing the dt-schema checker to trip-up.
> 
> Signed-off-by: Atul Khare <atulkhare@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
