Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4E564F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGDIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiGDIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:06:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B931AE7B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:06:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b23so10100337ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W9vEcsuPOmb6PFD1YP9Cd5t2i8+H7vKDdbGELGM7w6o=;
        b=qIVH3JbKvPTI90pL62KYY0CE73JeN2SUYSrBybV8uswZCRUzC7TyQR8SVFp8MZtE+n
         xr7tJOlv3L2n5ZyjubWWSM+HvxpWMMviQPJGc+z61rfEV7BG6cQlF6JShpAp0jtu8vVF
         ceTB3j2pH2b/Yt1sE4BJDCgHdKQmyfJZMtTr8D5mHqeWpIZvfd9zndu2IJA4nuyF61qJ
         PLuksfEnXLVGlUXKspIWeM/QLHcLr0LmFBlIvSpGCb9lgFdOCT5hGek9uM/lI/l3D+aq
         iN+8aCJy4pGjNnJY/joNcWnXboVwrTUBBtxKGrp15wZVhuCWO0JNd1/VK0fRmlhAUyqW
         ctvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W9vEcsuPOmb6PFD1YP9Cd5t2i8+H7vKDdbGELGM7w6o=;
        b=0VjZvrDUBfL2QlP3uUmhceoJq0ZxVMox6pzFQVspX5Xm32z+2KoUnSsvBQscBlvvGv
         1/87JZ5UTZKE3OByTOU9is4oFUplIggLQ8fyg71rbGkX+dlqr233xsRxTwv9Cv2UbgOT
         RMWAIuHrBNS0h55AuXr8KinN9/gurB+ZebLdzv0jA0PsIhj9SZOrMiirXPFBFBhPTJ5U
         sxzZw+c81PxZcYOaKbHBZ6unigjWNHST4EiedVSqR7k0Qa3ML9v7jgpXLNwKrZnXVDSM
         WLHu2QtFAiZzxtBfBzqs++1MozPOM3lk5LN0eyeeYBZRE64ldCdRy2tuGAZb/7fx0C6I
         HqbQ==
X-Gm-Message-State: AJIora8O2Ir+bgEVIIbhaKt9HCxT7K2ygvtJ9xxZmq/Rhl/wXvApMiKF
        f+Hswg3H6mjQvB8EIxC5D5sypA==
X-Google-Smtp-Source: AGRyM1shyweS5X2mqdSfWYknlmTWWG1DGobjjvfheeS4TSNX76HtThJhWEt1hwbwlkge4YLK4Rb5CA==
X-Received: by 2002:a2e:9097:0:b0:25a:6e3a:8b21 with SMTP id l23-20020a2e9097000000b0025a6e3a8b21mr15698533ljg.37.1656922001547;
        Mon, 04 Jul 2022 01:06:41 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512218800b0047f7c897b61sm5018145lft.129.2022.07.04.01.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:06:40 -0700 (PDT)
Message-ID: <2823c36d-efce-6c02-3b00-df1466c0d2bc@linaro.org>
Date:   Mon, 4 Jul 2022 10:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 10/14] arm64: dts: freescale: imx8qxp: Remove
 unnecessary clock related entries
Content-Language: en-US
To:     Viorel Suman <viorel.suman@oss.nxp.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-11-viorel.suman@oss.nxp.com>
 <483d5115-4027-e811-8bce-15da6c7c660f@linaro.org>
 <20220630083636.2c7mclmbq3tjma2j@fsr-ub1664-116>
 <5d8b2044-5ca6-c90c-57b4-afbb2ae20dde@linaro.org>
 <20220630194804.sa3mvokpv7iksgbx@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630194804.sa3mvokpv7iksgbx@fsr-ub1664-116>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 21:48, Viorel Suman wrote:
> 
> The question context looks a bit shifted. The "clocks" and "clock-names"
> attributes are removed from a clock provider device.
> 
> The OS clock provider in this case is a client which uses some protocol
> to communicate with SCU via a messaging unit. There is no
> access to xtal clocks via the existing OS<->SCU communication protocol.

SCU does not need to access them via communication protocol. It's enough
that they are clock inputs, physical clocks being fed to your hardware
which you describe in the DTS.


Best regards,
Krzysztof
