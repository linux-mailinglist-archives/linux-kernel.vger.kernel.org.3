Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128485462FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbiFJJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347512AbiFJJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:59:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE25B0417
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:59:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g25so5984944ejh.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gDHlNqBe4kROE4J7/F3QmWesLzxh4ZBvnILe171UGCs=;
        b=oDUOaXR7FzLMWZm3OxcWJ7MJl+lrNYx7qQfEIjW1VPEtcXwKo22y8LG3qxZERYh5D2
         1/6bktCkaRTFXhZRPn+Tr2xjLHk2tsGAHz227PSTLTEStq6e1c1EnxqsgfASf8KpXtOL
         ytT4IB96hjk9kQwUL0DYslPXSmrvavbvoAF1Aasp8dsm4RIq3Ofqr0TaG8jKkL6LZoVh
         HlxckmQQNlM1L/ErpqkpH83MwvKjpne9sdZWGkBHCzSl4/7ohRIBcMy9tzktRd7LIJSw
         2JXTjIkbSQqyAI9pB5aFcmeh+Wg5uXoi0GnkvRpd5dxQhHR8MuDnOSDfcYiOPFCbQNqo
         4jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gDHlNqBe4kROE4J7/F3QmWesLzxh4ZBvnILe171UGCs=;
        b=diGV6I2kmt/PHeo50XWzol7KukuQM6tXXGVGXO/dlMaeG6lpEMDjZEbro2A0BMuL3V
         JJKHvglu0LY1uRZaLBYHWEQHcUatR1ODbh8ibSyX3dfBhe7nXjVytIh2hTfzsgRPPMjA
         MjW0wplAb8FlQyucxuj+3r2VKG27ScSujes7KfQotm002dLy5FGIsBWksZZASSJ7xRF7
         4zeWhDHD9rBzFK+FXv+Og1JldCfISIwEgiwfRJkrinGL4bVKlbdiAkRoitKAgWhRw5GV
         x8mkGMXDHtgWiwjQX+znO/jOvpTs/BMPBNVMhCVbmjjV1ZvL+5Pmebr/RCdQDIb/EMzq
         s5bA==
X-Gm-Message-State: AOAM5311H6QVMjT95v0R8t7BTCVJf4vRTrFMLHuZjpIdRhqLZ3lJOwgY
        OVRDZRpO1iXi1cPko/Jt2GW+Ow==
X-Google-Smtp-Source: ABdhPJwhGh4TDi4lutZR0Redc77UMHZsElUmLjFEgzgCSTtr0oq2PlTyBwfzFCkOUwxt2ruFoM26kA==
X-Received: by 2002:a17:906:3087:b0:6f4:2901:608a with SMTP id 7-20020a170906308700b006f42901608amr40752732ejv.646.1654855189985;
        Fri, 10 Jun 2022 02:59:49 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b0043120d5f3dcsm11051751edb.14.2022.06.10.02.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:59:49 -0700 (PDT)
Message-ID: <2f386fc3-d496-62e3-20b0-ac962169e7a1@linaro.org>
Date:   Fri, 10 Jun 2022 11:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device
 tree
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomer Maimon <tmaimon77@gmail.com>
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
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-19-tmaimon77@gmail.com>
 <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
 <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
 <CAMuHMdU53RWvKXd0cPcPA8SiMA820stcpK4_UsTDGDAfByhcYg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdU53RWvKXd0cPcPA8SiMA820stcpK4_UsTDGDAfByhcYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 09:57, Geert Uytterhoeven wrote:
>>  "+             cpu0: cpu@0 {
>>  +                     device_type = "cpu";
>>  +                     compatible = "arm,cortex-a35";
>>  +                     clocks = <&clk NPCM8XX_CLK_CPU>;
>>  +                     reg = <0x0 0x0>;
>> Why do you have two address cells? A bit more complicated and not
>> necessary, I think."
>> the arm,cortex-a35 is 64 Bit this is why we use  #address-cells = <2>;
>> and therefore reg = <0x0 0x0>;
> 
> These addresses are not addresses on the main memory bus (which
> is indeed 64-bit), but on the logical CPU bus.
> Now, Documentation/devicetree/bindings/arm/cpus.yaml says you can
> have #address-cells = <2> if you have non-zero MPIDR_EL1 high bits.
> 

Thanks Tomer and Geert for explanation. OK for me.


Best regards,
Krzysztof
