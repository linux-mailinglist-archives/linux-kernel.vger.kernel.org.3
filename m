Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22AD5AC61D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiIDT3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02552DA9F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:29:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s15so7299511ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zHeAXo2eVvuHVI2CtRdbixiwjmytc3y6afJUtYoJYpk=;
        b=ThWlvfZfdpLZC6rr/TLTj3uI1wa6gss0BeXEu/MR0bu6mh5ROH84GuWWi0yMygSsk8
         GQMd6eUlDaYvmd9VAzJKYHpIlk81VNLE1B6WbCvBWQ8cmCfHV7IdZaxRlu62hKuwI68T
         aWoUSaic1aeLY7G3xVPOc5+D8P1P28prp2Dw4wLC0UFzleMPnWcdC4RW5nEsCHvjA26N
         h9e8wEp0ulmb1DhqIsw/uU3xo076Qrz6al7h0tKy2PDYbFViyg0vm2JCX+EWUjovIO7h
         jAAdt5zqurVEgQ1Glytm30i06NVu1K1E4kCgWhcmFsrts1U7FFwRj3FVvrhLU4Lqecxm
         hgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zHeAXo2eVvuHVI2CtRdbixiwjmytc3y6afJUtYoJYpk=;
        b=SKVKNMH0/8HNqItk+Y1f9zsNE91UwAecuYk4nljDV+nKTyo2Q9ROs3mnwozZX3pg37
         Jl4B5BUYC5m8e53ybF66Hhu8tLmzfBUO4Zt3NHCiQteDzURwPIk/6+rHVsHP1nrsF7+/
         WNrQwinTx6UIeWyGlyHRlFsSN1kEsxGa9oR+JzAo1lFjq68gcgmnITaQMMTPD5p8ujfk
         f2oXmJO1oorgCvVrhShqlhcTUhvY1GrRCXXjJtx1N56nMvmw3SA1Ldq+zkkCCXZCoMpZ
         T21Bkp1TXFoQRFMS493M1PlvieBRngdBYC1EpjYdm9rJp3yhR6JBOvWGgOe5anYWKCCx
         ouzA==
X-Gm-Message-State: ACgBeo0ahK33xRkgHzw2v+sCNrSmctspUfkXsCWDlBRe2cudLVyk3U1u
        y2A43Chi4fTFlQgj1UkgsloHSg==
X-Google-Smtp-Source: AA6agR65K/IgRHnj6QpYI1nFz586TFGQ5PPBnlzIci/aK9vvxN7Khb0SzyqI1idYiXM726MSBrsDTA==
X-Received: by 2002:a2e:bc26:0:b0:266:9e0f:ee86 with SMTP id b38-20020a2ebc26000000b002669e0fee86mr8871593ljf.1.1662319752110;
        Sun, 04 Sep 2022 12:29:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651c111300b00261aecd1c53sm1087776ljo.71.2022.09.04.12.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 12:29:11 -0700 (PDT)
Message-ID: <58608d9f-bc79-4e97-2027-e68863213aea@linaro.org>
Date:   Sun, 4 Sep 2022 22:29:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 03/10] dt-bindings: misc: fastrpc: Document
 memory-region property
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
 <20220902154900.3404524-4-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902154900.3404524-4-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 18:48, Abel Vesa wrote:
> Add memory-region property to the list of optional properties, specify
> the value type and a definition

You should write why adding this property. Is it already used?

New properties can go only to DT schema, so first the conversion [1]
should be finished or started from zero (9 months it's quite a time for
a resend...).

https://lore.kernel.org/all/20211208101508.24582-1-david@ixit.cz/


Best regards,
Krzysztof
