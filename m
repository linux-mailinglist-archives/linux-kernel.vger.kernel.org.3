Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4A571633
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiGLJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGLJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:53:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161D1F2CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:53:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so9238586ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LMjElaEycr7SAx7h59JBZKxM3vi9DYxeY8Usf5KNPqA=;
        b=M79X/n3YtBxlMJx0CE/v58ek7eJ/4+aNYp72M7tUXpcGUajqpRjpqWDvzIfk0iDKaZ
         RBqy7cwj2XdbTfuZTg2g2RKKDn///7skzfv3cZpPIpd0ma8qBuX6zO/9CcEdT+LGPYp9
         mocZH4KtdzqtbMKmes2DKIjZRmoMQKCICJVEyjM9+tOb/tOTNZIjZmj3nyY0erFmK3Rv
         WQQtDREaTeHmisLSJ2kBHx5avl8u//N3xZyIhfN2v3n0e4N3CZ4uNp3nkSlgf2tOn5b/
         WxkW5FP3vbpO3C2Dx2hgQBqQSsndsCtpbpGvI07V9Sxf/OO2qXrUlfyfFzCEnlikGbgr
         YEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LMjElaEycr7SAx7h59JBZKxM3vi9DYxeY8Usf5KNPqA=;
        b=E27vGugEAzp/Xw8ugFUlZrWuO613HuhQRaqY++m1hVWgWvQHocU/IoZ9lu1s5tfXt8
         Kgio+/pKBQ63cn7e69Zu6aVqFoAYkmEGPvFH0xbuMcEkYyQBH0KKaC4Nf7hgqTBWSNeB
         1jrJRhctExBrq7x53zUUsjFvFd0J9u/Qw09zVqssRKgQNBysEsTbyM65eQEjxxGguGXJ
         b57dBAkFYXQpWsvIK2OT9gwVIW12jMaSrtZdy8eieGnMrUsWLyKQlWWo0lifFMfAjMgn
         VeN9iA54nWb1lOJ1EvAUrjAiMMFtclnijoRjsNKwqrBvC1tLpqkK5ag2wE7bS5NFqUzz
         LIog==
X-Gm-Message-State: AJIora+Q0WLborsXRgBSvSccjZZJYNv7BINCLgLNg1eeJv1P31P3FOEZ
        Xz447h6qVDHKAX6zCZNO2nkCJA==
X-Google-Smtp-Source: AGRyM1vUyYI89x6KhM9BfxnYOCsnYfp6d4jaPd18IXEKS6Ap6dTYvp3qlHHbxDjKTmb0zSmt5WDAMQ==
X-Received: by 2002:a2e:96c2:0:b0:25d:7b22:f2dc with SMTP id d2-20020a2e96c2000000b0025d7b22f2dcmr1112264ljj.297.1657619634971;
        Tue, 12 Jul 2022 02:53:54 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z2-20020a19f702000000b004794a78bfe7sm2103304lfe.6.2022.07.12.02.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:53:54 -0700 (PDT)
Message-ID: <16107992-a69f-9856-aa36-8596c7cdd4ce@linaro.org>
Date:   Tue, 12 Jul 2022 11:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 04/15] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
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
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
 <20220707125022.1156498-5-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707125022.1156498-5-viorel.suman@oss.nxp.com>
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

On 07/07/2022 14:50, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'ocotp' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
