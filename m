Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8685A5F75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiH3Jai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiH3Jab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:30:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7C5F137
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:30:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so14696400lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7vyYZz9KgFNVi0JvWBzSGayrcz6ixg7MEp1UEYlRptU=;
        b=WaP/NHshvX6sNiRPPVuzIhwJZTulhNUEpAapYrefGstvj4/cZkFXxJhDVzktI28ZpI
         i13FUs6UZxue3hmF/BV7BD3jM0wwIIGE7upNTxSC/Ox2B8JC0mYapGDwQ4wIntCI7ez5
         r1DcSYENqx6DYD4O9UqOhO7YaJ05HbV5pROeEZVTRNEBoa8NgnuTEwgF42VrKnuoXBqr
         zkY3vDTGgRpoZIOturtJmRcXexP/zqfWiUxN3dL6lJpBRO/UT4JlpFjaGSswCgC2z+co
         NVy/GbTQNPGSMf8ESEhDPyOlT7sK/RBLFmjkATy+tUwBe16aVWdKQRQrXk2Avwk5zhQy
         N0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7vyYZz9KgFNVi0JvWBzSGayrcz6ixg7MEp1UEYlRptU=;
        b=mBo8UbE2EAXKjWap2gSlZg1tSAVZwsocKqBplm6cWhtSUgZyoaARo8S9iSa540bAku
         VN3ux6KM70x+EYxpLNJfU7iwFBPWEwg12DOjVitg48vurCrKKGn1IiQmwVt5PUIjxrnc
         6c8s3J7yvKC1ko+IxgAhQBgk322NdJVLTtmwu97YisTJgt5HMz51Q1KxpIVJDHTgTMk+
         wsgNpTJ5UtktcdOIndZPhE9cCREw9AFjW7IDTqhrQoRwp8AfCUk3MCwHW631N99yQdkh
         GePaN1E7erhWUvRuqT0erka+cAWq9Xn8QIZl33Uu4Zzq4k/wKf/6lQDFQeFaMzlON1Q5
         8MHw==
X-Gm-Message-State: ACgBeo1p/QdHtrwBi2pVMLsaSN+PspaSQVeK88Uuys67p7Qy5aMvk4y/
        w8io8NNg4H8NOYzbR4I+pQvslA==
X-Google-Smtp-Source: AA6agR4MJMvkWWr8MBhEZ8xVFUYxKK0ZPWsAy0YaBRPQ7YBUtTJXE1tDr4axCvoe0Qh+3CfytsxMjQ==
X-Received: by 2002:a05:6512:281a:b0:494:813e:53fa with SMTP id cf26-20020a056512281a00b00494813e53famr255193lfb.305.1661851827598;
        Tue, 30 Aug 2022 02:30:27 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s4-20020ac25fe4000000b0048aef1abb06sm1554987lfg.69.2022.08.30.02.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:30:27 -0700 (PDT)
Message-ID: <bbff0ffe-d555-ab10-7a0b-d4369dac14e1@linaro.org>
Date:   Tue, 30 Aug 2022 12:30:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v7 3/3] arm64: dts: qcom: msm8992-xiaomi-libra: split
 qcom,msm-id into tuples
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
 <20220830065744.161163-4-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830065744.161163-4-krzysztof.kozlowski@linaro.org>
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

On 30/08/2022 09:57, Krzysztof Kozlowski wrote:
> The qcom,msm-id is an uint32 matrix, so a list of tuples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch can be ignored. I missed that v6 was applied (there were no
changes between v6 and v7 here).

Best regards,
Krzysztof
