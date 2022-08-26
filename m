Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4525A2DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbiHZRka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbiHZRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:40:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA3DE0E1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:40:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l8so2869543lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OTdc27ee6jSrb6BUWefWgtonG87QJUY3qmhGjbQcM9o=;
        b=RXmV26SRp6JLrCtA+SI6m7ulgY5sVdkzCAeNCuwfF+qmPjgknJENdubUmhtapnYta+
         P4aEeukQwfu2z6s2CP+hHyAE+ft4N9uWPhv1Ta84x/KsOCv2WYmyf/B0E1PsBMuBw0xZ
         Ci1aPK9D7DPbsAczrbVCmb/2govUqFOBsZl3pnsa0f2tgsUYsBD5PtDBMCBg31Mq9B5o
         DjgFFcKZxBq7D8nA9vk5bPvVgCexttrcbYrEqa8UEiRDtn+SLA8kS+O5m6utB1NZqYqx
         rvuAWtnj2uZkTETPDZ5G8G9uuCaxFfW9vRm2XAH+uTPfCWPY8Zrvwvl2ilH/uJn+yBhk
         yJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OTdc27ee6jSrb6BUWefWgtonG87QJUY3qmhGjbQcM9o=;
        b=W3BO3dmaPhFNC7WBUTTteQ86zRUbvMZG6WZkTItoawSLky6XJF0PefCbmCYYthmaQ8
         iMH7ghQxUm10KvYF4EokQpx9ZHXZyMb3C10h8bp4Gew9YJOSGAq9yIOvsuj/q4dcqX1o
         sVjX/eMK4dsY0Wj3ex6SNm/lXLZRU1L/j074GwJnTBe+oE3hp4jGv57kB/fMGEZ2SVfO
         bRbEKP4VDmthVIBnZk85VUYEodC+S7gC2FIXTTE0GSxSAspYLbjpIq6ezWyw/4RoUCjG
         pg5byKGiec4JD/b2yzXaFSDGlXTVx9iZcLRDBQ3YxYk1K9GbETZGGkBNhUfALWc3ygBD
         8v8w==
X-Gm-Message-State: ACgBeo1Z6nYm6/AnSkShJuYb0qNgZsflawSEHgBqgasGaj/GmZ234pVh
        wuoD7Mo8eq2sZrtuzuNjHeap0w==
X-Google-Smtp-Source: AA6agR7LN4RGaM5qPxnsCAzc7OIKFH1FnfWKbhbLHWggszDp6UWrWAHHSAubsHoPD0z7IhpDHQRdpg==
X-Received: by 2002:a19:9149:0:b0:492:cb89:ecc4 with SMTP id y9-20020a199149000000b00492cb89ecc4mr2619171lfj.447.1661535614991;
        Fri, 26 Aug 2022 10:40:14 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id o10-20020ac24e8a000000b0048b08124139sm431721lfr.177.2022.08.26.10.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:40:14 -0700 (PDT)
Message-ID: <fd2c9ca1-5ff6-3c45-fc10-90167c413061@linaro.org>
Date:   Fri, 26 Aug 2022 20:40:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] arm64: dts: meson-s4: include meson-s4-gpio.h
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, narmstrong@baylibre.com,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220826122338.2452433-1-huqiang.qin@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826122338.2452433-1-huqiang.qin@amlogic.com>
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

On 26/08/2022 15:23, Huqiang Qin wrote:
> In the future, meson-s4.dtsi will have some nodes that need
> to use the meson-s4-gpio.h file.
> 
> e.g.
>   * Bluetooth enable pin:
>     bt_en-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>   * Audio mute pin:
>     spk_mute-gpios = <&gpio GPIOH_8 GPIO_ACTIVE_LOW>;
>   * ...

Then the header should be added when the need is implemented. Do not add
unused headers to files.

Best regards,
Krzysztof
