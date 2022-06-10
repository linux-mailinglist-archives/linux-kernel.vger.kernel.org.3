Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C535462E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbiFJJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245663AbiFJJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:56:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC27E79
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:55:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so52458200ejq.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fYLaThkrJ3eihxzDkJJoKJeN/ruDQRHwWXWApkInkkA=;
        b=eZMqUcnQvs+mvcIh4RmsXSM85Xjm0GxOtCVFq5r1QIgnOUj23JAk0RZ5CYM8+YSH9k
         f7ybIkD+/HHywul6k2FzvEWj8SR1iNcawcxRgqCp0cNbU4FrnUEmDmQcF8mIN1ez667E
         Aq4VD6nD8UwxBRV1fjIp8o7Egebu8P+xxQbiBQVNMKHTSONgGjZXbTqn0H7tbZTVNHxh
         MKwzQOOe029LUFO69vjUIO1dhmMlLvtTbthq4qRZJLpmHPIDVsqIuKB7U89mdaZ2XW+M
         057kmVyPGLomjrI5VMUYNgMnHZu1WjHD/iavKMoSQ2Qa0UscSO6I4dJ3+/XBVFuWPtUf
         Yk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYLaThkrJ3eihxzDkJJoKJeN/ruDQRHwWXWApkInkkA=;
        b=SHhGbEkj1RJK2exh7lemkJMnR6CloTAOwwsWF6RsDzzGV2AnP98dP6a054QIYapI75
         xb8cjGgvPCarlQq4dDvYoXEucY/TqxOOKD4Z6+r98OsPd+zy46KTc/Be7uAcBNc7qYk9
         zgGzQchTUv5pfLzs5g0eSOeJ6Y6RevmWWJN+QBQxjkYBPAL7ap8mkU6KOIgek9Dc/X1E
         FGBMKzfURf8/YI6Gz97RQO6vb42HzzQ/NHR0EG80atVYI0WpoXpzM6mhu0EW6j8ppwZ+
         IdH5L1Qkjf2H3/ySTj22ngSbbgTpLYbUprK0o2MKtBHF/+1EbzSeUQZtZZkGWSarBFxn
         vhjw==
X-Gm-Message-State: AOAM533kJixsnRoWXfSxn7xpe4XeBpaMtob+L0s0F/kK2KbVVVgaiaFu
        /laIgWVnjjpvmp7gtgCR3HXPTA==
X-Google-Smtp-Source: ABdhPJx+Nk5zqg4CzsaQGTYi5O5u5pqYvXJFs635gcflemvPBdHWm+Lqwl+EZSP0zP++5Ct8WUneEQ==
X-Received: by 2002:a17:906:a06:b0:711:4f17:4391 with SMTP id w6-20020a1709060a0600b007114f174391mr28161039ejf.288.1654854956040;
        Fri, 10 Jun 2022 02:55:56 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zc10-20020a170906988a00b006fef0c7072esm12179646ejb.144.2022.06.10.02.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 02:55:55 -0700 (PDT)
Message-ID: <381ff739-e898-8812-d549-df7101f0eaa2@linaro.org>
Date:   Fri, 10 Jun 2022 11:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
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
 <20220608095623.22327-13-tmaimon77@gmail.com>
 <add025b6-c622-b204-d39e-67b31878d37f@linaro.org>
 <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iDbB+X5QPE4Nsqk4nV41bZiVzQZExS1pQTuKEBz-iYew@mail.gmail.com>
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

On 10/06/2022 00:05, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Sorry, but I thought the fix is only to add an explanation to the
> dt-binding file as was done in V2.
> 
> The NPCM8XX binding is done in the same way as the NPCM7XX and both
> use the same reset driver and use the same reset method in upstreamed
> NPCM reset driver.
> 
> Can you please explain again what you suggest to do?

If you want abstract IDs, they must be abstract, so not representing
hardware registers. Then they start at 1 and are incremented by 1.

Other option is to skip such IDs entirely and use register
offsets/addresses directly, like Arnd suggested in linked documents. I
think he expressed it clearly, so please read his answers which I linked
in previous discussion.

There is no single reason to store register addresses/values/offsets as
binding headers. These are not bindings.

Best regards,
Krzysztof
