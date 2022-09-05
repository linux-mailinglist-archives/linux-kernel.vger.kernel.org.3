Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1C5ACB2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiIEGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiIEGlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:41:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B67286EB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:41:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by6so8183991ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7iOqk8h6HCBdlmyrMdMUjyxmIjBhsqgO7opmJfKWI7w=;
        b=SgVhbl4A9Qm9LgA/MGyhiC6R6uJRniyu1pIhrjqncLX60o0Cgb0vDZ824wf1K5xblK
         pWUbQQAQ0dY8OLbNAXeDsT6Ad6s02bu5O8BuzuJzUNcCDFhhw1sFVubm0N1s2T1n8S/d
         l41myO9IRTPwO4JxWXLbK73ODn7awLS4pu6PSx5oZBXhdXBT58Vp5TVqcTahYeD/G/w3
         TKil2UnFppVs0HMhjoE6nUzv4oDJAIWyk8bP0VOWLmLEDK5dM3KiKc8WMZIx51MASpny
         Dt6BnydNOGU7eUCBs9htFmrXqCWwzJvQVVuASE04GkJFg7Ja3LfTVakAiIjMcidyBvot
         WH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7iOqk8h6HCBdlmyrMdMUjyxmIjBhsqgO7opmJfKWI7w=;
        b=gzfnOEQJRxrUmdIblJOgjwLenHkLO5Ulc8iga4ye51i9VNsIv5n24ZwIRCJsmqiKD0
         x/M45Q6JtTcQa21ZPg5qzYRlrXsFTck3m3CHd8qRuvtjv2QJOARvNgwE57co28NO0eDZ
         THVq1kAPwUVTKsD2spYTjgu/yCnPrc+S6tKDlUiMlZoCtYf+kZq1bn1+3gFBoDp8xkMu
         cAbhH5XUQAFfRcuC3Z2N2yf8kVNv9DaBl146d3JixA3ppe9eZ+83KXZ8UQH2DZoy5f26
         tPIhOV+Ht0wecX0/au8jmA5GHx3p3S30I9lwSwudV5SMSuJ8o/I3Rbcam+goiVwzLqmQ
         34FQ==
X-Gm-Message-State: ACgBeo3IhUokXwZCiuSOtwsHVaUauHRgPmnU0HDGopa9WFHjTwVBpIBP
        zzkVR9viYySk/s2U/ZOtVa19ZQ==
X-Google-Smtp-Source: AA6agR70Kwi+8Nd0OYTksYwpghdDYR080Xz3FLE6Ddq6JO8p8kpEpzFgaZhYKrk2Vfw21qua3WkQOw==
X-Received: by 2002:a05:651c:12cb:b0:25e:44ef:8bfa with SMTP id 11-20020a05651c12cb00b0025e44ef8bfamr14654336lje.324.1662360077959;
        Sun, 04 Sep 2022 23:41:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br26-20020a056512401a00b0049469b47c1esm1088163lfb.152.2022.09.04.23.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 23:41:17 -0700 (PDT)
Message-ID: <cbb82e89-7035-1c01-8f22-319c1752156f@linaro.org>
Date:   Mon, 5 Sep 2022 09:41:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20220902230500.2624739-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902230500.2624739-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 02:04, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7431579ab0e8..ce89fac1898e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -831,6 +831,7 @@ properties:
>                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
>                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
>                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> +              - gateworks,imx8mm-gw7904   # i.MX8MM Gateworks Board

Please put it ordered alphabetically, so before "gw".


Best regards,
Krzysztof
