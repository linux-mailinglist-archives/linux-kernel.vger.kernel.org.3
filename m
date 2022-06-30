Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E9561E50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiF3OnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiF3OnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:43:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E7DDF5D;
        Thu, 30 Jun 2022 07:43:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d5so17187003plo.12;
        Thu, 30 Jun 2022 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUoQVUfGIj+k3cK9VwLwIAhO4opF70rEutg3/2JWbC4=;
        b=mgt0FAe0RaXxmkNV3dy2J1eV/FbHCE1/hDOnsUyVtVhvzO5yUJ0GR22CtF1X14Qnr7
         CXxb8edTqh/LWLZmNaoF0bq7rHhonzgqNKelVBfU+dOi03LOjpThN7IxfB6vDgYeLd4r
         W0LxeHexHjzHAzClwJwrY5Bnq0FsevwUOiYTReuID5T2LmFDZN2SHDD2ZNe9v9wLKdA8
         ZyMYqUXMTrbGbwHxnttvTjIGZUA2dF3zxMuD01r9Lp3atcGjoQamcELO+XoLNGj8RJpQ
         CU81vdOtOqTnAjLfDLcNGWg8u3YkUSsZ23oQwudqa3tZib6HtnbnoXIDq13jo2916ARP
         CCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUoQVUfGIj+k3cK9VwLwIAhO4opF70rEutg3/2JWbC4=;
        b=KCpvofXeV2g5fyo/9PrMVCLKlO3Ljd+H9xjkkrpumdIOhrk1WBIMl4CQUG8KAQi3wn
         5TerU3ep1zivUc31OsYF+dr/ZWc24HEGlpKAGUTwFXmowon6DacN5xJtet2s6X432ODG
         JmNg/yjWorODlckfQmRBffGygvINM5ShbyZ8xXHEiGNmg0EL1Jn5WYcMGzB5ySFlIB90
         aV5kqCUB3P61Kbi0vnAVD81x8gEzmO5h/u8V2RozyWvAlsU0q9oI/PTY9stkBKh/lJTh
         vKCoBZWK/XsIGo/heirHzjrF+EqMM71RtVNkrtWJMgROTWkyngD/xA0qAuGAQ5WMABZ7
         qfdg==
X-Gm-Message-State: AJIora+Sy96qocbWefnzwuczWpyXcBg8vfqP2FJ4t533d7IkeSpWeV3s
        LgO1TxYyZnwiBRDAV302Ahg=
X-Google-Smtp-Source: AGRyM1sYB1R3u1XCkRIl82xDtM8/BHbKNahIwLTkJ9JVsgEUEwGEDwnGSfR9o/mfcbDeU5mr4vFWJg==
X-Received: by 2002:a17:90b:d82:b0:1ef:366f:b654 with SMTP id bg2-20020a17090b0d8200b001ef366fb654mr4955387pjb.151.1656600196861;
        Thu, 30 Jun 2022 07:43:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ab88f00b001e305f5cd22sm4498009pjr.47.2022.06.30.07.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 07:43:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05ab4cec-ed35-1923-5750-e43c3ed30c50@roeck-us.net>
Date:   Thu, 30 Jun 2022 07:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 08/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
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
 <20220629164414.301813-9-viorel.suman@oss.nxp.com>
 <988844aa-f7ce-3cba-dd6c-227fa6d58102@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <988844aa-f7ce-3cba-dd6c-227fa6d58102@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 10:59, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
>> From: Abel Vesa <abel.vesa@nxp.com>
>>
>> In order to replace the fsl,scu txt file from bindings/arm/freescale,
>> we need to split it between the right subsystems. This patch documents
>> separately the 'watchdog' child node of the SCU main node.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>> ---
> 
> Assuming all patches are taken independently:
> 
> 
Assuming the same:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  >
> Best regards,
> Krzysztof

