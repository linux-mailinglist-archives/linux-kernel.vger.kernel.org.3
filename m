Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD05A5FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiH3Jof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH3Jod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:44:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E93A8CD5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:44:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p18so7412833ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1AEJkkvJsW5PL2iwboBiHlwrTQTde2dlnWXw8tEu3D0=;
        b=FAgokXKk3aNNyd6z/ejsI3SNO9qh9ttn1mD6G87U7kRtJfoUvCuuO7Mde+uT52JjKZ
         Aw5N2X5seVmUl3beG/WFteNBZDJugEFyBsyaXtlPZuGMwRCrYZmZjC0bZqWKn/6Pe2UW
         z0z6N/7VGLzwlfYm2CO3OeKNBn0Fx/xkbtFMcdKz2x5APvvQcX/+3bBKeQCUJRZATf1b
         8qgrCvnNNMEt+1zGgc3tias8nN9BCU+qoQl0mN7RdrkquLgh+jWSK2tT79gUBZ+atGCV
         fDEGScertwUdt1sMEj5ZGPISPcrjrAgqsMGXcCitMqWt53tz9RNwKPX95/VovA77YzTy
         Z3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1AEJkkvJsW5PL2iwboBiHlwrTQTde2dlnWXw8tEu3D0=;
        b=Ficksq8dY0H+oek5iyXnhreZyaignDPnAhxv+kxY8H0uqWlhxyfjPIwAjo107iW/1e
         x5iiPqZE3bdfOqBTGAe8s8g4hVPWpY35o+sTkT6DsXNGi8JQvqPoSkbHvmZG7dhzjsEP
         uF4cq8TsGldC9n2O4RiNpQSTpp/kYmhmsa9RAiqFJjQE/C4tDNLopBYnN7yOUMhoX2CN
         dd8yxBEYaJFolGG66LCET61eOazIjmqXFNNTrA3Ecuq9klcevdOaX5SL9EAmir/pXDT6
         Ib/r2f6AiA8dmnOCniAiBVoegGVtk90YL99xr2l+D+7qQS55ULhTVuWcmYYtQCkTAOhz
         8Cjw==
X-Gm-Message-State: ACgBeo0OQpwKQpBnDvLnAOBUpn+s1ZXFN2okye0GvkJZaUzxaQMPcO5Y
        0L81diVrJLyM3xXikn9XAsmOaw==
X-Google-Smtp-Source: AA6agR4wmHcZxRiO0kPf6nYJC6H8QVWakQUNp3C2O2l7s7/+azxjAIcRdaM+cCy4MnOoOrgqzVs13w==
X-Received: by 2002:a2e:a548:0:b0:261:c647:1d86 with SMTP id e8-20020a2ea548000000b00261c6471d86mr7330658ljn.237.1661852669933;
        Tue, 30 Aug 2022 02:44:29 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id h5-20020a2ea485000000b0025e6a3556ffsm1697579lji.22.2022.08.30.02.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:44:29 -0700 (PDT)
Message-ID: <ed582145-3694-b39c-bf54-815279fe93f4@linaro.org>
Date:   Tue, 30 Aug 2022 12:44:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Adjust LTE SKUs for
 sc7280-villager
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
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

On 29/08/2022 18:48, Douglas Anderson wrote:
> There have been a few changes since the patch ("dt-bindings: arm:
> qcom: document sc7280 and villager board").
> * New firmware reports LTE boards as "SKU 512" now. Old firmware will
>   still report "SKU 0", but that's all pre-production and everyone
>   will update.
> * It's been relaized that no "-rev0" boards were ever built that were
>   WiFi-only. Thus we don't two entries for -rev0.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This builds upon the patch ("dt-bindings: arm: qcom: document sc7280
> and villager board") which hasn't landed yet. In theory this could be
> squashed into that patch.

Unless Bjorn already merged it, this should be squashed.

Best regards,
Krzysztof
