Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDFD5A6027
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH3KEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3KCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:02:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F95D7CD8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:00:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k18so4382349lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qDIhNkRJpY0zIqLvOcBvjOAemNokXD1mo0hvIa/wH90=;
        b=OQ3mmQBYHhAd69bT5cNYFcJRUHQKdp+s3J1NohDx42YDP64HWn8wMsR/vGNXS0tKlL
         ys35MdecxfKaoP1cNLmwIop5D8GDktAERCdO2WMfPq8OCR4cMj4fkUI6HBb18KcfbbcR
         2Y7S4xQoWjvc9KWs+fmI4n9g5SzYeT7BlQapS51INbWRngIFDv7LsMQVeGMJ1EoIUGaL
         xWQ5PPxXLcO/2kr32Y30tZJkQLVA9keDmgvB1pXm29WXG0r6arXCasEu2v2xcuKpHb2n
         AhiS1JbK8NDJx5VmbUaOj8wU8MesgIWT+6clHY4Lvyq2ptBNGmxwLHCcAv/GZwlIYsqq
         iPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qDIhNkRJpY0zIqLvOcBvjOAemNokXD1mo0hvIa/wH90=;
        b=1v5iE0EXgeESpGU6eLXUpugwtePKte6W+4/u2OsK220YOAPZjSJojmZtKm/NnI3FSo
         HbBVauOrkhf4OtXzjvasU8TNTXKu0pdl75sAfyTviVu1YPr3UaDMrtlcqzgewe22wBwX
         QCACv17qCMthrxHF2pKyeJjFBFIZ8G3/hEH88FUEImoCJn1g8yjQBlupyBI8CTr+00tQ
         JjhtWRYtJgcw3Q7xgcbBQo7LCXbm2YkGR02uUSxxpFIh4SAOPh0MUxvbFEkSglSUf+r1
         8IdRW2dIb1qHd9iAxgrkO3H5C6wUJNgHDS4Dv9uozWMhOVGCgR/WDwVKo2Frwef9q4vz
         fEoQ==
X-Gm-Message-State: ACgBeo2alN9j4cmRuVSsebk1vf1EgG9zrovcLKKI8HxzM0K7ZTo5SPeg
        PUKm3imLFR9SP2xYjmX9SERbGg==
X-Google-Smtp-Source: AA6agR4V48JSDjw5vfjVGos0ruqfM/zbNheM3UU9XdSMDVN2inT8jBGsiWxBdE4dINkH3wb+jmBe6w==
X-Received: by 2002:a05:651c:b2c:b0:25e:6e68:ff51 with SMTP id b44-20020a05651c0b2c00b0025e6e68ff51mr6563202ljr.349.1661853649602;
        Tue, 30 Aug 2022 03:00:49 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b004947a57722esm140010lfs.26.2022.08.30.03.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:00:48 -0700 (PDT)
Message-ID: <ab678365-fb69-6aa5-75b2-865cfbdf0dea@linaro.org>
Date:   Tue, 30 Aug 2022 13:00:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG
 variant bindings
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
 <20220828205723.20834-4-joelselvaraj.oss@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220828205723.20834-4-joelselvaraj.oss@gmail.com>
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

On 28/08/2022 23:57, Joel Selvaraj wrote:
> Add documentation for "xiaomi,beryllium-ebbg" device.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
