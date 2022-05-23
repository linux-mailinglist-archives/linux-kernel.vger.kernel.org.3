Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF0D530FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiEWNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiEWNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:07:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A849C87
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:06:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s5so17110743ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=50wuqx97QXZx2zbLRPpUZaCAf982O497zw+lzOUq1k4=;
        b=SDuGMgEXCGQ1TJ0fNHdXQPIRrrbTcF5QRnV15Th8wlnm6ALDsCXQkDhSc30CAXl9Kp
         lUcwwo8YPG+ToK1ghL+xsLwZPbKsU3Xs5fTm4yRb1VvjTdISvp+ik2qXsRARg60MQYWC
         GzqnvLsPLHQQ9m8qRk3NoJy44Um8tv0iazTe+dReBMGQpIWhXgY7sW+X5Q92sAdYY4Up
         yPMCEKh8i9Ozg5XgOdN0UxNO4J+QgBEZh3/Z8fVZf4cnzrU5tlx9D2h6JrtHwCIXtkCT
         BYpUW9KmlugPMvChcIWuNOw5mvQnQfIPUm4rq/I+cIqgIavTpZd0JMU/RlcgqLJUgwvk
         OYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=50wuqx97QXZx2zbLRPpUZaCAf982O497zw+lzOUq1k4=;
        b=RcSQdzOnJri1WMWWbrikuYmAyl7U5skAmkrJ/u4IdsLd3CHlCWBhwH4TL2NiWCmBH1
         IC9eq+/OF4FgSuH7fT+gHbAx3MHPh4EGG+FnYK6mGjNyo/Sl7pIjEWunaQ2Xwgwm7+pK
         7l6a1l282XlDqx0LpEv0+bblPJd+5DtPm8s5nzdlgwmLPGM4CpFGEabFurI7X93+Qmgs
         lHQ1HGOzXrOMFC6NOwJ16JExCHpd1no5EjfCoslTFAFS4tMeBS30bhBgE8EEvpASdSLD
         flThrpPAislRwHMOJbclN5/Y7AGuaLrlqIzjwR0mlKBb0tk58IoGDbBUVpiU3tPAhOhW
         lAvg==
X-Gm-Message-State: AOAM530hTa5aAVA/x3dTe5a1zaFrQR9+tHc3nnKTU2vnQ5D58WOmjja8
        IjhU6xE3yCBRf08GRCwoQVKSUQ==
X-Google-Smtp-Source: ABdhPJxW/DBrlG7TEnvWEUg0Nipmvi6wS+g8Y+NMEBmjLhpKfeu4xjRK3q520VX+9jaURA7ei9otVw==
X-Received: by 2002:a2e:a26d:0:b0:253:d7b4:1d9a with SMTP id k13-20020a2ea26d000000b00253d7b41d9amr11639775ljm.203.1653311215543;
        Mon, 23 May 2022 06:06:55 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020ac24146000000b00477b0cfc990sm1968975lfi.30.2022.05.23.06.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:06:55 -0700 (PDT)
Message-ID: <2ccfbfa8-be11-50ed-66ca-3476cbddb320@linaro.org>
Date:   Mon, 23 May 2022 15:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 04/19] tty: serial: 8250: Add NPCM845 UART support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        robert.hancock@calian.com,
        nathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-5-tmaimon77@gmail.com>
 <CAK8P3a0Nh4m7O_WPe1DTWqwWU32C5khOPH0ir7r_=s106mLv5A@mail.gmail.com>
 <CAP6Zq1jk=wf3VbxttrHZwS-wywMoO4upgMQH4yr2AeKwYV8G4Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1jk=wf3VbxttrHZwS-wywMoO4upgMQH4yr2AeKwYV8G4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 14:58, Tomer Maimon wrote:
> Hi Arnd,
> 
> Thanks for your comment.
> 
> On Mon, 23 May 2022 at 14:48, Arnd Bergmann <arnd@arndb.de
> <mailto:arnd@arndb.de>> wrote:
> 
>     On Sun, May 22, 2022 at 5:50 PM Tomer Maimon <tmaimon77@gmail.com
>     <mailto:tmaimon77@gmail.com>> wrote:
>     > +++ b/drivers/tty/serial/8250/8250_of.c
>     > @@ -333,6 +333,7 @@ static const struct of_device_id
>     of_platform_serial_table[] = {
>     >         { .compatible = "ti,da830-uart", .data = (void
>     *)PORT_DA830, },
>     >         { .compatible = "nuvoton,wpcm450-uart", .data = (void
>     *)PORT_NPCM, },
>     >         { .compatible = "nuvoton,npcm750-uart", .data = (void
>     *)PORT_NPCM, },
>     > +       { .compatible = "nuvoton,npcm845-uart", .data = (void
>     *)PORT_NPCM, },
>     >         { /* end of list */ },
> 
>     If these are compatible devices, it's usually easier to claim
>     compatibility with both the specific chip and the older model
>     as a fallback, to avoid driver changes. This seems to apply to
>     the timer and watchdog devices as well.
> 
> Just to make sure, Do you mean claim in the device tree?
> like
> 
> compatible = "nuvoton,npcm845-timer", "nuvoton,npcm-timer";

compatible = "nuvoton,npcm845-timer", "nuvoton,npcm750-timer"";


Best regards,
Krzysztof
