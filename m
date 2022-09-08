Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40765B1CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIHMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiIHMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:20:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F215CD502
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:20:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q21so13186275lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZlfvZ8tQr5gNlUoouZ3I9uNRBlKistdcE0MDcCmrbq4=;
        b=lYk5Cwl1ThhWYFUC/pQfIp7A8QMyj8x/zUm/1s/COaudKrgFe5IPBhLNuWG5Trg0Jn
         MJOfvY8J+XqxwZDTDPF0gBV3hip+vFdnX32JaOD/turJT3vyHK5L5gC2XPudecHwH9P5
         VyM6NaGK+XvOVmnuFVl8rJoWLYCfOYHdv6JwZb/TMZtcLGbiqV6stEmh+WLC9y7rysJr
         +q8KF7RUh8epOBMfdNi+/Eb83XferTCf7HToUMIhHYuyVO6ANib62PhMfHJnzSEq1Qpf
         t281+Bfhq80x511FOMO/LYUxSLLK7WJZOKKy3AumgJpIU/qtPmngdLN+NRnmddWrvAWL
         Gk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZlfvZ8tQr5gNlUoouZ3I9uNRBlKistdcE0MDcCmrbq4=;
        b=t27EX9eaCA2bnejYx5P562PzGy5uTEzVyO2mz4j2zctfbJ0hYcNOGIMcVGPwD4kPSY
         KgQ4QBH6yHffm+HcInIWEljDDdgtx5w97B9R5IsCD6TWgFZBauu9ilE/hQ95QszwypOw
         eY39er1/M0SYc03ZndDWzWh62iKPE8jIp746Y5LnLksGQCNpwiv9xpgZTTMoFwYtO5mK
         k7caMoFs3PgCBnMvY6l65E4vKULLVUxdJACLQR+Q9l8fSyW1n+cJiH7zhS7c51CsPXUW
         n3BqeJAPRI8bmElyaz0JX2cS8ly0R24v+uR16cwrfoYJrstHmfdnvt4L3F3ickQLN5WL
         xFjg==
X-Gm-Message-State: ACgBeo2FFtDuI3Vx/s4a7+ZwJnaxQytogaYgi4fbaXx18eMzHG/j8Gol
        xT9c7rpajpMWQUaoRggLpW2bV5mp/Kkh+Q==
X-Google-Smtp-Source: AA6agR7VMqh8oJ3l0AiaXQ9a3lUiXGzxnL5vBOUpqUUZWZrosS4vE1RT8abc3K2o+aleCTQ3rc4TPw==
X-Received: by 2002:a05:6512:2252:b0:494:7a42:6ba9 with SMTP id i18-20020a056512225200b004947a426ba9mr2558006lfu.273.1662639643696;
        Thu, 08 Sep 2022 05:20:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b0048b0975ac7asm361973lfo.151.2022.09.08.05.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:20:43 -0700 (PDT)
Message-ID: <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
Date:   Thu, 8 Sep 2022 14:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907135827.16209-1-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907135827.16209-1-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 15:58, Astrid Rost wrote:
> Add devicetree parameters to control the insertion, release and press
> debounce times.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/sound/ts3a227e.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
> index 21ab45bc7e8f..a4aa4154c54c 100644
> --- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
> +++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
> @@ -17,6 +17,15 @@ Optional properies:
>        Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
>        2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
>        Default value is "1" (2.2V).
> + - ti,debounce-release: key release debounce (datasheet section 9.6.7).

Use standard property units "-ms".

Anyway new properties cannot be accepted. This has to be converted to DT
schema (YAML).

Best regards,
Krzysztof
