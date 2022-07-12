Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337157170F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiGLKRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiGLKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:17:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C7ACEC6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:17:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q7so9297506lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fHRooYs+4o17PBwHnahLoiQ893gV5511TOsp6p/JiJo=;
        b=soXHL/ARpHUqJnfcdhOOGRq2Y4jO5kOcUcoBUU9os1EAq1RG/FcdnvOZqriSHYU14A
         xIAlvpvhHIH1RkFz76ipHUrae7gKY4r0wAjr8bAXGXWaVBHXAbEcjhGlgXVnsAlibgH5
         ihWXdzTn58Xt7oSuPwZ/6FgyoxdnFw88y2Bm5bU66uP1lVboWHxru21ekVoQ/rDUUl1+
         XWA2mZ7oCtt5I01D4DTKc8i1C1U7Mcvra5DSXkAE/pIGp9uV4niPnEPCUyh2LCFmOwVs
         XKWoEtTVtteXAQOyB0BWpSPrOF59QrpLVeosKPrvYYtJH5CoP3U8qAVoe9Mgn92NpgtJ
         z7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fHRooYs+4o17PBwHnahLoiQ893gV5511TOsp6p/JiJo=;
        b=Sos0rTrjh4FAPV/hDyAB1N7fWq+u6+IxXe2fPh1JR1abM5fMc/cGdMIWy1MSbeddVf
         iMOuLFq1qtCOmKuFCCKQ+XpQdG3L9jhGGZuqN9qmWqssHURV89VZ5mjV/YnJ3WL+KOmi
         g2bDhYkypPSOYxOLOEfd5nzBF3fCkk3G6rTHTip9W0l7P5E+P5j4A12NdKkwTPv5td0M
         xThoLa7g2XSb3pqnbvSbw3okARhi6ODK5kgufsWkhfUf3t79aCgGjEEcDH6DRMDnACR2
         sPfpIt6630u5kwa+8y2QHPx9BFX4Ueuxa7dD+EauRW+AoQBuEdfZ1CbOdHBsskPeItV0
         Yw0Q==
X-Gm-Message-State: AJIora/iFa4pe+1ll2M1+m7BsaiZTsDxsE/x0T8DJJbQ/ZRUTYX2kp8T
        VqOpNZT9xvSLSC+LeFrP+bf9akD+N0AyCZG3
X-Google-Smtp-Source: AGRyM1vQKIrs60TadSvsioou2uZFd+HQFb3aZTE7Qseh545FyeclaF6GMd1NV/z3Lc6p3qDMyMpJfg==
X-Received: by 2002:a05:651c:2211:b0:25d:5ffd:1e2e with SMTP id y17-20020a05651c221100b0025d5ffd1e2emr9743872ljq.390.1657621069249;
        Tue, 12 Jul 2022 03:17:49 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id n13-20020a05651203ed00b0048724eb8cffsm2083556lfq.255.2022.07.12.03.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:17:48 -0700 (PDT)
Message-ID: <99fc289f-8194-9fb1-e50c-a2e7a3577530@linaro.org>
Date:   Tue, 12 Jul 2022 12:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] dt-bindings: input: colibri-vf50-ts: Improve
 documentation
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
 <20220712101619.326120-3-francesco.dolcini@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712101619.326120-3-francesco.dolcini@toradex.com>
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

On 12/07/2022 12:16, Francesco Dolcini wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Clarify properties definition, drop unused pinctrl-2 state 'gpio'.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
