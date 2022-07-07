Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649A569ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiGGGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiGGGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:50:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B12C119
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:50:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i18so29498734lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uK70/rhYUGhSJlSjNPURMjDiBCpuf2mNsuNaQulD/Iw=;
        b=UWPAlyaKtQ/n/u96Fq3tibzMJr1bxsYkWgSS14eH9FJzkIs35O9O1XF/OfMsmBXwdW
         edt8ncYGqUFWxoDLP90CSdmtZ8lGEwkD2OSr6c5Z9VjMVW4xVTKHsE8vcxTfAFEg7MTh
         Q/7sOhvT8xtVHwS9hNQo4LiV7KfTKwiaXJAAY45yp8Ti59TPgpi5RZhz5lMPdkbAYbNj
         j9ljUL8ydPr3rzKvMLx99jGJpuXpzKzqP2xTV0/XlAzJl/vanWk/W9CGHygWILpBe221
         Ub6Ym+UTutaBgEh+8EsUDZtE2qA+ag6ikaPzwuoGqmxD/L6jPTWuav/1HquoV9JK1G37
         qf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uK70/rhYUGhSJlSjNPURMjDiBCpuf2mNsuNaQulD/Iw=;
        b=uCUT/xqT/P9gfNo6n/ijY2/phdLxPA7ZWQap2TRAL+dxtmrby7f0erxqFTylvYxiFl
         FkWeE4TTayxvHGyjqZCL85oUalje/dfmJ7PQUi3XjrDEtF13WNoaDhrVGw2npYG4J/EK
         N2+z/2KKhxRkXGZXofwD+wRTaaCzXiyHGRfPUg3AK2CirvE+6O+ehpnRo1KaNnzjgFNk
         pyeH0HtaoNMSgCpHd7Q6O8QwiVNPJR32iCyqopf1Zy8+KN++3K6FH4meoF4tomcfeo4o
         Rxlc0rSuq/yA9Z75+GZA3PTpxOPBefBkY55dEgcVjb9UUlRdmq3ry0Jpfi3eU1RQtejE
         bo5w==
X-Gm-Message-State: AJIora9RCuhlO72IRPmpcqBHU5WsYxUKsvhTSoWvsx2mzDtQeN3XAEh4
        aDONk49y3kya5c+YRMSeLR4vgOOUdXfw/88v
X-Google-Smtp-Source: AGRyM1sEsLyBbfJ3jKEqStiC0eOawgxH/iIZByD8cbK1YXAhZMMZMX9ltXPSJ+cj1909p8pwapQW8w==
X-Received: by 2002:a05:6512:39d0:b0:481:ed:666 with SMTP id k16-20020a05651239d000b0048100ed0666mr30929880lfu.379.1657176651600;
        Wed, 06 Jul 2022 23:50:51 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id k26-20020a05651c10ba00b0025a736f5a41sm6661009ljn.9.2022.07.06.23.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:50:51 -0700 (PDT)
Message-ID: <4108a1d1-7e30-4b02-b614-984d185681c7@linaro.org>
Date:   Thu, 7 Jul 2022 08:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: add dts for UC-8210/8220 hardware
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220707053954.22168-1-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707053954.22168-1-jimmy.chen@moxa.com>
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

On 07/07/2022 07:39, Jimmy Chen wrote:
> Add 2 models hardware dts provided by MOXA company
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>

Version your patchset. You already sent v1, didn't you? So this is v2.
Add changelog in each patch after '---' describing changes.

We have the entire process documented:
https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L308

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process


Best regards,
Krzysztof
