Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784104F50DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843698AbiDFBlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355765AbiDELz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:55:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F7A25F7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:13:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a6so15034451ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xXIhb/k84YUPugErMI4w+XHiSb+7tM5DtyIUg35QKOc=;
        b=SOPe4Fz/Gd0TUXDXKPCA9VoNLaiWukRADEe+B53JR11QrjxpXX4bD5JteQJNyeAAOH
         7Au36PBclje86I2cu21Niy3oUS+GkRm704J0owWn0QAx5TRdjzRNZ5gFJ7u820ACv5JK
         Xwmcn6pK/x3/XOAKU3T3YubJpVAHynGMPw7I6zaQwGXz4jIo5fZ+fdrSnzw+vWtm0Ie3
         S6tds5TD7gJA4XDWha9NpRUZFDjcUHYsEyAsK6Yu9PteZcZrqZ4cL09OoPMIsz+yyWW4
         ZbDH9q104w1NxHqClHj/TA3OwMZNaq4ELH/TQQajLAKM/1DspmKkvByFILxwlsmMrY1C
         VpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xXIhb/k84YUPugErMI4w+XHiSb+7tM5DtyIUg35QKOc=;
        b=qD1xjylm3nX4/izhuZOpLJRmKwiXF6BLnxfd+fsj0FiVvgpw9gDanEpKjlcXjyOXCH
         WdumN8WH3Pod1RiflPKttDIcxlShcVwTUDcHUErCH0ZlmrZ7h3alpJO6wvgSo7MykJmP
         ePUQOJeFIMPn21kksrk2j3NfgtIP7v2cGNzX8fg5BSaWznem8KPTzpan+NTZDvbrwRz1
         1T8jvU3uHGw3GdX0tgw2GSrbPQBSzVsycEN20zNJ5saiU2WBfMt9k+ibAdy5IpfZVlPY
         GmTgUh36Hstcmb23mhCY6OljLYsIvoLZ8kLJJ68IwvNpV4HFR/hpoie8J/KKRouG8oKa
         lYRw==
X-Gm-Message-State: AOAM530iQbdu2mgMxj5S5C3AWIC1WPIUNpw0Ax+IHu8p5+et3QEf+u9f
        Ji7rwMhsl43+s3sZ2I+15Eio7Q==
X-Google-Smtp-Source: ABdhPJw9WvUhJrFGkEik3lLZvdk/MbisSziS8oeO/5WpSrdz1zCrQ+9wuri02UKa/reqvm1xDDaKZw==
X-Received: by 2002:a17:907:d16:b0:6d6:e3b6:9cd8 with SMTP id gn22-20020a1709070d1600b006d6e3b69cd8mr2972056ejc.94.1649157186513;
        Tue, 05 Apr 2022 04:13:06 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hr38-20020a1709073fa600b006e0280f3bbdsm5435580ejc.110.2022.04.05.04.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 04:13:06 -0700 (PDT)
Message-ID: <f7617857-b438-b527-315f-7543b9654a66@linaro.org>
Date:   Tue, 5 Apr 2022 13:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] dt-bindings: I2C: Add Qualcomm Geni based QUP I2C
 bindings
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20220404182938.29492-1-singh.kuldeep87k@gmail.com>
 <20220404182938.29492-2-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404182938.29492-2-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 20:29, Kuldeep Singh wrote:
> GENI(generic interface) based Qualcomm Universal Peripheral controller
> can support multiple serial interfaces like SPI,UART and I2C.
> 
> Unlike other I2C controllers, QUP I2C bindings are present in parent
> schema. Move it out from parent to an individual binding and let parent
> refer to child schema later on.
> 
> Please note, current schema isn't complete as it misses out few
> properties and thus, add these missing properties along the process.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v2:
> - Change compatible from enum to const
> - Drop clock-frequency description
> - Sort nodes
> ---
>  .../bindings/i2c/qcom,i2c-geni-qcom.yaml      | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
