Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22E53140C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiEWPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiEWPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:37:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132830579
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:37:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e4so17133229ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CNVGYK72FSE/DjXuo5FhnaPlB7gNCfpfmdbuSxUtMOc=;
        b=iau23czuiMXjm0hyqdsK5LqTD+cKYVfnaA9S+hQdET23Y0mX06Yvmm6kF7vXaHTfPy
         8//i31Rg+IIST3l9Sr0HyecMRQN5OqkZNKc8CS9yKXVH/8RbMhhmXeqzZSfepaj/zkwe
         ofB4tGj5QcepTEaNJQGL0uCSEQ2ADJPDbE222xkpnEOy/i6hOMC2Gogln7uIOXz1Z2Un
         eEdA7dxiMWE4KY6pnEhnPDqWZSOM1zSWeijmWVE9dewujOLdGsLSCspFY3jrwHLY5uJy
         G/qZz7B6FWs1eIB6vxDShca3e0arrF3KoP7sa7f+DQmKL7DLNfpzlnJHap6kywfaaz7X
         P+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CNVGYK72FSE/DjXuo5FhnaPlB7gNCfpfmdbuSxUtMOc=;
        b=VQkeuGYygKnLEVc8GCRcd2IvhoT7rAghVJxjWYejJbkW6CRR6bf7XFjSq1PnDaX6VJ
         9rdVeY1m0u1RLg75TM5S0hIRSVxCV1YO2AYwEBuyr3TXkz5ukSaeYyKPjuYgTwOtSlZ1
         vAJJ9tgsxINoI5PEyV0/gMLZY1IyiMnhdXzeAgSOnDf/YaVfo0hu+fUbykyOXe8YJO+K
         4DjI/fvGrK8O+2x4KGiXzKg2uFDnDIoLE7PezOtkWytowuwm/hzY6Uh6sqREVgNdVkWs
         xqsC9cHIw7rNp/O6Dm/rXEEZ0BryXC4+OPR0eGGyegSYGIohWm5TqNKCitairw5WDKjz
         ilcw==
X-Gm-Message-State: AOAM530MsjmPuXZkPaVj5c0Mz+8cyHGCFzZLShyxUex2oCMD4U8/bUPL
        ZK+I/Jfx5yczD3yEbpUIs2Cpkw==
X-Google-Smtp-Source: ABdhPJytSX0vw8XiyL0IPRTPz7bNI0Vb5IqxXheMy8cJ6OyJZo+/AZv6Os8PjXd8yRyNcZKkTN4sOg==
X-Received: by 2002:a05:651c:b06:b0:253:e51a:c507 with SMTP id b6-20020a05651c0b0600b00253e51ac507mr6361505ljr.420.1653320267494;
        Mon, 23 May 2022 08:37:47 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o14-20020a05651205ce00b0047255d211c2sm2036295lfo.241.2022.05.23.08.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:37:46 -0700 (PDT)
Message-ID: <fd52f328-c895-e27e-4807-eb0b8f14a247@linaro.org>
Date:   Mon, 23 May 2022 17:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 18/19] arm64: dts: nuvoton: Add initial NPCM845 EVB
 device tree
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
 <20220522155046.260146-19-tmaimon77@gmail.com>
 <CAK8P3a1LCkM-w_Oi2qUqgq_Qxsg64uoGg5aaz=X8pBENHBhj0A@mail.gmail.com>
 <CAP6Zq1j8PEQ2m7rG5YztesiOfXExCr=UMPFhD=Oe+GYDwGP95g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1j8PEQ2m7rG5YztesiOfXExCr=UMPFhD=Oe+GYDwGP95g@mail.gmail.com>
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

On 23/05/2022 16:17, Tomer Maimon wrote:
> Hi,
> 
> Thanks for your comments.
> 
> the patch will modify according to your comments and will be sent in the
> next kernel revision 5.19.rc1
> 

None of your emails reach lists because of using HTML. Please use
appropriate messaging format.

Best regards,
Krzysztof
