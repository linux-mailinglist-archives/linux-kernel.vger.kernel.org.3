Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3EF597F97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiHRHzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbiHRHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:55:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812B7EFDF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:55:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s9so952746ljs.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dawxEcQT0OhFPG9l9jRrsFoKv486Saz+4v6DaJSObPA=;
        b=EmOrw6T67t6JXnuPoMeZH07x7nMOn5ucQd9RoTd9bOMFEKuUgtrZta0s5paZoxZ9Je
         qHtrH+AQmv/+uh0Wkvu4yEo4vvvOhgYGeHDj6dINWfirYLVZvHjh4oBwWWXujjwuYK7W
         IyhV+YsFaoube+2i/I3eRX+qjTCQ5pbINij6ehzTR/F46fRZT2POawSEQhx7Cxmj6Qkw
         91lOK8BpeWpSNFUMzUazcGLXvoQxnH6SbpqvDnkgNqU7QlKfX3AMqye8CvLEhFYY5qpp
         E9/CCwT5A937l9YPLB1sVhzaCcRscQjVwFgdybaMnE6WtPfNFNxYOFNPZxSEiRU3tyK+
         gUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dawxEcQT0OhFPG9l9jRrsFoKv486Saz+4v6DaJSObPA=;
        b=SPv066l2dw6hR7Tbpbrh1sgqbfXnZ8bt8XkuK7/01s8F/fiXqrRkg28UQM/duHE5Yl
         qvuhXqpZsKhMyZgLHi9jp6EdoGw3LLllB2xsWzBfSbJOFrV++VYoRaf/DBLa+SGrwqRy
         X9lEwNO8U/sQhtSAMuITQnDWXE7Eb0rMu2bgyeopNhOwxiFLS5809ix0oL19PgJRCwo/
         e+6cJaiN0h1R/nM8EVCEtDKuC5PiRR5PnP1FOiSkZ002DzOqR7VDILz+j/YmPLOBqC69
         YkgRX0Yzqx7iEiVqTEG3D/rdPJSyVxx/aSUuPi6P4hJB1hJkRGA5LTEFvdKTLLIHEd28
         GVBw==
X-Gm-Message-State: ACgBeo0nWmKRYKIo+y3GhNgk8a4TRHhKGMFsANhBYKJRuCF2uoYaV599
        DpXYsaTvjV2aCcJxjv/oIMhl1w==
X-Google-Smtp-Source: AA6agR5VQUbfnby25Lc9unAu/HapmYL6K0oRaQ5+TLbZmOxeBd1NTB+IoxnuUO/L553aVNdK54dOwA==
X-Received: by 2002:a2e:bc12:0:b0:25e:59e7:8def with SMTP id b18-20020a2ebc12000000b0025e59e78defmr563029ljf.249.1660809349142;
        Thu, 18 Aug 2022 00:55:49 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id u18-20020a056512129200b0048afa870525sm127379lfs.65.2022.08.18.00.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:55:48 -0700 (PDT)
Message-ID: <88393f56-69b5-65d8-9acd-373e069c750f@linaro.org>
Date:   Thu, 18 Aug 2022 10:55:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK binding
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818031512.319310-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 06:15, Bjorn Andersson wrote:
> The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> platforms and implement USB Type-C handling and battery management.
> This binding describes the component in the OS used to communicate with
> the firmware and connect it's resources to those described in the
> Devicetree, particularly the USB Type-C controllers relationship with
> USB and DisplayPort components.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    | 98 +++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
