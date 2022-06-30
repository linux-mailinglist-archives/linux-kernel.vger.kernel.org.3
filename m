Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707D5621A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiF3SD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiF3SDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:03:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069C11C03
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:03:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf9so40595868ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0uH+swHPlJ9RojSxikcvtTdTm2Ft6StJ5nSjXFZviuQ=;
        b=mJyJ63L6G3LfrFNNOPQL+JCUsu4K66zLibFmLn6QDWgTUkWw45WcS1kbpltS66qyoC
         h5dyEEH5b8qkX/57TOgz6MWYJlU6EmcnHvNQ6DICRXnrUNKfKv5z47oRruC40/ELf0Dq
         8XBH+e/zPZeg/uRg51ZCSrbIo0A6ARJP5QT+yr+/eCNyC78bDz6Y9fl8xEt8sq4068vA
         BkIx4SyM4HuXLLHPn66lSEjJ20PxaMzytdPjOo043SlTKNiiS7YtqXPfQBcSd2CF+Ur9
         zsCmOjU11pUatUz+iJ3N3i96JGTxXGJSjWgv2RtcDCyiHbmZBjYYXeK8S+MRck82xk6H
         O2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0uH+swHPlJ9RojSxikcvtTdTm2Ft6StJ5nSjXFZviuQ=;
        b=dPZfhu/p2gg9/0bHC7Cu/ReKuZsBBGSV8JZf65XUCqyvz9lYWB6sRyckpZgM3xpueZ
         lUrxH86jnivaACUqmjwLfuy0viWDh465fkUm7wj4SVimtV3HvkR0Fc5nmqcg9APR15x1
         L9IU1u9busMS6klXPAPJqpJYmpzRLVGOogcxo4Nd7qKu3gdCSoPjguV8GWAPs6fzdUKb
         DvBUYtwjp/iFty1QpIu2vhnazvqPQne7rjcSCch1XIhAByJWwikv3yasz4u6xrl/zduM
         5Zf2YGU4DL59GqSf65VsWJ+thEz54DIG2dq9Am71GCrUEjv49IBYyw5jrkEmJQGp/7mh
         CvOg==
X-Gm-Message-State: AJIora866Y5rKNG1EGuKNDkJaKCoDD8azRCrdyB+lSwnSuDl+Cs4mvTg
        53OmB14TY2v3TZiRWxRF5qVCBg==
X-Google-Smtp-Source: AGRyM1tYnKg/a71RXO4vS6NNUZ8q1v3nVBYI/1+tx/313mwWo6s1xK6fPmKQRUx5yy1KucH3TezGwg==
X-Received: by 2002:a17:906:749b:b0:722:d9ce:fac3 with SMTP id e27-20020a170906749b00b00722d9cefac3mr9698020ejl.699.1656612190144;
        Thu, 30 Jun 2022 11:03:10 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k10-20020a170906970a00b006fea59ef3a5sm9427520ejx.32.2022.06.30.11.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:03:09 -0700 (PDT)
Message-ID: <c4f26508-45bb-d553-36b9-27ace8bed71f@linaro.org>
Date:   Thu, 30 Jun 2022 20:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu from
 txt to yaml
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
 <20220630121042.7kwomc4jc4zppoyw@fsr-ub1664-116>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630121042.7kwomc4jc4zppoyw@fsr-ub1664-116>
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

On 30/06/2022 14:13, Viorel Suman (OSS) wrote:
> On 22-06-29 19:51:06, Krzysztof Kozlowski wrote:
>> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
>>> From: Viorel Suman <viorel.suman@nxp.com>
>>>
>>> Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
>>>   * Updated according to Krzysztof Kozlowski comments
>>>
>>
>> My comment a about removal of each part of TXT bindings in each patch,
>> was not addressed. Your approach makes it more difficult to read patches
>> and makes sense only if each subsystem maintainer will take the patches
>> (separately). If the patches are going through one tree, then better to
>> remove the TXT gradually.
>>
>> So the question - who is going to take each of the patches?
> 
> Hi Krzysztof,
> 
> I just understood the context of your comment, will do it in the next version.
> 
> Assuming TXT is removed from aggregating TXT - fsl,scu.txt - gradually, do you expect the
> removed to be added into the aggregating YAML - fsl,scu.yaml - also gradually within the
> same patch ?

Each patch making the conversion should remove the piece being
converted. Then finally the patch adding fsl,scu.yaml should remove the
last pieces (remaining ones).

Best regards,
Krzysztof
