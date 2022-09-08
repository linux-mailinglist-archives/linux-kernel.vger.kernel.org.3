Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8F5B1E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiIHNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiIHNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:11:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733DE620C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:11:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v6so6438845ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=R+2eNpABZn1sWOuP5qsIz82wyLqG7isobx2a9FSrbqs=;
        b=c/YVkfb0OPNeWY0nklaFJblwA5Qk9t+JyRbsPGM5tFqk3140FSWNCL0kUb/C0TwLhx
         xe+R3w0siDgMu+ijyf33nR/Ry7BFZ2WZSRsXC+nP7dQOO6O5vBxXOFFzx+WMXdbgSMIb
         1k6JcFE3q+mlqo6/ZNr0D/z4Q1O0qO2wN4MGt6NEHLn6+C1OgcFCsHviniKEq0eydqpa
         ZTtTDIfI35dPlsvb8OAHczyQu1D7SA837f0dMtAu+oLuKpaDzD8KPC3nksPePsIX3eCa
         00HXWoX1q2eyKX6uVqTYF307iH2lGnFXdtPUtRBjL2bQFasb386fz3VFvdBD7alT1gGl
         1Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R+2eNpABZn1sWOuP5qsIz82wyLqG7isobx2a9FSrbqs=;
        b=UlSy4SEiN0I6vLlmw7pX6bfz9515VuqhuphdPU6Y3y+nHaMLA+be3/aZdCJ33DzhlC
         shWEoUMWV24oRwG/BA7U/UeiHhusCwJzOCSrz+dB4Et/oOElK2KIrS1rHbTHmZFsuLoc
         qbsd/s5yrKZsTJ0OLWxvQYOnYOo5KTxwVuH3zNEiTajgTnn7kpSRre4SzX4NhZlDgjom
         VFcGa0gHH5H+qqKcmijfQ9UPS3yc/HhiB5ELxVftbHFRtGGTR0Bn+2Nm5OOLNnSnbn/x
         LZGHhrUtlsiwRtP7Va8V5r2VJhl1Xfg3Oz0PPSdQ/xBXsGjg+BhBaLgOTHTNy6WRqTCV
         gung==
X-Gm-Message-State: ACgBeo3xJmD7wmaguWE+JFVwfmwd01duAMt9CaSLKF1BT9HaxQHe6ZvA
        1rrfBhONpnrQvHuKAjzjUqRckg==
X-Google-Smtp-Source: AA6agR6XTSCoPKYWJ6UEn+TGFiGOOZzYp7Yq+3DFNXMHTdLaatWtlWTLRExpcagv22LrAtpgO6jPcw==
X-Received: by 2002:a2e:bc21:0:b0:25e:c921:f7d7 with SMTP id b33-20020a2ebc21000000b0025ec921f7d7mr2392355ljf.91.1662642669047;
        Thu, 08 Sep 2022 06:11:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a2eb552000000b0026ab2a04055sm1243389ljn.130.2022.09.08.06.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:11:08 -0700 (PDT)
Message-ID: <1b38adc0-94e9-69d1-91a0-08fe80c591e4@linaro.org>
Date:   Thu, 8 Sep 2022 15:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: timer: nxp,sysctr-timer: add
 nxp,no-divider property
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
 <20220902111207.2902493-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902111207.2902493-2-peng.fan@oss.nxp.com>
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

On 02/09/2022 13:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The base clock input to system counter is internally divided by 3 in
> previous design, but there is change that no divider now. So add
> a property to indicate that.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
