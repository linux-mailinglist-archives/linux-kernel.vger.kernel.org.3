Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC7587916
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiHBIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiHBIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:34:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C226AEE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:34:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z20so7740091ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aHp4Yh2rcRrr2xl2PTuwsd7kksQen9PU5SLjODiDla4=;
        b=nYLwIhzChbnzC54T8x4mN/2jmwBAQbgIkFf2s2p3HQ5k79Fhzn3/vhRVIuKwJNVL/w
         uLtahYAkyaZEFsn3gbWNDLE1ptfTNwfd9YtKzRQrIDluadm5b4EqIOlVUhYT0OkapAzS
         fStBrPwgSIZ3K+5rsQnt+aZm09Ye0+Zy3vGiIn/7Y3ljaR8BjgEd/xcz6boDnnV8EddK
         /tkUX0T/oswa46JHzOE2e52CBegMgiHlV3SStncnpqWE7TCIh0k8hZk/rKdVgygHSyvP
         +Rc0EaAYxYL0fblqCkc4GOqgIJLFJxoOgHXvx+qpx49orbgbZZ1QS2C/5+4ceGseoEpz
         DLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aHp4Yh2rcRrr2xl2PTuwsd7kksQen9PU5SLjODiDla4=;
        b=BMF+frodjlf7OEFSRFMVbwM1MsRrCIU2i93IFNVFqQVmnNEV1Pq0HLBwurMXohr5xu
         MKlr/wLhywWgglx0z3ShepLkAXKqCddP+7EM1FX0+8USKebtojRUje8jDAfSYOjRaf/f
         hVPrxNZGBtYLCm8d3bTL2ix3gcYKsW9zXvT0Mb2hS6kjBDUJgAREJZox+O6qMaFXfvVf
         QVoWXr3T5bnpCwz7q/IB29H9IT3cugpsXgsZCpjIu3Pe/LozdMJPORSPFAbbWCLrx4k/
         s4bGk7JoRCwbXQ/QuC7X3Ws/Z4S9TF5ug57QVujc8bEVXc4ImHheerbWxMrZJua+10oo
         675g==
X-Gm-Message-State: AJIora8z3YYsYA3DCt/Y3keyzRnrR8skk8duUjC/QkBpvb3QOSyNSSn/
        9TXSMwA2yQ64e8n2qlNj0OF3Lw==
X-Google-Smtp-Source: AGRyM1v2RoMwCWgJQRpQTWDaOWPiz/1teviwJ5VZF+VOTBURgWT6kzm/Hthgd6B8Pa5Aq4g73j431A==
X-Received: by 2002:a05:651c:1544:b0:25d:a561:2d7e with SMTP id y4-20020a05651c154400b0025da5612d7emr6381308ljp.8.1659429281794;
        Tue, 02 Aug 2022 01:34:41 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id m20-20020a2eb6d4000000b0025e4cf9d0c1sm738547ljo.115.2022.08.02.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:34:41 -0700 (PDT)
Message-ID: <9a470289-c0ad-aaa9-17b5-b1c7242d3549@linaro.org>
Date:   Tue, 2 Aug 2022 10:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/3] ARM: dts: qcom: msm8960: change the device node of
 sleep_clk
Content-Language: en-US
To:     Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f0a4790d-7739-3bc5-b877-2dacbdb5158b@somainline.org>
 <20220730081232.14181-1-peremen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220730081232.14181-1-peremen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 10:12, Shinjo Park wrote:
> Change the device node of sleep_clk to sleep-clk, and add a label. This
> follows the similar convention as qcom-apq8064.dtsi.
> 
> Signed-off-by: Shinjo Park <peremen@gmail.com>
> Reviewed-by: David Heidelberg <david@ixit.cz>
> ---
> 
> v2:
>  - Rewrite commit message
>  - Rename device node to not contain underscore


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
