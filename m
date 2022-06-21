Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5778A55366D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbiFUPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353223AbiFUPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:41:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DF2C675
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:41:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw20so6017847ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RMRIR+HgYGPk4kqlGjQLW42tNRD3LRift0BoWoXmUl4=;
        b=PJhWavQQw1jz0WHXyX0ZMJ8eR94uUvT1OrTkOanzF8eCB9cRoiHlLFkzlXwgvLP1n3
         V+w0eQKQSencR01efMvM+CLx2hpLOKijSklYzMrRkzLvX77UTUutFGU6uJfiZB1pc98e
         VgYJdmbvnx1PUtVmTp+5NFI05o1TbHCDlbCQjnkikoTILqTKd6MV8Ho+yBGn8ZPN8hEJ
         sCMUvZdkn9wipxnotVkWIriVN5jdQ2mYy29rx649+igSQ202WUBmFIWDarvr2HGs4tJm
         xwmC6Jif32cg5AO1lfdsSE8Kh6DFfzyaj9s8iJixRwkpwtevMnkmSpC2/G3dP/aFLb1B
         NT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RMRIR+HgYGPk4kqlGjQLW42tNRD3LRift0BoWoXmUl4=;
        b=cOP5pG/y/vQ/HDo53kG8k+Z6eMDa7x5j+7QU5bIGSsBafsIMx46oL3MhHuVYI27SJ7
         /dVqk1j0D/8TjLjJ6zrFJXEuOTasvsZayajJr5uBq0AQfNJAcn7JDnBnQAmMRcznmumA
         UGFWzNI5cX5YiyFCtA8FQ2z56MNEnus1z7znGKTq6i4OZdrDMaclsBuZYzAq/GMyTl4U
         +vqf60id+gyy0uu+S9bsgjglkq7Wi0rQjxo5lt35dHcLCHDKWBMkAin2LvtAQyB80Zvq
         8AqaUbLLrIKLJvIc48+u4jCqnngnVEWO1k4hG4JohgQqnY+MVc14LOOy6RMmoNGdmaMA
         cQjA==
X-Gm-Message-State: AJIora+asWqU/zsYB9H3UrimisG2U2wMbXrYVzwN/3Ul4XvtYhBkjPh/
        725zsepn7Wy8vhl/8y2NfjCxww==
X-Google-Smtp-Source: AGRyM1ukaYxWxV49I7X4K/AxawnLaQ11uVqfavd6zhGXdlYd80VACHz45P5IFtZP8yM2ASJC8c4z9Q==
X-Received: by 2002:a17:907:3f97:b0:711:d61d:df9 with SMTP id hr23-20020a1709073f9700b00711d61d0df9mr26593417ejc.644.1655826109691;
        Tue, 21 Jun 2022 08:41:49 -0700 (PDT)
Received: from [192.168.0.221] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b004357738e04esm6977188edw.21.2022.06.21.08.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 08:41:49 -0700 (PDT)
Message-ID: <b1472a38-75e5-9711-3e25-7ca9a74109e2@linaro.org>
Date:   Tue, 21 Jun 2022 17:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 07/18] dt-bindings: reset: npcm: add GCR syscon
 property
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621131424.162355-1-tmaimon77@gmail.com>
 <20220621131424.162355-8-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621131424.162355-8-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 15:14, Tomer Maimon wrote:
> Describe syscon property that handles general control registers (GCR) in
> Nuvoton BMC NPCM reset driver.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/reset/nuvoton,npcm750-reset.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
