Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285504DCBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiCQQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiCQQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:56:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8C18FAE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:55:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x15so8166369wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=i/Fk6gDMt/Grt4NJkS0bE/RE15fansbwCg4R3aEXH2U=;
        b=ozNezHAQFm92bl3PCurfC7T22hhihc8I0s6w6D+NJXW8UBmlb9DBHUe3VmtcPvU95J
         lPa7l6QL2qa7i7CyKyRW4CtaGJnJr8rZ54Ptk7RwizCnoehZakTY7XlK2Lu51SEzg+YB
         vgCEI2W8MwBol81BtpywAtivFLGxRLRAj7/8scHDG7WGnMeNvYfkAp5yFTMzvqkOkHfI
         ZdpqCYINy33Y6PnSVOmzkPCduhiESww8VzMJsrDRCh8DkkCm5MWTSkVRQnQY5EX+kwn+
         MgIr7V+c5el1XET1TCWAMv8rc6nmnMmLad5KunbZC/WZT/EYkqOylQCQVhxngtxl+qZS
         qVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=i/Fk6gDMt/Grt4NJkS0bE/RE15fansbwCg4R3aEXH2U=;
        b=wuc1Q48IzONvurOB3r369ByAWHufJV2LYQuqPVUtUzmGWUi2cbAGgcfNVlJP8gBlsz
         nIbKO52fCL7Sbs1s2C8PTFnvS0d+aMYv6BrO7f5oP8tuPu2zoMKSn7dUfoY9WifalgKf
         gj6oSyUXdxPbGVFJHn4VyuUo+Fkt6qYFb4LN7MS/SfznTWifnszZYTR5mghMih/xze6/
         omwdX0J9qIbZMF3hiPLHBNSfGRRrGVkWp/SJz6dyVWgTuVwurxYNOSCQZYNosZzeFKZH
         B+pZ6d3TW78hpIh0vFopTY/Bm2A4yeKY8A3mktJD/2EUF9mQtsBo25hzSx4cqTISA6UT
         b0yg==
X-Gm-Message-State: AOAM532qq33GfyQ/3zoIwFbZspI0WjBlPrdzg288K+jfPnXm2gm386I8
        gOPWxODJ91mst3vNqnNb274gGQ==
X-Google-Smtp-Source: ABdhPJyYXDlB/d2tNDCbE6c7hp/FisGGzgGoDAWIvPNSuQV9sLYz7rl6/nmd1ugHlhB3s8zaSQ2/lQ==
X-Received: by 2002:a5d:64e5:0:b0:1fb:5b9a:1a20 with SMTP id g5-20020a5d64e5000000b001fb5b9a1a20mr4810404wri.34.1647536129056;
        Thu, 17 Mar 2022 09:55:29 -0700 (PDT)
Received: from [192.168.1.10] (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d4ecf000000b00203de8012f5sm4319852wrv.16.2022.03.17.09.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 09:55:28 -0700 (PDT)
Message-ID: <d53764bd-8b49-37eb-c393-1317180979d1@baylibre.com>
Date:   Thu, 17 Mar 2022 17:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/18] ARM: dts: ox820: align interrupt controller node
 name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
 <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 12:56, Krzysztof Kozlowski wrote:
> Fixes dtbs_check warnings like:
> 
>    gic@1000: $nodename:0: 'gic@1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   arch/arm/boot/dts/ox820.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
> index 90846a7655b4..dde4364892bf 100644
> --- a/arch/arm/boot/dts/ox820.dtsi
> +++ b/arch/arm/boot/dts/ox820.dtsi
> @@ -287,7 +287,7 @@ local-timer@600 {
>   				clocks = <&armclk>;
>   			};
>   
> -			gic: gic@1000 {
> +			gic: interrupt-controller@1000 {
>   				compatible = "arm,arm11mp-gic";
>   				interrupt-controller;
>   				#interrupt-cells = <3>;

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
