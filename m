Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B0568B41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiGFO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiGFO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:29:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30220182
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:29:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u14so18715951ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A5XEhFEI1sgOxZaIiNl90M23If361wx8ONPLgT7XGzI=;
        b=TehnPfWsuMVsRwFU81r/h8zYcxQIpoObN9ie5xXroVxDcqpcJP061im2t2iUz+aIzy
         TS4HZlmzQlGwdEim9PjrvSEA+yLT9OV4ePWfHLPHQpxbTJpcrFtk0jh5A1pShX7uo56v
         MK9tmTwENiCQPlvHV6IiyWBI8tvVRp0XaMhmij/Xj/dii68gyW+3UWm49v3RuTPK00vs
         ylAY1jIF6txWpDHiD3+FdU0+S1VJnFu/d5h0VqTDpPqKAeYB2Z5ExyiBmMSnwjk2K269
         GMhg1BZr0QNa60yDX63rq58ZFGibbuM+JbTDRuZtATgw4eIse49PfDj/aDcwPZZiz3DD
         2hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A5XEhFEI1sgOxZaIiNl90M23If361wx8ONPLgT7XGzI=;
        b=Y8pdOA5moEz0Pthbl6G8RidsV3a/03JxJwjTbsq72rMuD3hSTDY1p702Lt/mBt6KG3
         ypv3eJUOLGwi5wssp1Xatc56SIdApvN22zfvz12vlnX3oMjUDuMRY5QrwIZUcB3u/LHt
         AFM1joyySaKlTr3AVXl8H3dgjsXVk7Q4bw/vj4RT4Ki6vkj6mhJ41LUplCvLPBqNv1BO
         V/4AZgCCnh1UVICDW3fJG8tS9OVL8kksNcJFcVgkKL5+3m6exnCkPS3t5/Usr+xnWcFP
         /8SEiT4wkQUnkEo/oXFLmZIfcECbEcd15t6JlCYpQYpnicYQZALWy8L5QCdL2LzQuodh
         krGg==
X-Gm-Message-State: AJIora/n6juOlmXbNGMhKVm/0eZaw5of7OWeMe/m6J9vmLSCJBra8DfP
        GMe+7IMb1Snq2ZDMObgTSSG68A==
X-Google-Smtp-Source: AGRyM1sIkGqNfg4WOnb75LEjMGlLNjDJs3f3DtG0GuRhGMvhVYHisNiN2pWPdwfuUokq2/yMVyEnkg==
X-Received: by 2002:a2e:6e14:0:b0:25a:8ca0:7efd with SMTP id j20-20020a2e6e14000000b0025a8ca07efdmr22921772ljc.56.1657117755139;
        Wed, 06 Jul 2022 07:29:15 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 68-20020a2e0947000000b0025d375e8665sm971537ljj.99.2022.07.06.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:29:14 -0700 (PDT)
Message-ID: <8c395ba8-45f6-01ae-2fcf-24344cc89141@linaro.org>
Date:   Wed, 6 Jul 2022 16:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-3-viorel.suman@oss.nxp.com>
 <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
 <20220630123754.esbuac4pfktlseh2@fsr-ub1664-116>
 <78faf75d-80b7-7a0e-e306-6351dbe5133c@linaro.org>
 <CAL_Jsq+0GJBTVkS12XTvUKphMH4XuQ5AS1-QHMw6ULgpWbZBQQ@mail.gmail.com>
 <CAL_Jsq++FqUn3u56boHcoZhskx-6uUiduhJbUyWXbOH6dzExJg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_Jsq++FqUn3u56boHcoZhskx-6uUiduhJbUyWXbOH6dzExJg@mail.gmail.com>
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

On 06/07/2022 16:11, Rob Herring wrote:
>>> The fsl,imx8mq-pinctrl.yaml should be correct and I don't see the reason
>>> why dtschema complains in some of the entries. It's like one define was
>>> not correct... I'll take a look at this later, but anyway keep the same
>>> as fsl,imx8mq-pinctrl.yaml even if it complains.
>>
>> The issue is that 'fsl,pins' is problematic for the new dtb decoding
>> because it has a variable definition in terms of matrix bounds as each
>> i.MX platform has its own length (typ 5 or 6). The tools try to work
>> around it by figuring out which size fits. That works until there are
>> multiple answers which seems to be what's happening here.
>>
>> The easiest solution I think is to just strip the constraints in
>> occurances of this property. I'll look into that.
> 
> This is now fixed in the dt-schema main branch.

Great, thanks!


Best regards,
Krzysztof
