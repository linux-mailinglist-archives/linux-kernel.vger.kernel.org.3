Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1835811B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiGZLPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGZLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:15:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11831230
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:14:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r14so16119894ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oKdoyoN9nV1k0WPDhaASmXz+sLWK4waatCHeRbneQ7Q=;
        b=iONnJlIraFb64HSC5Epc+qg86VFS+2DWHPFsIKnWkUCm2chDqif0/SbDwwVxs3nTwP
         WsxZy7AfTa/L8anSlFP1/HwK1TyPpKgatqxkG8Aspnvu7mJvvD3Fxk0WCzsbU+Oeq+RN
         lXwppRVnwZBCyRtiwok2A0btssijWXYm0xVoDzEJrn/U+gv3Kmb/dadDaUHSq7Fqr8Jx
         JnjGfZtL38y6HWoIoiID0Q3mY5hA1uuYNi1T1AXXwxVln29i3l32mj0NuUlIMkbn82oY
         id05sbNhFxoabp8cqk0pTU2Ojhf+MkGwnsVveVrl2lDeXN3F9veADvOnoG4GWDEpbwFE
         gDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKdoyoN9nV1k0WPDhaASmXz+sLWK4waatCHeRbneQ7Q=;
        b=mpoO3F2aWc4zq5MioeMP7xTnh8rVLqh4/k5/KTBOh4ChWkLK430iFbjX73/box/9Mc
         vHW8m5NiQNtdxEyBk1Dl2wi6gisZG3B+K4jayyeKGSpE/V+YRfC7keW3g7WGI5zeAItG
         k8kzAajKObBZVhLvCEnQQkZ7tvmm90vi7YeB2MvjRFcrc7OQLrutp8Wca+X9LjK+7uux
         GwdD6CLRv4JNVQimTK6vKJhjwMKgK3zEsfv9Ii4S4QJtslt3kIaNYPMyVSVmy2VcMpnN
         uKR9X6hdEdZ6WaFmqMaYH+4TUASL3YsCzUg3yttAgYxCbvxn0wPIq50Zm/es/lJUEvRu
         x4Pw==
X-Gm-Message-State: AJIora/aohrAXg1GucEeBp1wDvL+Z90M1FBc4yPhFBCP0hZpXareWx15
        8i0nIVXpi0ZBdwCunPMyFvjTqQ==
X-Google-Smtp-Source: AGRyM1vNC3ThDADki7cDkV3KRm4MQp1oog1SjOnMpOsZrauao3FmXctCM5yMTSJjaY0t29SsaZYocw==
X-Received: by 2002:a05:651c:54a:b0:25d:6c19:448 with SMTP id q10-20020a05651c054a00b0025d6c190448mr5903808ljp.239.1658834096584;
        Tue, 26 Jul 2022 04:14:56 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id d11-20020a194f0b000000b00489ec9e377fsm3157659lfb.120.2022.07.26.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 04:14:56 -0700 (PDT)
Message-ID: <3e64462f-5db7-74b9-dd96-b2fdbb80920e@linaro.org>
Date:   Tue, 26 Jul 2022 13:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
 <20220724172442.87830-2-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220724172442.87830-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2022 19:24, Matti Lehtimäki wrote:
> The PM8226 provides 8 GPIOs. Add a node to support them.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
> (no changes since v2)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
