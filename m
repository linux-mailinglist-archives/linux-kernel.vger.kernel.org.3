Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD73530A85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiEWHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEWHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:39:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC431A80F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:39:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s5so16141817ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2o0hO8VxGZyOj9xdhEYgL8kZWVgpy5fzSg0aJgogftY=;
        b=oTlafLq1Et1sqIk16m6DA+jCJFRlO1codjbSN1yIOqPNsC/hH97jn05NIguWsQsgDv
         MWeWoI2vv9UbV3FkkFH8LRfKOud/5OOHhGZzSyiaRoZ4yq9pf4d9XglXpLwtFhbwxx3h
         l/MntMA7PuEhdGnWm9xpPY0CELq4x2ndZJmpM6TyRaFCPZ/8baO/9gBuYiHVSGFPS1jm
         b3KtJKIKCIsC+aHkFf8PcAu100fKNg2B8/yOoC4Ot+GFOGJuZroHrRLSGC770sv8mRIp
         QTGJT7iEIsDef/Fmtvyt1PfVDHLqAtEk7gs9OuxZND4nvEsGXsjKCbb7lWb0Matyrg/4
         l6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2o0hO8VxGZyOj9xdhEYgL8kZWVgpy5fzSg0aJgogftY=;
        b=XYElPox5qasVylZoX67jX6baPplDfOrUYimRpQE3/fQrqKwtZNP2QpjDF8gx3/dOzo
         zeMOASM9Y6KTg+XSB8JbZWYoWBrcNAN9slxktJtHipbZpcbQUN98xNLzb/Z2V5QsidAk
         lvoXWwDjRo2u4mgzcN0Aiy69bgPbL8y4Y3Of45r7PBm2mMwElbW2vfx+2Z5/pFy/o2At
         RYqGVfI9atV28I92pMrpw0a6rxrIWUpG9EYelJzvKaTfwe6F5q1cxSxLS9j5fO5Dbq23
         3QbKLTq4r8k6HBJVZ6T58z56k0qczBmvGBxq5dZg0WG8fpzbjjKf3yBR8EQ9pnCiaf9C
         t/nQ==
X-Gm-Message-State: AOAM531ft194lSxjvlycY35In2kfio0MrcJ6yk03VNczDv15vtTKengb
        zbWkx1YT0E/GuR/MvuB6lWj7Dg==
X-Google-Smtp-Source: ABdhPJwtbBM2Rwibao4fT7vqqa0BZadmJT0isYqGRbFlzHrWoKbx1K2YaXeJwobANdpRy17mjiYuzA==
X-Received: by 2002:a2e:9e41:0:b0:253:c37c:378b with SMTP id g1-20020a2e9e41000000b00253c37c378bmr12383846ljk.202.1653291551361;
        Mon, 23 May 2022 00:39:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e8545000000b0024f3d1dae7csm1656531ljj.4.2022.05.23.00.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:39:10 -0700 (PDT)
Message-ID: <d02b042c-7f6e-8d2b-a5eb-c7ac4a0eea7d@linaro.org>
Date:   Mon, 23 May 2022 09:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 09/19] dt-bindings: reset: add syscon property
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-10-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-10-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Describe syscon property that handles GCR registers
> in Nuvoton BMC NPCM reset driver.

Please wrap according to Linux standards:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> index 17b7a6a43a29..cb1613092ee7 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
>  - reg : specifies physical base address and size of the register.
>  - #reset-cells: must be set to 2
> +- syscon: a phandle to access GCR registers.

syscon is not a generic property, so vendor prefix and some descriptive
name of property.

>  
>  Optional property:
>  - nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
> @@ -16,6 +17,7 @@ Example:
>  		compatible = "nuvoton,npcm750-reset";
>  		reg = <0xf0801000 0x70>;
>  		#reset-cells = <2>;
> +		syscon = <&gcr>;
>  		nuvoton,sw-reset-number = <2>;
>  	};
>  


Best regards,
Krzysztof
