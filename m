Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8675A6B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiH3R7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiH3R6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:58:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DA1DBA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:57:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so16596772lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Vuo5xXbseR9WXiFJ4+y6+qbPTjY/jtEcAv7SSn7pWgo=;
        b=QfXlW4IuU99OY2q6gNRj7GVsdw2bqbps4mZGeVw2wZ9OaVaWnEaCBL0OpgnSwAZhx0
         v/7YH20sa3p/JsJ4eqCXBHIQqTFrLLoIu70ws6znoXqfUrHFy1vMjDfvXKLKA/o+wlbu
         1gVaNrPQZBkHjEsI72GdwpooycLxcLBcfurY4OiAqHlRdWrAzCvGasco4ZvLvcgTZhJZ
         +l3qbujcw68yIvwZ8hoKNwTQG/Y3+EJM1muHeduNLwv/d1XBTxw3gjKyxHglbyPdblNW
         hrUFsUWfoVGj7SlmBOhmBNnS8ODKjbcWMeV3DBO/2TkawtupEIKSWyqkODDFwbD9jOh2
         nvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Vuo5xXbseR9WXiFJ4+y6+qbPTjY/jtEcAv7SSn7pWgo=;
        b=HmuyZCTQCq+iqn7QxOgw6d2743K222Sb+vEnc6YxmuH+8BAS7YR9tCFV/C6NGrD20o
         wudXH/RMLK5lgjZNzEuQIbl1SNMqAfmvh6RvSukFcG6I80omtRvSZApe8VWNKkDmXKKE
         IXkm+KrzsOS8+P4ej9JRCyR9aTBLlFsRjrUYsyEII2/WRuayHTUUXEI0nEezIpzT7XiN
         GwEUcsGTST8OKYx2qXYn6C07PgGdivy5IiGqRB9GWgiSv1GzYAuaPtwH4tgFx9Ozjvnz
         e6jJh0lL/KeFeC28eNmiILAcTqWsspjSrCP9X+G3ejztTdlrgiJETj+cQjwA6yBGaOic
         4R+Q==
X-Gm-Message-State: ACgBeo1xSUm6lSfvqJ/nZwzIdHY9+xnHMFmZk4N+ZnsSR0PP7ZW5++a3
        x/4RgVTp6LkEnLlnPUQaAmrwqA==
X-Google-Smtp-Source: AA6agR4j3+LglVzZoY1U2SUJyCi9sxbKq0ZtPQG6bJaaRx5hv6JS+nLvIPeE95vVFpUbNOJLV4pjlQ==
X-Received: by 2002:a05:6512:3087:b0:494:6180:ba85 with SMTP id z7-20020a056512308700b004946180ba85mr5240743lfd.165.1661882274172;
        Tue, 30 Aug 2022 10:57:54 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w20-20020a05651234d400b0048b0099f40fsm1676191lfr.216.2022.08.30.10.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:57:53 -0700 (PDT)
Message-ID: <366e5719-c477-1645-4f5f-0a0233c0accc@linaro.org>
Date:   Tue, 30 Aug 2022 20:57:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop
 Leonard Crestez
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
 <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
 <DU0PR04MB9417C2A5495EC2E009A1B3ED886A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417C2A5495EC2E009A1B3ED886A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 17/08/2022 10:02, Peng Fan wrote:
>> Subject: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop
>> Leonard Crestez
>>
>> Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
>> Access denied:), so change maintainer to Peng Fan from NXP.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks. Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks for the Ack. Please keep it in new line, because otherwise it
does not go well with the b4/tools.

Best regards,
Krzysztof
