Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3845048BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiDQSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiDQSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:00:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7D1AF3A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:58:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so23473122ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nSubeHyIkbDyezCXTtI5pe5KWL/Nm+X5yHUcXHqauxY=;
        b=KmCxtqwiDxG8GCSszSnyyyohTIwtJgrR4dUoq6Pfw2NqgZdygFjyj52fymLpmFKQyV
         o1D/vivFHFxicCfzDfW2EdM5J1v7O0OsXJUF3UJhWq9NTWJDMwaCar9U4Yh6/o0wc+PI
         85xJa78Im2Lp7png/Ov+RZ3TQZdRvx1ByVbt1flSmuoYsi4//TUWig18ZBv/nqedKgm0
         heXVjbAGS90FAg9SFPZZMv4aBG/o+oHmzpswH931UpQXPd+Vt4h2ibwDESMDVYyjPN08
         o4X/bShbg7lG7u+Cv9wZrJf7GOwbQKFzT3aG9hxhfmd+ZRdEI0MY+PsbNoef/hz1LuP+
         +yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nSubeHyIkbDyezCXTtI5pe5KWL/Nm+X5yHUcXHqauxY=;
        b=QjNzAsxZzLDOkL7yYjNr+IdMnJC+SIbfcVnqk7kuvad1XvXqdAIYxJDBvp+wGilcKC
         ywq1MJxHgd6H0UUJ0ttDl9IBjjptFcDItXvzYtYLnVIQ6FfnbD4P0aoB9j2bJDwstKJm
         wsX7mOONz87xeHzov1u09MCCBaDU9a00KYair5c7IW0chmzuIzQac8iLu4j4ra5WqESg
         Tq0k6KtHZAW2Zcy4RP5xymeLw1bwO9BD1dew3W+yhKie//c9J1c1IbrDNxWXFHR+EEZW
         bHGLjDBTqr0vNdzcCKuR+HXBE/9Z+muSf+K9Bhs5ASEru81mxBJmvQyDbtPfOjbCxUTX
         ABsA==
X-Gm-Message-State: AOAM533eyV8vfOLq3eILnpJuOXHtEzIbNq4KCswcQ6+dDXOStBo1sjMN
        c9dZgAU3sjW6py2Eb/1siQKM5A==
X-Google-Smtp-Source: ABdhPJwn4RYMuzx1OPkO0KuwJKryizP0RNdSa0rqni5YB3lwpEj/clUpmf0tuoUU1d7TDzbh6UlCZg==
X-Received: by 2002:a17:906:c113:b0:6d7:7b53:9cb with SMTP id do19-20020a170906c11300b006d77b5309cbmr6634960ejc.197.1650218283093;
        Sun, 17 Apr 2022 10:58:03 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bf11-20020a0564021a4b00b00423e997a3ccsm80153edb.19.2022.04.17.10.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 10:58:02 -0700 (PDT)
Message-ID: <1cecb0c3-2925-765f-0654-37d5703b75b8@linaro.org>
Date:   Sun, 17 Apr 2022 19:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] ARM: dts: keystone: fix case in SPI NOR node
 compatible
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
 <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
 <20220415185439.4hsfnllhplfcpwvk@encrypt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220415185439.4hsfnllhplfcpwvk@encrypt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 20:54, Nishanth Menon wrote:
> 
> I have no idea how this works. There is no documentation for the
> compatible, So I am guessing adding it to Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml 
> is appropriate prior to replacing  with "micron,n25q128a11", "jedec,spi-nor";

Compatible is documented in jedec,spi-nor.yaml (through pattern),
although it should be followed by "jedec,spi-nor", according to schema.
I did not fix that missing compatible fallback, because I did not want
to break any setup (I cannot test it), but adding the fallback seems
harmless/safe.
> 
> $ git grep micron,n25q128a11 .
> arch/arm/boot/dts/imx6qdl-aristainetos.dtsi:            compatible = "micron,n25q128a11", "jedec,spi-nor";
> arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi:           compatible = "micron,n25q128a11", "jedec,spi-nor";
> arch/arm/boot/dts/keystone-k2e-evm.dts:         compatible = "micron,n25q128a11";
> arch/arm/boot/dts/keystone-k2hk-evm.dts:                compatible = "micron,n25q128a11";
> arch/arm/boot/dts/keystone-k2l-evm.dts:         compatible = "micron,n25q128a11";
> arch/powerpc/boot/dts/fsl/t1024qds.dts:                         compatible = "micron,n25q128a11", "jedec,spi-nor";  /* 16MB */
> arch/powerpc/boot/dts/fsl/t104xqds.dtsi:                                compatible = "micron,n25q128a11", "jedec,spi-nor";
> arch/powerpc/boot/dts/fsl/t208xqds.dtsi:                                compatible = "micron,n25q128a11", "jedec,spi-nor"; /* 16MB */
> 
> 


Best regards,
Krzysztof
