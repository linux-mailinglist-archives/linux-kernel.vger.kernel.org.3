Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3394FB3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbiDKGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiDKGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:45:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854F289A9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:43:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so10108091ejf.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Vqofv8LVUK572dtLwE2D5FeqaGv/N4ekUHyn/Cn/j4=;
        b=aRz4swXmDsmqG+eRKSkI/ahoMX3Z/0+3/IdbMM9Lc8OPR1+PvFaMloi9d8ln3cWg1D
         fFa/a0RWMJLhAh8AiAl8S2dClrHropyKIfUjkgkRthdMuU+jYXmerQW/KdHYaRcf1rBK
         CCN7muKJixe3xgYs5WsNpQuTbNg4VzM9Zeqml/lFLdEdpAxRTGtOuNiFIxcm1vZZhf+G
         252ZiFnVbmNeSq+Nn5IxQVq/zM2fzoJ4I9gC8ctsVGkBsWVRvCC+LL6aj38kxjUBa2Z5
         LfYm0F8UjsTmCJZt/sNQFTGYlI8S1rkqmmN8XrYAcxe5d7jKHYSJw8gOaOUiZ4e5VxdK
         xuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Vqofv8LVUK572dtLwE2D5FeqaGv/N4ekUHyn/Cn/j4=;
        b=7xYwPKNDI4raZ9XwE41r6YlSiNCoesmoMa6uHgXVpI4YgI7/awdNGIMk2PHP6BJT5Q
         AJ3ErTPWk5h/9b8cyqpNTTq4AonY/2mwjjfXTMJI85TNowG11qIpTr6ssB5SPhG6G5SI
         sQ4Dy23oMU2RZm3k/kTme3O/RCmNR3E+6n87LbuRazc1PIUaK+wxv3VzGeynmZtp7IEl
         g4iNmCYQ9MuK+rhSXWLP2w9fPudZhbT20Z0WzwBHohcFcBW/k9S+pN+RE19yLd8JzQxP
         Wn1LDyTpcTwPK/DzG7hWuPfvNq2tXh9en8dVWvTip/OVOmIbvuAZFqgNtwo0l9K8qmmI
         1HUw==
X-Gm-Message-State: AOAM533sQrGcHDfBgPAf0sTqispS2sawExlr/DlCNVVkhRLicN/inN90
        UjTnBT6St/jgXeed9lbkIEO6mw==
X-Google-Smtp-Source: ABdhPJzpt5TX2Bie3ZJ+Cp3TofE0dqCbXEJt2VD5MxF5GDj+HJBKryEeNGbKNr4zbFYPpiSY/t5VMQ==
X-Received: by 2002:a17:907:a40b:b0:6da:b4a1:33fa with SMTP id sg11-20020a170907a40b00b006dab4a133famr27713766ejc.22.1649659391560;
        Sun, 10 Apr 2022 23:43:11 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090618e900b006e8669f3941sm2985013ejf.209.2022.04.10.23.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:43:11 -0700 (PDT)
Message-ID: <ae5326a7-076a-f7a8-f6af-6efb4de0ea7e@linaro.org>
Date:   Mon, 11 Apr 2022 08:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 3/3] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220410193544.1745684-1-aford173@gmail.com>
 <20220410193544.1745684-3-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410193544.1745684-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2022 21:35, Adam Ford wrote:
> The SDHC controller in the imx8mp has the same controller
> as the imx8mm which supports HS400-ES. Change the compatible
> fallback to imx8mm to enable it, but keep the imx7d-usdhc
> to prevent breaking backwards compatibility.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
