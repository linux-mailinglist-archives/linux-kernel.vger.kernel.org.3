Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED34FA733
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiDILWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiDILWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:22:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FDA1DA76
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:20:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35so7057789wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CXZpCuRpjFsOGJWVG8aQtynijWwxxpOqzYSjsnpBEwE=;
        b=wb4A+PvMto8K/V1tFkCorbwnL5D/LZ/WQiTQunbXxo/gob3CLfqPV1tQfeSt5xm/RZ
         2HR3bMKaogiUhf49lY5u0U7diPKgzQbzz9igVGbjywFcGcO+JKxHqLE7z/Mic1m4X/O+
         2eNcqGmZ7AVWNgVD2v/p9/texU1MC7f3BG+PM/tneJF2IaOKgKb+XOQmWlwOIabSkSzQ
         1gTS/5hagBjdRi+zSUE8QZKhpGikPMXlNc16j79vM+hvmEt52vTuub/rXP1V1vY1Fspk
         r8fppTLpOaOJv8QMgrrXoyuYtFQxN4InEDQp566Z50qbmgGrGuzsde2mUVl+yWGNgNvm
         b78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CXZpCuRpjFsOGJWVG8aQtynijWwxxpOqzYSjsnpBEwE=;
        b=uEByyKUv7FoOPl9rvrAyHS8nHo8X1oT0//VgobGbItaoGzUozy9hPM29dW+DB1R4lM
         7fjXqgCj7uJxVrJ9ccUi6CblL1pyORPLlJNBeyB8NPdpJXm0ON1pddf+oqL2IGHQllvT
         1Lma5YaJelCtTPQfEd0CtLBIuTRL/EPfKvjoht8gkhXRnVkjP51RHoraIrydpJ84ZXK/
         wgGP5JbkbT0lGR13VcTPmyWaNU+w+oXViNt76Zt+zUB4P062FbgqNxT8knfTiMMTzARM
         ePbbjjiUBHJlkf+KmbxJcWs0/L6X21/XUDhG7Tji4m0rSzv/6eXtKpyJdEFT7R/bp/zp
         Qy5w==
X-Gm-Message-State: AOAM532GY7YLO4QtKQiXp69BFz2A2U77Y+nKa9Ii4RSARYo+XzlycPNi
        nW8FiqcARoscu7OSlrQ5L1zQag==
X-Google-Smtp-Source: ABdhPJyah1d42gYPUuQagzdOo5ncl0A+hSil1ZDFDPb6sGvJWozu90Apb2wx8JDxtGa0jYQT2SZ3tw==
X-Received: by 2002:a7b:c190:0:b0:38e:7e47:744a with SMTP id y16-20020a7bc190000000b0038e7e47744amr7828455wmi.38.1649503210673;
        Sat, 09 Apr 2022 04:20:10 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id 61-20020adf8143000000b002061d8d807esm11857688wrm.87.2022.04.09.04.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 04:20:10 -0700 (PDT)
Message-ID: <a4f7d456-45d7-b461-6744-7c580ae94556@linaro.org>
Date:   Sat, 9 Apr 2022 13:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 15/18] MIPS: DTS: CI20: fix fixed regulators as reported
 by dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <f04ba92a958abe0051be7ce3202f6361cb0f05f2.1649443080.git.hns@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f04ba92a958abe0051be7ce3202f6361cb0f05f2.1649443080.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
> arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@0: 'anyOf' conditional failed, one must be fixed:
> 	'reg' is a required property
> 	'ranges' is a required property
> 	From schema: python/site-packages/dtschema/schemas/root-node.yaml
> arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@1: 'anyOf' conditional failed, one must be fixed:
> 	'reg' is a required property
> 	'ranges' is a required property
> 	From schema: python/site-packages/dtschema/schemas/root-node.yaml
> arch/mips/boot/dts/ingenic/ci20.dtb: /: fixedregulator@2: 'anyOf' conditional failed, one must be fixed:
> 	'reg' is a required property
> 	'ranges' is a required property
> 	From schema: python/site-packages/dtschema/schemas/root-node.yaml
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index cb5257d32b55e..c045c4f75895e 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -69,7 +69,7 @@ led3 {
>  		};
>  	};
>  
> -	eth0_power: fixedregulator@0 {
> +	eth0_power: eth3v3 {

No, Devicetree spec requires generic node name, so "regulator-0" is
appropriate. See also examples of device tree node names in the spec.
"eth3v3" is a specific one, not generic.


Best regards,
Krzysztof
