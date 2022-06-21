Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11E5534B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiFUOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351344AbiFUOjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:39:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE224F3C;
        Tue, 21 Jun 2022 07:39:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w6so6125450pfw.5;
        Tue, 21 Jun 2022 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B3jkGZmyYe5YTvNOcCYwotjMONtKG1bLgc+a9HS4wM4=;
        b=HGEZK+RsjqtMuR/gMbFIRx8Oi5XKzWx+c5S5C8AsZJgbaE2iqGIodX8r1y2pCa6PLZ
         6tKO6deQ34s8LrzXhEumFzAkyyNL/thYf1U0jovp2cGEuOENMhFuY9xHQFUMCveF+Tiu
         T2SzXklrAnU87L+GAzyTMRi/BxowIHw2QTBq/Nvh/CRK2z6iOeF/hk47QG082iwb/KYg
         K5KnYfucYHCWVmSmjepnuD3Hn8q0dMqZiEzxz7Kqp0irLMlprtGsbIfs3bUSltLcq+uN
         5RuY30Lt235VNqB5bKc8cR6QUqIhgrQs+BvaSC70vPctZ4Z+6OKPwHbht+Z1gtptmF0y
         hXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B3jkGZmyYe5YTvNOcCYwotjMONtKG1bLgc+a9HS4wM4=;
        b=HtXdamPojpIAX/ELiHJZ1mHn6Majov44DhXVCG1eq7lFpQET/Kvlpt746BJn4j2wxq
         FiJm7QkXcYoo9mF5nr9rUFzKwKYXGWSHZa2/Iko530zp2oZpUB0V2Ml8JOazDFxFvAhp
         vc6Lw25Qyn8WbE3b/2A3PHuxPAeAcs/7Kwp7vChD8OP9RLhpRRfjVI+k2W1mHzMfBH0w
         OHJbaG0BdePbJhxX06nXbmkWuVZWPQQwlzEtya3Xr2NfzCF/6QA38jblnI5oYau88er9
         hVMyOdIjTq6gUClGq+j7KlLb5o209k2Dc/MajsLUVHCbUi0XL+h/YEddyry8Olypy2yU
         Yaow==
X-Gm-Message-State: AJIora/EsJGqrX1np92H0ySMDcNxStEcXFBdApgT78pNIibaO/3BHdhv
        RWjsenk3W5uvOaTBdzoScEU=
X-Google-Smtp-Source: AGRyM1v+pmMMh1utCCrDbNZeJJtA0McVOhRstARshwPejkn3gsWR4071Z3vyVnWDb20Gj/Pk9UyrzQ==
X-Received: by 2002:a05:6a00:2285:b0:525:387b:469c with SMTP id f5-20020a056a00228500b00525387b469cmr2731678pfe.62.1655822387169;
        Tue, 21 Jun 2022 07:39:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b00518424f8922sm11438750pfi.77.2022.06.21.07.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 07:39:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e597b6fd-e54e-6689-ffaf-8f7d9c14a1d5@roeck-us.net>
Date:   Tue, 21 Jun 2022 07:39:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 04/18] dt-bindings: watchdog: npcm: Add npcm845
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220621131424.162355-1-tmaimon77@gmail.com>
 <20220621131424.162355-5-tmaimon77@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220621131424.162355-5-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 06:14, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 watchdog.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Not sure what the plan is here. For the time being, I'll assume
that all patches will be included in a single pull request and
not be submitted through maintainer trees.

Guenter

> ---
>   .../devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt          | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> index 9059f54dc023..866a958b8a2b 100644
> --- a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> @@ -6,7 +6,8 @@ expiry.
>   
>   Required properties:
>   - compatible      : "nuvoton,npcm750-wdt" for NPCM750 (Poleg), or
> -                    "nuvoton,wpcm450-wdt" for WPCM450 (Hermon).
> +                    "nuvoton,wpcm450-wdt" for WPCM450 (Hermon), or
> +                    "nuvoton,npcm845-wdt" for NPCM845 (Arbel).
>   - reg             : Offset and length of the register set for the device.
>   - interrupts      : Contain the timer interrupt with flags for
>                       falling edge.

