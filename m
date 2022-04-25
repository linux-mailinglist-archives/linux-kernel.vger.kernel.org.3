Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF250DF61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiDYLyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiDYLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:54:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EFD1BA;
        Mon, 25 Apr 2022 04:51:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q23so7575158wra.1;
        Mon, 25 Apr 2022 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9EscMvNq76GeUom/FtzlsqDl8sdOCj3rZo00CWoiuwA=;
        b=F7CeinsqS7wotCIbiDe0PSdED/m/nEhij5VdSZwAPlpQo/wUAA6kvkSFvCh1Sj7DoG
         I+Y/7wtJdsRBk/txmwJv+E+Jmm+RvsNoCjLEWMfZ6zj7g4L1DW0nQMZlFOK+vH9eE3zq
         PJP4gOEJ5i2+IuFKrf6eIJZTX0yRiYqn7rfAjkQF58tv3+sA2KEIRxqACfhrn5gXjgc2
         k3zdEaAuqNa2jxuwV3XYiLwM97lJ50Y6uUEYvTs+v/RjlVbOxHs3ND35GqFby9PFQU9g
         qNUJJ7URS8t+02Dh+OAf2PxXIXKq/oNOlq+B29sD6fa37eTGVJTR9pDnIw+Cl1yXMVRd
         lbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9EscMvNq76GeUom/FtzlsqDl8sdOCj3rZo00CWoiuwA=;
        b=Yd9Pj8S6jzE+SY1y1fWhMUj2rbmKMU9W9HycXt7OjtU7d5dlV5Y9DSfmN1UI3uq31t
         fC8M0jcoxVIsZXMwSEjB+n0zoyT1YLcqGTrF7wDy4h1caU76eXZQ3M8HiHPW1f+UHen5
         /e1vSrzkYUEcShL9vJzJwbdh4YMOk3T7Vm7evVB8mNDuUbHeXEYzGLIm6hhNhIOeeKkQ
         yauXNZFGcvnIUZmmxAZn9Hdn3SuZ5l6lo+9ipNxPDRjCXdCzArMEmJ9TQnTkkN5BM9pd
         A8d+BzxK7LolkUM7eUsYiqOII7sIwn2FyokX8Xz2qI560cbki+laHa4Jxt6NNWCgFOaG
         /bng==
X-Gm-Message-State: AOAM533e16/Dn7T2HAmX8l80WP5NxKpTcd1LVymryqeQhRWsaJOWjPIL
        tNtNubAh7zDGoyWitGalgXw=
X-Google-Smtp-Source: ABdhPJx5UVMEI7qk+X/GYHCw8s1oJwyJxDKu2qUGV9WU7GKqAoeY+izqW35kJFgowSEYipjDWNs+cA==
X-Received: by 2002:a5d:4a0a:0:b0:20a:c899:cb7b with SMTP id m10-20020a5d4a0a000000b0020ac899cb7bmr13446037wrq.618.1650887465776;
        Mon, 25 Apr 2022 04:51:05 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e5ca446bcsm11573603wmp.5.2022.04.25.04.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 04:51:05 -0700 (PDT)
Message-ID: <20650a35-5392-43fa-8b70-902eea860d92@gmail.com>
Date:   Mon, 25 Apr 2022 13:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 3/6] ARM: dts: add clock support for Airoha EN7523
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220314084409.84394-1-nbd@nbd.name>
 <20220314084409.84394-4-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220314084409.84394-4-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2022 09:44, Felix Fietkau wrote:
> This driver only registers fixed rate clocks, since the clocks are fully
> initialized by the boot loader and should not be changed later, according
> to Airoha.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Applied, thanks!

> ---
>   arch/arm/boot/dts/en7523.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
> index 36597f587f46..2e705b87b6c1 100644
> --- a/arch/arm/boot/dts/en7523.dtsi
> +++ b/arch/arm/boot/dts/en7523.dtsi
> @@ -3,6 +3,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/en7523-clk.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -83,6 +84,13 @@ L2_0: l2-cache0 {
>   		};
>   	};
>   
> +	scu: system-controller@1fa20000 {
> +		compatible = "airoha,en7523-scu";
> +		reg = <0x1fa20000 0x400>,
> +		      <0x1fb00000 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
>   	gic: interrupt-controller@9000000 {
>   		compatible = "arm,gic-v3";
>   		interrupt-controller;
