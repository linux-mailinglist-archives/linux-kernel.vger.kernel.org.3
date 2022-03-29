Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0D4EB3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiC2TG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiC2TG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:06:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA521122986
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:05:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so37113260ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S+eaPVhOntRldab/h9j2OpmXWaKh1yuCdKow3ToRxmk=;
        b=BdcWfpm06YeOlKVWp4x/inLyxqw/LWhOVYObUkiX0CqZ41MLopiXNHyloYePwKpTDB
         OcOmCKDbxg1nXs/BiS30rsoa3jl04jvHZM4AKHb8CrCrUhb+IyG8PEn5qNfwGiAyVNjB
         Ln8W7lzoyp1A7A5HB/hIUiaAKWPld+yd0tc+ZO/nsnSh73acoajpMXvqA6b7k4vwhkR3
         GBONWmd5K39r/7iRa9MIBUXVYpnwNA1QYQz6vnf2/Lhw0VBUFj8kmmio17woJSc/UhvS
         pNYGJKvNv9FaSr/sdcl+TO+YmpDMTp3PFInZ/TM/6edkQS60WCKxdRmji+l/0svB0boC
         CVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S+eaPVhOntRldab/h9j2OpmXWaKh1yuCdKow3ToRxmk=;
        b=euD3hZ0wdIVNR4wO2BrBXmqAlq0KYH6uVgGSYRqVq/BVv595JLxSXtaLL+b9nm4Id3
         OqZ88ECfqN4aFW1byVZhz2Jfijp333D+cIJ+YS6lDiz9Vv++F/4XsgOgclwLLqlZ5ZsL
         JQ5nCfMuKDfp26ChyxobeRS4TEJ/M+IGP8S3qNWVQCWFDhaJOW+yke9UwqbMVDyP4pw3
         q3FyAMoBsNba0sjoDK93rKPMOy/m4x73AWuzcQH+Pmm7UGIneAd/UzbKDPpV2hJgSYRE
         gDOgZqI5fj4wUzOnbt5QFM9B1bstA9+JQS3dIQHJZtySsrHjKdw4y0VTgjPX1dhegZZN
         MI7g==
X-Gm-Message-State: AOAM532s43IQAPJjLtrq8w0k6JN5Nci25RXgdWYEyC2Ob2Vf7ukxYBM+
        UaVqz1mDNE8gJZ4JW6BjXVM0FQ==
X-Google-Smtp-Source: ABdhPJycTC7raztfAiipL763FFF5helrC1RN+N+kIOc93r7W1QZPixjRFiQxK64qYQpm/akt0PEFlw==
X-Received: by 2002:a17:907:60d1:b0:6e0:22a8:e2e5 with SMTP id hv17-20020a17090760d100b006e022a8e2e5mr35512365ejc.612.1648580707324;
        Tue, 29 Mar 2022 12:05:07 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm8990032edt.80.2022.03.29.12.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 12:05:06 -0700 (PDT)
Message-ID: <f766c981-2d40-d254-27d9-2d93b500c368@linaro.org>
Date:   Tue, 29 Mar 2022 21:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: convert rockchip,
 rk3308-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329184339.1134-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329184339.1134-1-jbx6244@gmail.com>
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

On 29/03/2022 20:43, Johan Jonker wrote:
> Convert rockchip,rk3308-cru.txt to YAML.
> 
> Changes against original bindings:
>  - Add clocks and clock-names because the device has to have
>    at least one input clock.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3308-cru.txt    | 60 ---------------
>  .../bindings/clock/rockchip,rk3308-cru.yaml   | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
