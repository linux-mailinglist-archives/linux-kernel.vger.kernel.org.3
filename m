Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514A259107B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiHLMEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiHLMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:04:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AABCAF0C6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:04:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c17so1075195lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6Kp8Yta0WaKZAcq5lDGwXYhuy7Bp52cXQEeMVR/1+WI=;
        b=e0NTS05OhsARZawCS+Q9V5QJklC7TFmJvLAbC9/1Rjz6b9TNijx7oX6q1vyROu9TGa
         L0GarXzM939iDPY+j88jTWrXvpr9+jisqiOo01vBWL1rq457Qd3WlrD8H1S4k/iyc/KW
         8m6xzKOXbjIKqyrTLY8QI+2M8TRkN0S3NV+UvwHCa5I1GSdFXUD6MMrkpWz65uVrwObF
         PA3IZWAZB1iE5H7/JTu5WF383hEt5cRcvSZhQ8ip1G17tF0MhvQBe4pXSF7jqPU2bbaT
         EydDQkwel042igDTE9+/sVIgg700h2ooG4BGxWR50lm/Q3fqPMW0/zKODvwTJB4/cqXZ
         m9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6Kp8Yta0WaKZAcq5lDGwXYhuy7Bp52cXQEeMVR/1+WI=;
        b=Xw6IJVpI6HFnawmZBkU2aTH1l9VkO88sUw7RGzFwXPGmCZtkdhEaLLCZSyxGkTgzKm
         lT/WmhDb2l8dN//fiw+xODYNIdlaJmAVe/U8fKTKkXw1GAqJ3oBToT2tmfq/n+0/Dm+Z
         vQe0YE64AgldeNFDGdM2V1+N1U0VVUQhmEZc2UgFyfPw5AyFoKWTnysQgdhQ4dxlS45l
         ya07Pykbd4LqelmA0I/u708LaiIWvlrGOQdjyjDFwsGEVw+bGk4FGk6ntqyoOtoYAIPt
         GfUUPLb5c8hKXZB58L6nEb2YpTHgFRNGlza9rLqHtVXF+VP1MbhaeGa+zPcL84KWSqpz
         0biw==
X-Gm-Message-State: ACgBeo3dAwO9O2xwk4KaLOk4N53uf2sZ1WTSPdoIW5/0rGOFnPEjbAH3
        S3wOU/64zg3SBUmdByoiiM9Q6A==
X-Google-Smtp-Source: AA6agR4sqXxxKi4mb3+0CFJc4qCyD4xvAMcIyGUn9NI4/7Ff/JuoW8K5vFDg7SS1M6jSetsvVHzWQQ==
X-Received: by 2002:a05:6512:401b:b0:48b:32f5:de20 with SMTP id br27-20020a056512401b00b0048b32f5de20mr1268909lfb.33.1660305885359;
        Fri, 12 Aug 2022 05:04:45 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id r3-20020a2e8e23000000b0025e60089f34sm333216ljk.52.2022.08.12.05.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:04:44 -0700 (PDT)
Message-ID: <4cf8d73e-9f14-fe8d-d6e2-551920c1f29e@linaro.org>
Date:   Fri, 12 Aug 2022 15:04:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH net 1/2] dt: ar803x: Document disable-hibernation property
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Wei Fang <wei.fang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220812145009.1229094-1-wei.fang@nxp.com>
 <20220812145009.1229094-2-wei.fang@nxp.com>
 <0cd22a17-3171-b572-65fb-e9d3def60133@linaro.org>
 <DB9PR04MB81060AF4890DEA9E2378940288679@DB9PR04MB8106.eurprd04.prod.outlook.com>
 <14cf568e-d7ee-886e-5122-69b2e58b8717@linaro.org>
 <YvY7Vjtj+WV3BI59@shell.armlinux.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvY7Vjtj+WV3BI59@shell.armlinux.org.uk>
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

On 12/08/2022 14:36, Russell King (Oracle) wrote:
> On Fri, Aug 12, 2022 at 02:25:42PM +0300, Krzysztof Kozlowski wrote:
>> hibernation is a feature, but 'disable-hibernation' is not. DTS
>> describes the hardware, not policy or driver bejhvior. Why disabling
>> hibernation is a property of hardware? How you described, it's not,
>> therefore either property is not for DT or it has to be phrased
>> correctly to describe the hardware.
> 
> However, older DT descriptions need to be compatible with later kernels,
> and as existing setups have hibernation enabled, introducing a property
> to _enable_ hibernation (which implies if the property is not present,
> hibernation is disabled) changes the behaviour with older DT, thereby
> breaking backwards compatibility.
> 
> Yes, DT needs to describe hardware, but there are also other
> constraints too.

I did not propose a property to enable hibernation. The property must
describe hardware, so this piece is missing, regardless whether the
logic in the driver is "enable" or "disable".

The hardware property for example is: "broken foo, so hibernation should
be disabled" or "engineer forgot to wire cables, so hibernation won't
work"...

Best regards,
Krzysztof
